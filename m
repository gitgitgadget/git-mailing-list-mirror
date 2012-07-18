From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch: make --set-upstream saner without an explicit
 starting point
Date: Tue, 17 Jul 2012 22:56:56 -0700
Message-ID: <7vpq7twr13.fsf@alter.siamese.dyndns.org>
References: <1341480589-1890-1-git-send-email-cmn@elego.de>
 <7vd34arvhu.fsf@alter.siamese.dyndns.org>
 <7vtxxmqezp.fsf@alter.siamese.dyndns.org>
 <1341559103.10752.59.camel@flaca.cmartin.tk>
 <7vpq89ny8q.fsf@alter.siamese.dyndns.org>
 <1341561809.10752.61.camel@flaca.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Jul 18 07:57:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrNFy-0002ny-4j
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 07:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686Ab2GRF5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 01:57:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55239 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751675Ab2GRF47 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 01:56:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D4D96E01;
	Wed, 18 Jul 2012 01:56:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hQdA5f1cnxylnaOJEve3LxFox2s=; b=hiEml0
	kb3komT+v+hYc8WHWbw2gFT1+4pg2KZMjurSLE3LQ54vaOcLrBGNtTi0yWs0083h
	HWvMuvH6jmST2kLDlX+b3Gs01uwqpqi3r8PpT3q1upN9dYrXA0ZSFCTl+UYselkL
	aC19GLoCNtpiDJIzGhHVLjeGfzIM8SB6TkstM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kZquy+GgIgTFSzoenA3oe5m4SEp1rUQo
	KB1o+WowEPtVJ//G2NcYeSP7QhtA71L400ExepV+Te2dTur3GSaF1Vp/zxOxHi7t
	gXLa5AJl4IbVEOtHO43f4FGQ+7iI/uUJ+toKiXH+Xh1amLHIdA9W9gvp7Paq4uwl
	nwBuEASHQpU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83E2C6DEE;
	Wed, 18 Jul 2012 01:56:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 03D826DD2; Wed, 18 Jul 2012
 01:56:57 -0400 (EDT)
In-Reply-To: <1341561809.10752.61.camel@flaca.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Fri, 06 Jul 2012 10:03:29
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 62956830-D09D-11E1-93CE-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201649>

Ping on a seemingly stalled discussion (no need to rush but just
checking).
