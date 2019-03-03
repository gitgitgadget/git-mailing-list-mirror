Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7E0920248
	for <e@80x24.org>; Sun,  3 Mar 2019 15:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfCCPBx (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 10:01:53 -0500
Received: from mout.gmx.net ([212.227.17.20]:46231 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfCCPBx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 10:01:53 -0500
Received: from [10.49.202.116] ([95.208.58.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MLR30-1gzuep2adG-000chA; Sun, 03
 Mar 2019 16:01:45 +0100
Date:   Sun, 3 Mar 2019 16:01:44 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 1/1] fixup! upload-pack: refactor reading of pack-objects
 out
In-Reply-To: <xmqq1s3o69cl.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1903031601130.45@tvgsbejvaqbjf.bet>
References: <pull.139.git.gitgitgadget@gmail.com> <5fa4fcad63e18dd9d840217eb8cf3dab8f69bc1b.1551046329.git.gitgitgadget@gmail.com> <xmqq1s3o69cl.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kmzxczEZ1puqTR80mkcuj6UleR+kDeW1q+09pAPFlTCvU/AtdMA
 5iy30pxl7X2Bu1uDxTorJXX4qHUvlWPAWIBMZM8z6jxZyu0QzP9zODcXWIt6jDJwZrR6Vw1
 snQevKEARy0qVFVqY0gWcg3b+pwS20/CdOJ8ljoF9CNfiAnINpMrmSdpJZJjuk68XUbXq0Z
 bkSjqRzKwbVyS9XDPi7CA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DbJxUP6ZApE=:F10CRs3KDtR/6lki0X6VpU
 c2DgJWbkCsb9ciSrNN65eC2xS2PbzjWK+vCFwocpxeTT0fSpUu2pHwTvSlMrt2i1kgIC0QJDX
 wGrdkdYzkqIV8ksPw5hwYjSdWK223FdW3UJJcOvnkWwITngTM8L5f5SrSTmqTT+chF38N4b2y
 ztffGAn0cLB1D+j+F1BRdQRuCBinVQ2RcGl7vwl4ZoSzlxMxU7m9G99qQQ9Euua8xi2K0iiYE
 ov6eQW+574pKrRdBVI6Pg0IKewN58UPNifS5Qc1I/8L/V93AdDIol2KMgvO/8MjsViQqzimzo
 DNj/M3/XPvtLP8rX3/uWpLfNWTfb1A0AYrCfzY8WOaWKaJnTbGTd4SzyX8wXlekGGqZdBPNni
 bwl1WRfDxLHwiflirKwEcT9TfriHCdpb0sHZ7lCg+x+hv/R1v5tCQ3Nyrfjf9O9lBTZc4OtsS
 +fkJ/yF7JmWLHebTd9j1l/79QddiNE9j1vTFOlnOjjxtC/JEFjVUbvyReXwDDvjwZIZfHavlB
 MhqchN2n6GTTg0zB1ctCgqWWthPcc4VI0CVqLGT6NM9azLeTz8PVCiKf/HbzrwMgD7bski8gF
 n7qnKhSqKd9uO6dMLy6IE8fNyTxOD3RKYvfeh5vg4HcEXIOlhUZhv8Dv+Y+huMsidHl3DY6eW
 1AINviCnwthfhXGCG4jbjNsBbgdqqrdGyi3AmNkCBPa9sgAHzj9JboVXCFXkBGsaf4y2191OX
 WfNWjJmrtVP+IKjmWgfOEv7qDKzyRuPxcuGRoI1nmNkBQv/OQ4FdGmvvqNkws1T0QSJTuRCvj
 uFedVTQ0Je/nrha+MII3EAO/ZNmmRUVdycKfqaZ1aztdQGdH4WJffWE6uD9mg6CcEG1D1w9kk
 oEnY+JNGE9Z4Ti82pQwSCy7+5XNIWCavZEA6lAC5cLiWNnA+veC1Amks0ZF1db74Sf1U3oyTQ
 Sj9ryHEyPag==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, 3 Mar 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > This fixes an issue pointed out by clang.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  upload-pack.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/upload-pack.c b/upload-pack.c
> > index 2365b707bc..534e8951a2 100644
> > --- a/upload-pack.c
> > +++ b/upload-pack.c
> > @@ -179,7 +179,7 @@ static void create_pack_file(const struct object_array *have_obj,
> >  			     const struct string_list *uri_protocols)
> >  {
> >  	struct child_process pack_objects = CHILD_PROCESS_INIT;
> > -	struct output_state output_state = {0};
> > +	struct output_state output_state = {"\0"};
> 
> OK, as the structure looks like
> 
> 	struct output_state {
> 		char buffer[8193];
> 		int used;
> 		...
> 
> we obviously cannot initialize buffer[] with a single integer 0 ;-)
> Between "" and "\0" you wondered elsewhere, I have no strong
> preference, but if I were fixing it, I would probably write it as
> 
> 	struct output_state output_state = { { 0 } };
> 
> so that readers do not even have to waste time to wonder between the
> two.

Right. I don't care, as long as Jonathan addresses the compile error on
clang.

Ciao,
Dscho
