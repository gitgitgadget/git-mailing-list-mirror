Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86A772036D
	for <e@80x24.org>; Tue, 21 Nov 2017 19:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751384AbdKUTTE (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 14:19:04 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:44361 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbdKUTTD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 14:19:03 -0500
Received: by mail-io0-f193.google.com with SMTP id w127so20603957iow.11
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 11:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H7QgbNhB1ZbU6wSeL2AwWvikVs7KvqsvUofRBx0kGk8=;
        b=ptjnf7LdaD0VTpDSFtNyP//WvT+0rXPqG/GufL+C6dTEZmnf5lu0zx+G24OojCC8qI
         PWsJW7KnMPGUKYJdEL7t0RpTZ6lzp51Kqgphm1YnDT4bqHZlfXBMln0Yi1axeg0P/C5k
         RmKNlOpia2+X5WUKm73t70Rjc/ogiOYMAazQ0vRysXEGZ4FL0q2WHyQGbgYu4bejNNI9
         RmuJidIGE8w2Fa1vTJlMmZ2aKIiSsS5EPPCdabM3GeVPa8GbZXOjmDTf1utmH2b+3snc
         WcfEhHayT6TidNR7hiyZycaShNSh/nenvBzIXmzWL67AL2Oz8d9f8Lhvk9K6aXaffkaO
         solg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H7QgbNhB1ZbU6wSeL2AwWvikVs7KvqsvUofRBx0kGk8=;
        b=oa5XpI5kLM6w0E3382GMdybyr+H137jIFicu5pggh9Ar+Bmx2APfya6dd/9sqI5g3W
         9N0k5gtd2Mfh1IGvEIX+K7wDhrflpyijnBD3Rqpz7owvNoMahFAjlCUMQNMaYiPX7KnF
         +Xzh+vhUEmgUCdg1vBsPEIUnnPDePTiegU5/t8kYIsDK6Y0G6IJKIDiubXKbmp7xbx+D
         t9ZMuiAK1VBr7boeM6kouKLu4NbsE1WdP7a7b9Lz2uFTvw3SvfXTYdqHGUl2sZlIx/9G
         euu6BYyeycMXHmDwc/d5qR4lKd4A3lgK2QTxIKthSfvaKkuWMl2THiDH9Dz6boK9/5n6
         cMqA==
X-Gm-Message-State: AJaThX5pn/mCL27saY6iijvmQJ4dA9aL1NOROkxxbmPmcJ6eRORof9at
        fFfMHUbge7cOUehWTa2hD9c=
X-Google-Smtp-Source: AGs4zMYqu22jYo03OUxMCT43ChrMosYKMOSLoOGmFTqGeu41XZZpwy1srf+dLqXi+p0qNSgF94ZTNA==
X-Received: by 10.107.11.85 with SMTP id v82mr19279845ioi.198.1511291943099;
        Tue, 21 Nov 2017 11:19:03 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id v8sm989367itc.5.2017.11.21.11.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Nov 2017 11:19:02 -0800 (PST)
Date:   Tue, 21 Nov 2017 11:19:00 -0800
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
Subject: Re: [PATCH 1/2] Git/Packet.pm: rename packet_required_key_val_read()
Message-ID: <20171121191900.GD3429@aiede.mtv.corp.google.com>
References: <20171121160939.22962-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171121160939.22962-1-chriscool@tuxfamily.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Christian Couder wrote:

> The function calls itself "required", but it does not die when it
> sees an unexpected EOF.
> Let's rename it to "packet_key_val_read()".
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---

nit: please wrap lines to a consistent width, to make the message
easier to read.  In the above, it looks like the line break is
intentional --- is it meant to be two paragraphs (i.e. is it missing
another newline)?

optional, just noticed while I'm nitpicking: the description 'rename
packet_required_key_val_read' doesn't tell why the function is being
renamed.  Maybe something like

	Git::Packet: clarify that packet_required_key_val_read allows EOF

would do the trick.

[...]
> +++ b/perl/Git/Packet.pm
> @@ -83,7 +83,8 @@ sub packet_txt_read {
>  	return ( $res, $buf );
>  }
>  
> -sub packet_required_key_val_read {
> +# Read a text line and check that it is in the form "key=value"
> +sub packet_key_val_read {

This comment doesn't tell me how to use the function.  How do I detect
whether it successfully read a line?  What do the return values
represent?  What happens if the line it read doesn't match the key?

Thanks,
Jonathan
