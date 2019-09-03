Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDB981F461
	for <e@80x24.org>; Tue,  3 Sep 2019 21:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfICVtr (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 17:49:47 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:45403 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfICVtq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 17:49:46 -0400
X-Originating-IP: 1.186.12.26
Received: from localhost (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id B22164000E;
        Tue,  3 Sep 2019 21:49:44 +0000 (UTC)
Date:   Wed, 4 Sep 2019 03:19:42 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4] git-gui: Add hotkeys to set widget focus
Message-ID: <20190903214942.ubcbdgtphpwnaxs6@yadavpratyush.com>
References: <20190903144536.8935-1-me@yadavpratyush.com>
 <20190903180704.11812-1-birger.sp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903180704.11812-1-birger.sp@gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the re-roll. Before you send out the v5, a couple more things 
you missed. Other than those, LGTM.

On 03/09/19 08:07PM, Birger Skogeng Pedersen wrote:
[snip]
> @@ -2640,6 +2642,27 @@ proc show_less_context {} {
>  	}
>  }
>  
> +proc select_path_in {widget} {

There was a suggestion from me and Bert about changing the function 
name.  I suggested "focus_widget", and Bert suggested 
"focus_and_select_path_in".  Choose whichever you feel is better.

> +	global file_lists last_clicked selected_paths
> +	global file_lists_last_clicked
> +
> +	set _list_length [llength $file_lists($widget)]
> +	if {$_list_length > 0} {

Since we only use $_list_length in one place after my suggestion, why 
not just remove it entirely?

That makes your if statement:

if {[llength $file_lists($widget)] > 0} {
	...

[snip]

-- 
Regards,
Pratyush Yadav
