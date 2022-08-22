Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85635C32774
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 15:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236903AbiHVPyH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 11:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236917AbiHVPx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 11:53:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E281FE0B7
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 08:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661183629;
        bh=DaVCRAy6dFZvptxHBPzcUELShYKyEq19L7IIKFS0p9Y=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bb02KzVDXYVzq53QwoeAATWdvHhe0il1Thc3lZSi6TpVt3gjMhQGSkO1TCPwyfBNF
         2ub7ZaoEV/dp0j+jG22o5eCxj6kI6Jle7Q8oDn8dmUeVrA6+blZmSOiiy94Qhn7vNy
         EJsAD1cKkVsgd17PIPITHrIQsJyzjKRsaOazCrLw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([89.1.212.11]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLzBj-1ohYAm2iyP-00Hywq; Mon, 22
 Aug 2022 17:53:49 +0200
Date:   Mon, 22 Aug 2022 17:53:49 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Christian Heller <christian.heller63@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: git diff --functional-changes ?
In-Reply-To: <CAOu2uD_CaVxxEtZhe4197ERDFASckUBtK_NyhmwQXr=5_reSXw@mail.gmail.com>
Message-ID: <5s05s44n-6q71-1198-8or9-164637q1sqp4@tzk.qr>
References: <CAOu2uD_CaVxxEtZhe4197ERDFASckUBtK_NyhmwQXr=5_reSXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5uwTxZ+M59+sIGkjN3wj7qfHQhIXtsXl5H8JyUJOmywdYgsHCLZ
 n+1xSlyoe2N/DJaPt/vvuCnhlrE6ivPZZkDw1lqwbJUNLBexOwphFC38iTQrfmBA+kdkJWA
 Z4RFcoENs6sqDG5s4BZAAmDGSxt4g+doyEpOC114/B3qLd2NDZG5+NFeEOpy+lMpuq62Kxq
 y2p+HFp3M/sEMAxFOEasA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/RkUF5G3zWY=:Taac1wocAQrvUvzkZLnpHv
 lhH7dpDcKiYxMOX85nMDGnV3tw9W7C9kPp1sOxhTRw0JZykva4OyxF5U3gZrLll8xBPtUiGVI
 kSwprF3ZW2/WQPSfxWQp4G9BoEPjrHjYT0he0bgNfqDUF80ZXtjzjxBhgMOioxSZCQ/JT310i
 ps/QHSuewWl80AiAvSz6NoIp7QBZs6q0HhXzI6R+kPw4qNlz8hJjxlsLZjui9xgC+PDc/xn57
 goKs9x5dNUHpDEg08HxMkN3GqRexCbYDS9iN7beJ3NdUPOwnnY68Kvaz5lJbQIjS4Tij6dumz
 4VIKRpShyEL9YuXqG5DY6MZIQzH4zOoGwTgXfReDokNxvptDVfF+ktBAtJi0e5pAGi4APT4md
 Y9DxdCD2Y/qeYzNJ0UHOO6SlNn3sxhBR1aeYQRM8N7TyaUzQkmeS8wmWeENbHs3wAo/2U1Oyg
 1kmiPXfBkeel1uZTU8TMidjo8scd2eL60O2FC31owD78kl0pfXWY73Cj5aRPfgMIBORvBjbLg
 xAmajb6+3jISJiZGEivewPLo33t3EYCJhJyedcujbqjAWijTGRML7GRlsoQCfqReUErdZjon0
 3/Y/xOerOPyHLmtz2mJshTgBbwOek/oISc8SL5tRwRiQyaQjvASITDGM6tv8n/cULVLkgNeOy
 g00uANWRNhGKQb+kGOMXtyDynB3KLnl0o9WFstQ7jh2GBfaY0LyehSJJMWCo95wWVotYMq9u1
 9g5JMn6sBOEn9jajT/TJHX6blhv+2zWZKMdw+Xdw7pbNtWuvJ/pGZquLE9ZsY8n/jQEcWKJiy
 5thg9quiC6U1xKwQfE3Pef1edUzfXL2XtZuU5AVvuv77L8RSLd02RG1AdAK/v7zlhg4+AFVe/
 jEsyhYfUji15sW8Jv0JdX2VPO4QQHvp86YHI8egEtE3pPaUGAfVbZWYy0MZpWaP8PCsOc3SUD
 7svjjZz77ViPHo98VicFklq4IpG479+MPI7rSsexhdEmYofK5LgtGHVc4yfWy9ekLzLMBRu7P
 of7JGh04z/Ft8O81qjRG/gjZgn2URtM5Fnj6kAcCWqCkekStcS162+/QqT5DkUhB4d4WwUOMy
 puncEPLENlS5pEjEZi+5DiM+NHJ8lzjSCxWJ4h3NutwCey2q3WqCXeQdA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On Fri, 19 Aug 2022, Christian Heller wrote:

> Feature request
>
> I recently ran GNU indent on a larger C project which made all diffs
> horribly noisy.
> Is there an option for git diff to ignore changes due to the placement
> of curly braces '{', '}' ?
> Equally helpful would be an option to ignore changes to comments.
>
> Something like:
> - delete all comments
> - re-normalize line-breaks and indentation
> - show only 'functional' changes

This would be very language-specific, and if you find a utility that can
do that, you will want to use it in Git via the external diff extension
mechanism:
https://git-scm.com/docs/git-diff#Documentation/git-diff.txt---ext-diff

As far as pure Git goes, I have had luck using the
[--ignore-space-change][space-change] and the [--word-diff][word-diff]
options.

To be honest, I use a custom word diff quite often:
`--word-diff=3D[A-Za-z0-9_]+|.`. This marks stretches of
alpha-numeric-plus-underscore characters as words, and treats all other
characters as single-character words, too (which means that it also colors
parentheses and such).

Maybe these help you, even if they do not solve precisely for what you
asked.

Ciao,
Johannes

[space-change]: https://git-scm.com/docs/git-diff#Documentation/git-diff.t=
xt---ignore-space-change
[word-diff]: https://git-scm.com/docs/git-diff#Documentation/git-diff.txt-=
--word-diffltmodegt
