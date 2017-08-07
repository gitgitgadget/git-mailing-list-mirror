Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 110F02047F
	for <e@80x24.org>; Mon,  7 Aug 2017 18:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751560AbdHGS1V (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 14:27:21 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36191 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751426AbdHGS1U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 14:27:20 -0400
Received: by mail-lf0-f42.google.com with SMTP id o85so5377467lff.3
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 11:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oahiIAEgTY+iYVjpWVn3591HoCx+p9cvYUN6Vf0nPNo=;
        b=UhTNJtK5yETHRF8AGDo7HOUPvhI3Sc3jSWLBZrff/Y6Yk89zRnrORc+V9ZHQbpu7Ie
         Pp0YQosx8c223tx0ECRdNmVbJ2oW94ORScn4YbH9ntZPdOh4IBlMaX9wHW0MM7ZpPNF0
         3YEOc3Oyh6rbnrnuvbdgVPLcf27SqH83g9nRf8cb1nLWn+5eS5hec8rlTTw+1VAAW6u8
         M/Ex5L/wd5hxv+YrA9o+KIv0K9IUXLeB8ESpCJEip2OLQyUe3LOiQwLsVuhXZwzBznjw
         PPKFBbIthWRUB9mUsRWta3OXAXmS/qxGRz4gL1vJna/fx5GIPEPJIaOTz6V/cOUyWMGP
         nmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oahiIAEgTY+iYVjpWVn3591HoCx+p9cvYUN6Vf0nPNo=;
        b=MnlskMvsprcHYlyKWuPVHCK5sR5fq0V/BsFwO7YTQvLpIyG12qm0hZsAjTLX1U037w
         wBxCt9ZaPlIyZHL9rtCy4KhTcCxgyBNzcP3jOnMXg++QBSsVs9o25FP9i9m5EJ/qwH4c
         vlhQWfQib4QBdTOFkWFKRA2m2yo1GMulQdsIcG2Fc2ENDYRSs1YkqPw6/Ie3KJRZAL6y
         jZh8Px8fwaqb6lFw/InhrU3M7GEnT121gWwiHUJDxOvtuCKo0salmk+8XUvHN+f513ij
         8oa7rIscNIRoMioBBnFUIPrb89cxT1rr72D9aU8vhoLn7dVZrYZYNBECzp79szpMLYML
         wJLA==
X-Gm-Message-State: AHYfb5gJQZAwxPMnhZs9HAuy5ItJ+QIiJfpccPCuyXL7HM1id3gtGyt/
        svNhNecwa1toYV3JSj6lYYyfChwtgjvu
X-Received: by 10.25.15.221 with SMTP id 90mr477703lfp.220.1502130438423; Mon,
 07 Aug 2017 11:27:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Mon, 7 Aug 2017 11:27:17 -0700 (PDT)
In-Reply-To: <CAJo=hJtg0PAVHT1phbArdra8+4LfnEEuaj3fBid==BXkZghi8g@mail.gmail.com>
References: <CAJo=hJtg0PAVHT1phbArdra8+4LfnEEuaj3fBid==BXkZghi8g@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 7 Aug 2017 11:27:17 -0700
Message-ID: <CAGZ79kZO517Bg+O2z3dr+oHqO_av1__FU3h9bP=rhXJUSDnRjA@mail.gmail.com>
Subject: Re: reftable [v6]: new ref storage format
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 6, 2017 at 6:47 PM, Shawn Pearce <spearce@spearce.org> wrote:
> 6th iteration of the reftable storage format.
>
> You can read a rendered version of this here:
> https://googlers.googlesource.com/sop/jgit/+/reftable/Documentation/technical/reftable.md
>
> Changes from v5:
> - extensions.refStorage = reftable is used to select this format.
>
> - Log records can be explicitly deleted (for refs/stash).
> - Log records may use Michael Haggerty's chained idea to compress before zlib.
>   This saved ~5.8% on one of my example repositories.

Some observations:

Also the bits in the records changed in v5 or v6:
  0x0..0x3 is valid for a ref,
  obj records have a ccnt
  0x0, 0x1, 0x4..0x7 are used in the logs

We have the following block indicators:
  'r'  ref block
  'o' object block
  'g' log block

  high bit for any index.

Without prior knowledge an index doesn't indicate if it
indexes refs, objects or logs. To find out, one must follow
an arbitrary entry which points to either an index again
or at a block marked with 'r', 'o' or 'g'.

Okay with me.

> The index may be organized into a multi-level index, where ...
> which may in turn point to either index blocks (3rd level) or ref blocks (leaf level).

So we allow 3 levels at most?

The file format structure marks the indexes '?', should that be
rather '*' to indicate there can be more than one index block?
