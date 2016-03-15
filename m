From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/1] Introduce a way to create a branch and worktree at
 the same time
Date: Tue, 15 Mar 2016 21:07:01 +0700
Message-ID: <CACsJy8A8OPZZnLs7dydvLMHz_CpU0xTaAAgmO9Vn2mABRywD6Q@mail.gmail.com>
References: <cover.1457609615.git.johannes.schindelin@gmx.de>
 <CACsJy8BA7-ev9wTt6K45TgiNxOaBUXbN1P03U4EUAzAPy=7Faw@mail.gmail.com>
 <alpine.DEB.2.20.1603101417590.4690@virtualbox> <CACsJy8AuBsF_rhuo_a_nqaVH1ApT3iAyozt1w2vkmvHmK17hZA@mail.gmail.com>
 <xmqqmvq5bjlc.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1603150746490.4690@virtualbox>
 <CACsJy8B+c8=Y0Lb-TxjGF4689xP2Vyqjp4Q6CuffTLDWDMh3gg@mail.gmail.com> <alpine.DEB.2.20.1603151448220.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 15 15:07:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afpdP-0001iD-4s
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 15:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbcCOOHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 10:07:34 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:36363 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbcCOOHd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 10:07:33 -0400
Received: by mail-lb0-f178.google.com with SMTP id x1so24271749lbj.3
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 07:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qVhSzn1thNb6lD+JKAgL45Tw/1asoAPWApVP7Dfl+Dw=;
        b=wtuGsAtQZDU3gFhXK2hECwpIq6yApDz4SuswETg3LHZBJCzUbqNffQO1N2RCV1woM/
         tvjfjMre/HOqPLJmKxRTypiQE7B6a0V9z/4ZzSyYk8y6+10S83RUCoUdHPMS13YS40BW
         0CP8p+9E65ni/BtB5I6KfDZ4I46HXATAfv5YM8wTF0xNmpQajoPOYctg1csaU8Ns6tXB
         dS/Z3ygrrA8R/mcQpCl2Zoff8/jLGD9ASWccxFZvo973GbUq61NRKcuzi4DugUpXuwfd
         VkYdRxhl+qVcXbEARl5B0/aFzMZyON/kckZ/1scaMYix0otjG84v7dejT4iGY4QMyNdr
         Nejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qVhSzn1thNb6lD+JKAgL45Tw/1asoAPWApVP7Dfl+Dw=;
        b=F5bRBvdA0fneCVb5RhEJzQdSaMbfS1Ov2leMQHoMP4y5cIb/OOPgWdl2+ia4OzeW21
         WTRi0Mw8v0g7Y9aBulwxiiMo/tY4Haxet/hYFFbhGNvxsDDYFtmyAdnyMs+RYxwxutMc
         S1x0wVjyeqX7Bq3MM7iLc/t9i689+cGjo/z848DvEAjRV6TumjnoonVtD5AHjL6NqK52
         5z0Sh7MNv6LVWiMJ5YMc5m464KAIFcnSe96kynwJPh6vj2FmHQyDSp+x3jmQYFg3/gj+
         o3OGeUbwWDnUoS8l4QTaudWXUKxo9aiHOlSyIIgcXBQFZJBxyWw0HQ167fBUyoxRwFGZ
         +9BA==
X-Gm-Message-State: AD7BkJK7AsAh7p7IPt+P0n7XxNK4aHzhoApPKLBmfPhuE8zg88WyOchr0DFqMq3P65ZnAguCCXfYEP43XA2R8w==
X-Received: by 10.25.211.75 with SMTP id k72mr9860343lfg.45.1458050851467;
 Tue, 15 Mar 2016 07:07:31 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Tue, 15 Mar 2016 07:07:01 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1603151448220.4690@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288854>

On Tue, Mar 15, 2016 at 8:56 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Sure. And with the repository being put elsewhere, you also buy the tedium
> to no longer be able to simply "less .git/rebase-apply/patch". Which I
> have to type *a lot*. You win some, you lose some. If you ask me, you lose
> some more, but in some cases that is worth it.

If you start to use git-worktree, you'll need to type even longer. I
notice I do and am seriously considering an alias of `git rev-parse
--git-path rebase-apply/patch` to type less temporarily. But this is
the lack of proper UI. "git rebase" should provide a way to look at
this file (and maybe some others too). I just don't know what the
option would be and how we align it with git-am, which shares this
same problem.
-- 
Duy
