From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] GPIO bulk changes for kernel v4.6
Date: Fri, 18 Mar 2016 10:01:25 -0700
Message-ID: <CA+55aFzVqPzEg6zq7sRweE7OCVKMJzM1eZRHXddMG+BabEDeCA@mail.gmail.com>
References: <CACRpkdbGkfJ9bW1db64msMeQjue+=y+op5EmSx62FWOWDOJwWg@mail.gmail.com>
	<CA+55aFwV4Cq=4zJc6Fw0yAGrTmci_DFAjJKxkk05pjJJf3iYbA@mail.gmail.com>
	<56EB9B0C.4050507@nvidia.com>
	<CA+55aFy=-UAbVo+Xx08tBA7eTPk2B+G3=SbarVxThS57LdakPA@mail.gmail.com>
	<alpine.DEB.2.20.1603181532040.4690@virtualbox>
	<CA+55aFwbRVG-5AW+NnMOFZ_hU5i+i7f3FxgEt9Qm7B6pEd7x0g@mail.gmail.com>
	<xmqqr3f7rbck.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-gpio-owner@vger.kernel.org Fri Mar 18 18:01:45 2016
Return-path: <linux-gpio-owner@vger.kernel.org>
Envelope-to: glg-linux-gpio@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-gpio-owner@vger.kernel.org>)
	id 1agxmP-000443-SF
	for glg-linux-gpio@plane.gmane.org; Fri, 18 Mar 2016 18:01:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754710AbcCRRB3 (ORCPT <rfc822;glg-linux-gpio@m.gmane.org>);
	Fri, 18 Mar 2016 13:01:29 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:32913 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484AbcCRRB0 (ORCPT
	<rfc822;linux-gpio@vger.kernel.org>); Fri, 18 Mar 2016 13:01:26 -0400
Received: by mail-io0-f180.google.com with SMTP id v123so34163858ioe.0;
        Fri, 18 Mar 2016 10:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=jgNB8oj71+5ruP90qVOGVoK1WC2JKZzgWORomW3cYzs=;
        b=gk4SMpr01vzG8cIQ8mmVZ+1sx54Fgm9RdGt9L7cMtYic+DlEp0/tcApNJdymt5KoLq
         Z3h6CwMm9y20pkWrSgPp1v0PmuBvmxGef8m/ng3Ffhlx2GNIwK6ARcjR6ApN6x5xNdEf
         eLEd+cDdyuo9YbfJn6Wzjs05Itp6xPYYMC6ycZeZTe8vdsqpAL6xNiYeRXZmliTUflNK
         9NbuVggxG+nDQHwg2RNeSDpq36UFzII6CMBPSQpvh9PPEUxP0ZvjoA/6oczKsspgAjYf
         QE5x0fyUTNK3JwkbbSfu1j1MH1L6n3kbQftFI9mZuWg3fx1LWyPIgeZAVe7aJSDbGjuW
         48hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=jgNB8oj71+5ruP90qVOGVoK1WC2JKZzgWORomW3cYzs=;
        b=D2v0Xa0zSX0PaxTAEPCRF1U1fvnhC6CiLiaEdcUu6qsGXBOpMrzM5vfuT59sefLawX
         L5gtxUlZ55H1GnUNvsSDOJa7b8NAeq5Iv3fR62b+zDaECyl3F6NjHHPaALuFoTNLDx74
         bUUofebjqTRGQBjmz/fDxY3GLxJ0bhHwrROm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=jgNB8oj71+5ruP90qVOGVoK1WC2JKZzgWORomW3cYzs=;
        b=fiDOicqJ/eBrVgIQqYM5+hfyM0nqU0OUfskhR0egPTqUITvXMcCG3Hhahb6cEyZp6t
         WsNZZAmGkGatleRtys8GxvaxS4BVckoL+UCiWRQGHLDgPAcy2QgYgs8wVSGRzQMCdm76
         QQT5yT7OcFMd6+Zpphd6fE/MhgjSI/4Ujl3Yj1Vbd1tXeaqRtnhs4ifL6nVKYweF1bQL
         RxBsD4awuq1r9/2hF/1HycqgzUF/Jfu8VNp8BGMIKFSjNRB9oWYOek1BkjcvRGBUy28Z
         jHp4WtUTfSD29pPqudvpF35Mv2JvZf4jP0a4iGtqonDSglhjC5vfm+YsDplWs45DoGoJ
         lsXQ==
X-Gm-Message-State: AD7BkJL3lDyARBdPfEUfaw77v0Qb/0GodANMgLm+QehkjWr17GQlcCCsXrDV+bvHYh3wzID59FBTjw5Savtvyg==
X-Received: by 10.107.13.65 with SMTP id 62mr17292669ion.186.1458320485720;
 Fri, 18 Mar 2016 10:01:25 -0700 (PDT)
Received: by 10.36.93.202 with HTTP; Fri, 18 Mar 2016 10:01:25 -0700 (PDT)
In-Reply-To: <xmqqr3f7rbck.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: GQCbI1I80zdGGEWJBvKjSbNMCuo
Sender: linux-gpio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-gpio.vger.kernel.org>
X-Mailing-List: linux-gpio@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289232>

On Fri, Mar 18, 2016 at 9:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> I don't think the original "resolve" did it, for example. You can't do
>> a three-way merge without a base.
>
> Yes, and that continues to this day:

Yeah, "octopus" also refuses it cleanly:

        common=$(git merge-base --all $SHA1 $MRC) ||
                die "Unable to find common commit with $pretty_name"

The code in the recursive merge that allows this to happen is this:

        if (merged_common_ancestors == NULL) {
                /* if there is no common ancestor, use an empty tree */
                struct tree *tree;

                tree = lookup_tree(EMPTY_TREE_SHA1_BIN);
                merged_common_ancestors = make_virtual_commit(tree, "ancestor");
        }

so the "no common ancestors" is just considered to be an empty merge base.

And I do think that's right, and I think it's clever, and it goes back to 2006:

  934d9a24078e merge-recur: if there is no common ancestor, fake empty one

but I think there should be an option there.

> This is a tangent but I wonder if we should say why we refuse to
> the standard error before calling these two "exit"s.

As mentioned, Octopus does.

That said, there's probably no reason to ever use the old three-way
merge, so I'm not even sure it's worth fixing the old
git-merge-resolve.

            Linus
