From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] An alias that starts with "!!" runs in the current
 directory.
Date: Wed, 05 May 2010 15:02:34 -0700
Message-ID: <7vvdb2hurp.fsf@alter.siamese.dyndns.org>
References: <1273019122.16093.6.camel@ubuntu.ubuntu-domain>
 <20100505005153.GC25390@coredump.intra.peff.net>
 <4BE115EF.8010306@viscovery.net>
 <20100505070131.GA11265@coredump.intra.peff.net>
 <19425.9169.537598.876589@winooski.ccs.neu.edu>
 <7v1vdql4c9.fsf@alter.siamese.dyndns.org>
 <19425.54504.163875.379151@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jared Hance <jaredhance@gmail.com>, git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Thu May 06 00:02:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9mgE-0001rK-MB
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 00:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756357Ab0EEWCw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 18:02:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56027 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217Ab0EEWCv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 18:02:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B630B0ECC;
	Wed,  5 May 2010 18:02:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JPr7lMDZF9r9ckMDHCox59LTZn4=; b=thhsx/
	6JaTmS+ahCCtUVQfCLT3SQN0GNyf5pjgBfrq6rDfV2W68RPkvU+MDAri+J2DRn9t
	7msnCKfRd+kzThd4Rr5SJe4mrnetR3ijyGpI4ViK1wbWJaC+xRiy6UFYtJxKeCai
	wkVa5w/U1tVEdOdDZ5iaMnOGESBD32DhbUQlc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fbw/vnTRGeX42jEQRxnC2hPcesUguXNu
	gZBrkdYN1GC3P5JGs7zf4J0POWMuCHZnAhOdO1uJFZoDCKcSN9gCh/YtWPzosy58
	DBtSbDb9fpuLF+kdX6VEpjbOq6Qi5CLYew6eBoUXmru/E+yxiXHI4dVPU/sT/YA8
	dyjqwJeYONQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D86BB0EC8;
	Wed,  5 May 2010 18:02:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D0372B0EBD; Wed,  5 May
 2010 18:02:35 -0400 (EDT)
In-Reply-To: <19425.54504.163875.379151@winooski.ccs.neu.edu> (Eli Barzilay's
 message of "Wed\, 5 May 2010 16\:28\:24 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EE08C30C-5891-11DF-982B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146425>

Eli Barzilay <eli@barzilay.org> writes:

> It looks like setup_git_directory_gently() returns the original CWD,...

It is designed to return what we internally call "prefix".  You however
have to be careful as it can return NULL or an empty string when you are
already at the top of the working tree.
