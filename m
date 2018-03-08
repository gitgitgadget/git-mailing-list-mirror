Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF6981F404
	for <e@80x24.org>; Thu,  8 Mar 2018 20:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750800AbeCHU1j (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 15:27:39 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35916 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbeCHU1i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 15:27:38 -0500
Received: by mail-wm0-f50.google.com with SMTP id 188so164750wme.1
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 12:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZBl0lPcbTauefyYFy1GFWUOeqREnl9obePhb/PquBEw=;
        b=euYPSqx9aCbhT+Cc56841k71l/xl07Gqrp+EAGPBeky++cUqXn3hUTbREkzR89Zkqb
         1H4HKiIGAVDXzmwL/rwPeGkgnHdEa/r2jyv525RCGkECZQ0N0LumZKY+pmXYal5IN9pA
         Kkw3ZXqXuTtMX5cTjkj1y1A86PWA2WB3J19pKSRWDDVu6cQlVdh+2Ee8/piAz96IOTRn
         PaOP35phsqpXXtkFlTzP/i5FQ3e2vg52iVGXFTp1U8zdHs0u8/+rAlR9FbzG3Y51zK00
         LGCJzkzouKuJG+J59SWbKPCvji7TfhieHUeNrOmx0E0dyTFQGCwDGfhxXzDL5J/fmnUR
         7I5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZBl0lPcbTauefyYFy1GFWUOeqREnl9obePhb/PquBEw=;
        b=cpQSOexN8Ts2Z1t29VNuoEAlzxLMMfokPOw8mY9O4PUPhlGOTlN2xxH/IsfMFQDd6Q
         vQcFgnc/qiPPUoCKTibNEEfweYoSyQoOFLRMpCDYS5/62oPQMX9GkcJJInz5sECf4jq5
         HekLtEOXO78gR7kunqmbknFBqMVzCXS/xu+XzT8Uz6NvYBfBJb0W6dHpFYfThG954WVi
         sc2j5mv1JKmqlrIODC1mZBswaefHI4ThDXy7UrdrzOCDCItxb1/niEzRiihZnITk88MT
         RFuUEuVikH8IsqlBmyDtOsHdxJPCT2X1mtriWb7CbkK47+c84jy/KvXZJRkQPiWYHpo0
         s7hw==
X-Gm-Message-State: AElRT7Ewv/kqVA7jTfNTvEjvC4Zud9OVD052fisgfXnr2kBD0stlp6Cj
        RATYqm44UfV79ATphq2VlvI=
X-Google-Smtp-Source: AG47ELsEFpdDJTyVeJIkoQDY9PR20oH8AaOwLGzMlS66OZKPONx6MoFfKWhMW2jf2Da4KIhEHLh2Pg==
X-Received: by 10.28.196.205 with SMTP id u196mr56539wmf.155.1520540857735;
        Thu, 08 Mar 2018 12:27:37 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id f23sm37574097wrf.77.2018.03.08.12.27.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Mar 2018 12:27:37 -0800 (PST)
Subject: Re: [RFC v2] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <87y3jtqdyg.fsf@javad.com> <87r2oxe3o1.fsf@javad.com>
 <nycvar.QRO.7.76.6.1803070742580.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87vae8yq15.fsf@javad.com>
 <nycvar.QRO.7.76.6.1803071450511.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <a0cc88d2-bfed-ce7b-1b3f-3c447d2b32da@gmail.com>
Message-ID: <4918cc79-79ba-5dd2-ea84-dc47db47d835@gmail.com>
Date:   Thu, 8 Mar 2018 21:27:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <a0cc88d2-bfed-ce7b-1b3f-3c447d2b32da@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/03/2018 20:58, Igor Djordjevic wrote:
> 
> 	git merge-recursive U1' -- M U2'
> 	tree="$(git write-tree)"
> 	# in case of original merge being octopus, we would continue like:
> 	# git merge-recursive $tree -- M U3'
> 	# tree="$(git write-tree)"
> 	# git merge-recursive $tree -- M U4'
> 	# ... and so on, then finally:
> 	git merge-recursive $tree -- "$(git merge-base U1' U2' B1')" B1'
> 	# in more general case, it would be:
> 	# git merge-recursive $tree -- "$(git merge-base <all-parents-of-new-merge-commit>)" B1'
> 	tree="$(git write-tree)"
> 	git tag M' "$(git log --pretty=%B -1 M | git commit-tree $tree -p B3' -p B4 -p B1')"

That last line should obviously read just:

	git log --pretty=%B -1 M | git commit-tree $tree -p B3' -p B4 -p B1'

..., above mentioned `git tag M'` part being a leftover from my other test script.
