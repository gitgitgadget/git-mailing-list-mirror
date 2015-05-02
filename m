From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: multiple source file extensions
Date: Sat, 2 May 2015 03:11:37 -0400
Message-ID: <CAPig+cT8kP0NrmXXn-chBU+zjM_28NT5CVivda2NDs_mxuepzQ@mail.gmail.com>
References: <CACnwZYed_aHzLsbkJVm=OnydXw-CPi-Zm9V7928rzvpaFMNENw@mail.gmail.com>
	<CANuW5x3OBWNDnHeVbH7ZQaj5AUAingea6crJ0cF9AHFjcJE_bQ@mail.gmail.com>
	<20150502011100.GB5634@peff.net>
	<20150502020431.GA15775@lanh>
	<CACsJy8C2aztHWHP0_U8VWJxMrT2HE7aYBxDQTnSWS1TVwCnedw@mail.gmail.com>
	<20150502023504.GC587@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Josh Hagins <hagins.josh@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 02 09:11:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoRaR-0008Ef-6Y
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 09:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbbEBHLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2015 03:11:38 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:36122 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbbEBHLh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2015 03:11:37 -0400
Received: by igblo3 with SMTP id lo3so53230197igb.1
        for <git@vger.kernel.org>; Sat, 02 May 2015 00:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=woonwINOCz9hc5fH4yp7xeDYZjl1YgCFoCgrEQpqY2s=;
        b=D6mh+TkpH4LWC+pzV82uqd4XWb0BRcydiev+ouZj7gn3CQqK/lRVkPhIbvxYY7WhZc
         vXeANS/qp662FMpSUEDbf12K5tegxkZQGTv3PI7ztk4gFwI3yrHYXp2Ooi29jpdURNDW
         4w15ex5uDg52SEORc0j23zBgz2dMRC5AkfYdvw+eTbqoTGLfmD9o475zovvNzLt1Rz4V
         l8woDtgNEWoi9Ygwg/m6U6rsnLlr15v4YXO+5605L3P2mRI6dMD6zBx3zrsiX4jTiVXI
         kBa7zN+QxyypZTHf5j8pXH1Dh5ZspoNlWEInHMF/XqwlnspFQpitNc+BfymHORWIX8kU
         hiRg==
X-Received: by 10.107.31.134 with SMTP id f128mr16767227iof.19.1430550697395;
 Sat, 02 May 2015 00:11:37 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Sat, 2 May 2015 00:11:37 -0700 (PDT)
In-Reply-To: <20150502023504.GC587@peff.net>
X-Google-Sender-Auth: aMM16xVz-6Lgi4MyNLfIG8Q-dVA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268222>

On Fri, May 1, 2015 at 10:35 PM, Jeff King <peff@peff.net> wrote:
> On Sat, May 02, 2015 at 09:11:16AM +0700, Duy Nguyen wrote:
>> On Sat, May 2, 2015 at 9:04 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> > On Fri, May 01, 2015 at 09:11:01PM -0400, Jeff King wrote:
>> >> Unfortunately there is no way to use curly braces with git's pathspec,
>> >> so you have to write out three separate `*` arguments rather than using
>> >> the shell-style {cc,cpp,h}.
>> >
>> > Noted. Need to add curly brace support in pathspec :-)
>>
>> Naah people can just do
>>
>> git grep pattern -- '*'.{cc,cpp,h}
>>
>> and bash will take care of expanding it into three separate arguments.
>> Obscure, but pathspec is also obscure..
>
> Thanks, I had a vague notion that I should be able to convince the shell
> to do it for me, but of course "*.{cc,cpp,h}" doesn't work. I always
> forget about breaking up parameters into two parts with different
> quoting like this.
>
> I agree we don't really need curly braces in pathspecs. :)

However, neither POSIX shells nor the Windows command interpreter
support curly-brace alternation.
