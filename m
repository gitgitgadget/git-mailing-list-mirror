Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 588761F404
	for <e@80x24.org>; Sun, 17 Dec 2017 14:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757207AbdLQOdg (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Dec 2017 09:33:36 -0500
Received: from mail15.tpgi.com.au ([203.12.160.61]:47725 "EHLO
        mail15.tpgi.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752395AbdLQOdf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Dec 2017 09:33:35 -0500
X-Greylist: delayed 2661 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Dec 2017 09:33:35 EST
X-TPG-Junk-Status: Message not scanned
X-TPG-Antivirus: Passed
X-TPG-Abuse: host=60-242-171-118.static.tpgi.com.au; ip=60.242.171.118; date=Mon, 18 Dec 2017 00:49:03 +1100
Received: from gw.urbanec.net (60-242-171-118.static.tpgi.com.au [60.242.171.118])
        by mail15.tpgi.com.au (envelope-from winehq.org@urbanec.net) (8.14.3/8.14.3) with ESMTP id vBHDn1eD011502
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 18 Dec 2017 00:49:03 +1100
Received: from beep.urbanec.net ([192.168.42.2])
        by gw.urbanec.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <winehq.org@urbanec.net>)
        id 1eQZJM-00081k-OI; Mon, 18 Dec 2017 00:49:00 +1100
Subject: Re: [PATCH] git-gui: Make push remote combobox full width
To:     git@vger.kernel.org
References: <20171211004848.13048-1-git.user@urbanec.net>
Cc:     patthoyts@users.sourceforge.net, git.user@urbanec.net
From:   Peter Urbanec <git.user@urbanec.net>
Message-ID: <7aff934e-c26a-8259-17e0-436104f377cf@urbanec.net>
Date:   Mon, 18 Dec 2017 00:49:00 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171211004848.13048-1-git.user@urbanec.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just wondering if I submitted this patch correctly and to the right place.

On 11/12/17 11:48, Peter Urbanec wrote:
> When pushing changes, the Remote combobox for the Destination Repository
> does not take all available space in the layout. With long remote names,
> this causes the combobox to have truncated entries even though there is
> room to display them.
> 
> Anchor the remote_m combobox to both left and right edges of the grid
> cell and use the same padding as url_t for a consistent, dynamic layout.
> 
> 
> Signed-off-by: Peter Urbanec <git.user@urbanec.net>
> ---
>   lib/transport.tcl | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/transport.tcl b/lib/transport.tcl
> index a1a424a..1046dc5 100644
> --- a/lib/transport.tcl
> +++ b/lib/transport.tcl
> @@ -173,7 +173,7 @@ proc do_push_anywhere {} {
>   		} else {
>   			eval tk_optionMenu $w.dest.remote_m push_remote $all_remotes
>   		}
> -		grid $w.dest.remote_r $w.dest.remote_m -sticky w
> +		grid $w.dest.remote_r $w.dest.remote_m -sticky we -padx {0 5}
>   		if {[lsearch -sorted -exact $all_remotes origin] != -1} {
>   			set push_remote origin
>   		} else {
> 

