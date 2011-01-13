From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Git Rebase blows away GIT_AUTHOR_NAME
Date: Thu, 13 Jan 2011 19:20:38 +0100
Message-ID: <AANLkTik15iV9SOv6rRL5+DQkAZ4JwBGTS+gqS3nXy2hN@mail.gmail.com>
References: <AANLkTinMX0yEPvSc-c=96R42SbFZTjW5Mnveuxk3ZHS=@mail.gmail.com>
 <20110112182150.GC31747@sigill.intra.peff.net> <AANLkTimanDRHwoqSj7i9sVCZkze1L3Qp-zFYwTwHAOHX@mail.gmail.com>
 <AANLkTimvK3p3M8kbGzLxyhchoFONiD4=FGPWxxs=i0GA@mail.gmail.com>
 <AANLkTikqfX3jhSdP5xhFj=VktqW2S6AeGL_MF18g8ZA_@mail.gmail.com> <AANLkTimf2rwKqyWwQbdj7cjS8YcQwCXYGRCvQbZ5HZ19@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: JT Olds <jtolds@xnet5.com>
X-From: git-owner@vger.kernel.org Thu Jan 13 19:21:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdRnK-0002mt-V8
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 19:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932812Ab1AMSVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jan 2011 13:21:05 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:55292 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756855Ab1AMSVD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jan 2011 13:21:03 -0500
Received: by ewy5 with SMTP id 5so1052982ewy.19
        for <git@vger.kernel.org>; Thu, 13 Jan 2011 10:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=FiJMcWclUYawCgaokyN79rK1Bv0IWKnsRqsM0UVedOo=;
        b=G4Z8rznL1DIkJrZXBhMCzgTEzNz3mcjWGPIxjHVwRmRzxKgTvTV2Hl3joHdXGJj10g
         syV3jonXpfrcwV+g4qNDnolWBQKVKe3MjHp9BvnkqKFatIM16+ycb8dc2S9xhix6USyV
         jDHXp2sN6yu9FKTqk95cSV2EPBFXGEl4rYKaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=vwwUdx3VdgSnWgDT59tpqrL2iVOrOgjjKv2IYNvXAAGtFhPVuz9AG1Ay9jzTOSpFHA
         Qlz6eKHhdvvaP3pChF2cFgNZ1Cwsk2sFWSsaYKZ38LR9f0eVt7iEXAsPhN4Fd9QhjEaq
         em4NroipmS1DQ37n5acksChRgpNVIhiNq1zxM=
Received: by 10.223.87.80 with SMTP id v16mr2651374fal.128.1294942861754; Thu,
 13 Jan 2011 10:21:01 -0800 (PST)
Received: by 10.223.79.3 with HTTP; Thu, 13 Jan 2011 10:20:38 -0800 (PST)
In-Reply-To: <AANLkTimf2rwKqyWwQbdj7cjS8YcQwCXYGRCvQbZ5HZ19@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165061>

In the future please don't top-post, as it makes the discussion harder
for other people to follow. I've fixed the quoting for now, though.

On Thu, Jan 13, 2011 at 6:52 PM, JT Olds <jtolds@xnet5.com> wrote:
> On Thu, Jan 13, 2011 at 10:47 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>> On Thu, Jan 13, 2011 at 6:11 PM, JT Olds <jtolds@xnet5.com> wrote:
>>> I got a copy of git-sh-setup. All of my commits (that have either
>>> worked or that I fixed) look like this:
>>>
>>> GIT_AUTHOR_NAME='JT'
>>> GIT_AUTHOR_EMAIL='jt@instructure.com'
>>> GIT_AUTHOR_DATE='1294756950 -0700'
>>> Author: jt@instructure.com
>>> Email: jt@instructure.com
>>> Subject: removing nondeterminism from test
>>> Date: Tue, 11 Jan 2011 07:42:30 -0700
>>>
>>> Should "Author" be my name? Could that be what's going on? I don't
>>> even know where that gets set. The ones that I failed to notice that
>>> they broke before I pushed them look like this:
>>>
>>
>> "git am" (which git rebase builds on) requires the author name to be
>> at least three characters long. This is a problem that has been
>> discussed before, see
>> <AANLkTinqTL7gH4CHEfy8UrhK13xcO_3UzgIyQka00MAh@mail.gmail.com>:
>>
>> http://mid.gmane.org/AANLkTinqTL7gH4CHEfy8UrhK13xcO_3UzgIyQka00MAh@mail.gmail.com
>>
>
> Oh thank you Erik, it's great to just know what the problem is. I've
> been feeling like some voodoo was happening.
>
> What are the chances of decreasing that lower bound of author name size? :)
>

It's a matter of editing the function called "get_sane_name" in
builtin/mailinfo.c.

But simply changing the bound doesn't mean you're in the clear. If any
other people you work with end up rebasing any patches you've written,
the same problem will manifest. There's a lot of people using some
really old versions of Git.

And then it's the question of why this is done in the first place. I
don't know, but I suspect Linus has his reasons. Besides, a name of
two characters aren't really sane. You'd need at least three
characters to form a first/last name pair.

I'd recommend that you use a longer name, really.
