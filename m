Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0366B20954
	for <e@80x24.org>; Mon,  4 Dec 2017 15:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbdLDPrK (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 10:47:10 -0500
Received: from mout.gmx.net ([212.227.15.19]:63562 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751846AbdLDPrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 10:47:09 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M5uLh-1fJ59J0Mpd-00xs0c; Mon, 04
 Dec 2017 16:47:00 +0100
Date:   Mon, 4 Dec 2017 16:46:50 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Liam Beguin <liambeguin@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v2 6/9] rebase -i: update functions to use a flags
 parameter
In-Reply-To: <20171203221721.16462-7-liambeguin@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1712041643250.98586@virtualbox>
References: <20171127045514.25647-1-liambeguin@gmail.com> <20171203221721.16462-1-liambeguin@gmail.com> <20171203221721.16462-7-liambeguin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4m5w5JHIki547+rPevOoTaJMsCrId+doQyAorN0F8zjRsoqy8Y7
 KmKevhs/IqoN1z58r71EeZqVgnhCsgDgBjh/vMFKDSRGZVvEMKy1u/GsWRD94r/Mzrw2irz
 BmqZdvH07PPJ7D0pvgVho7d6cUFrxEEtKVSWL68QISUEXliC4sGgYiRnnb5bvr5qnk5aJIa
 a/YgTHtEf0x+ZexbT5fjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kfFlNLxQwec=:Ya7goYfiJoRjAxKdGRx1US
 q16iH17VThjTFOhWk8blkdW23IWWyh1wLeSD6IT7JcWa+efZnFfuIIpiisI93bdTyObZXvyI3
 5RyVijVptNaH3VUBrPH41/uuD72oAeDAMds8Eva6bQT7VohCQ0/eNgK32g6ZLAyS1uMa4eVyi
 VRr0tq7TI+eFfjX/88VFZgXBZRmSqPjGo++u7XjlWd/zIVVoeN5w/rkYeh8h5dhlDiXSDKQbf
 qWBhIHl1yVy4x+Iwpodxy2YHVgSI7ufLGjdy+msEl9c1vrtdwzHnkOQld/gTbHpnqr9gpX8iR
 CMAzK83jfPIM8iMvJ0K84wNcy7F+Djv2eVLMILam5VHad/62fQdOjE7VD1/WLDvFjLgeA7kar
 qA1+xQAXZ/icpH/h+zVZXIFkpBOle3kahN4CK0tBc2A6JXKJgd81thd2zpWj2fJgslXKvfZB2
 wqyJxHx2xq70Ph8TIcKGym5xNO9aFr4NfHbNWSe5jU6bIT17GjXfFrEqJ1KKs7TLbJkjbQRYX
 wb2GevkQ/lKhkHR4UyUjK5108MR8z/ZZnEqdVbSP3y6D9bS/lZaV2ZKBjXD8P3EPNWfZcE0Tr
 /AhYI4jImCoJjr/+Fh+Ah7/F8xmFOqukw9dOr8u0rp1XQoflCBus2OXCnnesTcNWMxOyCO3RT
 mIzpHFQpJhKPMF/shXHjPAmWwHl2W2ozBi5Ucy1UPcZ1ywX2Jtn4vJX25Zh3uLb9rJUwblRtY
 zWXunnpM5SA8hZ08Izb5JiPzYwrhTzL9+Slc91N3o8sE+jdS0c5L0SEg8CzbOiWSK+e7wFfMe
 upFLqPpBGPYhHBHSC5TLXCs65sY0TuTNf8JLkjGNoEH5zC0S8k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Liam,

On Sun, 3 Dec 2017, Liam Beguin wrote:

> diff --git a/sequencer.h b/sequencer.h
> index 4e444e3bf1c4..3bb6b0658192 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -45,10 +45,12 @@ int sequencer_continue(struct replay_opts *opts);
>  int sequencer_rollback(struct replay_opts *opts);
>  int sequencer_remove_state(struct replay_opts *opts);
>  
> -int sequencer_make_script(int keep_empty, FILE *out,
> -		int argc, const char **argv);
> +#define TODO_LIST_KEEP_EMPTY (1U << 0)
> +#define TODO_LIST_SHORTED_IDS (1U << 1)

Maybe SHORTEN_IDs? And either revert back to transform_todo_ids() or use
SHORTEN_INSNS...

Maybe also TRANSFORM_TODO_LIST_* and maybe move the #define's above the
transform_todo_ids() function, i.e. one line further down?

> +int sequencer_make_script(FILE *out, int argc, const char **argv,
> +			  unsigned flags);
>  
> -int transform_todo_insn(int shorten_ids);
> +int transform_todo_insn(unsigned flags);
>  int check_todo_list(void);
>  int skip_unnecessary_picks(void);
>  int rearrange_squash(void);

Ciao,
Johannes
