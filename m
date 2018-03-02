Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAF871F404
	for <e@80x24.org>; Fri,  2 Mar 2018 04:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164083AbeCBEAP (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 23:00:15 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36495 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163935AbeCBEAO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 23:00:14 -0500
Received: by mail-pg0-f66.google.com with SMTP id i14so3252134pgv.3
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 20:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8xzcs/OltbxwcGedzOir70RR+x07iuOlzs4ue7PjQaI=;
        b=dWR/jP5YEP+JLRjecPNsZJuz1+R9Tbviq65mGzqqhoK/kRsBW39p/ijNHgrSbiLkov
         tqftBSDmzcKDKn6S/EB0riMKEqwE8FCj7Wben46EZ6Bl1sp6FyRIQiuBnc6CpiWQkNwn
         xguD6WBZ4ZIrNmwxMIxr2L8RioY/8P1+DYHA//e3Hdb7T1SM7qYXy826qHHxFIpmHIOp
         nc1lH8iZGVxV2jSBBcb02o84UlFx8YgrHkqFNqmsB33PrTSKxTXMJ/w5GZ9kG99HwEVL
         VBIMZeLozp2Ufyq35Uf+3HSuwAFvS3jV7MgOd5fPZrsf1VhEPZBj/18+Da99rJZg5kjL
         XCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8xzcs/OltbxwcGedzOir70RR+x07iuOlzs4ue7PjQaI=;
        b=AxNZ9Gff+Rtdz2bYyqAvLiraT2F+DNFfMTw8ceUX7oZwwZAp6h5ITKXAixQLEjhtYy
         sQaTzUEzxwfxxMK/ygbyEFr3v0YdAG6tx9OIFztX/EwJv9Nb03x5LW067xRlzG6hsBWc
         gXXi+XasX9Ia1Dnc4x0UpZodrVtaFlea0JdTN5xreIJTodWqiGxxneGmCZLZteGo+jBE
         EGSNw+Q+L7CmJUTjUevGbMAkbbvLE8elh8rd0htRuUVGEQAL0iTepvN4wWhfjyJlPL5i
         kiyNAa/HhLW03FGhVSXNAzfDhueT1RV6H+E7TFhrEDcBjmn9lMS1EsKNKl1CJtPp8dGb
         HQWg==
X-Gm-Message-State: APf1xPD/4CG+8mevRBn6HYspwHS2LQCgg3IgvlUOoyrEuTMVvS9vSv56
        UJ/RbxV1aEW0e42QCwBJOcc=
X-Google-Smtp-Source: AG47ELsc98DVbdGthzWCR7ydG59GJ9U20Y+XG1B+teLT5E3ox294FcXgflrLIJtamRpbxtfHL1oZkg==
X-Received: by 10.98.60.144 with SMTP id b16mr4319371pfk.61.1519963213502;
        Thu, 01 Mar 2018 20:00:13 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id z7sm8305964pgp.55.2018.03.01.20.00.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 20:00:12 -0800 (PST)
Date:   Thu, 1 Mar 2018 20:00:11 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        ungureanupaulsebastian@gmail.com,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] parse-options: remove the unused parse_opt_commits()
 function
Message-ID: <20180302040011.GB238112@aiede.svl.corp.google.com>
References: <1b5dcc90-896b-9a45-e1eb-c7ee946a2105@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b5dcc90-896b-9a45-e1eb-c7ee946a2105@ramsayjones.plus.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones wrote:

> Commit fcfba37337 ('ref-filter: make "--contains <id>" less chatty if
> <id> is invalid', 2018-02-23), removed the last use of the callback
> function parse_opt_commits(). Remove this function declaration and
> definition, since it is now dead code.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  parse-options-cb.c | 16 ----------------
>  parse-options.h    |  1 -
>  2 files changed, 17 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Thanks.
