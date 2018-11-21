Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D8BB1F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 12:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbeKUWgZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 17:36:25 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35397 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbeKUWgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 17:36:25 -0500
Received: by mail-it1-f193.google.com with SMTP id v11so8477786itj.0
        for <git@vger.kernel.org>; Wed, 21 Nov 2018 04:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x3UstJUQGzxRU3yLn5mQTK4UlhR2wpCKC7sObYAGAnU=;
        b=j7HU7o9o/G3M3W6DpqbLrtPLKzgM6522xdUo+2dLd9FeNWFyHC9QcyvBR5qV2yKLc8
         ZlFXqpIkelviLnypB7vLZKD75LnWaEkV9ExA/5qYrk8QYBuQVIKG/ssDRVn5Lxbi0Y0/
         Y/x2XcgJAMN9YJKbhcQ2rsLTqbuNOjf8a93JLGOVzqdS/N0pYdWwrWF1s7XxzIEoi0R0
         DlSmAo2EX+2poXbbYbmB5eP3T4vo+YecPCBujZQFv29eDvvM27fG3EeLEF/vDDsLGf21
         dPNOWn5QZ1iviVpAnEIAIZLhuz0Wfc3QeUIzfby2vm6WKlm2mUinYPwDvvUsfmJpwTgl
         2UKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x3UstJUQGzxRU3yLn5mQTK4UlhR2wpCKC7sObYAGAnU=;
        b=ZXgyvx3kIRbk541qRC8mdyBlCtK0TruvdLC+Bt/Ic0m+TzC4XlC5GykFf7wGLg7cpq
         MGeszEnV44wJzQjTUuT19l7w+FzHNOj7mh1lrpQmrEXluqCXKlLeC8rOSm27fci4x2P7
         ieYRByJoomOQGM3c6k3oZqHw5vozvBqLEHhnWB1VFCRxqenqINwp9Xhc7pbDzhv6d0Er
         yQEbATy+SOrsn/tT5gR51OKoLXYqCGzDOWxn6fFKywGCV/VXNYTCQFtNHQG1mqpCjeKl
         MLsayIr5OA2W+EMzOg5w8Z2cpUT5aTD+aGl17wBtQEfOF6RPGNcrvtKvQcsnH4MFJQMQ
         h0yQ==
X-Gm-Message-State: AGRZ1gKpJNZAF37/02ljNeLJP8P6OREh7nI69xNvcKZHr+DGo04Zv8Od
        22Gb8k5AavTKMYXeMuGFbHa3g/2xxW91kR6JAOpMkjek
X-Google-Smtp-Source: AFSGD/WRR/S0R0yrqxIYPCgCVZ9ojAM5Bz2fOoKbEXbzA3upsdzAP8C+jmBZ30oCOBP/97vkL5/XEvrcIZEYtJZ3pi0=
X-Received: by 2002:a24:538e:: with SMTP id n136-v6mr5598006itb.135.1542801737357;
 Wed, 21 Nov 2018 04:02:17 -0800 (PST)
MIME-Version: 1.0
References: <20181119101535.16538-1-carenas@gmail.com> <20181119184018.GA5348@jessie.local>
 <CAPUEsphLMBpxtJakAhQmdKf04H9X4m-8sBSHNFE_eAngn-44Ow@mail.gmail.com> <20181120091107.GA30542@sigill.intra.peff.net>
In-Reply-To: <20181120091107.GA30542@sigill.intra.peff.net>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 21 Nov 2018 04:02:04 -0800
Message-ID: <CAPUEsphaYBXp4V2FYqoB8-A2dyqppH=hSAaoQXGk4NMwXznCiA@mail.gmail.com>
Subject: Re: [PATCH] t5562: skip if NO_CURL is enabled
To:     peff@peff.net
Cc:     max@max630.net, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

FWIW the issue goes away when more than 1 CPU is used in NetBSD 8,0
(32-bit) and for some tracing, it would seem that it gets 0 when
trying to read 4 bytes from what I think is a pipe that connects to a
child that has been gone already for a while.

Carlo
