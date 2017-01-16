Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E508C20756
	for <e@80x24.org>; Mon, 16 Jan 2017 10:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751258AbdAPKyI (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 05:54:08 -0500
Received: from mout.gmx.net ([212.227.17.20]:58318 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750939AbdAPKyI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 05:54:08 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MNuwp-1cNKQo1ZAh-007QsF; Mon, 16
 Jan 2017 11:54:05 +0100
Date:   Mon, 16 Jan 2017 11:54:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stephan Beyer <s-beyer@gmx.net>
cc:     git <git@vger.kernel.org>
Subject: Re: [RFC] stash --continue
In-Reply-To: <cd784a4e-ee99-564e-81de-9f7f6cc26c67@gmx.net>
Message-ID: <alpine.DEB.2.20.1701161153340.3469@virtualbox>
References: <cd784a4e-ee99-564e-81de-9f7f6cc26c67@gmx.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gghmV+hcQUeccNc5xagxHADDG1oXWnGjQlNrSYOJLc/W8+kx4M2
 VLmBx0IisbtapFqt/yGdjGwIh2vwC+0nx+1duxk/LokmLgxaQgBZTTVKiRtJdlHoxyyISMk
 1mUrNceGCreTk0EqySmX2ObYlY+B8NSeIdQ+arzh4XAnpYS3XhV4dhP4OZ1BuaBKU5LBiJH
 IWfsxlKY0xYjJBKSkHpcg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J7xWrJJFP6w=:Eky79XmsZMTSuEc+ziXknk
 GHFfYHQJRkBQF7ae4g463G7BSdEMyz6v/0dwqjDk3hwA3bBVaoS4UYq7l7x27UAUQzT0hW+Ft
 9GNhbROF6u/gbFZM/G4DDUXY2Wd/LivmnOiXCaf709+YfCEVB9aYDLySvYBnO4tArr1u5edzJ
 E8fLbu0/jC9jlI66Smjm9CbQqsiwyTEBKL8ZHk0eTgX+1UjWnq4JCtx4uAD9TukYSJ5CaVkqr
 L2GPyWamP//nkKKbvCqOIqKA81fLThE1nbUyWiCOAM4AL1YxzZznXzcsIjNGLy3q640MXkgSE
 HEoFd+/IDtw5sBnFLOpWUTIkImOozp2EMpaXqgE6m7hU7PS8uqtXSAdm0oyf8bWA8r+V+/BFc
 uV/J+yyVyxvzfbN3rHkLfJCMWI9fglcKiUTx6XGN5U1o1EgZiY0dGSx7RoQNnU3dDOVaLvb6z
 gDtYkX3+GasQwXrbjhx0iaG/I4DCb0NZxwXF3YQXgIlv8zFt3zH7eb3i7lImlSn6gKOOcSje5
 fR2NT7I+FZyTFw9u89QDTbbAqJIpcIIWA/nMHVsf+cUiaDEClI6YGUgQwY/trfx9ANv/2qQoZ
 2Zy9LwRCYiS2E5W8HH+Tn/gpzOQ2jUAhZmvoqdcL5V39ogOKNE1oI8mGFi2qw1Bp93pDBwIqv
 gfilv+aA/m+cWg8TtYc5LIKeH0NYqBBvItulToJms7opp0wZtJYxPcJKDizS0xEr9q6Awolbo
 SOgs5MaDvZBZuoInyDhGNrqI8MuJ2IF9oPKIlZsYct8eq+G8N+GZwWL68LSbNYLDo/b1UCMMw
 vTohIPB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stephan,

On Mon, 16 Jan 2017, Stephan Beyer wrote:

> a git-newbie-ish co-worker uses git-stash sometimes. Last time he used
> "git stash pop", he got into a merge conflict. After he resolved the
> conflict, he did not know what to do to get the repository into the
> wanted state. In his case, it was only "git add <resolved files>"
> followed by a "git reset" and a "git stash drop", but there may be more
> involved cases when your index is not clean before "git stash pop" and
> you want to have your index as before.
> 
> This led to the idea to have something like "git stash --continue"[1]

More like "git stash pop --continue". Without the "pop" command, it does
not make too much sense.

Ciao,
Johannes
