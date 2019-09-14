Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E860F1F463
	for <e@80x24.org>; Sat, 14 Sep 2019 17:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfINRs5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Sep 2019 13:48:57 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:40805 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfINRs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Sep 2019 13:48:56 -0400
Received: from localhost (unknown [1.186.12.20])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id A2518100007;
        Sat, 14 Sep 2019 17:48:54 +0000 (UTC)
Date:   Sat, 14 Sep 2019 23:18:52 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v5] git-gui: add hotkey to toggle "Amend Last Commit"
Message-ID: <20190914174852.ybddibvye5pwrk4o@yadavpratyush.com>
References: <CAGr--=LmC2VwGCdfRuv_G2mXTt2H8XMDGsLnHU_2oHGhvbdNsg@mail.gmail.com>
 <20190914091835.11236-1-birger.sp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190914091835.11236-1-birger.sp@gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You missed labelling the menu item of "Amend Last Commit" with the 
shortcut, like we do for other menu items bound to a hotkey like F5 for 
rescan, Ctrl-T for stage, etc. I added that locally.

Thanks for the re-roll. Will queue.

On 14/09/19 11:18AM, Birger Skogeng Pedersen wrote:
> Selecting whether to "Amend Last Commit" or not does not have a hotkey.
> 
> With this patch, the user may toggle between the two options with
> CTRL/CMD+e.
> 
> Signed-off-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
> Rebased-by: Bert Wesarg <bert.wesarg@googlemail.com>
> ---
>  git-gui.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index c7d9103..790adf1 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -2664,6 +2664,12 @@ proc focus_widget {widget} {
>  	}
>  }
>  
> +proc toggle_commit_type {} {
> +	global commit_type_is_amend
> +	set commit_type_is_amend [expr !$commit_type_is_amend]
> +	do_select_commit_type
> +}
> +
>  ######################################################################
>  ##
>  ## ui construction
> @@ -3892,6 +3898,8 @@ bind .   <$M1B-Key-j> do_revert_selection
>  bind .   <$M1B-Key-J> do_revert_selection
>  bind .   <$M1B-Key-i> do_add_all
>  bind .   <$M1B-Key-I> do_add_all
> +bind .   <$M1B-Key-e> toggle_commit_type
> +bind .   <$M1B-Key-E> toggle_commit_type
>  bind .   <$M1B-Key-minus> {show_less_context;break}
>  bind .   <$M1B-Key-KP_Subtract> {show_less_context;break}
>  bind .   <$M1B-Key-equal> {show_more_context;break}
> -- 
> 2.21.0.windows.1
> 

-- 
Regards,
Pratyush Yadav
