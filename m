Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A4B31F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 13:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKLNji (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 08:39:38 -0500
Received: from mout.gmx.com ([74.208.4.201]:40937 "EHLO mout.gmx.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbfKLNji (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 08:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.com;
        s=dbd5af2cbaf7; t=1573565958;
        bh=GX3CMyPdWzAQgRsqNnyKtSCaJXiD4QfodoPpCsWaHrk=;
        h=X-UI-Sender-Class:From:Subject:To:Cc:References:Date:In-Reply-To;
        b=GLfB2E3o/8T/qxq3ajuyM1oA5Lz+W9KvbotqTz7iYYuayQWwH57A9+g1oPcjIGEMM
         aUSJMELWhn/VZUZob/SkcqHIifrl0tM7FdrSaMcl5n2HYnm2guxVl4oKQ4sRA6tATc
         Mn9LJf15wLSmnoDhUhIO+J6nLiUgMLz9+fVgjZC8=
X-UI-Sender-Class: 214d933f-fd2f-45c7-a636-f5d79ae31a79
Received: from [192.168.58.16] ([176.74.253.24]) by mail.gmx.com (mrgmxus002
 [74.208.5.15]) with ESMTPSA (Nemesis) id 0MgL5c-1iHuxE17gM-00Nkvj; Tue, 12
 Nov 2019 14:39:18 +0100
From:   Paul van Loon <nospam@cheerful.com>
Subject: Re: [BUG/FEATURE] Git pushing and fetching many more objects than
 strictly required
To:     peff@peff.net
Cc:     jonathantanmy@google.com, git@vger.kernel.org
References: <bc43c70e-861d-425d-d7c4-73a3e25b7383@cheerful.com>
 <20191108184723.246596-1-jonathantanmy@google.com>
 <e537d298-6431-c36a-2fc3-e41baa10d0a3@cheerful.com>
 <20191108212156.GA15365@sigill.intra.peff.net>
Message-ID: <61aa8bc7-997d-a7d7-e37e-92b30e04d005@cheerful.com>
Date:   Tue, 12 Nov 2019 14:39:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191108212156.GA15365@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Cm5waqFakXH/cpnMupgKYaKkaixXO14vL3cqh8lcvszCzJ9DNyf
 1YV9KUmYvjV7anIf5CQAwtp0qA/XoTRbbxvXzM/vMmYNOzvdj7CXI/5FXex9mK0jzMeuH/N
 UgdFV9oxRt7zYwQW05SddMz4ALTVqgaKCyiAHvsCnciDspygasGNjxLu7wOzAnfYZRS6cVZ
 u7WQkEtoakhVWlL3UoT+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qnK94YYTFLA=:WB9A7mVcEk8cNDt76tJNRG
 ySv+SSK7njM9JxN2YPQu3cBoPZYlmaP/6fg0z3wZgXqKpjNan0on3KkmBkYiHTxVlU+izlkfj
 iF1dENM91iqXeDW/ShkGsz9fo1nBjtfpyonO1MG6HeB9KW3ThdELYPG0ZY9nmIy+9Z0Dy28op
 MS62owaB85k3OAAcsl8aZvv53xNRgdQ/jcOTWiEqrTjmpMpaRIe72WOZQLohaxz7ZHaHjalFJ
 xxpcuNW5v3K7HFVyjDNu8OJMo6Q3pFxTfzHrSxPg5Hj8TxJOum1F+CEpLuswEz/2mf/XmSg1v
 GFGR/4t45LHFBH2uI3HmlhIq5xFw3a5d/CPtw3WgSpeefwthpAE/kpnLwAIeCwFiNPB4FiKDl
 OxxPnzaDmTTSWDE8ldi9rKZVSAQ9/w/wCBsmsOxlKRgtjytWeiqYUhY5Os2dc2t9oTIEYekQU
 Lw28jQG1ed0uScx8tChCugKpG0dVfnlzlgF24I3FFfMKO+8R+qpHsuitOZzIfir55fFQ5FeKH
 PtoCCVQJJFW8z1uVxjbd8MXz439Ra5UqXa4xS6YBysd3v14iVzHt7rUOwRem2GMptUdgrLmF8
 sDK282Gpqx/YWs5sAk7bSo2Eo08/APi5SMDERH2e2r82eoAetD11pmenXHEpnJi42ubJAXelj
 Tyt5n0AdyuqsiPSBTXaQjtYCBjr6VdT6na1kUjWeWg+X1htJo6DXc4MmYIRcRGWHbaRxL+R2f
 Ye1rk6xQmk/3OtXN801qGn4uShp/qU/gZ0uGglptnKQdZWEYV+c/mF0YUl4AOa1kbb8dPHKEe
 eIX3BRcEK6EFxqM3tOomfF2qknItbOkVcVFLXeGEjXuy4x+TVfZdaFc7VQZs/WpMYdWQ4pauw
 YS7r5cHUIXsUrpHa9Vy8HN0lZh1y5vgoUorN/tQxUGU6ijB59laZWmF3SsGWnmWIC4g4OavEZ
 io2gbI8cc89nsyadHlGyzm65wi9uTpm/MZwH8dmoCaBf4vm/FmJI/y4t76hj3n/lZKGvnOi+M
 Q2bYeOkOASiRoSssxc7L81dZ8hcHGH22d1S6yGeHJ5z2KowIl9sJcszsPd+UVWMzgoeKHYUIm
 rESfMwPy7Lkvfe14Y0fmxu5nOtWgr3C0HbdZScMus4F4xmBSc7lRhvAUjcKnI6epotMICvF3E
 MKCTTmPhdZ8ZjeTFM5xfc3x98Sdz1AYz6EMZ9aaPZ1Hy1HB8zut/7LtrO2y7n8HBlz43ymke7
 heZIZLjCmo7zAqD85/S6CjLzKgLLpmBhlAsUHVDSrfDtn1bfdw8az8+7X37bTgbTKJ5fuPqpa
 +F2NW7nd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-11-08 22:21, Jeff King wrote:
> On Fri, Nov 08, 2019 at 09:54:02PM +0100, Paul van Loon wrote:
>
>>>> $ git push -v origin 'refs/replace/*:refs/replace/*'
>>>> Pushing to XXXX
>>>> Enumerating objects: 2681, done.
>>>> Counting objects: 100% (2681/2681), done.
>>>> Delta compression using up to 8 threads
>>>> Compressing objects: 100% (1965/1965), done.
>>>> Writing objects: 100% (2582/2582), 1.96 MiB | 1024 bytes/s, done.
>>>> Total 2582 (delta 95), reused 1446 (delta 58)
>>>> remote: Resolving deltas: 100% (95/95), completed with 33 local objec=
ts.
>>>> To XXXX
>>>>  * [new branch]            refs/replace/XXXX -> refs/replace/XXXX
>>>
>>> Could you verify that refs/replace/XXXX (or one of its close ancestors=
)
>>> was fetched by the "git fetch --all" command? "--all" fetches all
>>> remotes, not all refs.
>>
>> No, it was not fetched. HOWEVER, the ONLY thing the replace commit (1 s=
ingle object) does is point to an existing parent object. No other new obj=
ects are referenced.
>> Those 'ancestor' objects were all fetched.
>
> Was it a parent object at the tip of a ref?

No, it was a newly created replace object (created with git replace --edit=
)

>
> The push protocol, unlike the fetch protocol, doesn't expend any effort
> to negotiate to find a common base. It just feeds the ref tips of the
> receiver to pack-objects (which then does traverse down to a merge base,
> but it can't always do so if the sender doesn't have all of the
> objects).

So this would be the opportunity for performance improvement I guess.

>
> It's hard to say more without having a reproducible case to look at.
>
> Some possible things to poke at:
>
>   - record the stdin from the local push to the local pack-objects,
>     which shows which objects we're planning to send and which we're
>     claiming the other side has. That would help determine if the push
>     isn't feeding enough information to pack-objects, or if pack-objects
>     isn't trying hard enough to find the minimal set of objects
>
>     There's not really an easy way to do this, but something like strace
>     might help.

That's way above my Git expertise.

>   - try building reachability bitmaps (e.g., "git repack -adb") in the
>     local clone. When those are present, pack-objects will compute the
>     object set more thoroughly (because it can do so efficiently).
>
> I don't _think_ the fact that it's in refs/replace should matter to push
> (in terms of what it feeds to pack-objects). But obviously another thing
> to try is whether pushing to or from a different ref has any impact.

I'll do some additional experiments

> -Peff
>

