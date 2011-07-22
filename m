From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Move git-dir for submodules
Date: Fri, 22 Jul 2011 13:30:10 -0700
Message-ID: <7v62muys6l.fsf@alter.siamese.dyndns.org>
References: <1311267139-14658-1-git-send-email-iveqy@iveqy.com>
 <7vhb6f1ipp.fsf@alter.siamese.dyndns.org> <20110722190223.GA27076@kolya>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jens.lehmann@web.de, hvoigt@hvoigt.net
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Fri Jul 22 22:30:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkMMX-0000CT-GJ
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 22:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084Ab1GVUaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 16:30:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46839 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755164Ab1GVUaO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 16:30:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD16A42DB;
	Fri, 22 Jul 2011 16:30:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BBUUeXmtr5Q48okvE52uz3ChsHE=; b=oUpGtD
	YnE6IdpQJKcSxAYncDXDZ7yyvYIrydjNgjePMJ2vESOIgkx4xlTKTKAk3J5HV3mp
	eB8AcoEWI2oVFmc+bBRCL+FDo4pZIO+RSKnvJYfryoSUZXFlr98UC+YZsefwlmL4
	GTsCTQpo+4E+adx6FSslulixafpC99qCTxd9M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p4mu3JogD6yX3YDR0WWbBFwXYWLYVDsS
	y/aFgwDplMFZiwHtgOerEGdtIOylmxqNtZXNddxcdM8vie8n1U9eepljpmUvNtg/
	/XTOAT+VzrQ9EV3BKVOfIuLgtyba4GVWegBGo/9rb24Z8fBmtBX7OUOfPuvz98oX
	mOpA5DFUD08=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C40A042DA;
	Fri, 22 Jul 2011 16:30:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5DB6042D7; Fri, 22 Jul 2011
 16:30:12 -0400 (EDT)
In-Reply-To: <20110722190223.GA27076@kolya> (Fredrik Gustafsson's message of
 "Fri, 22 Jul 2011 21:02:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6686B3B8-B4A1-11E0-8786-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177664>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

>> I wonder if we want a new option to "git rev-parse" so that we can say
>> 
>> 	git rev-parse --is-well-formed-git-dir init/.git
>> 
>> to perform these checks without exposing the implimentation detail.
>
> How about using
> (cd <repo>; git rev-parse --verify HEAD" >/dev/null)
> instead?

Can the <repo> be without any commit, i.e. just after created?
