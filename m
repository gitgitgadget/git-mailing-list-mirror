Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F8301F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 12:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933302AbeGJMXc (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 08:23:32 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54701 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933132AbeGJMXb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 08:23:31 -0400
Received: by mail-wm0-f65.google.com with SMTP id i139-v6so24315614wmf.4
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 05:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PAzSb5ix48wlskA+Q8CD1J4gyOmvlioTRX2SbMmqN1s=;
        b=HstRSwxrPCyRnBfvU4TSbtgSdRFw9ykT7NnVCweYc1AeXrqJQf04pTQhs860BBGtWf
         UHxrpcN2ICPzDivKTUUk/IAqLNdR1i7jParMd7d9RQjO8nF9cguzyDxpxgIpUe/n1jJj
         C/N6Nd/LkBfXp0XpQdWD7U0w15Nq/E30lJ1rhq0ZiLXH+BoElqSQjqD/oGjQkaCIoJJi
         pQ5T1ISpzyO7bZc7x+px8mQw51NpDmEvkna4G/lD7VbLkpxs1yqIKSDuJBKOipqCsbLW
         rQRuBKEVP9/RiUN+qs76Einqx5dmc3iNqJdW/gdL+08BVNpjV15sxY/3QR5VaXJE8k09
         /eqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PAzSb5ix48wlskA+Q8CD1J4gyOmvlioTRX2SbMmqN1s=;
        b=DVJJ2vNOOld+0YpUz8T9X38I8HUYjKzXiOhpuNBLySXTEyYqqoG3wVxekn1U6QL6St
         3MEXyQxdRQ4qNet5wu50Vcnvqlbn6YJIwFGkUlgMFMnqPBCtCe+FWoQl6Z5UFeAtO4ET
         BUc6wglLUN12wxxVvWnkCc5dezOpRhH/0BkeP/MLZHGW1vCaySMRLdIg4xMvZgNM2b6l
         ELhlzi0K/ixFZ3CHWghRSN+b9Cm3TsXwD96WBaKFNWZ1g5sf2NZm/FK5vQqpVfq46zFB
         gTeJEsOUY7PVPX8IKwL40AYg6a7bNYeV6LzFTwzXqWOoftws4T66zJHoNi5O0xYk0j0g
         t+Sw==
X-Gm-Message-State: APt69E3JruI2uoWMN05ZxmNRDRSP+0EBn70j2r8s/P0Bp2DUVqqh4Q6B
        09dMLkvckuqToF7LSY4e704=
X-Google-Smtp-Source: AAOMgpcN5bmx8bzhvP/34oiRHP0GLtv6jpGrSBQygqGtfvWPx7Zqbe4Ux3dNkrasvbwggTDInYGHeg==
X-Received: by 2002:a1c:8f0e:: with SMTP id r14-v6mr15866728wmd.79.1531225410052;
        Tue, 10 Jul 2018 05:23:30 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-239-37.w90-38.abo.wanadoo.fr. [90.38.238.37])
        by smtp.gmail.com with ESMTPSA id e3-v6sm30116358wmd.2.2018.07.10.05.23.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 05:23:29 -0700 (PDT)
Subject: Re: [GSoC][PATCH v3 03/13] editor: add a function to launch the
 sequence editor
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com
References: <20180702105717.26386-1-alban.gruin@gmail.com>
 <20180710121557.6698-1-alban.gruin@gmail.com>
 <20180710121557.6698-4-alban.gruin@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <fc0ac1cf-4bea-f36a-5891-bb571a056241@gmail.com>
Date:   Tue, 10 Jul 2018 14:23:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180710121557.6698-4-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 10/07/2018 à 14:15, Alban Gruin a écrit :
> As part of the rewrite of interactive rebase, the sequencer will need to
> open the sequence editor to allow the user to edit the todo list.
> Instead of duplicating the existing launch_editor() function, this
> refactors it to a new function, launch_specified_editor(), which takes
> the editor as a parameter, in addition to the path, the buffer and the
> environment variables.  launch_sequence_editor() is then added to launch
> the sequence editor.
> 
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---

And this has not changed from what have been queued in pu
(ag/rebase-i-in-c), and from v2.

