Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B11D320951
	for <e@80x24.org>; Fri, 17 Mar 2017 22:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbdCQWCS (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 18:02:18 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34591 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdCQWCR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 18:02:17 -0400
Received: by mail-pf0-f193.google.com with SMTP id o126so9899616pfb.1
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 15:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KL23MuAQUfX/T7NbFuW+usFEGSW6JSfLnq9kvJVUX2o=;
        b=VwUBiqJ7rrGWY6KyOIVVkYZ70TKJdt2BGmDYYWMeVoTjQkYSSA8zTMRdL793cyD7Jg
         RCEw/qrsgAfd0ZE6sSlOz0im3ls0LGmloSxPquNyPgmKvW3HYhJapQZAnC5u4Dh7V1/S
         vd7Wmsyn0+w38oV143muRsMmsiYk2ni6lZTc3PQPWuGb37B3zQTpQUv3D4fX7KS/8PDB
         9TTX5jMKWYVDpKY5+0TNOeeMW5s4hjFmqZwWyXAvb9iwHRVto7stEeVnEBV1WWzrGEhs
         p32pvxWe/rWqv6E7qgbyGBi3bxMBuowtLbxt+iAiZUN0kTPG/xVZqBYLf7j+VLDyRGMS
         6vbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KL23MuAQUfX/T7NbFuW+usFEGSW6JSfLnq9kvJVUX2o=;
        b=osJ1CMxUlK5VYfSbN4fA2t3bDrEgkAYWQeLLvkNknFEOTMNfK7E2hO39eHeUsBPhiQ
         r5cj6jo4Ev2TE7uX8/XzY/+wG00aoD07gQxxW0N3RNOB9GVSqJ+P9PrjCp+8clxgFHGZ
         HUTk16OaN8PWcorjBFLdTolG1gj5JVneFyqGAnY+C7/+waZ/XvBIhISg0fOgr/y8mKlV
         0p8ej+BjdCIUmzvZX0y2lIV5NK24DuB5+xYEuLibOHNTqk+uRBVBsB/8vTbFHLqCcxDL
         tKKQNhwxo6UWwqQwgQPOJr7LtAjJx+T5I3Alt2ax7F/+P3sHGWacV4EkQGmLD2EEb/SH
         ctDg==
X-Gm-Message-State: AFeK/H2CbQxU8WHKtdveniA71l/0FnrQB/gvilwHo/CKnWJFD4dA3g+4CXkU8E1pD74B4w==
X-Received: by 10.98.65.211 with SMTP id g80mr19260470pfd.187.1489788135854;
        Fri, 17 Mar 2017 15:02:15 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:cc9f:ca23:5f26:6394])
        by smtp.gmail.com with ESMTPSA id b8sm18822059pgn.6.2017.03.17.15.02.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 15:02:15 -0700 (PDT)
Date:   Fri, 17 Mar 2017 15:02:13 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Nevada Sanchez <sanchez.nevada@gmail.com>, git@vger.kernel.org
Subject: Re: Bug with .gitignore and branch switching
Message-ID: <20170317220213.GO26789@aiede.mtv.corp.google.com>
References: <CAPUVn2u0Uos2mT5+4ejj8m0okNK6XwerL6ce2miHfhtuEs-ZnQ@mail.gmail.com>
 <xmqqmvcj61j2.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmvcj61j2.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> There is no "untracked but precious" vs "untracked and expendable"
> difference in the current system.  An untracked file that matches
> patterns listed in .gitignore is treated as the latter.
[...]
> We've discussed the lack of "untracked but precious" class a few
> times on the list in the past, but I do not recall the topic came up
> in the recent past.  It perhaps is because nobody found that class
> useful enough so far.

The most recent example I can find is 2010:
http://public-inbox.org/git/4C6A1C5B.4030304@workspacewhiz.com/.

It also came up in 2007:
http://public-inbox.org/git/C0E9F681E68D48EB8989022D11FEE3D1@ntdev.corp.microsoft.com/
Earlier in that year it even made the "What's not in 1.5.2" list.
http://public-inbox.org/git/11793556383977-git-send-email-junkio@cox.net/

Perhaps those references could be a useful starting point for an
interested person's thinking.

Jonathan
