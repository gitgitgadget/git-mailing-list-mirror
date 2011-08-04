From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: gitweb highligh generate illegal char when the content had utf-8 chars
Date: Thu, 4 Aug 2011 11:39:37 +0200
Message-ID: <CANQwDwcR5sS3-m6SifQbjU1VoS5bxRRGJNZZj0U+zp=zsoGbLA@mail.gmail.com>
References: <20110804053123.GA13198@greatfirst.com> <CALkWK0kURz_Rax-JOPT2sW1x4VrqWk=KDjUzzw4apacDo1UTyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: zzs <zzs213@126.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 11:40:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QouPP-0002Ix-NW
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 11:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974Ab1HDJj7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Aug 2011 05:39:59 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:58882 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594Ab1HDJj6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2011 05:39:58 -0400
Received: by qyk15 with SMTP id 15so849893qyk.19
        for <git@vger.kernel.org>; Thu, 04 Aug 2011 02:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Lfu5gRVcxTgJTDxC70FRmW8Q7hCB0y4MBY0Us84bJNw=;
        b=P8qGVKQT4+2oUaSq4noJnCMR/gfgRWBRdkoVj6UqQmLzkHRRckRYLY2bkcfG13Z9t5
         ZLC3CKhwh+lVg8+lHLcooVQ3WmG0q6fxPzgGEnlwadmY53Lu6xNJVgIY6VGVBj9P7FaT
         VVc8clCPzJEKpvuqdp/sT+GLKYChUQ7O0HJOk=
Received: by 10.229.69.154 with SMTP id z26mr397267qci.243.1312450797464; Thu,
 04 Aug 2011 02:39:57 -0700 (PDT)
Received: by 10.229.31.209 with HTTP; Thu, 4 Aug 2011 02:39:37 -0700 (PDT)
In-Reply-To: <CALkWK0kURz_Rax-JOPT2sW1x4VrqWk=KDjUzzw4apacDo1UTyg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178712>

On Thu, Aug 4, 2011 at 11:11 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> zzs writes:

>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index dab89f2..48def38 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -6465,7 +6465,7 @@ sub git_blob {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$nr++;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$line =3D untabify($l=
ine);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf qq!<div class=3D=
"pre"><a id=3D"l%i" href=3D"%s#l%i" class=3D"linenr">%4i</a> %s</div>\n=
!,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$nr, es=
c_attr(href(-replay =3D> 1)), $nr, $nr, $syntax ? $line : esc_html($lin=
e, -nbsp=3D>1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$nr, es=
c_attr(href(-replay =3D> 1)), $nr, $nr, $syntax ? to_utf8($line) : esc_=
html($line, -nbsp=3D>1);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0close $fd
>
> Looks sane, but I don't know enough about Gitweb to comment.
> +CC: Jakub, who can probably say more.

This looks correct.

--=20
Jakub Narebski
