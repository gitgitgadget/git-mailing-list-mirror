From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/1] Introduce a way to create a branch and worktree at
 the same time
Date: Tue, 15 Mar 2016 17:34:37 +0700
Message-ID: <CACsJy8B+c8=Y0Lb-TxjGF4689xP2Vyqjp4Q6CuffTLDWDMh3gg@mail.gmail.com>
References: <cover.1457609615.git.johannes.schindelin@gmx.de>
 <CACsJy8BA7-ev9wTt6K45TgiNxOaBUXbN1P03U4EUAzAPy=7Faw@mail.gmail.com>
 <alpine.DEB.2.20.1603101417590.4690@virtualbox> <CACsJy8AuBsF_rhuo_a_nqaVH1ApT3iAyozt1w2vkmvHmK17hZA@mail.gmail.com>
 <xmqqmvq5bjlc.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1603150746490.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 15 11:35:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afmJm-0008Vy-V0
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 11:35:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934628AbcCOKfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 06:35:10 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:33359 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932440AbcCOKfI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 06:35:08 -0400
Received: by mail-lb0-f180.google.com with SMTP id oe12so16588021lbc.0
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 03:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3EMIbyqOYJVfMx68R2jz/WHQD3XEhdGp/FIiQGUtTRs=;
        b=Xa8NCO3CBLkZhwygH/ukOyCPKxGfO14oA9L+2tEFCdodtoeUi06g3KpRAk7M2ut2bF
         I/bH0ZhqTqxrMDveNmN81owJY+JcYvHBhj//azRfuZ/jna079d192dqlekS4hUpvWZHd
         Lce6fB5w79cQVHwxAGZVpaUH0CPPqj3Ky8T776PEqIm3B7slx2mVy0CXzSYWeKPHjqrd
         FkDxi0q9gA3wv5iASvl7i9siylPfTgmN+iNyGVjSkjKwULKWv7Y1gSKYFifUsvYnKYVI
         MhZoZALDs03hDJ5NkifKlkypEItqWe+sZp+uZ05ruXZUASnCpByxbZEduNrTCxVZ3ybz
         ybxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3EMIbyqOYJVfMx68R2jz/WHQD3XEhdGp/FIiQGUtTRs=;
        b=dKmbkKt7L8LZumPyqsz6hkMgGa8bvYdDsQqebELQGUiGG/x3K/mqcaFin4H0ljGBwS
         u5SF3h6sxBhFrixqd0T/lKe2QXcHLv7wPW7TNcwO+jV11Bxv5sdjbiIDzQHHwMiUfefS
         qDK0gYKMK1V7mq6GYB7l/KmL5m8JOxDc0ie8xd6n/ahGJyNWdl6IoLU2JAc3F/9TKYvf
         PojI4xDJWPrCrpKRx/G8W/OUrRYknKrzkU74fMr81NGUhb9/9sWuJMjPm09+2uHHcSbT
         qXEB35DTW5C+meUllIY+q8X6mto9huRHq4bYX/wO65Y+x3omrFWgM9WX05pOjnyL+bhV
         KIaQ==
X-Gm-Message-State: AD7BkJKhyuf2HelfGsFUtGJ4W3WfMDgAJn0Jopjgz9S8ZKYXbErBg7hPnr14+xcwrI5FvR1NfjZ45UF2srQtFg==
X-Received: by 10.25.212.213 with SMTP id l204mr9762603lfg.118.1458038106766;
 Tue, 15 Mar 2016 03:35:06 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Tue, 15 Mar 2016 03:34:37 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1603150746490.4690@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288844>

On Tue, Mar 15, 2016 at 1:53 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> That approach to implement the UI that directly faces the end users
>> via scripting would let your users choose layouts more flexibly.
>> Some people may want a repository and its worktrees next to each
>> other, some others may want the worktrees embedded inside the main
>> repository, yet some others may want layouts other than those two.
>
> Having the worktree in a totally different location than the associated
> repository is *very* confusing.

I disagree (unless I misunderstood you). One of the use cases I have
for multi worktree is move all repos to a central place. Remember the
.git directory security bug? It would not happen if the repo is put
away. And it would be easier to backup repo data too. Also, "git
worktree list" is there to locate any worktree. I don't see why it's
confusing.
-- 
Duy
