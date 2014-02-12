From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: pack bitmap woes on Windows
Date: Wed, 12 Feb 2014 12:56:48 +0100
Message-ID: <CABPQNSZAK2d1hSQNG6uoNHoTJGCiq2UnaBP+_RJkPi47xaxGPQ@mail.gmail.com>
References: <52FB2268.7080906@viscovery.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Vicent_Mart=ED?= <tanoku@gmail.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Feb 12 12:57:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDYRa-0006yw-K4
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 12:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbaBLL5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 06:57:30 -0500
Received: from mail-oa0-f44.google.com ([209.85.219.44]:35688 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbaBLL53 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 06:57:29 -0500
Received: by mail-oa0-f44.google.com with SMTP id g12so10806692oah.3
        for <git@vger.kernel.org>; Wed, 12 Feb 2014 03:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=qlCRqazf1zQKyIAiEIK1ZWPgWySOw/FBF8ZsogJz3No=;
        b=lpC5ttI5SgaB7Tfxr2dlPny2jDi6BI6YNKz1Rwuj5soB1MB9+FyrMvzpqDfsVlUToH
         rlXdzTQxsPmjv4XHIhnvn4kzZA0pw08tzin5b2e81zvzLdrDqVk/AtA8B7AVPnpLJKZY
         Qu0Jyl7MS1Au3Qw2CGKtTmkZQX9tWQs+ELR4GgSgKR13mOSTu1p7Yc2/thotFWBVx7Ma
         FWFKqAjUcdaKJMi3QDeJ8UUx2Zu8xZP+aH4xbbUPrI+spkPi9824FoT6JrWEERskx5YH
         bRupY+lnXVCO7TvcnPUDApr1IZWRh9ofwB0s+dcosUZvzpk2Au2fd+k3WUyIqId/ndts
         3+Xg==
X-Received: by 10.182.148.106 with SMTP id tr10mr74006obb.65.1392206249118;
 Wed, 12 Feb 2014 03:57:29 -0800 (PST)
Received: by 10.76.85.103 with HTTP; Wed, 12 Feb 2014 03:56:48 -0800 (PST)
In-Reply-To: <52FB2268.7080906@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241984>

On Wed, Feb 12, 2014 at 8:27 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Running test suite of 'next' on Windows fails in t5310-pack-bitmaps with
> the following symptoms. I haven't followed the topic. Have there been
> patches floating that addressed the problem in one way or another?
>
> (gdb) run
> Starting program: D:\Src\mingw-git\t\trash directory.t5310-pack-bitmaps/..\..\git.exe rev-list --test-bitmap HEAD
> [New thread 3528.0x8d4]
> Bitmap v1 test (20 entries loaded)
> Found bitmap for 537ea4d3eb79c95f602873b1167c480006d2ac2d. 64 bits / 15873b36 checksum
>
> Breakpoint 1, die (err=0x5939e9 "Out of memory, realloc failed") at usage.c:97
> 97              if (die_is_recursing()) {
> (gdb) bt
> #0  die (err=0x5939e9 "Out of memory, realloc failed") at usage.c:97
> #1  0x00487c4c in xrealloc (ptr=0x12b10008, size=837107040) at wrapper.c:109

~800 megs is a pretty large allocation for 32-bit systems. What gives?
