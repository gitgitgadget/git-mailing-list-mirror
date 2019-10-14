Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF6FA1F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 20:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387581AbfJNUm5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 16:42:57 -0400
Received: from mout.gmx.net ([212.227.15.15]:56579 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbfJNUm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 16:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571085750;
        bh=2fz/98divc5dRlo+2+BEK3iYELCOGVgGx2ygTo3kZpM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YDqh8ckmRp4Qvu7KpErNrEk16wSyWJJw91YXiOWkR/61ltmygHxzgVrQIplzPEt4S
         NCxB4cDUwuSdHFQZ1veF2CK9j94pdT9DXQOhOc/2wgoLQdS4SONXg5gpt8rGq7SOiD
         ZoWpgb3gcjj5YsX3OpwF5No6tEGeFgaIw5le3gV8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGyxN-1iGYej2Jb1-00E9Db; Mon, 14
 Oct 2019 22:42:30 +0200
Date:   Mon, 14 Oct 2019 22:42:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     James Coglan <jcoglan@gmail.com>
cc:     Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        James Coglan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/11] graph: commit and post-merge lines for left-skewed
 merges
In-Reply-To: <5661fb1e-d850-f193-6d00-23de9f48e742@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910142241130.46@tvgsbejvaqbjf.bet>
References: <pull.383.git.gitgitgadget@gmail.com> <6c173663aac37f1d314db8637cf4a243066b8078.1570724021.git.gitgitgadget@gmail.com> <9fe7f2d9-2108-5cf6-dcd7-06d91e74e98b@gmail.com> <204c7479-c78d-54ff-5ece-397b4c31804c@gmail.com> <20191013065609.GA30601@sigill.intra.peff.net>
 <5661fb1e-d850-f193-6d00-23de9f48e742@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fcnSaZ5Nw0xLr/Uq2dgEDPoXVHVUgR1yPpYCYwE6JHereXYNnFx
 0uro6CkKymPRqL4EH/1bozrrXqSEjs2ETI1FAoGuRGKEhhjyY3yRtt+xcYqI+qtAo1Nd7Kz
 2VOB+pU62w4dom3D1nsUSEdhoMyTvobEr+N0HmFYqOAKjBQa37rekaa6NM/s4+9dwOaxkn9
 HrJvrANdhftAVugDkbvnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nKN88y4Cdpo=:O4MydGYPWTTKTFbc4/VAcF
 rgHU7bFCAG6sdzsUayj4++gonn0jvDcd6pdhXXlPmQZjOQkh3/VKkdhCwgReVbiloSOG2MZu5
 bdyT0ZNV8hWU+tS39QoKAVXdEkgv9VhbU+rcautoV4O8D7KXeg+fZtroRUPafAqtigOIO6q8J
 Gavm3fxnclE9K4KAPxUGJcoOMXqq8RgGZp679rUtRGSMG4oYqTPtzk26MwpqtrYQ/f9dzyqRG
 N8b6d9NbVnCpTzQJ/vN/yLXov6D4zK1k9tfEcuz+YRxOy38wL+UaC0Z0oZk/quGfWBlYHa5Mu
 k29Q0CXoKYj50/BahpuD3lgRPkn2iLzaj34jgqYquO5bk5SIboeSid2woypsTgLLA+jbGy+F1
 X11mOltQb+lNL6Db75GjG7mT16fS3bgRhhR9QY/2h3UTJuoLaJ2JrY7OLPC4srhPbpJAt6fly
 P4J5Ao4AM9NowqmZqVh3yr41Q8gYkEQ09cpXKleMPB+mBMmZA+2UZNh4jYiinijQe5C7LA/Jj
 1No20RpUUycWVF4N+B/6yXskf29DlAOPNQwuNy76kSxQoV06NsVScnHg1qoH4IZp2Ydppcipm
 bS8a7xXC/LNjzJFNJoyxzBxkQM2Ypkn/0uAFRKrniWdXh7J5FUNy9Qs0m1eTBZaTrn9TUr7xC
 l47GewErS9jj2F+zV2z6BwOQd6M9sm9sFSfpRFcO4T/POXs2srrLPuFh7XTGu7v7dOQkZ1DLC
 tJsgPaA9OmozM5zTbrIwytFMFkCIQ7V8ZyUbk8CcHfbMhLx7N6FhJgskkNH7rCnRay3/uFTsA
 Xf8dRHRvixj5DXtAY2gb6i3yb8K9GP1ogaTG2OQOJ0a6NTWF72GzLYVL/IKHakZvQ+SeJp3El
 pS01tsS1buuwHfynN4zo7RERLpe+Q+iEbqaKIA7M8y7px5UQMNpJrJlfv/AQ0Q9oB2wt0xKWq
 3As2hy/yDbpltY5yvjvuFFkrGKVeZBTQH031z9a8uy8jAnDYyPonrzZgZvso5tjyR8izEZeMb
 LuJcV9/4+kWQobhqJgPgd49jyiohfiuNgqtdgw+R9tkzbVMLq2XUpv1OAd+lJlfWqR8Xq8PFs
 udbvT2ajXo21Eg8UqChLySSGHkvyNqOUXcCA/LLsvcdiOse85tFih7YsFqBOK75SPxzpn8Jsq
 POFiaZ6p4VNoVHKXIbUakei8NzviqbIHGd/WQsix6Yetbx0Cq8f7XeBsaBvJ4R50s1yCQUU6R
 ctze53hAFE0KYfMkmE+M0S0kHMxkLJ8UzQ416JE7TEHM8jEI0lGe0WegRObE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi James,

On Mon, 14 Oct 2019, James Coglan wrote:

> [...] How should I go about sharing the current state of my patch
> series after I've incorporated all the changes suggested here? Should
> I post them as replies on this thread, or start a new pull request via
> GitGitGadget?

Just force-push the branch, and tell GitGitGadget to `/submit`. It will
take care of tagging a new iteration, generating a range-diff, and
sending it off to the list.

Thanks,
Dscho
