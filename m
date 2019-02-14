Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49C211F453
	for <e@80x24.org>; Thu, 14 Feb 2019 21:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439965AbfBNVX2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 16:23:28 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37771 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387702AbfBNVX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 16:23:28 -0500
Received: by mail-vs1-f66.google.com with SMTP id s16so4580955vsk.4
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 13:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/WctZfb9hSg2MgXJETr84BTooo62oV3YUJkJ3Ce7SnU=;
        b=oCyuKRwM06naHCS0qQvwGXnu+E0lgrxbUGBJKhS9GpN1/fGianj1lZSVN8rNKuSsoB
         9kZt33+8QZx91/gF2gH3fr60PK7ewKQm3kcCfJshRbFn4+2t9e+ofY0aoDeJPny+jiBt
         OoEHt9j3/vqVsr+PtU/nbbeAKxPuOQzmIFSVNXbfR9HCMzJzb2rfrfvQ9Wsw/qMdyCsp
         Y6pdHD/G3R+ISJslBK8ea2SeTJIW6Aov/r1pI0i4brVo9tjJPsAgwkyNzt0IlFYIrmmJ
         /j/o6OV89ul6km7JhozXwyDTWthWc3n2hu6Dh2vf1eFjiLJ9PhHUdWZjd+8a8l3SA6NO
         Cb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/WctZfb9hSg2MgXJETr84BTooo62oV3YUJkJ3Ce7SnU=;
        b=e4rHY3/OKLlZil8vFYaUfnCIyAWy+7fPyaVi+iE/yQylhFt06k6QuENvQgM5F1LYvl
         r871LCklTGw5eN0+kyXYnWLyMk77pHjy5U+DJ1Pkj73DZZ0YvzJS+8YiPtK2k+skyHnv
         T/U3F3oqPSMgZqP+K4vDOqrSS4nG45+gn+7qZx6uZ/AuVUuZklr+jqkZCSBTvZHTFNDn
         kkZEsctExwIbP9WQeXWiPJTV9Bc4JzkLk8aBwLuN3WdIAfqbiPTy86poHjq9EYaPSDqv
         GWf4OwXnuUTDLb51146VgNWLQ+Vq/fCJBU6uzTMWAYYVAbEYPC1QF8nEx7ClZAzdEu8u
         ++yw==
X-Gm-Message-State: AHQUAubQWB2cNiGphHGO+pFEfAZzHK47W2YRMxzVg1eRGk5Z5BRgShvd
        88R9wUmJv9xW8nvxWVBijuMDKpzpRSCJeKzBrSw=
X-Google-Smtp-Source: AHgI3IaKTUGVz41B2x1OhfvMuwfR3JpS3LKXRCs64wVoqDfm5rc3rR04NvILKGQlz8+ZrZBSQwzgH68McAZEaIs3VoY=
X-Received: by 2002:a67:e908:: with SMTP id c8mr3134182vso.116.1550179406511;
 Thu, 14 Feb 2019 13:23:26 -0800 (PST)
MIME-Version: 1.0
References: <20190214082258.3mh3hcr2l6dl3wuf@vireshk-i7>
In-Reply-To: <20190214082258.3mh3hcr2l6dl3wuf@vireshk-i7>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 14 Feb 2019 13:23:14 -0800
Message-ID: <CABPp-BGstumw1eyZ++0itk-AR0Bk5zd0AchgznBpMq35a6ScUg@mail.gmail.com>
Subject: Re: [Bug report] git diff stat shows unrelated diff
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Git Mailing List <git@vger.kernel.org>, vincent.guittot@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Feb 14, 2019 at 11:35 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hello,
>
> I am not sure if it is a bug or not, but the output I got wasn't what
> I was looking for. And so looking for some help. I was looking to send
> pull request [1] to PM maintainer and was generating the request
> against his tree [2], which already has kernel upto v5.0-rc6 merged in
> it.
>
> These are my local branches:
>
> Branch A:
>
> 55538fbc79e9 cpufreq: qcom: Read voltage LUT and populate OPP
> f896d06665ec cpufreq: qcom-hw: Move to device_initcall
> 1c7fc5cbc339 (tag: v5.0-rc2) Linux 5.0-rc2
>
> Branch B:
>
> a4f342b9607d PM / OPP: Introduce a power estimation helper
> 285881b51eb5 PM / OPP: Remove unused parameter of _generic_set_opp_clk_only()
> bfeffd155283 (tag: v5.0-rc1) Linux 5.0-rc1
>
> pm/linux-next branch already has Branch B merged in it (with an
> earlier pull request).
>
> Branch C (7c139d3f0f99) is a merge of Branch A and Branch B. When I
> try to generate diff-stat with:
>
> git diff -M --stat pm/linux-next..7c139d3f0f99
>
> It shows me the diffstat between v5.0-rc1..v5.0-rc2 as well.
>
> If I do
>
> git diff -M --stat v5.0-rc2..7c139d3f0f99
>
> it shows only the files that have changed in patches in branch A and
> B.
>
> Since pm/linux-next already has Branch B and all the rcs upto rc6, I
> was expecting the output of first diffstat to be similar to second one
> (without branch B stuff). Is the expectation incorrect ?

I think you're getting tripped up by double-dot vs triple-dot with
diff being different than log:

`git diff D..E` means the same thing as `git diff D E`, i.e. diff the
two commits D and E.

`git diff D...E` means the same thing as `git diff $(git merge-base D E) E`

There are some people for whom this state of affairs makes sense.  I
am not one of them, and I suspect you aren't either.  The arguments
made by those who feel this makes sense seem reasonable to me in the
moment when they present them, but I have never been able to remember
these arguments longer than briefly.  It just doesn't stick with me.
The only thing I seem to be able to retain is the following:  "git
diff D..E is totally useless and should be an error because (1) it
doesn't do what I expect and (2) for folks that want the behavior
currently gotten with that syntax can instead just use a space instead
of a double dot."


Hope that helps,
Elijah
