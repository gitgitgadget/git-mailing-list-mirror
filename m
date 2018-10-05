Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 236FA1F453
	for <e@80x24.org>; Fri,  5 Oct 2018 14:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbeJEVT1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 17:19:27 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:44304 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbeJEVT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 17:19:27 -0400
Received: by mail-wr1-f49.google.com with SMTP id 63-v6so13725777wra.11
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 07:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:user-agent:date:message-id:mime-version;
        bh=sJoPpKu2xChneyq9O4f1hFdqd0/Z1uEpjuSpBNUkiwQ=;
        b=eVSQYxeVToz91q02QGEOow9RlkWviF3SEEPljpykqAER6ZveHFEFwikNghKiYbYTX8
         xf5G37zovmc/KA13UdBWrGr0Oitu2guCa1VtpWb6mx2vtWOXAiKXlED0HJygGqK4s5VI
         KaKVq+SHUbXCV3sTJcSeykr79h9ydn614vDXt9Jz4dBHG4HnwtcXf7VTd+8h9BcmYawx
         UT18d618HSlsfzNoycQ3GKSyDr9nUR3A6s3+yFj4rtvWnPRGl9OiKQFP5dbViD5ccPwQ
         KehHmBGaoBG/JjqHLFepJcf9i/aTJ5aINZqxzL9zswiBRK8BHqyvGYWRUu7KzOABBo4b
         y6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:user-agent:date:message-id
         :mime-version;
        bh=sJoPpKu2xChneyq9O4f1hFdqd0/Z1uEpjuSpBNUkiwQ=;
        b=ibz+zjU5EDKgtRze8qf/iscBImkdVuHuFCFRgHCxe3Q++jJ2ZJN5lgdgNTJcGRrgnV
         wKeWUyP6KhbyOeSXNzXFRn33+7CHnwg3wm0zyioCpX+8Fmw8yC0gL5RRrZGIHPTVV/Eg
         mW6SKhpDpFLo/gf9S8XPTdCjcVd+SGFDxT0/LX2zZvg/kz2RW1J+HZepZzsXqDL41nOR
         spmPPaH98fwmcbRqdd+W3ldnbGqbHyWizJe082XNQVkcG/rXpcXelGKYWs9ekXNjXXqa
         sf8sc+yFgGWHcSLQTEpyBUPcRetVJSZnSyT5iMXJ7LTpNwyCfknB+etv3fbFE1lwik+b
         hP/g==
X-Gm-Message-State: ABuFfohzR84w3ZR5ayFLGIRTtnlboi1uCPbkKJdFJ3eX2bQFZSZu4Rlv
        D68ZtagbOAk1X8blO5qfUjJiWNS+
X-Google-Smtp-Source: ACcGV60yRWuc9e/qoLba9MShQITBPbBXEB8Ov8uZ/8fetwhnRkQxsvz9Ile8By4SA/v5D74I3DcsKg==
X-Received: by 2002:adf:e9c7:: with SMTP id l7-v6mr8009030wrn.238.1538749228945;
        Fri, 05 Oct 2018 07:20:28 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id y19-v6sm92610wra.60.2018.10.05.07.20.28
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 07:20:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Git List <git@vger.kernel.org>
Subject: Is there some script to find un-delta-able objects?
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
Date:   Fri, 05 Oct 2018 16:20:27 +0200
Message-ID: <87d0soh3v8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I.e. something to generate the .gitattributes file using this format:

https://git-scm.com/docs/gitattributes#_packing_objects

Some stuff is obvious, like "*.gpg binary -delta", but I'm wondering if
there's some repo scanner utility to spew this out for a given repo.
