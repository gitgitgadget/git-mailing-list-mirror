From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast_export.c: Fix a compiler warning
Date: Sun, 19 Aug 2012 23:50:31 -0700
Message-ID: <7vfw7im4zs.fsf@alter.siamese.dyndns.org>
References: <5031063E.3090405@ramsay1.demon.co.uk>
 <2715225.vOk3BtNY6o@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 08:50:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3Lp6-0005Kb-CG
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 08:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755294Ab2HTGuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 02:50:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63811 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752437Ab2HTGue (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 02:50:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8788E4B51;
	Mon, 20 Aug 2012 02:50:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RNqa4hXcw1V5MSuDeLFFBfzVIqc=; b=vP8aj9
	RwTDmHhyxJyRk7OLKRP5xn72qOTYRhcxfNvG6BVuKbtAdXkTA74F7pCHUWOoutAf
	4VF8/t9BIrn8PfKVqOGTNC61PgcAM1Y6HYENJp2HOlL9cR8Y5+Dyq/lLFXTCem1c
	RCxaBpoyh42+eiI/9jdOTs97XLWf5s4RcxcnE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rq44+JhEeri/hsrzm3RXIl5wYeJABlLT
	mL335pTecAtHHdHFxtRV31bRJ/w1pxW0BcQDenj1kMUQ7KTXre+NJrnEilX+E+WD
	4bIcojPJiMFcjPZixK6/JKpZn+qzp8ymqmZxUGPT70xuVkxeku5dgG/dH6B9OHHE
	/BzIYXwo2HU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 755CE4B50;
	Mon, 20 Aug 2012 02:50:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E69FF4B4F; Mon, 20 Aug 2012
 02:50:32 -0400 (EDT)
In-Reply-To: <2715225.vOk3BtNY6o@flomedio> (Florian Achleitner's message of
 "Mon, 20 Aug 2012 08:19:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 567684CA-EA93-11E1-BD7D-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203760>

Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:

>> If you need to re-roll your patches in the 'fa/remote-svn' branch, could
>> you please squash this fix into them. [This was implemented on top of
>> commit 2ce959ba, but you will probably want to make the equivalent change
>> to commit d319a37c ("Create a note for every imported commit containing
>> svn metadata", 17-08-2012) instead. Note that, because of the context
>> lines in the patch, it won't apply as-is.]
>
> Ok, I'll add it to the next version. This warning only occurs when building 
> for 32bit, thus I never saw it. There would be a format flag for printf that 
> sprecifies the platform's size_t integer type: "z". 

Yeah, I also queued 05ce866 (fixup: add missing cast to
vcs-svn/fast_export.c, 2012-08-18) on top of your series before
pushing 'pu' out yesterday.  Have you had a chance to look at these
fixups?  There are others you would find in my tree, including minor
log message typofixes.
