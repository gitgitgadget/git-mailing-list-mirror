Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F43F1FA14
	for <e@80x24.org>; Wed, 12 Apr 2017 18:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755361AbdDLS2D (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 14:28:03 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36557 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752256AbdDLS2A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 14:28:00 -0400
Received: by mail-pf0-f174.google.com with SMTP id o126so17460318pfb.3
        for <git@vger.kernel.org>; Wed, 12 Apr 2017 11:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=K4+LDTqok1mXgFJEEEkt/zb8cA3rVgF+NzwtG9G1AzM=;
        b=o/tzlu1fZYEUcCYopCrh9qaIXwMyabfVaToAlYlh0ntw6SOGPIKlbmT+Nk+5mb/7yk
         BPMK6CvGk2jI2doywDt9eyb0/0eUbcVXnknSARcNdA9OB7Y7KG7tf3wGAhv3XTZ8b0xQ
         wmLKwo49Yy+9ZhWOTr9tYtKVVKVa13h12PsAw1CbBIN/JW8FTvji4os7aO4yJxUb6unn
         iO+e0XZZWB7R8wbUKz62Ve0KvXb0/DTTrPb4bE+FsIoHOb7l8ic9ZKPPLRU8RjPsTeC8
         +lJFOp598OM6MLjLdoMONEzs5tKiMQPS7DGBl04DLA2YIUEoIkPwXUW66SpuC94etKnv
         rbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=K4+LDTqok1mXgFJEEEkt/zb8cA3rVgF+NzwtG9G1AzM=;
        b=NbPVAHoChPN1x8OyybQar4jHsPKmqsDO/eNIEtoUJbxXd2jd60FkMHW6X74+bhUpT5
         1gbVxqX4di85HL1i+6X8J5NRkXs7SnzD5LHsK/Si9OmcX/WrJyrqBUkVA+vNasAzS0az
         a/WH01fTRSP28c1xNGcGuAJwi4AQduvs1raOCuPn6mApzZeCcn/kg1rI7PJ2A6O089dJ
         O0NY9lBKh5mzBSz1gXb2Q93fZJBVAczu6KLY2ftOuq/12QUF4uV2XxhjPOAA8Fc2RXg7
         yN1H2UBIFywTop+/zjmxoCYklqXXhQkgOVtFs0Prn//pZ9nH38HhxqbLA+3zXNnRl6UO
         28aw==
X-Gm-Message-State: AN3rC/5kQw9IkEGICLwFDoZ4hRej2rZIB7a+9retBlkDVRCH7SoAsCVbZhtEIuxfwJiinCsJ
X-Received: by 10.99.160.1 with SMTP id r1mr3878920pge.37.1492021679002;
        Wed, 12 Apr 2017 11:27:59 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:c894:c91:2f85:4c6a])
        by smtp.gmail.com with ESMTPSA id i195sm25844114pfe.89.2017.04.12.11.27.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Apr 2017 11:27:57 -0700 (PDT)
Subject: Re: [PATCH] fetch-pack: show clearer error message upon ERR
To:     Jonathan Nieder <jrnieder@gmail.com>
References: <20170410210511.8505-1-jonathantanmy@google.com>
 <20170411214748.GR8741@aiede.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <bc49db16-d434-6493-3020-25058bbcbad8@google.com>
Date:   Wed, 12 Apr 2017 11:27:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170411214748.GR8741@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/11/2017 02:47 PM, Jonathan Nieder wrote:
> nit about the error message: since this isn't a sign of an internal
> error, we don't need to tell the user that it happened in git
> fetch-pack.  How about using the same error used e.g. in
> run_remote_archiver and get_remote_heads?
>
> 		die(_("remote error: %s"), arg);
>
> With that change,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks - used your error message suggestion in the latest version [1].

[1] 
https://public-inbox.org/git/20170412180602.12713-1-jonathantanmy@google.com/

> Follow-up ideas:
>
> * would it be straightforward to verify this error message is produced
>   correctly in tests?  If not, is there some way to manually trigger it
>   as a sanity-check?

The best idea I can think of is to intercept fetch-pack's output and 
substitute a fake hash for a certain hash. This is probably easiest to 
do if we run upload-pack in stateless RPC mode (so that we can pipe 
fetch-pack's output into sed, and then into upload-pack) but that would 
require something like my test-un-pkt helper (in [2]). The change in 
this patch seems to be at best, correct, and at worst, harmless, so I 
didn't pursue this further.

[2] 
https://public-inbox.org/git/40f36d5eeb984adc220a4038fc77ed6ad1398fef.1491851452.git.jonathantanmy@google.com/

> * Documentation/technical/pack-protocol.txt only says that an error-line
>   can be produced in response to the initial git-upload-pack command.
>   Can it be updated to say where they are now allowed?

Done (in the latest version).

> * Are there other points in the protocol where it would be useful to
>   allow an error-line?  Is there some lower level place where they could
>   be handled?

For fetch-pack/upload-pack, I'm not sure - the sideband already has its 
own error reporting mechanism, so everything might already be covered 
(although I didn't look into detail). Lower-level handling would be 
ideal, but something that I'm not sure off-hand how to do - pkt-lines 
are used quite diversely (for both text and binary data, and with 
sideband indicator and without), so we would need to ensure that a 
solution would work with all those (and any future uses).
