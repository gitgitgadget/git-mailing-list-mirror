Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A86C25B06
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 12:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242536AbiHOMum (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 08:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242588AbiHOMuj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 08:50:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6183F635D
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 05:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660567826;
        bh=2gjCQ+OyzKjt3czKsq1w2sSlnTUuVyLXE0wXpqsLKOs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Qt56RQjVhU6JwdvubV0Gl4RBh57UoN+36rU35TfLMUXHnRbYMA7mXmsGvrP2f7HgZ
         fzCjaalN/PmbmV36n+MmHpAYeD31q9IYqY38T7zIMfCycmwadj8vTvB85f/TgHipHv
         t5UaG1iNRKSN3c5qxGALSDfVyh2VRdXzh28MPeDg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.214.151]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N63Vi-1nHVSz3Kqe-016QdL; Mon, 15
 Aug 2022 14:50:26 +0200
Date:   Mon, 15 Aug 2022 14:50:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Justin Donnelly <justinrdonnelly@gmail.com>,
        Justin Donnelly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, newren@gmail.com, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] git-prompt: show presence of unresolved conflicts at
 command prompt
In-Reply-To: <xmqqy1vq3zm3.fsf@gitster.g>
Message-ID: <r980s5q6-7714-8r0q-4sp1-3qs1458r17qs@tzk.qr>
References: <pull.1302.git.1658798595633.gitgitgadget@gmail.com>        <pull.1302.v2.git.1659132518935.gitgitgadget@gmail.com>        <CAGTqyRw-SYDbQy9aktq5s3ZhoDhUOCf-pEopjH9m7v5+PH7Qqg@mail.gmail.com> <xmqqy1vq3zm3.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rVbwg+Ah9rW6nrU1R1/FB98sHovlLhP64nyETT4rdL6SU9blepN
 whj4kyu9LIg8hlooJc5GUZH1KnLzJWfqlToFI3V0Iv15xBQBwMQ//Ts9K7I1CsV9tjk14i+
 ark/IKX6c+kvnLuJSt0tZX88xaIXfux2NSghRiTJhikcuth5DPl+SKL0FLfq1ZaH2CJXlbH
 8USqRBd4y2LDz0RoQa8ng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bAbSk1k2xPg=:Q1lJ3Ldjd1IZQW18wdMbm2
 rwWlddWKH/hw93y1jHivT3cnBnuHF9Szup71QQ/gbk3NiWKghgJRG2WodfoZ/q5QWgJWTkb0e
 Ny8ywHMdVfcKDwzxDiULZJMWEEDR8A4kTun8DKsFCiu+8Mw5/3SR0jGWWZi06m5j2ISehscen
 wuRVS4cgDnR8DMkwR56wkIPKv6rPoREF2A+pRz5oOIrA8eGqafdr+eQ/AoQ8AZnStD+SwW+Cb
 od29bhKnsXNIQS1vovxUM/k6jFd2bxJmqICyxfGjfm9MIm97M9Iqjb6DkMd7RRSMypzuRYbHA
 55mxtu4FUHFLE8yIdR4uLLJ00GeGTgAlmLBeovpjCyrs6McDikx9FUioohFu3n4RiQEkgT6on
 4TRf/WuKLIj+TYSjD0iU5uYFvRQtShSntRqNcNaPFAtB2yo1RUkjwB74mob8rkdan+mRijkBP
 30scWbvG1MQj/rq8on9OkpjowehOCjfb9iCcULBYOcvGdqNMkN0WKZa9DSdjXEEnfCERYWnpf
 MdIlYDFdJQDmDSETICJVVxFbpc4RD8GJY6Pv7qJ1whHjvldHsiNTfgQbOroiE34Vr8b2MOkDY
 uMaicC1hHQrZkm4dLqbxTNFsqDBjPWz7lQqierSZj6LH+WpD5BfSXo1ID+qaegK+9EUITRbxJ
 mtRLXADkACE/gNlRXW9CidzWnW+PNE0uuP4zk2tE9YguDij7BgzSTVJyDBh5snoApobIJdONv
 czUMCmx8OarVNTz8X51kW6CjPlyIzdVq3VYitDHSgdbLnH6F6Sf1vhshDfhBUYHEZQVilQhla
 EIF7UOLs+VyfzymwjfT8ew0+A97wwhmsz7Afy+WmPctgBrqxtwNgrebXHYqCVaFTxbKxOR/vl
 hR2U5tdXifRk6Plz5J7JsLcbm0fIxCYGgsM2E6iqW7+yoOI6eUlFzqr/1hQ1TFuk6RRWWERWz
 JUCK1B/zbdC2ZRUZnJTFzqkLRo252LlDja+ZIsgPIK0UeAMHR+XxP4eUonhoDTdgIcOp5hGdQ
 kn3gmqrILL7U2jbGUntDSBIl9rX7KwLcWo+0Di+xCSDqlVJFAIPZWfy94arfcrBafReZS1UOl
 HgGsMa1bhDv07naRvsZksFgEgOXYY8q8bp9DmhTxiWk+kS/H2zYas0qeA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, 14 Aug 2022, Junio C Hamano wrote:

> Justin Donnelly <justinrdonnelly@gmail.com> writes:
>
> > I hope this is against protocol/etiquette, but after some initial
> > feedback from Junio, I haven't gotten any more. I wasn't sure if
> > nobody had seen the patch, or if there just wasn't any interest.
>
> It probably is a bit of both.  I personally did not see much point
> in adding the long "conflicts" marker to the shell prompt (I did
> worry about possible complaints by end users triggered by seeing
> them suddenly without asking, which was why I commented on the
> patch) and I was waiting for interested folks to speak out.

Speaking for myself, I was too busy elsewhere. But now that I looked over
the patch, I think it is fine. My only feedback is that it would be wise
to only add a single test case because that is plenty enough (after all,
it validates the `ls-files --unmerged` call and not the `cherry-pick`
code) and it is unnecessary to waste the electricity on additional tests
cases (even if somebody else foots the bill, it would do well for all of
us to start being more mindful about energy consumption).

Ciao,
Dscho
