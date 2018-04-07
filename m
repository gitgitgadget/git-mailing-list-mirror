Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 308511F404
	for <e@80x24.org>; Sat,  7 Apr 2018 20:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752870AbeDGUhp (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 16:37:45 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:45178 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752865AbeDGUho (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 16:37:44 -0400
Received: by mail-lf0-f66.google.com with SMTP id q5-v6so4937771lff.12
        for <git@vger.kernel.org>; Sat, 07 Apr 2018 13:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=xFPoWiiSV+eNQPdqO5gtjahumRwhN7NJqae/R3xG/5o=;
        b=siMAb/KN+JZXNnanm4pWSuUF6OAk/keTe1BTYbuOF/KR5/fFsEBno40ocf9f/WTc5K
         FSLVE8kuaQMdYBBbIqgu5exbcQRUc+45Z2M2YifCsT70zyEIhMZGmePwuU+fkWEh00F9
         A1weZXheGj4dKiy3LXCv5yuOkB84LjfVCwzp9oLjNyw61RO/OXc3DkvOkUCJRYvmEuiZ
         LnKJklqZtLxX/u4eluA1l4jeNKgF/0s9kNMYATkAfn6hKnDfOzVc8dgqoavTm3EjFs18
         g4aqw5zr7LkpEm7VjgPidAZfbTYWINV8zKMfiDLyvyqsOIO37Q3uDf+Kf+t5wAWwWqyv
         jNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=xFPoWiiSV+eNQPdqO5gtjahumRwhN7NJqae/R3xG/5o=;
        b=ljqnIvhU0yfrI6kjdAbR1JbteFaNCdTJ90eDTk5sPr40SKT/OR6dVRjaC5UVXPgowq
         VUIrDX3j/lQb/JFW32wV82ypTuFk+25Gqd7/nsI1Nc9d3FQ6XP2/s29GwmamBCD6/8b3
         EzoaKikc/M5+QfbKfGB4MLgXv53pA2zaZLm6Jnd8tOBPJcCGL7p9vIsyrv4N5JfwhVIT
         TZvGQVOpVvOD76f2rKCcAVJcQMKrlp4q9tKO/G41lLkjcIBx0xvZplVbL2dPkCYqzQl3
         RYS5JAqRSl9FjkZQn4jWhJTckOdtAJbQb3M6PmtZxbHMKLNAyfEBLF0XoWS03bqPGETs
         H+lw==
X-Gm-Message-State: ALQs6tBakvx9kByQiIxSZ7H/ZnkmuvOyhdoZushwhlMXgApRprtenC54
        G0RyDKCGPUOeXJimSeBhcmU=
X-Google-Smtp-Source: AIpwx49M0De/nDdNmlK3VXIKVgohEui95eBs5IL8hejqHFnBkLXdUQoAFYVT1CqucUt7yCEQcUBZZw==
X-Received: by 10.46.101.16 with SMTP id z16mr19412740ljb.72.1523133462674;
        Sat, 07 Apr 2018 13:37:42 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (aga121.neoplus.adsl.tpnet.pl. [83.25.156.121])
        by smtp.gmail.com with ESMTPSA id j74-v6sm2683746lfg.92.2018.04.07.13.37.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Apr 2018 13:37:41 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, Alex Vandiver <alexmv@dropbox.com>,
        git@vger.kernel.org, jonathantanmy@google.com, stolee@gmail.com,
        sbeller@google.com, peff@peff.net, johannes.schindelin@gmx.de,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Git Merge contributor summit notes
References: <alpine.DEB.2.20.1803091557510.23109@alexmv-linux>
        <874ll3yd75.fsf@evledraar.gmail.com>
        <0c3bb65f-d418-b39e-34c7-c2f3efec7e50@jeffhostetler.com>
        <20180326180517.GA205538@google.com>
Date:   Sat, 07 Apr 2018 22:37:37 +0200
In-Reply-To: <20180326180517.GA205538@google.com> (Brandon Williams's message
        of "Mon, 26 Mar 2018 11:05:17 -0700")
Message-ID: <86tvsmeory.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:
> On 03/26, Jeff Hostetler wrote:

[...]
>> All of these cases could be eliminated if the type/size were available
>> in the OID.
>>=20
>> Just a thought.  While we are converting to a new hash it seems like
>> this would be a good time to at least discuss it.
>
> Echoing what Stefan said.  I don't think its a good idea to embed this
> sort of data into the OID.  There are a lot of reasons but one of them
> being that would block having access to this data behind completing the
> hash transition (which could very well still be years away from
> completing).
>
> I think that a much better approach would be to create a meta-data data
> structure, much like the commit graph that stolee has been working on)
> which can store this data along side the objects (but not in the
> packfiles themselves).  It could be a stacking structure which is
> periodically coalesced and we could add in a wire feature to fetch this
> meta data from the server upon fetching objects.

Well, the type of the object is available, from what I remember, in the
bitmap file for a packfile (if one does enable creaating them).  There
are four compressed bit vectors, one for each type, with bit set to 1 on
i-th place if i-th object in packfile is of given type.

Just FYI.
--
Jakub Nar=C4=99bski
