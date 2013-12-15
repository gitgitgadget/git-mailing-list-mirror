From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 02/21] path.c: rename vsnpath() to git_vsnpath()
Date: Sun, 15 Dec 2013 09:25:30 +0700
Message-ID: <CACsJy8BdLt8ZUU2z4LAgTcfXUjruFaOFsvrv6dSziZVizAopGA@mail.gmail.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
 <1387018507-21999-1-git-send-email-pclouds@gmail.com> <1387018507-21999-3-git-send-email-pclouds@gmail.com>
 <52ACBE2B.3040909@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Dec 15 03:26:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vs1PC-0006da-It
	for gcvg-git-2@plane.gmane.org; Sun, 15 Dec 2013 03:26:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902Ab3LOC0B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Dec 2013 21:26:01 -0500
Received: from mail-qa0-f45.google.com ([209.85.216.45]:36462 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590Ab3LOC0A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Dec 2013 21:26:00 -0500
Received: by mail-qa0-f45.google.com with SMTP id o15so639522qap.4
        for <git@vger.kernel.org>; Sat, 14 Dec 2013 18:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=z/NSwx9FuQ6mMmZKmPxo9t6twCFPXKuf18O2QEBLwLs=;
        b=ba7L1m9k33dkJkUaOAB0uPSDWSdhZgS92J6Zl2OfeNzc0KhK7YExPEAWhZzWHspp/H
         N5KiMrsTKsq8xlBUtqeRTYdm98t+dK2CrEf1vFoiLb8sVZuf+2n2oH/QseRWME9eHgZ5
         8dBeQ15xCj8FV/2Ed0m8TtQCbkAWwlnv8RBSFjyScGwrFDa9YO1Mq7v3slum9y6mzp6b
         bRpkzV4W/cjlLeX0yuQQsmLXvbSLWPVZBIXNTnHkDSBvIdourW2mGAkYXD30c/gDjJcD
         kyD0vK//DCXZkWPkhtGTEAyjNTw55XDb7zt75uDoHPvK1dDw8tISPQaI+e3/j3woqiQg
         e6+Q==
X-Received: by 10.49.15.227 with SMTP id a3mr19770348qed.66.1387074360110;
 Sat, 14 Dec 2013 18:26:00 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Sat, 14 Dec 2013 18:25:30 -0800 (PST)
In-Reply-To: <52ACBE2B.3040909@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239322>

On Sun, Dec 15, 2013 at 3:23 AM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
> On 14/12/13 10:54, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> This is the underlying implementation of git_path(), git_pathdup() a=
nd
>> git_snpath() which will prefix $GIT_DIR in the result string. Put gi=
t_
>> prefix in front of it to avoid the confusion that this is a generic
>> path handling function.#
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  path.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/path.c b/path.c
>> index 4c1c144..06863b7 100644
>> --- a/path.c
>> +++ b/path.c
>> @@ -50,7 +50,7 @@ char *mksnpath(char *buf, size_t n, const char *fm=
t, ...)
>>       return cleanup_path(buf);
>>  }
>>
>> -static char *vsnpath(char *buf, size_t n, const char *fmt, va_list =
args)
>> +static char *git_vsnpath(char *buf, size_t n, const char *fmt, va_l=
ist args)
>
> :-D I renamed this _from_ git_vsnpath() in commit 5b3b8fa2 ("path.c: =
Remove the
> 'git_' prefix from a file scope function", 04-09-2012), because ... w=
ell it's a
> file scope function! (i.e. the git_ prefix implies greater than file =
scope).
> I'm not very good at naming things, so ...

maybe gitdir_vsnpath() then to avoid the global scope prefix git_?
--=20
Duy
