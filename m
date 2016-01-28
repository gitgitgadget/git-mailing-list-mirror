From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 11/20] tests: turn off git-daemon tests if FIFOs are
 not available
Date: Thu, 28 Jan 2016 03:21:56 -0500
Message-ID: <CAPig+cRXV-nv1ZZv1MrujdF3YfZMgwusTcBHAXnyCRaYyXmRWg@mail.gmail.com>
References: <cover.1453818789.git.johannes.schindelin@gmx.de>
	<cover.1453911367.git.johannes.schindelin@gmx.de>
	<35b05b7e0d01bf550b698d3c6ecc577eb80d4149.1453911367.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 28 09:22:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOhqC-00037T-RT
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 09:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965822AbcA1IWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 03:22:03 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:35045 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965801AbcA1IV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 03:21:57 -0500
Received: by mail-vk0-f66.google.com with SMTP id e185so1245103vkb.2
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 00:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=qdl9Dp5Z7zdYr0/WKa4x+3v3usRKyHziE1tAUnPoDtw=;
        b=Q9/VROAjO1ASMzQqP2J+AVBciY5pQjbRRU+rSU2Bs4rIRwcallExja2iP8o5MX7/YA
         ZUWX74M/5K/j6M2ZasQoaSlOBOZAZC2+0tMRfWmm2bi8C7VIBcbXJjABR6ZBw3zTyuLY
         7odJcjPbpnVK3kr6n0ZI4nWmiDg5x0x/5enFPTRCBZnbHzAmiWf/et9celMMcBsp4pj+
         dZudWcxvAfmEcMC1pNBVX/XxTtNnCU/kami0oSCZTNYe0zyC2P7z/wvjaZk5xpgHcmy+
         dttihothocoxfGSDmNndMqgduEkhO+7ODC3Bfy2S2P+asIYNFFnN6+ngiW7aXz6OELoG
         rfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=qdl9Dp5Z7zdYr0/WKa4x+3v3usRKyHziE1tAUnPoDtw=;
        b=DYAGub3PUgqfGqsgxfo8CcNw7r6wyi0mFoEKL5dHcxbE8zUxULybjOLVoBEt2qA1hI
         q9L9/13i4U8AFfeFoQbxu+DFfQpLFETwKSlN70exQ/Ecscy2sYr5KyoQ7O6N3vBOtRLO
         hhVbTWPrXARoQi3PFpmdWwMThBrgy2nV5qEtpPJW7isX1fJpVNtnncczsT5uI6lp3Cwn
         +1+Lp5+kuQsW643MzWjB/mhSq6A+SHtMepoGy6eXZwU5Kzh6anQKlvzq/XP6nVubl64A
         MNCNe8CltxkGG9HD1IV8egGXUDD4HMlWfvbnCE+unxJ9xqz+mCgu9vjqN3wSJEg8DHg7
         JcGg==
X-Gm-Message-State: AG10YORFQF1sy3spTCe7G6pp6ETqiu21CHzqic5UoNf16fbOczQeo+GLW0BDI+FqqG/+5/VMCEdNkajzPK+DjQ==
X-Received: by 10.31.168.76 with SMTP id r73mr1155563vke.117.1453969316110;
 Thu, 28 Jan 2016 00:21:56 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 28 Jan 2016 00:21:56 -0800 (PST)
In-Reply-To: <35b05b7e0d01bf550b698d3c6ecc577eb80d4149.1453911367.git.johannes.schindelin@gmx.de>
X-Google-Sender-Auth: C3Bs5onV9P0kCeIdDdktsit1NFY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284986>

On Wed, Jan 27, 2016 at 11:19 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> The Git daemon tests create a FIFO first thing and will hang if said
> FIFO is not available.
>
> This is a problem with Git for Windows, where `mkfifo` is an MSYS2
> program that leverages MSYS2's POSIX emulation layer, but
> `git-daemon.exe` is a MINGW program that has not the first clue about
> that POSIX emulation layer and therefore blinks twice when it sees
> MSYS2's emulated FIFOs and then just stares into space.
>
> This lets t5570-git-daemon.sh and t5811-proto-disable-git.sh pass.
>
> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
> @@ -23,6 +23,11 @@ then
> +if ! test_have_prereq PIPE

Maybe:

    if test_have_prereq !PIPE

?

> +then
> +       test_skip_or_die $GIT_TEST_GIT_DAEMON "file system does not support FIFOs"
> +fi
> +
>  LIB_GIT_DAEMON_PORT=${LIB_GIT_DAEMON_PORT-${this_test#t}}
>
>  GIT_DAEMON_PID=
> --
> 2.7.0.windows.1.7.g55a05c8
