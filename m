Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7F7D202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 21:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933387AbdKAVPG (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 17:15:06 -0400
Received: from mout.gmx.net ([212.227.15.15]:54589 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933191AbdKAVPE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 17:15:04 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MF4iR-1duGuL3Lb9-00GEOA; Wed, 01
 Nov 2017 22:14:54 +0100
Date:   Wed, 1 Nov 2017 22:14:39 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jacob Keller <jacob.e.keller@intel.com>
cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] sequencer: pass absolute GIT_DIR to exec commands
In-Reply-To: <20171031230733.18949-1-jacob.e.keller@intel.com>
Message-ID: <alpine.DEB.2.21.1.1711012214220.6482@virtualbox>
References: <20171031230733.18949-1-jacob.e.keller@intel.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6fktoUwp8IiUjhh1unPQxVwpLoOSbQ+FXbZe/6H/NFBHg9q+t9G
 JRKcMfMHBCqBUVexe6r5QuvUmHqArEKBW+pocpOZ6lVGFXKWZ/GE7WAZqThxW3wvY9B7BL9
 WWjuvai6GQSWjmByA/JP7iPjWRGFnMc1bLJ4TlLNitvs/dd15mXbkk1a00AJHyZTCPhDx6c
 2kGCOaFuNbap2COGyPOnA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:O5GMQudPbHc=:GMD6HSKXLD6JfZXWh3dBJv
 z+Q35kHgm8pbwaC90tU1Kbm0RT8q+He0ejgRyVP3uuu3n1Z6LVCS/lyquFMlDEBdXE8dgQkbf
 CvS3jYTJ2Gr0+azYZwnAEHAcAg5aVP3LuY1Skx1aAyYzZESMWL0AeRTnBT2byoG7s19lpyGcf
 +03+on/ODOQwlimYgIaTbfcHraGToakWS5r8OzCHSKb2aij2if23QbouNqQVNgbxiqKpKrqZZ
 Z5Xh2FzL2lgZEUW0B0hG7rr4Urd4mg5etmYyn/TViwrf9A/jQM4OSfO2W4YbKfuN0edO3/IhC
 k2d8tB0pqEsVo4b2VBtMnFQGPUd1fdMRlckjyb1ZYcUiEUaGoFbZXHo05+e8QG8nxlKhtvCbQ
 5zikjj/eszjpWNxOjUivFCWYPVuircvY8Kag6PdkYC7XaCGFIudRuVKVIyDJR1iANONk3Xphd
 v4GX6dpO5rsPJV4pacgyVdjyhHDXeuIEVzFbUw8GPosRNlelyFyrDDXwWgqI17aXShtLp2nmi
 BmP10HDXQqZR5l6z+VDZsgXONKr53X7HBu/1tR1r/gi+13J2fzo4tJyPuHMVS4dJ4xgg9mFWL
 hcT7/EsJtsOlC5INyyxrnaNSYFRRrUHvnJ1mixaBnFwcNyglvIxpdGQvj8wxWOjkimE03RY6o
 z4pZBf56MGRRAlJVlUF8M8REUtHupVs/ykq+09uMwux/cGt+GbSqmU7YUFTbfdWSmfKtg/plu
 VnPmiaxu2JTFF9ds555WUzX9eRZWGQfzEzJY+7ECCb80a1lOAVnXsqEIeJoH15NsSmJHu2dj5
 1spT+oHdYpS4VPYR3mMjyq0i6SGSfRrk9K20BdjbnjlAwK1YMo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jake,

On Tue, 31 Oct 2017, Jacob Keller wrote:

> From: Jacob Keller <jacob.keller@gmail.com>
> 
> When we replaced the old shell script based interactive rebase in
> commmit 18633e1a22a6 ("rebase -i: use the rebase--helper builtin",
> 2017-02-09) we introduced a regression of functionality in that the
> GIT_DIR would be sent to the environment of the exec command as-is.
> 
> This generally meant that it would be passed as "GIT_DIR=.git", which
> causes problems for any exec command that wants to run git commands in
> a subdirectory.
> 
> This isn't a very large regression, since it is not that likely that the
> exec command will run a git command, and even less likely that it will
> need to do so in a subdir. This regression was discovered by a build
> system which uses git-describe to find the current version of the build
> system, and happened to do so from the src/ sub directory of the
> project.
> 
> Fix this by passing in the absolute path of the git directory into the
> child environment.
> 
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>

ACK,
Dscho
