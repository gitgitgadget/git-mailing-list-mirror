Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D2571FADF
	for <e@80x24.org>; Sun, 14 Jan 2018 17:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751622AbeANRZS (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jan 2018 12:25:18 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:24434 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbeANRZR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jan 2018 12:25:17 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id am1zeUxspNSVVam1zezue8; Sun, 14 Jan 2018 17:25:15 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=NYGW7yL4 c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=onhi19IbAAAA:8
 a=Dx4yW56zAAAA:8 a=M2GpmdpaB_3U2oAO02wA:9 a=wPNLvfGTeEIA:10
 a=JvkiTdytZRqVYIXWt-wT:22 a=X_u8qhY6y2Nm79co_leF:22
Message-ID: <E2F9FAE97F7D4B49A5A644FC796A9AAC@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     <randall.s.becker@rogers.com>, <git@vger.kernel.org>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
References: <20180114164529.10120-1-randall.s.becker@rogers.com>
Subject: Re: [PATCH] Remoted unnecessary void* from hashmap.h that caused compile warnings
Date:   Sun, 14 Jan 2018 17:25:15 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 180114-0, 14/01/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfBpVX/tdfB7TTc9hP+kbpU3RdiKZJre2kMIXGRRFfaYVNYS1qP4gCFiU+POHWV0SB+fAodGszoanV+fjfhiq+QhNwSvdSnK3FSUfhYUPSizyxPa9AFh2
 l9Sz53EGHXJtxgJ7xoRPYY/VW4CIXY1ecPwBoggp6msfLI+MuUU5i2S2NXwHhcK+rIVMUBljIxSVQTbVP851cZ04uxbON78N08Vkk4uG4cvt5vxPOoNnQMiK
 /J/aL1/ZNujwht6ePqfoAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: <randall.s.becker@rogers.com>
Subject: [PATCH] Remoted unnecessary void* from hashmap.h that caused 
compile warnings

s/Remoted/Removed/ ?

Maybe shorten to " hashmap.h: remove unnecessary void* " (ex the superflous 
spaces)
--
Philip


> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>
> * The while loop in the inline method hashmap_enable_item_counting
>  used an unneeded variable. The loop has been revised accordingly.
>
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
> hashmap.h | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/hashmap.h b/hashmap.h
> index 7ce79f3..d375d9c 100644
> --- a/hashmap.h
> +++ b/hashmap.h
> @@ -400,7 +400,6 @@ static inline void 
> hashmap_disable_item_counting(struct hashmap *map)
>  */
> static inline void hashmap_enable_item_counting(struct hashmap *map)
> {
> - void *item;
>  unsigned int n = 0;
>  struct hashmap_iter iter;
>
> @@ -408,7 +407,7 @@ static inline void hashmap_enable_item_counting(struct 
> hashmap *map)
>  return;
>
>  hashmap_iter_init(map, &iter);
> - while ((item = hashmap_iter_next(&iter)))
> + while (hashmap_iter_next(&iter))
>  n++;
>
>  map->do_count_items = 1;
> -- 
> 2.8.5.23.g6fa7ec3
> 

