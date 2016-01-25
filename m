From: Ray Donnelly <mingw.android@gmail.com>
Subject: Re: [PATCH 16/19] mingw: avoid absolute path in t0008
Date: Mon, 25 Jan 2016 19:31:07 +0000
Message-ID: <CAOYw7dsBPCXhUGfcZs4GGe8P+=mSCHdhEQ3wYRExrQSJs7Nq6g@mail.gmail.com>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
	<7c35a7b9c65d9febb6af1b50907988974bca3fbd.1453650173.git.johannes.schindelin@gmx.de>
	<xmqq60yibe89.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1601251747050.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 25 20:31:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNmr5-0000dh-Ba
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 20:31:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbcAYTbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 14:31:10 -0500
Received: from mail-lb0-f196.google.com ([209.85.217.196]:34529 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932246AbcAYTbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 14:31:09 -0500
Received: by mail-lb0-f196.google.com with SMTP id oe3so7356101lbb.1
        for <git@vger.kernel.org>; Mon, 25 Jan 2016 11:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=t36wKqLQfbf/pC2GkvaF9voQIVAMEDLCvrsBSTgnER4=;
        b=DUdRquFWtuIO6/jGriStoUk/EMpew6SJLo/4QyC96npmDZua8GUwZ/ecvfJZj9geVJ
         29iTVqvq1ZUveHqAsl7gFDMOSteunPWjeDAcR1SeYndxM8GkLT+HHI9aEfOicF60Zm+Q
         0mHG98YfzlYwbtiCB7qM/Puy6Mlqj1iyWeZgZHsZlmhkPZY/N85WSFm0ZvNmJ+Q1yF6h
         wIzNc4pOvHHy3vsWavxhcyNjFxoHEhgSECaTKjhg5pTCQteF4qHQAgEc5Cwo8OLRU6+k
         /1i/AyCASoLB8skq+/nPQK0t3We3Eu43wakPNPYVXLa1JfMBACkNHchxkiwrb6SY7gxO
         pEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=t36wKqLQfbf/pC2GkvaF9voQIVAMEDLCvrsBSTgnER4=;
        b=hQdnwcNsHk9XtbaoynwsIdHuC6AK/8ngj6CfjSZZXg0ROQUz9h+zS9qWOQ2Mri17Cz
         5Gfi4JaySmbqWIYUJBgDAVnzAwAG9tTyH2KXM+vdDE+b0xz4el4GrMTyknwuBkrSY/xo
         JdqVlXvaIerBf/tJR0g63xSd5esyxfYDzmfZ73lkQhD+Fo5Qkt0DUKivxd0F2WPUxtAx
         v9qpQ3DXv+/v/8v53s7Ho/kDvNDHvhwrgQeA4XYks3qZWLixeILZBsKzPQH2wACrxeFB
         Ra/2GONvVyY/L/z5GwgO69JksAfqHJ40sXSDiURgdBRSFMbY0reN12xqPWjWOnVHIV3O
         xbrQ==
X-Gm-Message-State: AG10YOSbWGt8uq+z8ZL9uQUbLBJ84Lh+Let50aN/41bxkF7Ti1W41o1k3/iyz7rXhP0jNzkwS91jzEj9NavPrg==
X-Received: by 10.112.199.67 with SMTP id ji3mr7186278lbc.105.1453750267564;
 Mon, 25 Jan 2016 11:31:07 -0800 (PST)
Received: by 10.112.136.200 with HTTP; Mon, 25 Jan 2016 11:31:07 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1601251747050.2964@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284751>

On Mon, Jan 25, 2016 at 4:48 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Junio,
>
> On Sun, 24 Jan 2016, Junio C Hamano wrote:
>
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>
>> > From: Pat Thoyts <patthoyts@users.sourceforge.net>
>> >
>> > The test separator char is a colon which means any absolute paths on
>> > Windows confuse the tests that use global_excludes.
>> >
>> > Suggested-by: Karsten Blees <karsten.blees@gmail.com>
>> > Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
>> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> > ---
>> >  t/t0008-ignores.sh | 8 +++++++-
>>
>> Is the fact that $global_excludes is specified using an absolute
>> path significant to the correctness of this test script?
>
> Apparently not. So I followed your suggestion and made this independent
> of the OS:
>
>         https://github.com/dscho/git/commit/0b9eb308
>
>> A larger question is if it would make more sense for Git ported to
>> Windows environment to use semicolon (that is the element separator
>> for %PATH% in the Windows land, right?) instead where POSIXy port
>> would use colon as the separator.  A variable that is a list of
>> locations (e.g. $PATH) makes little sense when elements can only be
>> relative paths in practice.
>
> Oh my... I was not looking for more work ;-)
>
> Seriously again, I do agree with the suggestion to use semicolons on
> Windows as path lists' separators instead of colons.

It definitely makes things easier from the MSYS2 path conversion
perspective. Anything that can be done to make this easier is hugely
appreciated.

>
> Ciao,
> Dscho
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
