Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD478207B3
	for <e@80x24.org>; Fri,  5 May 2017 22:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbdEEWcL (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 18:32:11 -0400
Received: from mout.gmx.net ([212.227.17.21]:52457 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751348AbdEEWcK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 18:32:10 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MPIvU-1dB9UJ3UJM-004P6h; Sat, 06
 May 2017 00:32:03 +0200
Date:   Sat, 6 May 2017 00:32:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Daniel Ferreira <bnmvco@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 3/3] add--interactive: use add-interactive--helper for
 status_cmd
In-Reply-To: <1494009820-2090-4-git-send-email-bnmvco@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1705060031450.146734@virtualbox>
References: <1494009820-2090-1-git-send-email-bnmvco@gmail.com> <1494009820-2090-4-git-send-email-bnmvco@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:XES/4+Q8ExbteFpXFtFbMglHUwLRfeB9bDKJL4fhgcHzZRPsTeo
 o5OInuzqod2yQdRU17+v0mzz1irNOG2cnxS9ckXtHFtrvNJut7ejYph/9rzDEbah6umlfhS
 K53qHaCwB5ZZCyuMHjIGyr66UxjJfQkv9QcxR3eMTh2fUmkB+bArn7PSmopv8D5q3xQbYm9
 cAX3QGdwLhinE79BKlTFw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0OP0kOdUBIk=:ZiLJ9NiLr+GPhvDX4/uNlh
 UCXy8j/0HxBWNkktUGZRQcEbnNpZFo0oDhe9HQkArEUbRFzb73g08v/rTSjrog+WRhpl/n53t
 ZvFpVxCZtznGdXOzYn99DStM6HOjxIZmzOZ4A7Wd54Qb62BOS+8J03IwmoBKSi6yldxXuJnP6
 xJthXteO7bcU5v+a7cA4StFN/tfb++mRbvWy9ljdwnWudgzI9UlZydxSZiukwJOk6IqiryVY9
 tc+v5rTH4pZrlbwad7F73RDamM/iWPel8sAojcJNBOgXa87+1UMC7wNKB4C7iMhyFyWyY/4+2
 ibfI/jTI8GNaNhnid5cvw2oB1h7UxY2Ueen2kdVvl3a7F3h099WLfVd2lv1+7k/YVb+UpOhJn
 0q49gpcAHSK+J8shzvHw1dGQbhUW+7t3AeoWS/R6edodT/McDnUkFzwqza/Ic/NMuqK04Gp9t
 7Mj2Rau2EmrPw3AEINg5QX/Ye6vejUP+UVB4mNSz3UPUnxZPof13yCGgeb15WHInN3C4NtTTK
 X+fcNEvDowc5oxkXE32Hk4LUW7Z0qNZTGXN91i3s2z0E2zKoBsGXv7mFdZPufu2O6a0/RutzE
 EVc+aZZ3803J1HG2Nve0dvfD1Z4dp8mW4y22U7sgoLPqjI2b/ZILDZcehoASqRrvC4yeUpIHU
 IAXW7zm02E3/zIVSIkPPRlVtJxva8NPbjNL3/zxL9E/6kxaXrYwCP6IFdII+cWRiLrLwc+S40
 o8UFrLwWxuKiKHQL0bJbnAtLXNQTZiVOEsIvZG4iFbKTY2A+ajPvzoTtwQb43EiXtgRBjoHRR
 pB+r6oi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Daniel,


On Fri, 5 May 2017, Daniel Ferreira wrote:

> Call the newly introduced git-add-interactive--helper builtin on
> status_cmd() instead of relying on git-add--interactive's Perl
> functions to build print the numstat.
> 
> Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
> ---
>  git-add--interactive.perl | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 709a5f6..8617462 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -632,9 +632,7 @@ EOF
>  }
>  
>  sub status_cmd {
> -	list_and_choose({ LIST_ONLY => 1, HEADER => $status_head },
> -			list_modified());
> -	print "\n";
> +	system(qw(git add-interactive--helper --status));
>  }
>  
>  sub say_n_paths {

Obviously good!

Thanks,
Johannes
