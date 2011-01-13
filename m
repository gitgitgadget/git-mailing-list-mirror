From: JT Olds <jtolds@xnet5.com>
Subject: Re: Git Rebase blows away GIT_AUTHOR_NAME
Date: Thu, 13 Jan 2011 10:52:48 -0700
Message-ID: <AANLkTimf2rwKqyWwQbdj7cjS8YcQwCXYGRCvQbZ5HZ19@mail.gmail.com>
References: <AANLkTinMX0yEPvSc-c=96R42SbFZTjW5Mnveuxk3ZHS=@mail.gmail.com>
	<20110112182150.GC31747@sigill.intra.peff.net>
	<AANLkTimanDRHwoqSj7i9sVCZkze1L3Qp-zFYwTwHAOHX@mail.gmail.com>
	<AANLkTimvK3p3M8kbGzLxyhchoFONiD4=FGPWxxs=i0GA@mail.gmail.com>
	<AANLkTikqfX3jhSdP5xhFj=VktqW2S6AeGL_MF18g8ZA_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Jan 13 19:06:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdRYt-0001Le-9g
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 19:06:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932971Ab1AMSGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jan 2011 13:06:10 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49619 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932835Ab1AMSGI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jan 2011 13:06:08 -0500
Received: by eye27 with SMTP id 27so1001268eye.19
        for <git@vger.kernel.org>; Thu, 13 Jan 2011 10:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=gKNWiIIpEO4qNhkH1RXylplK0UtKhpWoPN7EYL+Oo+s=;
        b=jTY1aSFxvjeHuQnK25KjCWoMV9raGNVA/YmlcseLhQjfC7fVsCco5D6nLgx3fQeu4s
         bHQvAO7F7lYasFuQH9QlxtxXKaSa+2lGsDpP9gUFO62/O/XFFMlsbq0nHdLfE6K9TfIf
         9c0riCarvHdZYO9CwhsQQvp+DiJbFEXDprqtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=TxJCSlv2dNhJ0QdTSJ2Sxmf9rypwznK6HPAqxvfdmsrq2gm7eohcs8iZ30aN2ybUS0
         KPiS22vimaZ0JcgHIpp+yoYB8jsGx80XIHBpaABf4pIN1pfhResatj2b1oMQ7Wdz3oYN
         NtFu1X2aBgKpf0S8zBNybL4oHdDAdfI1J5/ms=
Received: by 10.216.173.7 with SMTP id u7mr887370wel.50.1294941168567; Thu, 13
 Jan 2011 09:52:48 -0800 (PST)
Received: by 10.216.2.194 with HTTP; Thu, 13 Jan 2011 09:52:48 -0800 (PST)
In-Reply-To: <AANLkTikqfX3jhSdP5xhFj=VktqW2S6AeGL_MF18g8ZA_@mail.gmail.com>
X-Google-Sender-Auth: LZDlipKTshLbZl4hNS3JLLzJhU0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165060>

Oh thank you Erik, it's great to just know what the problem is. I've
been feeling like some voodoo was happening.

What are the chances of decreasing that lower bound of author name size? :)

-JT

On Thu, Jan 13, 2011 at 10:47 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Thu, Jan 13, 2011 at 6:11 PM, JT Olds <jtolds@xnet5.com> wrote:
>> I got a copy of git-sh-setup. All of my commits (that have either
>> worked or that I fixed) look like this:
>>
>> GIT_AUTHOR_NAME='JT'
>> GIT_AUTHOR_EMAIL='jt@instructure.com'
>> GIT_AUTHOR_DATE='1294756950 -0700'
>> Author: jt@instructure.com
>> Email: jt@instructure.com
>> Subject: removing nondeterminism from test
>> Date: Tue, 11 Jan 2011 07:42:30 -0700
>>
>> Should "Author" be my name? Could that be what's going on? I don't
>> even know where that gets set. The ones that I failed to notice that
>> they broke before I pushed them look like this:
>>
>
> "git am" (which git rebase builds on) requires the author name to be
> at least three characters long. This is a problem that has been
> discussed before, see
> <AANLkTinqTL7gH4CHEfy8UrhK13xcO_3UzgIyQka00MAh@mail.gmail.com>:
>
> http://mid.gmane.org/AANLkTinqTL7gH4CHEfy8UrhK13xcO_3UzgIyQka00MAh@mail.gmail.com
>
