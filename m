Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EE7D1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752415AbeBFAy5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:54:57 -0500
Received: from mail-yw0-f176.google.com ([209.85.161.176]:33326 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752165AbeBFAyz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:54:55 -0500
Received: by mail-yw0-f176.google.com with SMTP id x24so167902ywj.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jMdgz2SPD6FdJVgvfZjVBe1iR+eYxgLYjYOj8Dx/j9g=;
        b=D7D19bBeM7KHC5idExwSZ4XmDEQXyCNc4r+VyqB1YxXZ/fhFT87m+k9RY0LIBrhufD
         GfnTMPxnlS/fsWIrKirs9f/ZVSVB0RKB3jpTOiHl3Z1msHw6UaqVbQAkYEQXb0pQDdWY
         QGpuZAOgiMEjQHtmOw9H993irs2Ned38SSGQLw7sVSH1aPy3lwGuvOkR1wAQ6eWkCRRd
         wF09pDLf7T/a5FgaYeB2JPndq6E71Jbgp46/UIHV9yNSMkM6pOR/f03pt3yAdsRooTmv
         yKVrGsw8qApNZsWU3svwVRT7X1cZlPWMfXoHBkN6hVY6Du2ZcvGt04fTXvaUETT4we0j
         R5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jMdgz2SPD6FdJVgvfZjVBe1iR+eYxgLYjYOj8Dx/j9g=;
        b=UvhrNYd/RXDzrlIJqR0e+5ehhrq1vYjnmX3xaT1daKK3zAd25A4PaIzubSGE1dlQ6i
         He/79O7TyaS06K1UEwIwRxu6fTzqXkMHro7EtwMeqJXDiSTPX/b5LJRsbmoXt3yuGHUq
         +HIszlBef0pa91tlenMBDDohsC6nxvTo/Db0tyBiQgMmjlLcxVgmF3fVxziSu7yaK8Zq
         D4CxfA3/wKxQ8poAGkN+FuDEaW3eK2YfznBQLHdrbpzuK2e/WYeQjn20v5Gi779fLilg
         ngumvn+2YBAIcAXkQ4m0bSKds3oRMpVDBdxvLJIoH/gSLHOcd+KdOKmsTVyc4aY2zFph
         VE1Q==
X-Gm-Message-State: APf1xPCo5t3eLnzZM2oF/YAa/GVEOsxtYDJoyE8tnj5/XXolngum5AOZ
        AdZbdNAr9TTiqg8W2fULdchdCndKVV9c68wnkmFP+WyIptM=
X-Google-Smtp-Source: AH8x2268IDDYGtYYjk5EWoRbzNndxiGQAEtEYa3X+EKOwe0R+AD/mGFJ2EnOkKpQAxqEwoQOfMzP7a/D+g1PO2juwfA=
X-Received: by 10.37.37.87 with SMTP id l84mr419793ybl.386.1517878494378; Mon,
 05 Feb 2018 16:54:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Mon, 5 Feb 2018 16:54:53 -0800 (PST)
In-Reply-To: <20180205235508.216277-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 5 Feb 2018 16:54:53 -0800
Message-ID: <CAGZ79kYn6bAH4vVR=Z5nGRC5=R=Ke42Dr21s-MnxE9BZciLfVQ@mail.gmail.com>
Subject: Re: [RFC PATCH 000/194] Moving global state into the repository object
To:     git <git@vger.kernel.org>
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 5, 2018 at 3:51 PM, Stefan Beller <sbeller@google.com> wrote:

>
> Any suggestions welcome!
>

I wouldn't say sending out this many patches is a smooth experience:

* After trying it out internally, it stopped at patch ~80 and the rate
limiter kicked in.
* Okay fine, I'll rate limit myself to be able to send out as many patches!
* Apparently I did not understand the docs correctly, and after reading the code
  a patch was made:
  https://public-inbox.org/git/20180206000743.217503-1-sbeller@google.com/
  I think the sensible thing would be to error out instead of ignoring the
  relogin parameter.
  This is why patches 21/22 ff. have a weird in-reply-to setup, as I hit CTRL-C
  to stop the unlimited sending and picked up from there using the rate limited
  --relogin-delay=25 --batch-size=3
* You'll notice that at patches 99/100 ff the same weird in-reply-to appeared.
  One patch has had a missing '>' in the signoff, such that the server refused
  to cc appropriately ("Stefan" not a valid recipient)
  It would be nice if we could check for that before even sending out emails,
  but I could live with this blamed on the user. (It was my mistake)
* Patch 118 just bounced. "Message rejected."
  It is found at
https://github.com/stefanbeller/git/commit/141ba1f82c223636728a476f9acc1229f353a381

Stefan
