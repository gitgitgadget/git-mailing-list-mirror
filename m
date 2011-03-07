From: Ruben Laguna <ruben.laguna@gmail.com>
Subject: Re: why is my repo size ten times bigger than what I expected?
Date: Mon, 7 Mar 2011 10:59:29 +0100
Message-ID: <AANLkTinJZFGVNSQVfCipo33h5uPpK0pFY10E203oTfhU@mail.gmail.com>
References: <AANLkTimi+OnpdX+Y7jx1JaOmGbZc_XEgJFeK0PKLpu2o@mail.gmail.com>
	<AANLkTi=V3nEamocowbHovvV0U69nZgD70fysu1CQOwrR@mail.gmail.com>
	<AANLkTimp8B5Lv15qhGOwOzh+kqOS0g3Xwvgib8vyk+m+@mail.gmail.com>
	<AANLkTinwHMULqPZSguYtJztuA4Oy6-s6Ah3_tcVVO7D9@mail.gmail.com>
	<m2zkp9wwqe.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan del Strother <maillist@steelskies.com>,
	git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Mar 07 10:59:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwXE6-0002Wq-Gc
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 10:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755628Ab1CGJ7a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Mar 2011 04:59:30 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41004 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755622Ab1CGJ73 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Mar 2011 04:59:29 -0500
Received: by pwi15 with SMTP id 15so736378pwi.19
        for <git@vger.kernel.org>; Mon, 07 Mar 2011 01:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=S2CznGjDbrmoahs3Lsg05rhzoLFRrKBP9gJcMvQs2uM=;
        b=WnrtfaQzPUeIVJnN+LaDhdOPDRhhbebdaczdyyX7L6a6V2mJsT6wljKLCdHsTbp5wk
         S6zOMwxAnUFEGsMKrgCmk2bDEv7YQqC//2lPpYry8ITDUHwjBPscpQ5YHRfGfJv6qjC5
         iDkdrTRE7AOuKtiRauq7B+mrrHnYGzbPSkno8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oLDDL891Py81a7JGf2Y1wdSgKPkpeJJonOWvhCjllxjfcG/U4Xs5eUax3PqWUTaL1k
         lOfP5aQZXtQulXmkZKJ53iqpAYSZkIPrz2fqjV1d7xuCbgkl8QqgAIFRdIYby4gOZuCb
         bJT1bJxh/B3FTxthmKn63QeH21Raj5P7T4Kgg=
Received: by 10.142.208.16 with SMTP id f16mr442397wfg.58.1299491969078; Mon,
 07 Mar 2011 01:59:29 -0800 (PST)
Received: by 10.143.162.21 with HTTP; Mon, 7 Mar 2011 01:59:29 -0800 (PST)
In-Reply-To: <m2zkp9wwqe.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168572>

Cloning it that way didn't help either,

But I have more info

If I set a bare repo and push my four branches to it (master, develop,
gh-pages and experimental) the total size of the repo is 2.4MB
(instead of 87MB)


$ git init --bare en4j_xx
$ cd en4j
$ git checkout master
$ git push file://$PWD/../en4j_xx master
$ git checkout develop
$ git push file://$PWD/../en4j_xx develop
$ git checkout experimental
$ git push file://$PWD/../en4j_xx experimental
$ git checkout gh-pages
$ git push file://$PWD/../en4j_xx gh-pages
$ $ du -sh ../en4j_xx
2.3M	../en4j_xx

So, how can I find the contents present in en4j that are not present in=
 en4j_xx?






On Sat, Mar 5, 2011 at 1:57 PM, Andreas Schwab <schwab@linux-m68k.org> =
wrote:
> Ruben Laguna <ruben.laguna@gmail.com> writes:
>
>> also cloning the repo doesn't change a thing
>>
>> $ git clone en4j en4j_xx
>> Cloning into en4j_xx...
>> done.
>> $ cd en4j_xx
>> $ du -sh .git
>> =C2=A087M =C2=A0 =C2=A0.git
>>
>> any other idea?
>
> Please use file://$PWD/en4j as URL, otherwise git clone just hard lin=
ks
> everything.
>
> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756 =C2=A001D3 44D5 214B=
 8276 4ED5
> "And now for something completely different."
>



--=20
/Rub=C3=A9n
