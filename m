Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB1971F404
	for <e@80x24.org>; Mon, 27 Aug 2018 17:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeH0Vfr (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 17:35:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43930 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbeH0Vfq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 17:35:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id k5-v6so14415533wre.10
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 10:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GCvaktkphuHbusrvrDPXsEOPeEgPM3W6jXgMcc/XV3o=;
        b=p1FY1WiIg/RP9PcLN3DsSgaErrULqgPgGSM6+15OiY5nKQSKacdwgEf/jw5KZll0tL
         MAWX9ZZrtpA0+oB5tEHL2CR4/IVAW58BxW1VkY36N4zu7u03y7oEkBmIj033bXDz3A3F
         48aDzSFZ+NJCUifU/XR6k8NLj/S6QYHUDW4IyZDZWvqRrRUhtK0T3oovtx7RQMIecvql
         Oo9eqoSR1mMNS5ZB87r+DXwfA7F+fLaspL4qcWC2Ho78iUDu+puNxc/7PEEzgFUDo73f
         8FylYEMt9bUs/EgenENlqyfuhizASf8nypybqZ/LmdVAE+MuOR90zdkvic/OaBFG4xpp
         fo/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GCvaktkphuHbusrvrDPXsEOPeEgPM3W6jXgMcc/XV3o=;
        b=PNXZiFTWQQdoHi7ZL89s5uCOhzyiTSajctxqIMCslyUOpRrIjvwjENaz3VmsRjHRqn
         uDkaJUxrOfWHfQgRA7ouizQrZYVTFaDwTshQRNmKJRAQpB9cytc83TFAElmeMr7/ebbD
         jl0aiW4BCTCyjBOCSMOIZ0EoAzUTEZ8hhpQykk6WYwzrrOIeHv+lRSAgrHZTD9o0GLBr
         +DfbPQvWvU1tiJ17C8MzA96/b/Kd+RlANqN7/bq6Rqo6V+nz9UV1+jULO9Gy6yo9ahjR
         GydBqNk3EuYAimjkasbeA8trosUkL3sK4MpLatzARXni+sCu34PXt5BI2zRYZvF4S3hP
         PVYg==
X-Gm-Message-State: APzg51B553JRrtNDZIPsIFca0FntHjQkSI5Gxtw0Og0bBbmdkjAUZYN5
        6R6n77LSZukCuXxQGvrxqZU=
X-Google-Smtp-Source: ANB0Vda2v0ZWHNWqGLAUO0JfRW4g/YXU/2ejnyLRtkJL/U+baGQCE3sSmah7TGqerOy+cvcKwIZaaw==
X-Received: by 2002:adf:db11:: with SMTP id s17-v6mr9908795wri.221.1535392091350;
        Mon, 27 Aug 2018 10:48:11 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m129-v6sm15010129wma.1.2018.08.27.10.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 10:48:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/1] Teach the builtin rebase about the builtin interactive rebase
References: <pull.23.git.gitgitgadget@gmail.com>
        <20180823024856.GH92374@aiede.svl.corp.google.com>
        <nycvar.QRO.7.76.6.1808260144570.18296@tvgsbejvaqbjf.bet>
Date:   Mon, 27 Aug 2018 10:48:10 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1808260144570.18296@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Sun, 26 Aug 2018 01:46:10 +0200
        (DST)")
Message-ID: <xmqqa7p7lmzp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Please include this information in the commit message.  It's super
>> helpful to find this kind of information about why a patch does what
>> it does when encountering a patch later "in the wild" (in git log -S
>> output).
>
> I thought I did include the relevant part? As to the full back story: I
> was repeatedly dressed down by Junio in recent attempts to include more
> motivation in my commit messages. So I am reluctant to do as you say,
> because Junio is the BDFL here.

I do recall discouraging you from including irrelevant rant/whine in
the log message a few times in the recent past, and also I do recall
you never listening to me.  Don't make me an excuse.

I think what Jonathan finds helpful is the other half of the story
of what you did write in [1/1].  You wrote that it is no longer a
shell script and needs to follow a separate calling convention.
What was missing from that description that was given in [0/1] is
why the original "rebase-in-c" series was done while pretending that
the other effort "rebase-i-in-c" did not even exist, which made it
necessary to do this change as a separate step.

And I tend to agree that it _is_ a relevant story in this case.

