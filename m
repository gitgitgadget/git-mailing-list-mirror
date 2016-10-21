Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25B7420229
	for <e@80x24.org>; Fri, 21 Oct 2016 13:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933003AbcJUNIC (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 09:08:02 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:36991 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932884AbcJUNIB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 09:08:01 -0400
Received: by mail-it0-f42.google.com with SMTP id m138so163884626itm.0
        for <git@vger.kernel.org>; Fri, 21 Oct 2016 06:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9r/a5gH5sba/gAvX7ZBVTt5TiHRBnHHRTzMHhGC34HU=;
        b=haarYGtmPPZk0HS9JUpVv58x0iQBwN+r3PWpbu1S5bGEnl9Up/JaXPSp89sDkAgsZh
         hqJzfbMh37/Z0OtJUrdxjPYWx04F6ZePeuBlsmsmqqLIvjNyOFIAUMtyNSlA13v6aPNa
         SCmtESGHpHZh93DBBDHn4rW6CCAJeIT5PXsrG8S6i04uM+jA134Voae1FhhiiOfjAAY6
         SKrEa2LWc0vb/RkacsXcBZ/7yuU46840Vc/br7Bgo4l7AE/yu0NQH7gG7X5wKNetwhYF
         RYTloqdeFuzk+FXbIxkzoWDmn0ynsV08U7sj7SBkm9t+4wLXkP1aORs4i6jwnHh6VlPe
         Np2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9r/a5gH5sba/gAvX7ZBVTt5TiHRBnHHRTzMHhGC34HU=;
        b=RmIuWY5LRZHHr4/pQnCSfzjTdWJUjkDhtYGGLDoyBNJTplVPqhiWYhoDoWv0Uy4f0X
         5ipg09mKSkik6LR3se82K7/1uskcCe5e0yyudVqbQuVTqxiuKff1C3YnfgQStwC1jJd0
         9CCx0MPAC/b/4MQbOt6Pxh5wroGUAhCNqDPbss2bFGuwEjT6SiCkboFB2TImB2Ct9gNa
         XnV3/c8plmN4htWw5/7iGGp+YgjJjQFr56p98adCBj9sOVwoc2Z7zYqzOaBd176dVuJF
         EI7kP45p12fkUzJSimPTGSibe+lDIw8cufdpBLjrdei5Z5Kay9gRqoBNWYxnhPLgYCMQ
         sIHQ==
X-Gm-Message-State: AA6/9RmpiU0mijLWRaufevA2byyUu+8B6Fcf03ng0YvVWDyDZuOzaWSac8R3IxYxJu9v1+f6V6GXopMEVx6YdA==
X-Received: by 10.36.216.4 with SMTP id b4mr13774821itg.74.1477055272715; Fri,
 21 Oct 2016 06:07:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Fri, 21 Oct 2016 06:07:22 -0700 (PDT)
In-Reply-To: <CACsJy8Bxn1qV+xXNnCpuOQ7qWNsz3oLt5-VG=VXZvV9dvJVvTQ@mail.gmail.com>
References: <20161021002654.qo6kcya4gocp73rs@sigill.intra.peff.net> <CACsJy8Bxn1qV+xXNnCpuOQ7qWNsz3oLt5-VG=VXZvV9dvJVvTQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 21 Oct 2016 20:07:22 +0700
Message-ID: <CACsJy8CkK8K0ty3fv9qyD7wwB+81VPB-P1UUCbDJTJ4iM0Y+Cw@mail.gmail.com>
Subject: Re: [BUG] fetch output is ugly in 'next'
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2016 at 7:11 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> Yeah.. replacing the 4 DEFAULT_ABBREV in fetch.c with something
> sensible should do it.

Correction (if somebody will pick this up), it's
TRANSPORT_SUMMARY_WIDTH that needs to be adjusted, not those four.
-- 
Duy
