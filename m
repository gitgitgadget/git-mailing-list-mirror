From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ab/i18n
Date: Thu, 24 Feb 2011 11:11:57 -0800
Message-ID: <7vfwrd1c3m.fsf@alter.siamese.dyndns.org>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org>
 <20110223234828.GA7286@elie>
 <AANLkTimn_CmWORwJfWXEiY18QCmXdNZMhCUC9YBMo_kV@mail.gmail.com>
 <20110224102712.GC14115@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 20:12:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psgbp-000365-0C
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 20:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756010Ab1BXTMM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Feb 2011 14:12:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51616 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125Ab1BXTML convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Feb 2011 14:12:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8748348B8;
	Thu, 24 Feb 2011 14:13:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nBCUNYXPpSu5
	6I91Cch9z47kyR0=; b=dbSGaHrRDcCtZ+sB48+RERKr52fEAfSE+Pz0xjy8++oA
	uNM2HaH6ROrbj7xSLPywW6Jfowo2n1HSPon50wwo439tNimxFD2ByxFCyoVTyrBg
	tbe1BJn5NnTkqTVnJIF3L1mgzMB0X5sS2Ka+nyAyhaPNoFKolmyxzqOTcu6YIag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=lOYgOY
	rHtcQL05M7GwEoaZM8VG8WiVJ3RlEfpisFfW12pHE+FL/MJd37xZ6I2IBQYQcpcn
	WX1Ngvmqw9ZBMvbDLJsXHfgo9ozETpOnLSerhg1fMalP1LTV/yGWBF6Kn007PiQQ
	pliWbYtNUuIGbkOCOLDnbDpSl+MWGB0gfO7hc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 41F5548B7;
	Thu, 24 Feb 2011 14:13:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AA87448B6; Thu, 24 Feb 2011
 14:13:13 -0500 (EST)
In-Reply-To: <20110224102712.GC14115@elie> (Jonathan Nieder's message of
 "Thu\, 24 Feb 2011 04\:27\:12 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 23BA9C1E-404A-11E0-95B2-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167850>

Jonathan Nieder <jrnieder@gmail.com> writes:

> * The series is too long to read in one sitting.
>
>   Suggested fix: deal with some arbitrary early subset (35 patches?
>   I'd even prefer around 20) first.

Let's concentrate on making sure that the first four (i18n foundation, =
no
markings) gets merged to 'master' first, using the early ones (say,
"init", "clone", "add" and "branch") as a sanity checks.

And then we can stagger the remainder, perhaps at most 10 in one batch =
but
preferrably smaller, two to three batches a week merged to 'next' and t=
hen
down to 'master', over a few weeks.

> * Patch 2 (add GETTEXT_POISON) is conceptually complicated since
>   its arbitrary string is not arbitrary.
>
>   Suggested fix: split it into two patches.  But I am still not sure
>   if that's considered acceptable?

See bottom.

> * Patch 2 squats on a valuable use_poison() identifier space.
>
>   Suggested fix: rename it to gettext_poison().

=46or this, I can just "rebase -i"; I don't think there is anything
controversial nor tricky.

> * Patches 5 (i18n: git-init basic messages) and onward do not
>   explain "we are marking strings for translation, in
>   preparation for translating them later" in their commit messages.
>
>   Suggested fix: use titles like =C2=ABi18n: mark some "git init" mes=
sages
>   for translation=C2=BB.  Or ignore the problem --- it's not a big de=
al.

If you want to see a mixed patch that has both logic reorganization and
message marking in one change, e.g. i18n: git-revert split up "could no=
t
revert/apply" message, split into one that only reorganizes the code
structure and the other that only marks literal string, your "mark for
translation" would start making sense.  The other half won't even have
"i18n:" prefix in that case.  If we go that route, it would be better t=
o
have the code restructuring patches merged to 'master' before (and
independent from) i18n.  But the ones I took a look at didn't seem too =
bad
(e.g. i18n: git-revert "Your local changes" message).  I think =C3=86va=
r did a
good job splitting the changes into a reasonably small bite-sized chunk=
s
in this round.

Assuming that we are not going to do that "even finer" split, I think t=
he
patches we have on 'pu' are descriptive enough already.  They look like
this:

    i18n: git-tag tag_template message
    i18n: git-mv "bad" messages

> Does that sound like a fair summary?

To me it does.  Thanks.

> I'd be happy to reroll the first 30 or so patches following whatever
> approach is the consensus for these things to move this forward.

I tend to think that except for the GETTEXT_POISON bit what we have is
mostly fine.

Can you give two weather-balloon counterproposal patches for "add
GETTEXT_POISON" and "i18n: git-status "Changes to be committed" message=
"
to illustrate what you have in mind, and perhaps list the patches in
=C3=86var's series that need similar changes as you would need for the =
latter,
to illustrate the extent of damage a careless translator can cause by
omitting '#' from the beginning?  Would that help the topic get unstuck=
?
