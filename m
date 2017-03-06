Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42AA420133
	for <e@80x24.org>; Mon,  6 Mar 2017 23:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753682AbdCFXtt (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 18:49:49 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36569 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbdCFXtp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 18:49:45 -0500
Received: by mail-pg0-f67.google.com with SMTP id 25so21093042pgy.3
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 15:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ba37HayA8B10WH85PUB/V6aLG2V2wJfOx7gp7QLaDVg=;
        b=DlBjUMXW0mVRiWRjajvB/iZ9yIUrPfkQkR9jE/AkfmY8k4G7qhu1s+buPTn1MHhZns
         0U55ApVWJrCawUeG/17T/J17hUE/5zPSj35jDGH7hZj7Nr7NZ2BGy9+FCuNoW+mmnX9A
         gfKDEIJm49RgCnVyVuGN5z4nL1DqX1rZDAiGqRcaAUfkhcaU12EOJPGm6VxWKUYQ96mC
         zJT1TzivMRTx2NFSa5q/y2hRl4Xs2tx8fBPxUY5msysbSZoPdwduY0UY1pePsVHQGZ9C
         Fa3avZimgUO74J64y+T5b6qI/geS8Mk6n0yzJYGQFRuUEwjQ2ho3OY3PQQ1eplVtZT2l
         OfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ba37HayA8B10WH85PUB/V6aLG2V2wJfOx7gp7QLaDVg=;
        b=qZZp3sjtwZ7fmtIYkomTO8atnralmr7RUL2W0JTK9noUnBZ2/fQXzkNBFx+d12YHt4
         lgCXvSwOyfPSDaidyCpM2L8O/Q+VwZA+Pv+cdYqErO+k2k2prbqn7ECk+Js2fLN0jHJg
         O7yNqlvNpbk1E1YCu7aKhvaOjZb2/yV328UAjnPNv33LtVvkPQH1DMOnB2LIhdGCIHem
         MgZWV/FYBWitHA6UA83Y1zA4ETnX2F17IJfpB8TDxsiC/AGV6EsU/EKgRZUKGRXigD1J
         QDPK7lMLFWyzGSK4XIFO8HIztgIKqaT5vjZWHcC6IhnMeijyfH8jCYs+HEIo3OXywmB9
         wqHw==
X-Gm-Message-State: AMke39n6zuw9g7MnryqcUb8qnp8Yjc+zrPZUwHim9mp7FyBaYpNz1CqDdWnvcRmf7Pc+rw==
X-Received: by 10.99.238.5 with SMTP id e5mr23481836pgi.49.1488843633616;
        Mon, 06 Mar 2017 15:40:33 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:39da:9b0c:a72:8776])
        by smtp.gmail.com with ESMTPSA id 15sm41834357pgh.21.2017.03.06.15.40.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 15:40:32 -0800 (PST)
Date:   Mon, 6 Mar 2017 15:40:30 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     David Lang <david@lang.hm>
Cc:     git@vger.kernel.org, sbeller@google.com, bmwill@google.com,
        jonathantanmy@google.com, peff@peff.net,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: RFC: Another proposed hash function transition plan
Message-ID: <20170306234030.GB26789@aiede.mtv.corp.google.com>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <nycvar.QRO.7.75.62.1703050258200.6590@qynat-yncgbc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.75.62.1703050258200.6590@qynat-yncgbc>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Lang wrote:

>> Translation table
>> ~~~~~~~~~~~~~~~~~
>> A fast bidirectional mapping between sha1-names and sha256-names of
>> all local objects in the repository is kept on disk. The exact format
>> of that mapping is to be determined.
>>
>> All operations that make new objects (e.g., "git commit") add the new
>> objects to the translation table.
>
> This seems like a rather nontrival thing to design. It will need to
> hold millions of mappings, and be quickly searchable from either
> direction (sha1->new and new->sha1) while still be fairly fast to
> insert new records into.

I am currently thinking of using LevelDB, since it has the advantages of
being simple, already existing, and having already been ported to Java
(allowing JGit can read and write the same format).

If that doesn't work, we'd try some other key-value store like Samba's
tdb or Kyoto Cabinet.

Jonathan
