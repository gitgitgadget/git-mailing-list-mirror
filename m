From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/3] git-am: add am.threeWay config variable
Date: Thu, 28 May 2015 21:20:06 +0200
Message-ID: <vpqpp5kpl09.fsf@anie.imag.fr>
References: <1432675975-11020-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1432675975-11020-3-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<CACRoPnSnwA5GcYZjHHTepz4WzXYuJ+9nJqGsL92r_vnsNrN_-w@mail.gmail.com>
	<xmqqy4k8h9f8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 28 21:20:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy3Lr-00053S-DB
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 21:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754399AbbE1TUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 15:20:19 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51300 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753826AbbE1TUR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 15:20:17 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t4SJK4is027581
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 May 2015 21:20:04 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4SJK63E017076;
	Thu, 28 May 2015 21:20:06 +0200
In-Reply-To: <xmqqy4k8h9f8.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 28 May 2015 10:57:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 28 May 2015 21:20:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4SJK4is027581
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433445605.04554@U32jCQ3kVKVB4Ve3ABUxwQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270182>

Junio C Hamano <gitster@pobox.com> writes:

>> I've noticed that in the block above that initializes all the variables,
>>
>>     sign= utf8=t keep= keepcr= skip= interactive= resolved= rebasing= abort=
>>     messageid= resolvemsg= resume= scissors= no_inbody_headers=
>>     git_apply_opt=
>>     committer_date_is_author_date=
>>     ignore_date=
>>     allow_rerere_autoupdate=
>>     gpg_sign_opt=
>>
>> threeway is not initialized at all, and thus I think running
>> "threeway=t git am blah" will affect the behavior of git-am.
>
> Correct.  I overlooked this when I originally did threeway.  Perhaps
> a preparatory bugfix patch is warranted before this one.
>
>> Also, I noticed that we do not check for --no-interactive,
>> --no-signoff, --no-keep, --no-whitespace, etc.
>
> Even though adding support for them would not hurt, lack of these
> are OK, as long as we do not have configuration variables to tweak
> their defaults.

I wouldn't worry about these issues, as the port to C will make them
disappear anyway.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
