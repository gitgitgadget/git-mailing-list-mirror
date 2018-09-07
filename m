Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64F7D1F404
	for <e@80x24.org>; Fri,  7 Sep 2018 09:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbeIGOeD (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 10:34:03 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39510 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbeIGOeD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 10:34:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id q8-v6so14054048wmq.4
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 02:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=4f8KN4EJOl/GIXT1DsrxVO5qq/vZK+1TQrAg9kipzRI=;
        b=Gv+pwLWnW/MCpYdW/0Gxu3Wzw/tVO3xtkxiVlFzque/bZdpcxLAZPqfuEzyMCY1zuQ
         cYgJAUup3JgRtoOakJcJeiwQWA7jWOdjSwx4wdJvvDLSw2yh4VVqf+KA+Cno+8IV3lIS
         HzZC6xOMTidow/wCZ9noyVrASaNdxkIpv406+vFyaorHdxorHRghctoheTnpEn0hmgL0
         TqNktclwZ7bnIggnbba4yj5DUH3TeMVf9GS3VMQ/mBZeF6Wb0BJC7WtwtQRB9qzL+cys
         O98N66KSl1pR9tIomGsrZ9vfrLiYglI1LhP0HAA7BzVC+AUxpXEIdrw/fVrjcTVbEjQc
         Qaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=4f8KN4EJOl/GIXT1DsrxVO5qq/vZK+1TQrAg9kipzRI=;
        b=j4jrFYkSiAFF+ie1qtpLDVq7l873U5c9C6rBB9ByzEmG7zy0QlznyCndExO9RRl6cY
         nXACWd8sU5HJGNzs3ktjpcyj+Nvmszjj6r1CBbHD+mrPW5T4pPE+/sM9/qGMo6zlk5+h
         xErsxZJdA6E4VpOdhp0TEPB8aL3FNs7zg9i6H6DRzLk5cKJSt/7ACoRsNP5F9ON89tiU
         9QSlIHdGwJrv7SuTsfe1xIDmvjevpMouvMXdhNZPa/WJzjzbAr6euJrsHET+M9f/xIH7
         7/wzNyss1puMtqzLdWHFeBoyPwMnXwaKETQE7gnhTF5iJ26JKx1uXRBC5CCPVIJ8Nes0
         ylMw==
X-Gm-Message-State: APzg51DDMKWXF7WKOubsx0fsXkykDDjD9XUpZk63NHqCb/gmXqDQ3Ifd
        tri19FXp5KA+ka9U/2IhCFY=
X-Google-Smtp-Source: ANB0VdZuxAas0TJk/mAIuk5aodJ4fn+eYunP1GC7+OhynYga8VpLGk+2EDBh03XURk8uiMpyS69tcA==
X-Received: by 2002:a1c:638a:: with SMTP id x132-v6mr4867560wmb.33.1536314032225;
        Fri, 07 Sep 2018 02:53:52 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a9-v6sm6794804wmf.28.2018.09.07.02.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 02:53:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] diff: allow --recurse-submodules as an synonym for --submodule
References: <20180905225828.17782-1-sbeller@google.com>
        <20180905231258.GD120842@aiede.svl.corp.google.com>
        <xmqqefe6z5ws.fsf@gitster-ct.c.googlers.com>
        <20180907064026.GB172953@aiede.svl.corp.google.com>
Date:   Fri, 07 Sep 2018 02:53:51 -0700
Message-ID: <xmqqh8j1y6og.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> When I think about it this way, I suspect that (B) will provide a
> better experience than (A), so this diff change doesn't seem like a
> step in the wrong direction.

OK, that's fair.
