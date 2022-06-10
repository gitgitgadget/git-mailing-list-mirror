Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E287C433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 16:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243344AbiFJQB2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 12:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243286AbiFJQB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 12:01:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1CF193205
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 09:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654876882;
        bh=1jksAAs6g9PIcsXxxzNF3vq7Xl9eK9IdZhAP8+1rIeM=;
        h=X-UI-Sender-Class:Date:From:Subject:To;
        b=efwEo9cyLmN8Z+iLBg1zQiM6OMxXx54dO1T0fGkVKjL1Sup2XkUAvVYy7u2m0LeLQ
         YWPk8rgTs5Lx5tcd4UFIa1JUqS+mdXqDlF2TKxboo453yx21p5yTf9sIVGiKm8Q4v3
         q3dkaHk+2pe7+a7NYPBrp7S3fz4GmmSOMSeE7LAU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.102] ([46.5.231.216]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M42jQ-1nzh4c0rg0-0001HZ for
 <git@vger.kernel.org>; Fri, 10 Jun 2022 18:01:22 +0200
Message-ID: <3352fbbd-d555-fc51-1eac-692fdb5e4ae0@gmx.de>
Date:   Fri, 10 Jun 2022 18:01:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   =?UTF-8?Q?Volker_Wei=c3=9fmann?= <volker.weissmann@gmx.de>
Subject: git bisect outputs list of commits in the wrong order
To:     git@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eyP9TlGIfaYdpM/hg/z0J6NIZIQQAvJWEoExY7D9RRCu6qrBQVI
 xMzzN2gjxe/2yI+Qd5Y2eLU5ciXtXxj30NCeuxxAOtCY7wUsh5sTd9FKu4Ofz6945XYe9C7
 F3+sGPVIpBMgeHOa1kOiZojSYQM47855Gj/3DKK1nUYAX1IKFHB/F8OYf3PKU+VtLwJT//S
 q4J1cURqN7BqPd51CpuVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7ahzWT/93cQ=:tOV9Ja0ayFJuYk9TM1MCUy
 aXSNjw1TdFCQ9imTHV7K/Gaua/WBGMb/WmEOE26q864z+weE1PC4wf5VMbbV2BMuAiBq4DyIQ
 GQUETyPguFZHy/ZaG6gOR1q4oZmnkmYD72ZOLcysrAvFIfyxXHo2slwERty6OwF31Ej2fdIQT
 6Wx+Qnd28Lf/xSB0L+xZsHnUOi6gc/fUXgLt50gYTdHMLOtbzOWsTSsSTTXfl4wzuKyrzK1wn
 Wo8BWm+LPJXJg+3q4SoZcIK5j7xVYtIT9gE44OMsDb72TF/WKCxlgTKF7tLHvxx7/+92qaoEq
 l/2Lktq/kCYvw0gHF8NfngbkyKjSouoBaoIxADjqLHX/bF4oP1YXXOVrM0s8EMTlMq+TOJ9jK
 d3wLrEB1JMqdjzEkTyjm5WMgIAEOWrEo/3pdb6EXknnKvTw4CkpmgDAwm9nJ7P8vK/EeRN1Pq
 osP4XF8G+jT9GEatI0FX+jbP5skZEWzx0zrkfugf0jSNOpNFqhhPX4bFlGckHJnrRlXbSQykA
 JV3+wDM3vXm3Ys5hxXpNGOe1uJQQGRE23xOu7KEmTK2wQdH56UXJhxIn/RTTVHUW8yR8SwVdw
 4ESvOPU4zt/pAZZTKwDml8biV/Mq6lYyIK5xzCVdEL+24pik7/vI/ej0/x0dfak/tRE1yT1h+
 3/0aEAvelouYQ1RdamYjS4cyg7XjdM6Ny/0MOw08kFUgjbeiETctyL/w4CQkOjZD0ftA8EbOX
 sp5oblsC6mGKx9t1rD8ySBRIE00DckcFY45PD7avjODaKjuwE4Bobd3JO7x30DV6qvXl4BIf6
 DG5Gyey/W0ZhWvFeY+hkA1bayvHTOZWJmwOdCKtCUzBhh8s7eP01vgDLsj5mE7gSqTHElFbRb
 8NROrBJ1BwtO00rdeKS1uuQqKDpqov88g4nlx9nHZDvqY16J1C2B31rbC4wktAx5fcIe3CZ2/
 uF7jRnKeYz70+FKXziCRdRx9ZZiba7JOw54ijMYfGgKxilwWHkQyHHPhrzNzTCNP9HMYIon29
 qAe508/Ufnayva5cJJ04Hp7SElqeLMru0ggTKaS7hu2DWjXXlMb5YniiWGeFjZW64RMfYlCqB
 oxOwq7ysXRzIk9USybM+gaK6mJUaeT2Pz/P56pV38smviFmc3LSkY5Q2g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you use `git bisect` and `git bisect skip`, you might get an output
like this:

There are only 'skip'ped commits left to test.
The first bad commit could be any of:
01f793267a9af328f0f1af2cdb88301a08f007b2
a87784e29411e8b08059fdc79629e64de3002c99
af0df663440796a0580644493c15290405e60ecd
4f34b8cd48e2a814263efb319fe5dbab91215aed
f3d91e38a45f0a2ec5affb884d536c9c4e5bb290
13526e1b0e1b11a2e30e44ccf35fbf92ffb61372
abee97622db5301d593265ff6e2009777b09221e
b63700f09a422f01d954967b84c5e662881352eb
We cannot bisect more!

While the output is correct, I don't like the fact that the commits are
not in chronological order. Is there a reason for this? Chronological
order makes sense and would make it easier to find the first known bad
and the last known good commit.

