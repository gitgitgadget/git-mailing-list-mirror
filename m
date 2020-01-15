Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10335C33CB1
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 14:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D87222C3
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 14:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lgbw1yCG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgAOODH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:03:07 -0500
Received: from mout.gmx.net ([212.227.15.18]:42521 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbgAOODH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 09:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579096982;
        bh=7y83qwpK1urV0rOZu3oX1WdEDywlJt49kHo7Y3lBUb0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lgbw1yCGzDGvB0EJaISzfiO6YohxTEolLe0mbnLsGwkdOzY70XV9Po1Bw4+zlx89L
         wVtu0Zp4hilmzTqN7JgU3v4481i3s7OBtusAHaoTODPSqbTJ9mhRF5A1orQ0MhXGFR
         v+TG5AAZZ0KsHRFkGQDQGYXzUd+NsRiO52R3rkx8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOzOw-1j1fxq2hum-00POCH; Wed, 15
 Jan 2020 15:03:02 +0100
Date:   Wed, 15 Jan 2020 15:03:01 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: "rebase -ri" (was Re: Problems with ra/rebase-i-more-options -
 should we revert it?)
In-Reply-To: <xmqqpnfnj9p3.fsf_-_@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2001151458100.46@tvgsbejvaqbjf.bet>
References: <f2fe7437-8a48-3315-4d3f-8d51fe4bb8f1@gmail.com> <089637d7-b4b6-f6ba-cce1-29e22ce47521@gmail.com> <xmqqeew4l6qf.fsf@gitster-ct.c.googlers.com> <xmqq5zhgkwxx.fsf@gitster-ct.c.googlers.com> <xmqqy2ubjkeo.fsf@gitster-ct.c.googlers.com>
 <xmqqpnfnj9p3.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:e9aZxw1+Qvtg59q/spCDRCZJuP4Ir+q2bP5X2nN4IUSNDrFVD30
 SNY05nnGHl5ZINBRM0qVxeyCVh+csUGcFfIPipqblS04Ig4p/ffmk7kEk9MZRp4CGhXuvpv
 AeoXMZmJhJ190HNXsyIv2O1FJBKoWj20Gepl/8nKm0MTgH0bwN02FJFoPAzHDLuHUUI7P6C
 LYI40wl18uMXaYXDBnPeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:veXHMNg+beM=:jAvUC87+alWGCZgQuROASw
 jQVTSuZOf6K3Wj3/8xYykUuHvAwhEReukCWN7/kdL8pH0suMnK0Rk7CskwA+PcU5r5Lcy0Tih
 iMEzv91/kygn3xl1Uk6iCRf3p5JFloTlA7Q73DOZbFn1FBfjmkKvUT464y9w4c0pCOQaYuqO6
 RljEblGFwbQNhBlrtDXI+YaKj5zp2HvUzNA0Ru3yECLHoS6ApbNQiH7+jCujQeuVVbie4awPT
 5zBYl0oUHBRR9TD6rwXEWCnkrTk05S8ZbvVeEDBM1l9kIVj13Y/pDhSewpZuaoMJLln9bJz0N
 5OToQclhlfAKVKYaeLK7GuBTj3vfCDTFDn1xhHDpbKGGiRTksuVI5RFSEpBr+3nsARt34D3kw
 jVLOn7u4bqyi+ShcDWVMJVxOWsGek6MfQA6II4/wkRW3/oD4VxOCAknhSxoE0FSip56q1Jpyu
 YxByE02exLR7EGRuCL0ffZAZCscQDL2FBKZkwYqvhXntqfQu4OhcUocc+Mp9TmKkkxmrq2y/u
 dqyuy+UCbjdX7hcxJvRb1ucSGZHXVqFEasE4+4PFVaytiY/vMw7sfgi13O04noX2UuGMyMTXf
 n1PU8jO7OSj6pIeXLuvHa+1GjeVejxKZe8pgkKYD5ExLxPOLawjnKBgxPWWQqFtR0wdFb/16q
 esEdKRqcoiRFXeueMCxaPWEMqTajbBuTHRXM8WXzPo19z4Bte+ZFVT/uF8LamhIRlqLKP+uIs
 q7t6dN1PvGHyNge/WOh/NlAjmLBWo6XNwBtBLRjWGz2iS+wcHVR4d3eoT2oqSubvbL7KUYZk2
 TcNQIro/XcAHFFIv4bNNJY/tVmXqANbWVQoIzXL01YGnjuCtGrbqeNVj2nXqKAn6zpBkBrOB0
 EH6/ju0WeDem3dLdyxQu3qO1unFN7Dpuvm0pdht23VL6/WWrxKJbyWj6RFZDp1tTfYYQMNqe+
 z5yibH8ZhlvFypNdppLvj169PmsBmpu+ZIshBVz/tiMisrdlUAgNs/OwlOvPFYLdt7lqHd62R
 KB/708ldWIiEYsgfSqTI4j7kpR2IalNr+Odhhb/UC3mYc6QWVHqpB/fs/1ujQZw5Fr+l9bIxt
 a2cRDK+utxhkbWA8FHe8UoWyxck2ZBNnFDI9KJWq9dddeSaWNcrUAEM44XcXVxI5l4dqTD5AL
 402x6eDD3Z02SvGQLEmI43Bcu/I3qoePNUHHX6pO9jwDTRQr12EAbzdHafRb++3L1KReutFpk
 DEFXvV3ndpnY4SJGZ8t1QEnE6/RIfPuq5PGrFetHlGO12uwhg1eoG7z3gEkI=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 13 Jan 2020, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >> I will push out what I wish to be able to tag as the final [*1*]
> >> shortly but without actually tagging, so that it can get a bit wider
> >> exposure than just the usual "Gitster tested locally and then did let
> >> Travis try them" testing.
> >
> > I haven't heard from any failure report so (taking no news as good
> > news) I'll cut the final today based on what is already on the public
> > repositories everywhere.
>
> By the way, as one of the methods to double check that my result of
> reverting the merge made sense, I ran "git rebase -ri v2.24.0 pu"
> and excised the merge and the problematic topic out of the todo
> list.  With the rerere database populated beforehand, it was more or
> less a painless exercise (except for one topic, en/rebase-backend,
> which is one of the topics that was queued forking 'master' after
> the topic got merged *and* actually depended on what the topic did)
> and after about 1700+ steps (which did not take more than 20
> minutes, including the time spent for the manual rebasing of
> en/rebase-backend topic) I got the same tree for 'pu' I pushed out
> last night.

Nice!

> One thing I noticed that "rebase -ri" could be taught to handle
> better was that the side branches that were merged to the final
> result did not get relabeled.  Those merges that appear on the first
> parent chain leading to 'pu' call themselves as "Merge branch 'blah'"
> and many of them (i.e. the ones that forked before the merge of the
> topic getting excised from the mainline) did just merge the tip of
> the named branch without touching the commits on the side branch,
> but some branches did have to be rebased, but their tips did not get
> updated (only the tentative rewritten/<topic> labels were pointing
> at the updated tip during the rebase, which are of course discarded
> after we are done).

This has been discussed on the list before this past September, but I
think the discussion has stalled after v2 was sent, most likely due to my
suggestions asking for more, I hate to admit:

	https://lore.kernel.org/git/20190907234413.1591-1-wh109@yahoo.com/

> But other than that, it was quite nice.
>
> It is less transparent (at least to me) and probably less efficient
> than the current workflow to rebuild 'pu' for a few times every day
> ("less efficient" is primarily because the established workflow is
> quite optimized to the way I work), so it is not likely for me to
> switch to "rebase -ri" any time soon.  But it makes me feel safe to
> know that there is another tool I can use to double-check the result
> of everyday workflow.

I understand. There is definitely a non-negligible cost involved whenever
switching from one flow that works to another that might not yet work as
well. I had the same hiccups when switching the Git garden shears over to
`--rebase-merges` (it was worth it because the result is so much faster on
Windows, of course).

Having said that, if you ever find yourself wanting Just One Feature in
`--rebase-merges` that would make it worthwhile for you to think about
switching your patch-based workflow to a `rebase -ir`-based one, please
let me know, and I will try my best to accommodate.

Ciao,
Dscho
