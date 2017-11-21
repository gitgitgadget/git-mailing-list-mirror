Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2CF62036D
	for <e@80x24.org>; Tue, 21 Nov 2017 19:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbdKUTYp (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 14:24:45 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:40635 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbdKUTYo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 14:24:44 -0500
Received: by mail-it0-f66.google.com with SMTP id 72so3373805itl.5
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 11:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9RujA3uJAfo8mOs27j4T4T/qBiOUL8VuQXe9QUZK200=;
        b=GKDvWgQhge9Y1F+NwBXPlcMt7542A2jKMTX3RsbjXaB5RMAklklbu39gDHoOusiy7F
         5ox21QIdXOXySvhtARcKBWU0AEcmfwkd/bHDAHZ6W1qF+Je+OzqaqwZT2QpuTqEOG8vU
         seciuX39LcvxDUc3bdwzF1uOjWhrc3Zpvc4VZKOqxmgxaWpw+sj1OmYi/VOHgw2p7lCz
         pPhbPr8We172OnsnWRS3JWSe/L3ygBG5ULAezJWgmE/PXLVkJsl3duRhL4/vi0Fyi4pD
         rdfI0NzObD5tTQhow4tr0J/vucqO4ZCUulUsZYi2NCMyEpMELbmQ2e5wYXc43gaUO+sM
         C1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9RujA3uJAfo8mOs27j4T4T/qBiOUL8VuQXe9QUZK200=;
        b=XM3aQfpap7W0gc/H9rsqTUC9BGu70xN0TM6xY/zqE7+CzHq8cc817XdJuDt63BfWsE
         38s1Uw9YK0OKeD+MuDV6Dg8Kkm50se5eC+1FsfQshuITbuQpkO0GjXDT6h2iP8LhW2mF
         9wOLgJhoa6LO0/sUgmcjwOZKOyZHvXVgJLbHSbkT4aqb/SIuHCJfJGQmFlrIkpdsee6Y
         9x6SF1ImAGXQjVXSi/cVrYTDBZgvkuA2rPTT6tk6BwJikHtHBI50hDZVZhmhGWdoyDQ8
         O0CvpeUJLqXffzAUmwAigDGNg9PTz38UML+q2FVrvb/RpU+LJtrro9FfFNnm6WI463DF
         qMoQ==
X-Gm-Message-State: AJaThX5DtG7gjKt2qVzrVn1QYtxjnUSAL949H8Z+BoRRVI2z0NTO8cp6
        GHjdGsym8a3f701fg3DNAZCKHDMe
X-Google-Smtp-Source: AGs4zMbErn8MUfF9pCexJkvXcQCyRDD0Zz6henRQTdrNe5ZGrLC55y0Odon/iRErNJBqWUxUwABZDQ==
X-Received: by 10.36.211.22 with SMTP id n22mr3614661itg.5.1511292283673;
        Tue, 21 Nov 2017 11:24:43 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id m141sm987921itm.12.2017.11.21.11.24.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Nov 2017 11:24:42 -0800 (PST)
Date:   Tue, 21 Nov 2017 11:24:40 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/2] Git/Packet.pm: use 'if' instead of 'unless'
Message-ID: <20171121192440.GE3429@aiede.mtv.corp.google.com>
References: <20171121160939.22962-1-chriscool@tuxfamily.org>
 <20171121160939.22962-2-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171121160939.22962-2-chriscool@tuxfamily.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Christian Couder wrote:

> The code is more understandable with 'if' instead of 'unless'.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  perl/Git/Packet.pm | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

I'm agnostic about that.  In some ways it seems like an odd change,
since it is changing from

	if (exceptional case) {
		die "explanation";
	}
	common case;

to

	if (!exceptional case) {
		common case;
	}
	die "explanation";

when we usually prefer the former (getting the exceptional case over
with early so the reader can concentrate on the common case).  In
perl, it might be even more idiomatic to do

	die "explanation" if exceptional case;
	common case;

but Documentation/CodingGuidelines appears to recommend not going that
far. :)

[...]
> --- a/perl/Git/Packet.pm
> +++ b/perl/Git/Packet.pm
> @@ -68,16 +68,16 @@ sub packet_bin_read {
>  
>  sub remove_final_lf_or_die {
>  	my $buf = shift;
> -	unless ( $buf =~ s/\n$// ) {

For readability, I find this whitespace within parens more distracting.

Documentation/CodingGuidelines covers that for C programs but not for
Perl.  Do we have a preferred style either way about it?

Thanks,
Jonathan
