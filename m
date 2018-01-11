Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65DE91FADF
	for <e@80x24.org>; Thu, 11 Jan 2018 20:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933794AbeAKUWA (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 15:22:00 -0500
Received: from mout.gmx.net ([212.227.15.19]:56916 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933683AbeAKUV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 15:21:58 -0500
Received: from [10.122.129.233] ([46.142.197.184]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MaaOf-1eJzkz1Zqj-00K58s; Thu, 11
 Jan 2018 21:21:40 +0100
Date:   Thu, 11 Jan 2018 21:21:38 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 8/9] sequencer: try to commit without forking 'git
 commit'
In-Reply-To: <5efbad65-6afe-e135-4681-ba380cd6797f@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1801112120390.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20170925101041.18344-1-phillip.wood@talktalk.net> <20171211141330.23566-1-phillip.wood@talktalk.net> <20171211141330.23566-9-phillip.wood@talktalk.net> <20180110205351.GA73826@aiede.svl.corp.google.com> <nycvar.QRO.7.76.6.1801102332350.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <5efbad65-6afe-e135-4681-ba380cd6797f@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:j8dd/cF0RsFqGmO8ONICxDVkEJt4IEP2kvGl7GwAoPutl3sw7i1
 sm2pw/E2/O+ANRQxuM9qi2NFrPQts7unQpRIkhGzk5vTDKEiUESmeajMrIP+R/xxf/pdxsx
 zvqbBsULbHUvtzMu/2oQnlTAoYOxT2M/Z92eXNmo4nX9Bi6T6NhEsZ5kM3BRFTksL9qar1j
 +kyX/KGruPW9TSfSLm9oA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Uj3kK5iyoUo=:ooUpoT4V5Q70+4ue1qsrXj
 osEq7/rAIUd6P+i3WSuPdHLSGB8zVAeeTPXlRU0UxuJwmCuZcGsfc1d6mxM8GVCnK376nfz02
 3Cpt4Nf5ORVtbMhtlWTkT7WoEORunCodifTiDzkX5MwstCsNpburij3x3TR7/driY6XmvwovG
 rZdZtDU2pveT42HrH/y4YH3dH+2Z2pshyZLqmia6y7xd/q0IR4Op1inlo/bm/6dsv9bMqzTNn
 pbOn9odT2vsdhVDWje3xbdNh5OsCCklPzIuQV1dBPognuUvs94UPiOf9j/IYYtFBeOke9rZyy
 iosn1VFLLVwyQmJzTqX0IO8oWVkaPuHKCeNrPfFn/pH+jat1pERfn1ASyRYZ07WQ0zOY9LKEv
 e0ButWOO1dz2h61cFAvgjxgMRWqjh0DliYcqQUSQ0zYVyHPP45929WbonJ+T60K4WdJp6ln++
 d78FABCFGp/Db3sY3O+JP0LwDdqBEdIyNtl8I24TfSs/AjEoeX2SEhBgMCuTHaufmEs6Auq/D
 PEiydOBM/dchOAblsdikQF20HQI27nE3p6gGtF8C4jcxwKvsUbxKiCo3gVHHwjmgPGqHpqK/n
 rTfkojEayNDbEY83Lj43koJbxjML6s5A9Zsvg9F2dd6nvo3v9/a+8pG3gx4AK4N734oWgTdXj
 ZtQbZDLa42IfyrxtrDm9co7HHNS+44aQTN/qLWiTxmkPxMRvtNjbR2H6t4pRWl937GOlLUYyO
 /ionITXWov8KYRzgKCKqeD8ufQ+EFCAJnCWlLHcLGbA4m1BtSaIB0eJePznldm4r5W+WwEla7
 Zjumvl8U5pZbrBtXrwmfOBOh5eqi06TtR/umKulHDUmb4gaayA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, 11 Jan 2018, Phillip Wood wrote:

> On 10/01/18 22:40, Johannes Schindelin wrote:
> > Hi,
> > 
> > On Wed, 10 Jan 2018, Jonathan Nieder wrote:
> > 
> >> that this causes the prepare-commit-msg hook not to be invoked, which
> >> I think is unintentional.  Should we check for such a hook and take
> >> the slowpath when it is present?
> > 
> > We could also easily recreate the functionality:
> > 
> > 	if (find_hook("pre-commit")) {
> > 		struct argv_array hook_env = ARGV_ARRAY_INIT;
> > 
> > 		argv_array_pushf(&hook_env, "GIT_INDEX_FILE=%s",
> > 			get_index_file());
> > 		argv_array_push(&hook_env, "GIT_EDITOR=:");
> > 		ret = run_hook_le(hook_env.argv, "pre-commit", NULL);
> > 		argv_array_clear(&hook_env);
> > 	}
> 
> Thanks Johannes, though it needs to run the 'prepare-commit-msg' hook,
> the current code in master only runs the 'pre-commit' hook when we edit
> the message. I'll send a patch with a test.

Sorry, yes, that's the hook I meant ;-) the quoted text by Jonathan even
mentions it explicitly.

Ciao,
Johannes
