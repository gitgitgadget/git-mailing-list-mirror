Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD89D1FF30
	for <e@80x24.org>; Wed, 23 Nov 2016 14:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937926AbcKWOPJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Nov 2016 09:15:09 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34880 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936466AbcKWOPH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2016 09:15:07 -0500
Received: by mail-wm0-f49.google.com with SMTP id a197so79747272wmd.0
        for <git@vger.kernel.org>; Wed, 23 Nov 2016 06:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YnjLf40OCZTeVTIOOznnrmApm7CWKvJLjWK4Sbzl+xo=;
        b=GOmaT9yBn7VFS2XVWJIB4A+qe4xXMzDPDDZTL/GBAbUCAGp3Dsjp8NDn0C+WfI8YHY
         yii2pXOfuCC/yqgkETqt+AA+9jBtWnLlp+yvOLxTGFCmSHxlJiMkUfrck3bFMFA9s9Eb
         XiFtbC/JZ4/g927IweF0WHvG0D+wrSnUPPF5tb3Z1Q1L881uEHzD7vQOil6uZwmVT2ZK
         34pr6uqLc6hVy7esEPDRw8ESRxWSdBD7xaUZMiY2nFGmc/VQkmHGhSX6mGQDPD5vDRNE
         g85byt9US6epRUDMcWHCP4anN9d5bOB59IpckKhgbv57mw9U5AKKXv9lRlmuOZ93dZcq
         v9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YnjLf40OCZTeVTIOOznnrmApm7CWKvJLjWK4Sbzl+xo=;
        b=ImEe7NfXBfxHMSjV3hzowlmQPqNLfLQv9gc89SOFRoscjj+9zHJp/xfAEQVh3ABF7s
         bCxfc3mUwsHznXjuRP9wstAwkwrfG8oCWGk2gvyracC8eBzlACgQDXe+/mGrY/DS40b0
         k8tV/T+p2L7DGnUFo2nGzNC0j3JX44zmzuqQchFusJaeOuwzAFJngiMp8p6v7pUk5fmW
         H+XFirwWn3gQvFBdajvj1Ytj4NHmZ6YPo62pS0R8DLdUTevzpB02eznRQEzUDPO/jOWa
         iTXqwvWbHC4h0AeCffHhU9HlkVwQiIWbhk4LRQqg+zgld2QzOezn78mtYK3BwXRDXXUx
         FrRw==
X-Gm-Message-State: AKaTC01TfZHHJXL6SGOflxNTpaCCiPPNR8v+IqzlrSHkbBlr3EoyqbsAvudQrSB2DEg+Lg==
X-Received: by 10.28.91.141 with SMTP id p135mr3407972wmb.128.1479910506296;
        Wed, 23 Nov 2016 06:15:06 -0800 (PST)
Received: from macbook.local ([2a02:a03f:8dc:8600:91db:f5fb:66b4:11fb])
        by smtp.gmail.com with ESMTPSA id n17sm36648540wjq.6.2016.11.23.06.15.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Nov 2016 06:15:05 -0800 (PST)
Date:   Wed, 23 Nov 2016 15:15:03 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: dangling commits in worktree
Message-ID: <20161123141502.GA10722@macbook.local>
References: <CAExDi1SYOuq7GJC69+5yDmzaw--vKMmmqv0Jsm80hU1L5phDUg@mail.gmail.com>
 <CACsJy8CPX3PDfhcaftDHy_U37rEACr7Q1gj_un4ALen45J9GZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8CPX3PDfhcaftDHy_U37rEACr7Q1gj_un4ALen45J9GZQ@mail.gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 23, 2016 at 04:45:56PM +0700, Duy Nguyen wrote:
> 
> It's a known issue that gc (and maybe some others that do rev-list
> --all, like fsck) "forgets" about some worktree's refs and you will
> see what you see.

Good. I just wanted to be sure it was a known problem.
Thanks for the info.

Luc
