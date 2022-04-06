Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4CCC433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 17:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239275AbiDFRfv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 13:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239365AbiDFRff (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 13:35:35 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FA730F0F8
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 08:43:36 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id c4so5003760qtx.1
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 08:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zd+njoNVxYGD4URX7rkcGoYE1wGcqCwES1rbzyqb2uw=;
        b=2EPz+y4QW/0Zpo0HUOz9VgkdbQoFb+ThDDq7cTaYtrjxPLLBpP/jyMAirIgsa2AdrR
         WqzCkA8/o0czGlBUs/xIqhM4pj4i6oXrXUKqF3seVMFc8yiH5re90vXCAv53MVgKjJSk
         ANd1USbzknqAy5JkRqnrEPPOqK/H09GvuOPFjE0/qYIYiJbV3MOXCTpd2vmq8T2tlDEh
         3L3Z6MesvSrVZ/dAhTArM7lYBaXk8Fd5Pvp4f9nKlFyMRtBLih2hr9l7hN+662fl2hp0
         EpLl05sZpFznmcnrQgQegtgQHv8LBYVg3ddecd9QlCxoUWJ731OtassarHTTLMUTIIF2
         VEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zd+njoNVxYGD4URX7rkcGoYE1wGcqCwES1rbzyqb2uw=;
        b=OjLZxYkqyqT5XljXzXtk8dswAJ707KjfkVaVhgoTzF/HbfF5niwCvv+lJGkUQL+2Bl
         XrOkLaqO0EzMrrESdQCRCQCpYSMArSElXAUJamrPFDdEpBojkHt9t+ZYWL+tMxDc7fjF
         osplT2Tptsz5dvEJQ2zIUR0P1DR8ReJquSvFY941/6zWmsnehnOR1QcoC739XvlKBp+9
         etB/OxCWR3nTOLrm4E0QO63hozq7DWYBLl21mj9gEh5P7S+MhTopAlYETV3MFxftqii1
         ohIQ42S3zflDn/rVclmAhY/jK2kntcUhNukVLZIYDXMe0CKL6u3w2KzSWKTmNtaluuYm
         RBdw==
X-Gm-Message-State: AOAM531KeetXN2Y4eYU6VQBZz1/VOFoabKJA1aGvFF3/PpMwWGucMS4V
        a2buxkepsnKQL2S/KxGaS96mZA==
X-Google-Smtp-Source: ABdhPJxixemnavpQNgihnWnBALpvjWb8yT9aX5vSPjzYp+CbU+JcGS+uCfrU5ShmFP/vAErim7scgQ==
X-Received: by 2002:a37:9dca:0:b0:67b:8dfb:6835 with SMTP id g193-20020a379dca000000b0067b8dfb6835mr5818374qke.638.1649259815528;
        Wed, 06 Apr 2022 08:43:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e13-20020ac85dcd000000b002eb9458498esm13003879qtx.95.2022.04.06.08.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 08:43:35 -0700 (PDT)
Date:   Wed, 6 Apr 2022 11:43:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Plato Kiorpelidis <kioplato@gmail.com>,
        git <git@vger.kernel.org>,
        Shubham Mishra <shivam828787@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [GSoC] Contributor candidate introduction
Message-ID: <Yk21JvirO6FyQ3Va@nand.local>
References: <CAO2gv81zCGbxNN_7a2j7sJZ_fbHiFXf4YxagddWLBWw7-ki5zw@mail.gmail.com>
 <Yky7xb7nQRR8Vqtj@nand.local>
 <CAP8UFD1Y+4XDARoK_T_c2eMUou4senhQLnjJE4zyz2KHuZGsFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD1Y+4XDARoK_T_c2eMUou4senhQLnjJE4zyz2KHuZGsFw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 06, 2022 at 08:25:29AM +0200, Christian Couder wrote:
> > Christian (cc'd) may have more information. Christian: is it possible to
> > accept multiple students for the same GSoC project?
>
> Unfortunately, I think there needs to be a different project for each
> GSoC contributor and GSoC rules ask for each contributor to work
> independently from other GSoC contributors. It's possible to have the
> same mentors for different projects though, so if the mentors for a
> project are OK with splitting it into different independent projects
> and mentoring all the independent projects, I think it could work.

Thanks for this information, it's exactly the sort of thing that I was
hoping for from your response ;-).

Like I said in my other message, let's play it by ear whether or not we
need to split the project. If we get closer to the next deadline and we
have >1 potential GSoC students interested, then I'm happy to split it
up.

One thing that I worry about a little bit is that I think a new on-disk
.bitmap format will be necessary for both of the projects that Plato and
Shubham are interested in (though I could be wrong). Since GSoC forbids
students from working together, it may be difficult to feasibly split
the bitmaps project into multiple, smaller ones.

That said, if we do end up splitting the bitmaps GSoC project in two,
when would we need to do it by?

Taylor
