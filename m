Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B6CA201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 20:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752835AbdGCUTt (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 16:19:49 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33519 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752827AbdGCUTs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2017 16:19:48 -0400
Received: by mail-pf0-f180.google.com with SMTP id e7so104743760pfk.0
        for <git@vger.kernel.org>; Mon, 03 Jul 2017 13:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=060mYyBYSvOuuF8cWS7xP75kcsHf++JejOuvpUce+Zo=;
        b=AXqFYm1A81nlY8kutXwX67Zlevm3sENvIckJYBYHU8unT/ymyHGqCmPD7T1RzDA+Qd
         arTFLElM1LrT7surAQJFiocMWZ0kXoDalBG2WyLlzfQL8tRLRZ1wmjjtsp/T0Gs5y+P7
         ZI28VbJn6azqXZ/LQ1k5AHzqu+BXBGSgQIeDtkMKGYth2vAJLLPlEhlcvnJjFcKtaXX6
         qgS5U373MokKy7GczNmFbv+nwamG3H02TctOcMsbI2I6bGCwDxjAl0m13oilMMOf7v2/
         +TWxoPLe0UHa+HiyKw7uChq4NbHaSbYzbrBicaZreuaJPcAlEHENIbBKPbfnyx90trgk
         QdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=060mYyBYSvOuuF8cWS7xP75kcsHf++JejOuvpUce+Zo=;
        b=E0fTPTvq8cDQFnY/tgtU19tYaGahpBchX0zRt8Rk2pZfSUN/hHGp44WTB8sSY7vKth
         +76Hpk3fwEMuRUwWjeUKaLXMK3w8roeT1MVOzJSf+5ufenQY+XK7JEwTOnBOO+cMqe/M
         MWCOSVWbj7oQ1GdqYeFcBi8KZByQxp3dp1+DIdE6G+moYgNFPKMyQELvWVNx9I5yHkYx
         SZiaIRib49A8yFepx9OHuEUygwLECdRPq7EmJ6TF6FV4mkg0UwwzF43PTSLlftz8CSYs
         OzReilVHQ40em4M3PErkbN5q9fklWIhpBuqo3Mt9mnHGKPPP6sy2STDz5MoG4FsUWaSp
         1HSg==
X-Gm-Message-State: AIVw112eG4l1VSDmLohK4HvNSr3TsYuo1uQ7EgY0OvO7xkzzerRkDtPh
        oIekvFgRRNdbRg==
X-Received: by 10.98.28.71 with SMTP id c68mr11747853pfc.116.1499113187817;
        Mon, 03 Jul 2017 13:19:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:30:4739:ca21:b5b4])
        by smtp.gmail.com with ESMTPSA id b7sm40790983pfl.44.2017.07.03.13.19.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Jul 2017 13:19:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jun 2017, #09; Fri, 30)
References: <xmqqk23tp2jk.fsf@gitster.mtv.corp.google.com>
        <4374FA169AD7465AA39BDB477A348B02@PhilipOakley>
        <xmqqo9t1l6vi.fsf@gitster.mtv.corp.google.com>
        <C31723137B784D54A3CDB1B7D9432D7E@PhilipOakley>
Date:   Mon, 03 Jul 2017 13:19:46 -0700
In-Reply-To: <C31723137B784D54A3CDB1B7D9432D7E@PhilipOakley> (Philip Oakley's
        message of "Mon, 3 Jul 2017 20:13:02 +0100")
Message-ID: <xmqqfuedl1ct.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> Am I right that the What's cooking  is prepared by a script?

Because I have to keep track of so many topics, its maintenance is
heavily helped by a script. I do not think it is sensible to expect
me to (or it would be good use of my time) correctly update the list
of commits manually every time a topic is replaced with its new
version.

But I consider the use of the script just like my use of Emacs to
edit the final end result.  Yes, I use tools to prepare it, and the
tools know certain rules that I prefer to apply to the document,
such as "a topic that has not been touched since the previous issue
by default does not need its description updated."

Does that answer your question?

