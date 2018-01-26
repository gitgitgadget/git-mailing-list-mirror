Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF2BC1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 14:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752449AbeAZOOF (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 09:14:05 -0500
Received: from mail-ot0-f170.google.com ([74.125.82.170]:43166 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752385AbeAZOOE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 09:14:04 -0500
Received: by mail-ot0-f170.google.com with SMTP id p36so498692otd.10
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 06:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xeXwpWyh3oMYbY4ab8DtfzCaw3tTdEgTT5zytqIXpPc=;
        b=hYAmU/nEc4HNgmah7zBUG3PfSRrOMbvS4mmREhu2DuWN9vbPL8PlDHukbAaW1DsCHS
         nYpA/RLh1OBOAoq+9cwf/zPe5XIi40UqskOQCcj1genxThpHdLj8wX60J6zVW2eOj6++
         wUkblGGMgECup15hNxB1UWdJUdx9b28JgTWZ0fieDkuT2tfl9/uevQqKyTL0F1gmKJpT
         1KJem4EHIEfAJ6vfUQ+Kgx2LIkcVO9NJe+NdU30WSD8VG2ajhwr0vraPI7/PRUg8BDid
         ilLVlgeF3Y6CyyfA4kqam33YLb5hf4eaPMfU7igXZpwiTFBIXZ8yjDk4AjmW8wVKUsDI
         EvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xeXwpWyh3oMYbY4ab8DtfzCaw3tTdEgTT5zytqIXpPc=;
        b=LsecVxKD7dHvtxojeooDj1E24gUubXF+oVJ9CEt9NxFM/Lza5VP35pFy1k+V2dbQL7
         6ZA5jTuiOcPbR36cd+vR+usqBiWFQkSxmo4GPgEqibT+WdqU/pJQFIfxV8/pDH8hQH2d
         pMa1+LxccmstfkTWlZxpri5bVnAVBsaI/6ZLygI/5PsY11jikThlTsS+ylx+Quvbtd+o
         vdTPlhOmscFdJ9ZImmggImk76iPywstRA8YDhsHyn6Soy9yWQqiPi5t3nNapLyMLYJZ1
         YVpFPiCeRNfhkrHVpoQWlNIsmZFWga+W8vpz9AFlURE3BFz/GzC2bBJ28FNoP4LpzrqE
         BQDQ==
X-Gm-Message-State: AKwxytcO0K4OKGMST+U3OQ2tMLlPcNpgdS3BV2kuW5TN3il1wxJcbqMy
        b8gCoyc5HxGdfEio3Jusil41lZi3ISXaKWh3uAg=
X-Google-Smtp-Source: AH8x225vXNlIBM3Tw2zHBTTrX7q1lNY8frVFdoBFiq1ypkEH9PKCyyNy3Gb8rkWrOFf82uzvooQfKqnH2mAGHzmVq28=
X-Received: by 10.157.112.12 with SMTP id k12mr4116186otj.165.1516976043994;
 Fri, 26 Jan 2018 06:14:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.144.218 with HTTP; Fri, 26 Jan 2018 06:13:33 -0800 (PST)
In-Reply-To: <20180125140231.65604-2-dstolee@microsoft.com>
References: <20180125140231.65604-1-dstolee@microsoft.com> <20180125140231.65604-2-dstolee@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 26 Jan 2018 21:13:33 +0700
Message-ID: <CACsJy8D8ofq+G8XrN-i2MTxGWESfE8_TZm6sAEJe9=mUjpipRg@mail.gmail.com>
Subject: Re: [PATCH 01/14] graph: add packed graph design document
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Stefan Beller <sbeller@google.com>, dstolee@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 25, 2018 at 9:02 PM, Derrick Stolee <stolee@gmail.com> wrote:
> +Git walks the commit graph for many reasons, including:
> +
> +1. Listing and filtering commit history.
> +2. Computing merge bases.
> +
> +These operations can become slow as the commit count grows above 100K.
> +The merge base calculation shows up in many user-facing commands, such
> +as 'status' and 'fetch' and can take minutes to compute depending on
> +data shape. There are two main costs here:
> +
> +1. Decompressing and parsing commits.
> +2. Walking the entire graph to avoid topological order mistakes.
> +
> +The packed graph is a file that stores the commit graph structure along
> +with some extra metadata to speed up graph walks. This format allows a
> +consumer to load the following info for a commit:
> +
> +1. The commit OID.
> +2. The list of parents.
> +3. The commit date.
> +4. The root tree OID.
> +5. An integer ID for fast lookups in the graph.
> +6. The generation number (see definition below).

I didn't look closely to compare, but perhaps you should check out
pack file format version 4 [1]. It tried to address the same thing but
it never got to the point where we could replace our current pack
format with it. At some point I wanted to push it even as a local
optimization (pack transfer is still in old format) but I never had
enough time or energy for it. How it stores commits though can
probably be reused.

[1] https://github.com/pclouds/git/commit/23cb8ae5bdd968c1a290ff8d0fd7cb6b4d572a43
-- 
Duy
