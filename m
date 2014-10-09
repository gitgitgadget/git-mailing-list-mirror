From: Ray Donnelly <mingw.android@gmail.com>
Subject: Re: [msysGit] [PATCH 07/14] Fix BASIC_LDFLAGS and COMPAT_CFLAGS for
 64bit MinGW-w64
Date: Thu, 9 Oct 2014 20:25:42 +0100
Message-ID: <CAOYw7dsNQZNYZRz1c7RM0+CuOtzTXMH-2zWJR5MbM_kH9eZ1Eg@mail.gmail.com>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org>
	<1412791267-13356-8-git-send-email-marat@slonopotamus.org>
	<alpine.DEB.1.00.1410092115100.990@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org,
	gitster@pobox.com, msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 09 21:25:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcJLU-0002uN-VH
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 21:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbaJITZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2014 15:25:47 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:46244 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618AbaJITZo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2014 15:25:44 -0400
Received: by mail-wi0-f177.google.com with SMTP id fb4so2822650wid.16
        for <git@vger.kernel.org>; Thu, 09 Oct 2014 12:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PYryr6JP/wOWqEQmW8wVyEeJkswSS8/pQn4n7GygBOA=;
        b=eoco3uWfXUDoredDlA+XqnT8Uu2/WoCmH2II/U27jc4nMiI4HtJbA+zYNfEiCrTG3I
         LTt+4fv5h+xg4BY+8VK19H/VebsCGjJMq4Hj1YuipWuzWSP63+n4MyeiHmoq+ukB4PjZ
         6pNbG43oc+rZfGS5DGP5ObSCwbxmt9vAwChHnqv1yg3e499RqFuQpXeIiJ7MJvLK8ix8
         s92LUPkMuWrqCcpoy4bXwxnAYPWkB+6OOdkRy+kHayShfuOfS1HfIgHoLJJk2wVOIUwx
         DE/yM3qzYTIRJJw2QjVHbidPne/F3B2M93H7h0NKPm6MOT2biQoqEFhvhn8/1xWjtvw3
         3P7A==
X-Received: by 10.194.77.195 with SMTP id u3mr6346167wjw.115.1412882742210;
 Thu, 09 Oct 2014 12:25:42 -0700 (PDT)
Received: by 10.217.160.9 with HTTP; Thu, 9 Oct 2014 12:25:42 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1410092115100.990@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 9, 2014 at 8:22 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 8 Oct 2014, Marat Radchenko wrote:
>
>> +CC_MACH := $(shell sh -c '$(CC) -dumpmachine 2>/dev/null || echo not')
>
> There is a rather huge problem with that. The latest mingw-w64 release,
> 4.9.1, does not do what you expect here: while '.../mingw32/bin/gcc -m32
> -o 32.exe test.c' and '.../mingw32/bin/gcc -m64 -o 64.exe test.c' work
> fine, producing i686 and x86_64 executables respectively,
> '.../mingw32/bin/gcc -dumpmachine' prints i686-w64-mingw32 *always*, even
> when specifying the -m64 option.
>
> So unfortunately, the test introduced by this patch (intended to figure
> out whether the build targets i686, and skip a compiler and a linker
> option otherwise) is incorrect.

Which release are you talking about? Can you point me to the tarball please?

>
> Ciao,
> Johannes
