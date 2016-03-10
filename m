From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/1] Introduce a way to create a branch and worktree at
 the same time
Date: Thu, 10 Mar 2016 15:45:10 -0500
Message-ID: <CAPig+cTjD7=jkyvQLwUAec3gNjWLjizqaiKJTu6XbhXHDgF3GA@mail.gmail.com>
References: <cover.1457609615.git.johannes.schindelin@gmx.de>
	<CACsJy8BA7-ev9wTt6K45TgiNxOaBUXbN1P03U4EUAzAPy=7Faw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 21:45:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae7SY-0000r7-SM
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 21:45:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbcCJUpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 15:45:19 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:36641 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932088AbcCJUpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 15:45:16 -0500
Received: by mail-vk0-f66.google.com with SMTP id j65so7587535vkg.3
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 12:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=DwjfFexUFEX+A/y4IEPskVu+V5W475uPFSXWEoDiBT0=;
        b=p2jss0ZEwmaUbYWEEYepUnupJrf6daLVuadtDBjTjQhMLNLu9UFvY2K+dqhYx0KcIX
         GmGcDVPrV20YhWtHgt1CHbldbOTNK6J8uTfiLElpbDLqfGllzzlneZNHGLs9FL5ViNmt
         300e2kJUiyAcI02oB2J+PzUrHAUrLf7/zzgadvR1cB2022Xin3+qsGQ+qedLJR8BMs2H
         hiZCNnSpz6BIeRmT4N+wrT+qrtRkqfEOZHYpr1mz7c/hDQ1dBzM2wruuoUUDat5LiaUc
         J82kKsy88MbmFI60v0+OCAJN9cw3RjHbM1+S29xuzhuKQBbH9yTzIqCI0/4ccHpOGEUi
         teZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=DwjfFexUFEX+A/y4IEPskVu+V5W475uPFSXWEoDiBT0=;
        b=myuYs4gszP6S+z49bjvl92fOGDI+lJTrkztHfzwsvVy1dqIx/CMsxoGFTEC0Siq0F6
         rTl0FTS2Mymj1EMwp/CujxQSrlh6pKw0NiaYYqJh/N/6KOa9Gw5DcYh25tEFtEHbfUie
         Lx5NygSKjN98xtrCOQu0Y+y2csDsuVqwP7wdmwo/Yy9sqFTbujN+LYT2EzDc78Ntf/d2
         lgNRtSJmqnIzAkARyZOc1Bal54R9IBjugdHVXK+eS7RjAk9fsG4ZJjOc2kBE+2aHT290
         xKYjaUX7lJThe+BDHRHwZWx2JwTgAZkdMD7K66M/v1zsrqKIF5kI2bI0WnzrzpKbYvhB
         oATg==
X-Gm-Message-State: AD7BkJJnuk7AZMANI+3bD8Rndv0Ir4C1wJalIK8Mty4kvsgHlVLIhnJVByXhKJq7CV+zSeV52IrSVwdfa9wFEg==
X-Received: by 10.31.168.76 with SMTP id r73mr5861320vke.117.1457642710727;
 Thu, 10 Mar 2016 12:45:10 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 10 Mar 2016 12:45:10 -0800 (PST)
In-Reply-To: <CACsJy8BA7-ev9wTt6K45TgiNxOaBUXbN1P03U4EUAzAPy=7Faw@mail.gmail.com>
X-Google-Sender-Auth: 3pZrGVmcB6VZx-YIFiNLeCpV-0Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288637>

On Thu, Mar 10, 2016 at 6:51 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Mar 10, 2016 at 6:34 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>> The invention of the `git worktree` command changed this developer's
>> working style dramatically. Rather than switching between branches all
>> the time, topic branches are created and checked out in newly-added
>> worktrees, to be reworked and refined until the topic branch is either
>> merged into `master` or abandoned.
>>
>> It gets rather tiresome, and also typo-prone, to call "git branch xyz
>> upstream/master && git worktree add xyz xyz" all the time.
>
> You can actually do "git worktree -b xyz xyz upstream/master" for the
> same effect. Maybe we can avoid "xyz" duplication with "-b -" or a new
> option name?

There's also the even shorter form:

    git worktree add pull-rebase-prefix

which creates both a branch and a worktree named "pull-rebase-prefix".
This assumes that you want the new branch based upon HEAD, which won't
work if your use-case is different and that you're not already at the
desired commit ("origin/master" in your example) when invoking the
command, though.
