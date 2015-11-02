From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/5] Use watchman to reduce index refresh time
Date: Mon, 2 Nov 2015 20:23:52 +0100
Message-ID: <CACsJy8DzSEVJYc85-3vSAZ8wB1pR9TLz0RrKyKFfHth9Tq+xyg@mail.gmail.com>
References: <1446386146-10438-1-git-send-email-pclouds@gmail.com> <CAHVLzcn3j8eLi9VrNoZjyOZ2UzE7=NYF1bqB9UyKmghUoUw1Zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 20:24:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtKiS-0001JZ-EE
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 20:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbbKBTYY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Nov 2015 14:24:24 -0500
Received: from mail-lb0-f180.google.com ([209.85.217.180]:34506 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbbKBTYX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Nov 2015 14:24:23 -0500
Received: by lbbwb3 with SMTP id wb3so95014809lbb.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2015 11:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=eB5bku2lY8RwO9iuvvb4ekXRTwA+M+p+Iy9NABe54/s=;
        b=Ds56pwD3ILI0Kl+/Z5WBOBBtbYio6M6JarO0EwxUMLHpa7p7RZE3jFkKZXLRXg1Qqo
         B+bP/l48Jq025xiP0n7qZMnjVFW9DexTOybpffTfviZpLJdNeUQXEHhOGHJ9cALehpNM
         B+FrsqeKBaXOUxf93tQUrQ8WncS4bViDKElPaHWcT3aH/7PKjGTulvZqYQbeQHOS4Mvx
         VDQBZjNKwiwsFr1Mfv+MGgAtI83Icb/8yXVrd+GvhW65LVxuqslPAQVXj29nFdhux0hF
         NtcMS2cyP+IrCc1nmS5F2/9iP0ewcckOXPRbzubm3cp8Z8aS35Vqv+C3qc/HVdPc/YRP
         zF/A==
X-Received: by 10.112.147.10 with SMTP id tg10mr11197851lbb.58.1446492262476;
 Mon, 02 Nov 2015 11:24:22 -0800 (PST)
Received: by 10.112.255.229 with HTTP; Mon, 2 Nov 2015 11:23:52 -0800 (PST)
In-Reply-To: <CAHVLzcn3j8eLi9VrNoZjyOZ2UzE7=NYF1bqB9UyKmghUoUw1Zg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280711>

On Mon, Nov 2, 2015 at 3:54 PM, Paolo Ciarrocchi
<paolo.ciarrocchi@gmail.com> wrote:
> On Sun, Nov 1, 2015 at 2:55 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy <pclouds@gmail.com> wrote:
>
> Hi Duy,
>
>> This series builds on top of the index-helper series I just sent and
>> uses watchman to keep track of file changes in order to avoid lstat(=
)
>> at refresh time. The series can also be found at [1]
>>
>> When I started this work, watchman did not support Windows yet. It
>> does now, even if still experimental [2]. So Windows people, please
>> try it out if you have time.
>>
>> To put all pieces so far together, we have split-index to reduce ind=
ex
>> write time, untracked cache to reduce I/O as well as computation for
>> .gitignore, index-helper for index read time and this series for
>> lstat() at refresh time. The remaining piece is killing lstat() from
>> untracked cache, but right now it's just some idea and incomplete
>> code.
>
> Did you manage to measure the speedup introduced by this series?

It was from last year. I may have measured it but because I didn't
save it in the commit message, it was lost anyway. Installing watchman
and measuring with webkit.git soon..
--=20
Duy
