Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C28D1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 20:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfBGUec (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 15:34:32 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:34940 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfBGUec (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 15:34:32 -0500
Received: by mail-wm1-f46.google.com with SMTP id t200so1297109wmt.0
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 12:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1zT3t4k/AUmNC8UOpw3mVqr8BOents7RYBT56BT9z/g=;
        b=sFmUIbSVVENH+ufHiDCm3HedmqPOMdw71XyF9zbyXxO0j+3UjuZrCAJ9PaomJQ3h8/
         LFHdoiWyoX/LLpIGQ0EzcsGharpmpEtABzN+8ABf3Wpeeae16d6SLCW8JJMWNlci0meQ
         k/+cRbmKdOpUK17m8OSsotIf/FA1r/WkxVSKoxeuGTXr4VuzFOWH3v+x6DqLgu/7ZlKJ
         NjoIlihibLIJCgLGuqRlGCjRhPpxrQA0jkUJ8j7GrzPp3bwB2P9bPbfyaOEn/yFYAtLX
         /UacSveRQGhe/bcx3jdQiRy7LH21ced5GFi3IpKtcbGHb4zPwO6xC0N3XdRzYjjNA4pi
         ka8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1zT3t4k/AUmNC8UOpw3mVqr8BOents7RYBT56BT9z/g=;
        b=H6+t0kwCDxe/UNzrZpNqAM23+sbBlqivkxrHSH0A3gBItmN7LwbGb3rOj7uqp8zqcw
         D2FAuPGGb9bZcUG6YxdWjp8FBB4pEUG1YkHadpnq252XpD4QO/sqN1twUDun9yWzS38r
         3W8XpKQOVW7YoMLNQZvcPcmEhT4yK3G9WiyVi6cISSddCy3wZhlITbLStGnbzyc02JFW
         XlygyMVWH7Q8X/78vf03L4Qdva7l5RyCEKzXyglPmWlQnvB+ype5mZLdxw9geJ1a6J0G
         P14sQ+1ywqpvdVOSkn2Vb+qBFO9kopcje0eGyyl+a9QkW0+gY9ifRcwT0i45JNBJG02u
         9azA==
X-Gm-Message-State: AHQUAuaYF0Y2HCF3zMXb0kAfsRfBNIxpiId4Ce8YEwWX3WFi7g9aAqKL
        muwIbfgyW1WgpMttdoKYZaY=
X-Google-Smtp-Source: AHgI3IbuyEbrHKFv8WEMuCpDyK8oorJZm4dpNoiaLNjRmI4Wa1JCtq6cMNWN51bo/fadbRdro98GJg==
X-Received: by 2002:a1c:96c5:: with SMTP id y188mr9036668wmd.103.1549571670078;
        Thu, 07 Feb 2019 12:34:30 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q15sm232238wmj.46.2019.02.07.12.34.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 12:34:29 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.21.0-rc0
References: <xmqqh8dgqcqn.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1902072049080.41@tvgsbejvaqbjf.bet>
Date:   Thu, 07 Feb 2019 12:34:28 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1902072049080.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 7 Feb 2019 20:50:08 +0100 (STD)")
Message-ID: <xmqqef8jnxrf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Wed, 6 Feb 2019, Junio C Hamano wrote:
>
>> New contributors whose contributions weren't in v2.20.0 are as follows.
>> Welcome to the Git development community!
>> 
>>   Arti Zirk, Brandon Richardson, Chayoung You, Denis Ovsienko, Erin
>>   Dahlgren, Force Charlie, Frank Dana, Issac Trotts, Laura Abbott,
>>   Patrick Hogg, Peter Osterlund, Shahzad Lone, and Slavica Djukic.
>
> Could you include Tanushree Tumane in that list? Granted, so far they
> mostly cleaned up Pranit Bauva's patches, keeping the authorship, but
> still...

There is no provision for manual override in the machinery, so, no.
