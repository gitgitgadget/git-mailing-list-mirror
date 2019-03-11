Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6AD320248
	for <e@80x24.org>; Mon, 11 Mar 2019 12:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfCKMyq (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 08:54:46 -0400
Received: from mout.gmx.net ([212.227.15.15]:43587 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbfCKMyq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 08:54:46 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LkfdE-1gTAkd3T8u-00aT3A; Mon, 11
 Mar 2019 13:54:39 +0100
Date:   Mon, 11 Mar 2019 13:54:23 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 1/1] fixup! upload-pack: refactor reading of pack-objects
 out
In-Reply-To: <nycvar.QRO.7.76.6.1903031601130.45@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1903111353150.41@tvgsbejvaqbjf.bet>
References: <pull.139.git.gitgitgadget@gmail.com> <5fa4fcad63e18dd9d840217eb8cf3dab8f69bc1b.1551046329.git.gitgitgadget@gmail.com> <xmqq1s3o69cl.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1903031601130.45@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9oqF8St0gem+NvLHxwYWjTUix9GeHxzsfYQz7FfvZbaz45oEoka
 jagB4yBStilNosj3PJvfhYehqWl3yX+WbmtMr/4VJhjCmUpFP6JMBENKOM/fW3xy06DPeJV
 gqueZoomFsRqruoGZSkpcH1MmerpKFzeGVrMP6rKdiSYn6ALWt/79PtvOaqu4TKu5iU3UnK
 +8delixqwDt6MEZY/HODg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:osIHGqAMwKI=:WYkTkx/0sPfja4pc1QWnPw
 eRr0riaw6EjYIie2JQ0gw4wb1VvTfQzM8ZgnPrJyqS0cm8KiR6ZZsB+S5Y2Bw0gtF0AJD5lLw
 JD8M16jNUIsFDAqe757j7fCgN/wl+XTWRJVt9aRJI7MxOKf52Nl72on6TAo4yqn6UW3sYl/7D
 Jl2N3SYe18204cATZo3eTreSyI2zGn6b4X0DGvddr/m46ByKvGkiDLh5eP1Hrsx5VjHg7qd3N
 4KcwSdXm4SIy71IVrcNYR4lH4f380ApfHGVFLgPuE3FKgfSlVZMvuC8U3/BjiCvYnQbu/WTJF
 51ATYrHVv81z2OZvoSUGhK715SlpS1TZmDZn2vmGFQhDyLgIsNkzbDSmKoA97LlOtW4v6ZrxC
 x6vaeq14IibHbiuIvjYPB4CsTFRUVgdjnzs6ubGdq2aiMCl228INf5gn1+dxM4o/+T0HieEb1
 e64ZVJZ5PJOr1GV7AKESnPtHDBkoml5tNfeO1/rwizpGHt/XPzqyEyX8CbcGeidxfRKeM2Ctp
 JOESQ6fV3QMpk544odyvIHtnwjC/eLYaUrR8QWtEKDSCbYyCU6yh2ddPkzE2jXNLPeaG9s7WZ
 XrnOjFGj2PZmwQ1Ue4zEn75wePs2zrDrCLtkOr/x3yx1jkOP8HqblUUi8Em5FOLQGByOP0i/E
 8fytT3TlXG3cMg9F0PfxgMbomdDEEAnOUr8z1c8zq2wv+QGSFSiWpbkOUoFoIHNbE+C5Axuq3
 g0gAB5KOHcbCQ5pd17dMQwDqv6MGNwltdjbdUlOx+VODua7ZjWt+HbY/aug7DR358zf5QtiJL
 ag/3+CNfindHFOuVLKRdT5vy+yY3YMuZTn3MY4vKTTI7bpHl7zdxV7X5iTQfvULPRka3GV9Ji
 T8vMWQLSc7+bN08hKlBLjbu05rHQ0jaqndMyo3+C0SYgiy3PEpkmsIH19ZTqyU8+huU9UK7Bt
 Suy1AlCo5mg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Sun, 3 Mar 2019, Johannes Schindelin wrote:

> On Sun, 3 Mar 2019, Junio C Hamano wrote:
> 
> > "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> > writes:
> > 
> > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > >
> > > This fixes an issue pointed out by clang.
> > >
> > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > ---
> > >  upload-pack.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/upload-pack.c b/upload-pack.c
> > > index 2365b707bc..534e8951a2 100644
> > > --- a/upload-pack.c
> > > +++ b/upload-pack.c
> > > @@ -179,7 +179,7 @@ static void create_pack_file(const struct object_array *have_obj,
> > >  			     const struct string_list *uri_protocols)
> > >  {
> > >  	struct child_process pack_objects = CHILD_PROCESS_INIT;
> > > -	struct output_state output_state = {0};
> > > +	struct output_state output_state = {"\0"};
> > 
> > OK, as the structure looks like
> > 
> > 	struct output_state {
> > 		char buffer[8193];
> > 		int used;
> > 		...
> > 
> > we obviously cannot initialize buffer[] with a single integer 0 ;-)
> > Between "" and "\0" you wondered elsewhere, I have no strong
> > preference, but if I were fixing it, I would probably write it as
> > 
> > 	struct output_state output_state = { { 0 } };
> > 
> > so that readers do not even have to waste time to wonder between the
> > two.
> 
> Right. I don't care, as long as Jonathan addresses the compile error on
> clang.

This is *still* broken:
https://dev.azure.com/gitgitgadget/git/_build/results?buildId=4337

Junio, can you please in the least add my fixup! on top of
jt/fetch-cdn-offload?

Thanks,
Dscho
