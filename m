From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH 0/5] Use watchman to reduce index refresh time
Date: Mon, 2 Nov 2015 15:54:57 +0100
Message-ID: <CAHVLzcn3j8eLi9VrNoZjyOZ2UzE7=NYF1bqB9UyKmghUoUw1Zg@mail.gmail.com>
References: <1446386146-10438-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 15:55:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtGW4-0005TF-2m
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 15:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853AbbKBOzT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Nov 2015 09:55:19 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:35775 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbbKBOzS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Nov 2015 09:55:18 -0500
Received: by lfbn126 with SMTP id n126so62512947lfb.2
        for <git@vger.kernel.org>; Mon, 02 Nov 2015 06:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=cWoVnMTwYWgAktHAhNXIU6NuhTkS09Lc8WSr7WNtYwU=;
        b=VDZtX+2un7J5sUWLGg0bV/mxzQsEMN39+ECVu8GnZkS5HzMMGtOSGQ64JNlF2XMbo1
         wnrO1/aN57vcsjR2d9OHs7RDnJFzMOKbNkFYG+IHqXvxlACorW47GAw0gtHBKiPN2Zj1
         tfgI9ucKl19RUbI4weiNRslF8EV6IC7BNN6sj3b0tExDrJYaohIRfuuTgJRem2HdvF3K
         uHBB9Ri1NaMnSUjH2tUUtcQIJF0IAyz7nmUTKsZU5vEKJ4Rfd+siW563RATx/OoHNw3L
         he5l5qMqpTRY9sglafxuMr25d9MMpFWzu7sxYDhV8njvacqolmo/15x+sQwUsHpr8C90
         J8EQ==
X-Received: by 10.25.17.103 with SMTP id g100mr6746305lfi.110.1446476117056;
 Mon, 02 Nov 2015 06:55:17 -0800 (PST)
Received: by 10.25.198.195 with HTTP; Mon, 2 Nov 2015 06:54:57 -0800 (PST)
In-Reply-To: <1446386146-10438-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280692>

On Sun, Nov 1, 2015 at 2:55 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:

Hi Duy,

> This series builds on top of the index-helper series I just sent and
> uses watchman to keep track of file changes in order to avoid lstat()
> at refresh time. The series can also be found at [1]
>
> When I started this work, watchman did not support Windows yet. It
> does now, even if still experimental [2]. So Windows people, please
> try it out if you have time.
>
> To put all pieces so far together, we have split-index to reduce inde=
x
> write time, untracked cache to reduce I/O as well as computation for
> .gitignore, index-helper for index read time and this series for
> lstat() at refresh time. The remaining piece is killing lstat() from
> untracked cache, but right now it's just some idea and incomplete
> code.

Did you manage to measure the speedup introduced by this series?

Ciao,
--=20
Paolo
