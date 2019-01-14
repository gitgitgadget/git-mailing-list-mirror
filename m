Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C21AD211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 15:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfANPLx (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 10:11:53 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:44998 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfANPLx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 10:11:53 -0500
Received: by mail-wr1-f48.google.com with SMTP id z5so23240314wrt.11
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 07:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=C3RvRrLn7QpG0yreCh5QnHU2jfaAPsnKaoOLxdmEaZ8=;
        b=DY5Ams24cjJIiewfJWti8IthwDkWEawUdoilDqPG55gAW8GtiO4arQ/S8X4COnha76
         Ca96F76nZAJ/tns44CkXYgbeXmCyJEtH748tnaMeQc/0HAWC6cCoeqNyGQ3gmzWHKgB5
         VRmBzgm2rQN2AWjh5OthdD747l6jITch576nS3DkJstDeAhvR+gLnni9psu/8ILbhoay
         lkrrCOs23rz7dRHQJknShZTaA7R57dff132dRJX9/aRpAOQ8jZOlERram9kVmP8L3yU6
         nctntaZY6hejYShnexv05fiacepRbtGhefhSVf2ua4lZe3vRaL2UDy+zH+CxWkloyHcb
         Y0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=C3RvRrLn7QpG0yreCh5QnHU2jfaAPsnKaoOLxdmEaZ8=;
        b=XScBXiAZnD9QrZBhP5rM4pahad5SPmd/B/EmgU3Y/FqqWPbIIrHvjTe2/VfPFyCZZU
         ZvfrPboDGggU6sHa607pxpOIHIry22h7uJM2FG+rWtKoGxVYr2mrxP4W2efxI0wZoXDP
         XhGanNVPKIp/dln3PvEoU1lyAT+dp5vCl/mlqaEGlWQw7Jsut7EvEIOitNxfOQjfZj3M
         F9mPCmOTfsBNMVBOWsxHyVy/pU3OeR1zOFkZwF9l6KfoUAyaw02jBMyaAuq+5+d+8kvT
         oLiuCEtkSevw1g40x/3nVUj8UcXQaJrrn/NHGpB7hihCvxrgVDrFv/5YH48i3CMnIxe0
         +OoA==
X-Gm-Message-State: AJcUukdGpOcOQIcn994Ngr0wWJfuC/CTYhtDgxHCakQza1FAkmQF5yhu
        o6Ib/V40m/gKHObD2mU94Vukh1gWC/E=
X-Google-Smtp-Source: ALg8bN5lKFJ7qycb8N9JPjJNjP7G4DnYrw/8I19oaW/faxNR0TTPnMZByeNTR+249zYzIsccvh+m5g==
X-Received: by 2002:adf:b3c3:: with SMTP id x3mr24747345wrd.294.1547478711567;
        Mon, 14 Jan 2019 07:11:51 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id d16sm57223657wru.52.2019.01.14.07.11.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 07:11:50 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org
Subject: Re: [Possible Bug] Commit generates GC repack failure
References: <002601d4ac18$83d4a210$8b7de630$@nexbridge.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <002601d4ac18$83d4a210$8b7de630$@nexbridge.com>
Date:   Mon, 14 Jan 2019 16:11:48 +0100
Message-ID: <87tvib46kr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 14 2019, Randall S. Becker wrote:

> Hi All,
>
> I'm trying to track down what happened this morning. We had a commit that
> caused a background gc to occur. What happened was:
>
> $ git commit -m "history commit ... "
> Auto packing the repository in background for optimum performance.
> See "git help gc" for manual housekeeping.
> warning: The last gc run reported the following. Please correct the root
> cause
> and remove .git/gc.log.
> Automatic cleanup will not be performed until the file is removed.
>
> fatal: open /dev/null failed: Invalid function argument
> fatal: failed to run repack
>
> Obviously the /dev/null open was not right, but I don't know where this is
> in the git code to investigate further. Any pointers on where to look would
> be appreciated. This started happening at  2.20.1 on the NonStop platform.

We use start_command() when gc does run_command_v_opt() of
e.g. git-repack. See in that file:

    null_fd = open("/dev/null", O_RDWR | O_CLOEXEC)

Maybe that sort of code just fails on NonStop?
