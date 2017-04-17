Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DB851FA26
	for <e@80x24.org>; Mon, 17 Apr 2017 22:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754700AbdDQW5B (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 18:57:01 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34333 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754172AbdDQW47 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 18:56:59 -0400
Received: by mail-pg0-f68.google.com with SMTP id o123so30000117pga.1
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 15:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BDQpMarS7sU3o/x2NTB4ch3XITznJKXZdH54cxHrE6U=;
        b=VbeavyRWMDAekqYUa/pqB86ROsrC9kTsNOrbEyyn/R0HDk0wFr/yaifRZR1Z7TbgUW
         nNtCtR6moAyywxH+tIETK/fP8nKQVO2hLjuSE3LX1Y72RA7FkRPMsSUNPGETjutLEhvh
         GFVm1v3sUNzrSDz1zV5uaSPPu5HtmWx10LsR8S49wkm7PhcXc7HAw5GkiL/40C764HlC
         nM5BDmevF5J4pvTNJDnpITnZ4gZHaPptrMBajfbSyvaNyvU7J5X+qOoQojWQLUfHZHvM
         bLtxWUFa5Gx/RvOEHyDu/UkYH5ecVatsR47T5L6hBIy0ZOS19qqiu9cF8fXwJJMl9dNX
         uK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BDQpMarS7sU3o/x2NTB4ch3XITznJKXZdH54cxHrE6U=;
        b=HJJib1MI+aK9i3Y9pW5b6qBu+7lbR8eSJ6Yv2b1/ZD8sJpckLLKdwwHplupk6PaXBh
         skPuOxKHFWyh38g4weXSTnBipxOeU2hQFoTy7aHGJHs9WCh59megc/FwNLX/RiS1yqXB
         bV6DUFHvhxfp5J/goBA/s9Oe56uG7FgJU7biXQHTRONSmpgF5rE36nEILHdcR8JRjn3q
         1/jwPZBXkaKd55TBwdghG9zhRegY2cJ9IFRHlYBY5xSvJUfQL+ij2hCJ8l2cT1EwM+lh
         0WeoKv9oEvg+Svhv7nXoFQbaKWNm2WHj5I20jQyY+xnJAsiD9qzdAstqasEV8GJrqSOS
         zI0Q==
X-Gm-Message-State: AN3rC/4R2gSKrQCor6y2gaEtT16mZv4va08C1KkFLHcN+35ZJB1OJTXu
        HEu6j2XJNSL7ej6/GNI=
X-Received: by 10.84.209.167 with SMTP id y36mr18776171plh.78.1492469818487;
        Mon, 17 Apr 2017 15:56:58 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:d10d:449f:8b4e:a37c])
        by smtp.gmail.com with ESMTPSA id d3sm19982152pgc.37.2017.04.17.15.56.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 17 Apr 2017 15:56:57 -0700 (PDT)
Date:   Mon, 17 Apr 2017 15:56:55 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] fetch-pack: show clearer error message upon ERR
Message-ID: <20170417225655.GB8486@aiede.mtv.corp.google.com>
References: <20170410210511.8505-1-jonathantanmy@google.com>
 <20170412180602.12713-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170412180602.12713-1-jonathantanmy@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:

> Currently, fetch-pack prints a confusing error message ("expected
> ACK/NAK") when the server it's communicating with sends a pkt-line
> starting with "ERR".  Replace it with a less confusing error message.
>
> Also update the documentation describing the fetch-pack/upload-pack
> protocol (pack-protocol.txt) to indicate that "ERR" can be sent in the
> place of "ACK" or "NAK". In practice, this has been done for quite some
> time by other Git implementations (e.g. JGit sends "want $id not valid")
> and by Git itself (since commit bdb31ea: "upload-pack: report "not our
> ref" to client", 2017-02-23) whenever a "want" line references an object
> that it does not have. (This is uncommon, but can happen if a repository
> is garbage-collected during a negotiation.)
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>
> Changes from v1:
>  - used jrneider's suggested change to error message
>  - added documentation about "ERR" in protocol
>  - updated commit message to explain documentation change
>
>  Documentation/technical/pack-protocol.txt | 7 ++++++-
>  fetch-pack.c                              | 2 ++
>  2 files changed, 8 insertions(+), 1 deletion(-)

For what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for writing it.  Sorry I didn't reply sooner.
