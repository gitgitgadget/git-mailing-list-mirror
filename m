From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v7 00/31] Support multiple checkouts
Date: Mon, 14 Jul 2014 18:06:22 +0700
Message-ID: <CACsJy8AAfZJtg1MBNmKJcYZ=VKaLV4NWJ0nETk=0uD9XK3+exg@mail.gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
 <1405227068-25506-1-git-send-email-pclouds@gmail.com> <xmqqvbr0zgy1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 13:06:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6e5y-0007F0-3Q
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 13:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753832AbaGNLGy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jul 2014 07:06:54 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:39401 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252AbaGNLGx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jul 2014 07:06:53 -0400
Received: by mail-qg0-f41.google.com with SMTP id q107so1094100qgd.0
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 04:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Ea2kbV/Z3F3hZuMiTN9riNW05SvZENvfVhwp2R+eqFU=;
        b=wjv3HHmUEEckO+2g8uldi1t4LAk3i6wGbIvEEuxcVg1FiRLMgHZBfwy8FKolWxhDle
         4dV+USOtNvJHPCokBjJhJmm+3tlmxJkLZZhCzuqVTSLloUhVCuAWoGESzl5g9SICJ0dR
         ADxsgnamAMhKwIg5wNNWn0K6coBx7pAnSJnBM1h9OaXV/BVE7uOdaxZP/K5t9SKxUCiD
         w3vuqS/qlW7ELh2LE+QLuc3pLg6Tn6ApBhydvJ2Zh0dpfRPvPg82H+NecIgBwZ1q/udS
         /n//8wVuZ9S2JcZqD7oyepiR4m8L8O3s9fRlNoZt7hfls0iNKw2+y89a9dK5tGONwT8b
         XznQ==
X-Received: by 10.140.87.100 with SMTP id q91mr10248841qgd.21.1405336012462;
 Mon, 14 Jul 2014 04:06:52 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Mon, 14 Jul 2014 04:06:22 -0700 (PDT)
In-Reply-To: <xmqqvbr0zgy1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253488>

On Mon, Jul 14, 2014 at 11:45 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>>       fd =3D open(git_path("repos/%s/gitdir", id), O_RDONLY);
>> ...
>> -     while (path[len - 1] =3D=3D '\n' || path[len - 1] =3D=3D '\r')
>> +     while (len && (path[len - 1] =3D=3D '\n' || path[len - 1] =3D=3D=
 '\r'))
>>               len--;
>
> Do we anticipate (or even allow/endorse) that end users will edit
> this file with a random editor?  And, to a lessor degree, the same
> question on the reading side.  Do we encourage users to directly
> read from this file to learn something about their repository?
>
> If we are the only tool that writes into this file, and if we are
> the only tool to be used to read (and use) the contents of this
> file, I do not see the need to cater to LF vs CRLF line endings.

No I don't expect users to go and change these files by themselves.
But once directory structure is documented, other tools might appear
and scripts on Windows may just append CRLF by default.
--=20
Duy
