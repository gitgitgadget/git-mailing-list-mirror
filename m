Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DD901F404
	for <e@80x24.org>; Mon, 19 Mar 2018 20:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031136AbeCSUDx (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 16:03:53 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36778 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030619AbeCSUDr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 16:03:47 -0400
Received: by mail-wr0-f193.google.com with SMTP id d10so19912707wrf.3
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 13:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aLGWJ+eEGvbJhBpjUsTMHr/OnthPBCvvQ+9qcEWBp8M=;
        b=hjXGWxyBxpReDgwS154nfAk7Pq0a5LQhi3Du1AYs5NW+th4GU1C9QvMl8m/7+GzX3B
         ASWRcayHOnt/4ywPGKdcwaet78oowem0nT/ScfDv6JRKGJbsfe+DURV8Pn8JId3i5aK/
         NKlpppqGwT8NWP/Qr13vZjmT+CHUa7401Wqwzt7qNPIvMyXRf0La3s5nHIFxmb5xZqb4
         cfl2PRhKJPE4FgEh8PMZfD8APorc3OCbcirYFRy4SVSHmkSlvgGVlSR1X/Zn2WPjUeEm
         jYBNK27yB/q49fkY6WvYl+ur+SVLSnBea8gTGTshRwhPr38NlEwEK4WsF2ngBL1WNpWd
         1Org==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aLGWJ+eEGvbJhBpjUsTMHr/OnthPBCvvQ+9qcEWBp8M=;
        b=od0IaxMeGuq8WDTouu9EnGEvsQylZalkKcpzt2ybhfakp+xj2/LomCm7kUjkUINvfA
         dX/2rTGLNDRzU95xebJJJ5/pUsc/pPY4vC1TVy8K1y8MZdh8QJCg6h13iKHkft3tmakV
         HIy8CLKpMTjO+LhPaPW5lJvfS2nwnZx13w9HSS7nJzxbrNJJTmm6QpI/UU6T90OfFTcN
         eufDL3Lst4ZcJevehYEpOaUkjabbeBDirjUMMij7//uOkYV/UvIRV5USZpKXSJe0n5XB
         k39H15TeFW/5GCVfk0reBkZPovBuoIY+giCbWEZNmrFi0niy/+AFQwcGUNrwbX5Dpvuw
         QZfw==
X-Gm-Message-State: AElRT7HH8FmxgAq+HhkLoNeMl3Ochh5OMFM17h51aT0ClvdA8N/KXhnA
        BlZhIKVhcfP77XFV3G/Y3FU=
X-Google-Smtp-Source: AG47ELskXDlO+lTjymVWzmE1B+8w/XL2GSZzxmFhVeebilaOdbALdw6ctkJ4TKDWZrUs2Q/E/VnwGg==
X-Received: by 10.223.184.234 with SMTP id c39mr10116089wrg.67.1521489826438;
        Mon, 19 Mar 2018 13:03:46 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b8sm5168wrf.29.2018.03.19.13.03.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 13:03:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Moch <stefanmoch@mail.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Simon Doodkin <helpmepro1@gmail.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: Re: feature-request: git "cp" like there is git mv.
References: <20171216013130.GB188893@aiede.mtv.corp.google.com>
        <20171231191156.28359-1-stefanmoch@mail.de>
        <xmqqinb87f70.fsf@gitster-ct.c.googlers.com>
        <20180318210908.3ed94777.stefanmoch@mail.de>
Date:   Mon, 19 Mar 2018 13:03:43 -0700
In-Reply-To: <20180318210908.3ed94777.stefanmoch@mail.de> (Stefan Moch's
        message of "Sun, 18 Mar 2018 21:09:08 +0100")
Message-ID: <xmqq370vvnmo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Moch <stefanmoch@mail.de> writes:

> Are such redundant checks in general a pattern worth searching
> for and cleaning up globally? Or is this rather in the category
> of cleaning up only when noticed?

A clean-up patch that is otherwise a no-op is still welcome as it
will improve the health of the codebase, but they become hindrances
if there are too many of them to consume the review bandwidth that
would otherwise be better spent on other non no-op topics, and/or if
they add too many merge conflicts with other non no-op topics in
flight.

The amount of such negative impact a no-op clean-up patch can have
on the project does not depend on how the issue was discovered, so
we do not even have to know if the issue was discovered by actively
hunting or by noticing while working on a near-by area.

It is possible that by actively looking for, you may end up
producing more of the no-op clean-up patches and can more easily
interfere with other topics, which we may need to discourge or at
least ask you to slow down.  On the other hand, issues discovered
while working on a near-by area would typically not increase
conflicts with other topics in flight over the conflicts that would
be caused by that real work you were doing in a near-by area
already, so in that sense, "only when noticed" is a practical way to
avoid the clean-up fatigue.
