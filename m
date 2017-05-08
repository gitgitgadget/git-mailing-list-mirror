Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9BC320188
	for <e@80x24.org>; Mon,  8 May 2017 06:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752055AbdEHGLK (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 02:11:10 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35559 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751840AbdEHGLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 02:11:09 -0400
Received: by mail-pg0-f67.google.com with SMTP id i63so9157650pgd.2
        for <git@vger.kernel.org>; Sun, 07 May 2017 23:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O41QJjJbAbsZUtdNtBoj3RONqYPxepMcsNkbAQV6bx8=;
        b=AcPTaZPyxiCJIwGNrosqhMMwcOvPBWdSc9iRh6fArW/fPsd1lnR3sqMoOS4EgCq1+5
         PrqXo497+NxES/qwA0Vv5L2Nvf0gbujcGQ+PFy5cGwNrZfg+lD0dKY6J6B3BxmF81OmG
         uKnAVS+KGQ4vq2VeXELUTclfvo5Zpzs3lXanPgep48b9ACdrARFHgzgny/gmBFDhC+v6
         gMX3zlYu4L/ZMRk9kdwN9Ubain8JFtv3Acw+C7hSaqR7GLo8hZjh/CbZGx0WextBpL6q
         +db/sSVFK285hn8A5bifiuWuW5ybAMgS98aKq1qbBSNzMMM/piAIsq94moYiTz3NXmXo
         AdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O41QJjJbAbsZUtdNtBoj3RONqYPxepMcsNkbAQV6bx8=;
        b=DECLZcJDsFh1ztD6eF0TZGbXv+jWSlvCsUx3x0Yjg02yiH9RUIR1qKo5R6WjxcJuNH
         SW8JmU1DTCKRAo3aDingPE27cg1nG5O1hdvp+ZstCgod7a6RPuCbujI4qhqfyIs1zJ+k
         kQQvpAex4pTBLZnF5JNMVwUSxXmDZIPJIC8GSif2X6btPKWICVk9TXrj9Q86IZiPPU+b
         amqkXjjkS+7r3QG/E+tEauOVZWIZhNX5SyixRmL8ZFmH624rIFUsoa4m5kCOttloa8ZR
         5B74jmJDcazUu+e3AHwZPjnSrOttMcg+mAJk8w1P5UqQ44n8coYedYjwWGT/THnV+3GM
         9YcA==
X-Gm-Message-State: AN3rC/4saOvHYpkvW2KQy8vwiRlV8PQXax0WkkoIg0zvtI9rDGUJ5rvH
        RFkKEMIA6mR18km+
X-Received: by 10.99.174.1 with SMTP id q1mr16835098pgf.161.1494223869200;
        Sun, 07 May 2017 23:11:09 -0700 (PDT)
Received: from HP ([116.56.129.184])
        by smtp.gmail.com with ESMTPSA id y78sm21761888pff.107.2017.05.07.23.11.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 May 2017 23:11:08 -0700 (PDT)
Date:   Mon, 8 May 2017 22:10:51 +0800
From:   Yubin Ruan <ablacktshirt@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] Add warning when git discard changes on another branch?
Message-ID: <20170508141048.GA3463@HP>
References: <20170507233512.GA9332@HP>
 <xmqqzieo9hfo.fsf@gitster.mtv.corp.google.com>
 <20170508111836.GB3014@HP>
 <xmqqvapc9fsg.fsf@gitster.mtv.corp.google.com>
 <xmqqlgq89dzl.fsf@gitster.mtv.corp.google.com>
 <20170508122705.GB3540@HP>
 <xmqq60hb9915.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq60hb9915.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 08, 2017 at 03:07:02PM +0900, Junio C Hamano wrote:
> Yubin Ruan <ablacktshirt@gmail.com> writes:
> 
> > That would be helpful. But, frankly, if a user would be aware of that `advice.*'
> > variable, he would have enough knowledge of Git to be aware of that situation.
> > So, I think that 'M lala.txt' in transitions from branch to branch would be
> > sufficient.
> 
> Ah, you got the advice.* thing wrong.  The "advice" messages are by
> default noisy, and experts can turn them down by setting advice.* to
> "false", saying "I know Git well enough that I do not need handholding
> in this area."
> 
> So a newbie does not have to know about "advice.*".  When s/he gets
> experienced enough to get annoyed by noisy messages, s/he can tune
> it out.

You are right. I might have had too much drug right then...
But still, I don't think that advice.* is necessary.

---
Yubin
