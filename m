From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: A better git diff --word-diff (--word-diff-regex) ?
Date: Mon, 19 Mar 2012 17:54:55 +0100
Message-ID: <CAA01CsqcDsK2-n6npQiiO2=ux0JdUU-Sq6ceHrc0A9q2hjQC3w@mail.gmail.com>
References: <CAA01CsrJ12LmNYe6ujnDsZecJcGc8mFaB=1GC8-RZzvMYbYuUw@mail.gmail.com>
	<vpqvcm0exc4.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 19 17:55:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9frL-0007wC-Id
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 17:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032021Ab2CSQy5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Mar 2012 12:54:57 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42134 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030563Ab2CSQy4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Mar 2012 12:54:56 -0400
Received: by yenl12 with SMTP id l12so5597136yen.19
        for <git@vger.kernel.org>; Mon, 19 Mar 2012 09:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=rqn1Qo9Dh+8PmXdcuZCRfRvuHqfR+Ctp8M0eBA0o3YA=;
        b=mqkJJwFeIHDO5hlJsseVJrXlgzxClFyDpAw/2DMIuh0192Gy0/z8PyXUJowYKjxrEa
         aWuBCKIUaqIL9zCiE14ZIZAMsYlwgOl5TB3TBtpv9UF7TPtLjqWzu0GrGlIgU0KTP7zl
         juWvrCSA2HqMsnxNObAuMEb4Hz8GdduUZZa9uYaVUJmKjf1840VhnRBPErWwPtp8ugvK
         agpLjvQgHQQA4V0DkxoD+317T8ge3YuBMag+LzvFqxTbP87x1PDqZt/+0uJfiI6C0HIe
         UrakC7UYagdl4lz/ZqYBpDckcVbTasYdfBVXxH+RE1Z5sHLHgMv3gDv+K99fBTQx3IP3
         yH+g==
Received: by 10.50.170.104 with SMTP id al8mr6715969igc.9.1332176095593; Mon,
 19 Mar 2012 09:54:55 -0700 (PDT)
Received: by 10.50.170.40 with HTTP; Mon, 19 Mar 2012 09:54:55 -0700 (PDT)
In-Reply-To: <vpqvcm0exc4.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193441>

On Mon, Mar 19, 2012 at 10:47 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
>
>> Hi,
>>
>> is there a way to configure --word-diff to be a more programming
>> language friendly?
>
> I often use this:
>
> =A0git diff --color-words=3D.
>
> It's rather bad on plain text, since it will try to diff within words=
,
> but works well on source code.

Hi,

thanks for the idea, it's surely useful in many cases, but it can look
confusing on source code too. For example on git b3256eb8b in path.c
one part of the diff is

-                       if (!access(used_path, F_OK)) {
+                       if (!stat(used_path, &st) &&
+                           (S_ISREG(st.st_mode) ||
+                           (S_ISDIR(st.st_mode) &&
is_git_directory(used_path)))) {

and "git diff --word-diff-regex=3D." shows

                        if (![-acces-]s{+tat+}(used_path, [-F-]{+&st) &=
&+}
{+                          (S+}_[-OK-]{+ISREG(st.st_mode) ||+}
{+                          (S_ISDIR(st.st_mode) &&
is_git_directory(used_path))+})) {



--=20
Piotr Krukowiecki
