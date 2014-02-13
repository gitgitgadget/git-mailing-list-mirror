From: Cameron Taggart <cameron.taggart@gmail.com>
Subject: Re: feature request: text=input option in .gitattributes
Date: Wed, 12 Feb 2014 21:05:06 -0600
Message-ID: <CAABik=txo0bkiL1V2GjvRwyfXb24PDrj9g5CHj+S-0RAV80PCw@mail.gmail.com>
References: <CAABik=sZowhZ4hMi6R=KQHWT_FGBJ9iXJEjtX26wueCzjEQL7w@mail.gmail.com>
	<52FB99A5.9040607@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Feb 13 04:05:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDmc0-0003FL-HW
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 04:05:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbaBMDFJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Feb 2014 22:05:09 -0500
Received: from mail-ob0-f169.google.com ([209.85.214.169]:47876 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbaBMDFH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Feb 2014 22:05:07 -0500
Received: by mail-ob0-f169.google.com with SMTP id wo20so11531782obc.14
        for <git@vger.kernel.org>; Wed, 12 Feb 2014 19:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=BVfiS8PrQvAUcNUkwxx3wKYsi/UKLWdoiihYWpxabxs=;
        b=XdLLuG9RVMuIvCv0Sr87aQDuFzcAg1LxAfq2o2jUz6ICoI/fFtr7nxbhkOEUENbwzO
         BNPJG0IZ38f8ygFphW5NX/yq6dlqIhsIsuecVyzODnzftIuj2zC0AJ24B68AyULbDbnd
         yyf5gwdsIe9OKC73RngA2+spMnnlcCMbMUN6Y6x4Ia5aMbouIwsb5MivDUwC2JDFi1lv
         u5i54QI4HC8wE6Jm7Jc/yzngNKMrV+QbKu9osYAec0qOSVMzs8L5Ls4MGwzaPiZd329e
         rvrRheEcjiaZzUjT0qaByYGpYBAl5q6VMOqvfUkXKvJ0PWAv14nVGSeBYchCd6+ka/rk
         wfrw==
X-Received: by 10.182.250.163 with SMTP id zd3mr40711170obc.20.1392260707013;
 Wed, 12 Feb 2014 19:05:07 -0800 (PST)
Received: by 10.76.82.129 with HTTP; Wed, 12 Feb 2014 19:05:06 -0800 (PST)
In-Reply-To: <52FB99A5.9040607@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242041>

Thank you Torsten. Could some one help me clarify what this means?

https://www.kernel.org/pub/software/scm/git/docs/gitattributes.html
"This ensures that all files that git considers to be text will have
normalized (LF) line endings in the repository. The core.eol
configuration variable controls which line endings git will use for
normalized files in your working directory; the default is to use the
native line ending for your platform, or CRLF if core.autocrlf is
set."

Does this mean?
1) the files in your working directory should only be set to CRLF if
your native line endings are core.eol=3Dcrlf and core.autocrlf=3Dtrue?
2) the files in your working directory should be set to CRLF by
default if your native line endings are core.eol=3Dcrlf and not
core.autocrlf=3Dinput

I was hoping it would be #1, but it does not appear to be working that
way. The F# Compiler Service that I want to source index has
text=3Dauto. It can be used to test.

git clone https://github.com/fsharp/FSharp.Compiler.Service fcs

git config --global core.eol crlf
git clone https://github.com/fsharp/FSharp.Compiler.Service fcsCoreEolC=
rlf

Please help clarify how git should be working, so that I can either
log a bug or a feature request.

cheers,
Cameron

On Wed, Feb 12, 2014 at 9:56 AM, Torsten B=F6gershausen <tboegi@web.de>=
 wrote:
> On 2014-02-11 15.57, Cameron Taggart wrote:
>> After requesting this as
>> https://github.com/msysgit/msysgit/issues/164, I was told to take it
>> upstream, so here I am.
>>
>> I would like a text=3Dinput feature added that has the same behavior=
 as
>> text=3Dauto, except that it defaults to core.autocrlf=3Dinput behavi=
or
>> instead of core.autocrlf=3Dtrue.
> If you want to normailze your repo, and keep it normalized,
> I can  recommend to use .gitattributes.
>
> Please see the excellent page here:
> https://www.kernel.org/pub/software/scm/git/docs/gitattributes.html
> And especially this part:
>
> $ echo "* text=3Dauto" >>.gitattributes
> $ rm .git/index     # Remove the index to force git to
> $ git reset         # re-scan the working directory
> $ git status        # Show files that will be normalized
> $ git add -u
> $ git add .gitattributes
> $ git commit -m "Introduce end-of-line normalization"
>
>
>
> /Torsten
>
