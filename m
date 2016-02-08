From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] t9100: fix breakage when SHELL_PATH is not /bin/sh
Date: Mon, 8 Feb 2016 17:34:14 +0100
Message-ID: <CAA19uiRsdc0eyZDqGtjpAcLyn=hyO4DXbhDbd=hoj8OxK2GK3A@mail.gmail.com>
References: <982f6f499c988e1063275e2951c9856d622a83f3.1454872161.git.git@drmicha.warpmail.net>
	<20160208135013.GA27054@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 08 17:34:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSolc-0002is-S1
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 17:34:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134AbcBHQeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 11:34:20 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:42675 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752996AbcBHQeQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Feb 2016 11:34:16 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 968A020930
	for <git@vger.kernel.org>; Mon,  8 Feb 2016 11:34:15 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 08 Feb 2016 11:34:15 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=CB8qJ
	T+FykvelRlTS0ZWXwybgf0=; b=k57kPhGJ1JSWw76Nw2Hj31Oa8vyUSrK0WZEOC
	UW1V1GjsD2yiZ1o+e24lwk/sKwTlfApqFi1rg8tI0+CqVHF6z2Dl2xdv2f3+haJP
	C3pGcw2p0u7fAzuxsgnPultqUDwV8Hf739BsgUuInPB4Q0vYOARxUNU0kK2MPzGo
	4aLBEU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=CB8qJT+FykvelRlTS0ZWXwybgf0=; b=Cm9YP
	dhp01OE6phXZlN3xD5dcYPCdhCsf8+0IvR8PqcTb9LAfa+UzVrtCTok4pFTmUZpX
	aYAGIj3OYbVaFsnAejhPNdRRi6ARksxlspJGUHh+2C1LXQMoQNHrBqwfS80lYZPF
	9ClvKQ06oL5CyGQuGGzSPCvE/lI9FpnAHO0BXU=
X-Sasl-enc: YP40g+XZJLwM0TPkMjxOTIseLzR1/l4uDX54cTSirvrL 1454949255
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
	by mail.messagingengine.com (Postfix) with ESMTPA id 2D2D8C0001A
	for <git@vger.kernel.org>; Mon,  8 Feb 2016 11:34:15 -0500 (EST)
Received: by mail-wm0-f44.google.com with SMTP id p63so123492326wmp.1
        for <git@vger.kernel.org>; Mon, 08 Feb 2016 08:34:15 -0800 (PST)
X-Gm-Message-State: AG10YORzkcXEkTqVUrw23oULDh5ZM+oCJ238n2mxeLJwwcHecwdOFE2KPNzg4cnQ1zfqtKVEdLJ7UjTDb735Cg==
X-Received: by 10.194.123.228 with SMTP id md4mr28906492wjb.6.1454949254410;
 Mon, 08 Feb 2016 08:34:14 -0800 (PST)
Received: by 10.194.81.69 with HTTP; Mon, 8 Feb 2016 08:34:14 -0800 (PST)
In-Reply-To: <20160208135013.GA27054@sigill.intra.peff.net>
X-Gmail-Original-Message-ID: <CAA19uiRsdc0eyZDqGtjpAcLyn=hyO4DXbhDbd=hoj8OxK2GK3A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285780>

[warning: experimenting with forwarding to and replying from gmail...]
2016-02-08 14:50 GMT+01:00 Jeff King <peff@peff.net>:
> On Sun, Feb 07, 2016 at 08:11:37PM +0100, Michael J Gruber wrote:
>
>> bcb11f1 (mingw: mark t9100's test cases with appropriate prereqs, 2016-01-27)
>> replaced "/bin/sh" in exec.sh by the shell specified in SHELL_PATH, but
>> that breaks the subtest which checks for a specific checksum of a tree
>> containing.
>>
>> Revert that change that was not explained in the commit message anyways
>> (exec.sh is never executed).
>
> I think this just re-breaks things on Windows. That first setup test
> used "chmod +x" (which is brought back by your patch), without having
> the POSIXPERM prerequisite.
>
> We probably do not want to mark the whole setup test as POSIXPERM, as
> that would effectively break all of the other tests on Windows. The rest
> of the tests need to be able to work whether or not the "chmod +x" was
> run. It may be simpler to just break the executable-bit tests, including
> setup, out to their own section of the script.
>

The commit message does not explain that part of the patch at all - to
me it looks as if the direct "echo" and "chmod +x" is simply replaced
by calling a function which does just that, or more exactly, not quite:

> That being said, t9100 seems to pass for me, even at bcb11f1. Can you
> show us the breakage you are seeing?
>
> -Peff

SHELL_PATH=/bin/dash (in config.mak)

As I explained in my commit message, the problem arises when
SHELL_PATH is not "/bin/sh" and, consequently,
the generated "exec.sh" results in a blob with a different sha1.

Just try "/usr/bin/sh" for good measure...

Michael

[This time plain text, hopefully, and thus vger-palatable. How do I
make this default...]
