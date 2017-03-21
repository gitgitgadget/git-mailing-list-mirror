Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16D7B2095B
	for <e@80x24.org>; Tue, 21 Mar 2017 21:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758390AbdCUVYY (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 17:24:24 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33144 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758387AbdCUVYX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 17:24:23 -0400
Received: by mail-wr0-f194.google.com with SMTP id g10so24304785wrg.0
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 14:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gal-ro.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=FO0bLaFAzODz0zgjQVX0h+PzMqzBl0//TI3+pS1HwYo=;
        b=Y5GZWGjAvcdRSz4/oFdSkE21NROXyfLCT94RegOT6R7yABz6FzpF+BChcAtXTekFt4
         QsYow3QxzAPZDneiDmk4GBQjfd2rihHSGg6Ocw9dgqpeiYTqf1aQsBLCKEWTncETpkbw
         PQFG0bWgf9sc2glNJNfRNWXRh2YZI5tYDQ66G9mmSC3EIlyn7HTz0r3mP6J3X8fqIBcF
         zoGDcuGV6SsUZq1wHoNFUDS6mqIn5uCH6mEvX/RwVopU7ALPW2gum/KY6ep1dt8hXG4A
         6X/8IXGcDkjnHjsPR3dw8k7vRE6LHVXuNVbdMS44F77VaEPabeNTJqFrLHtu2c7SsTK1
         tjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to;
        bh=FO0bLaFAzODz0zgjQVX0h+PzMqzBl0//TI3+pS1HwYo=;
        b=swb4+ueNkJBWjeBCn5FZ3NwySyCkeP6Ir0CRn2gCfFYixbUKautK8TrTdr6bF+wmrX
         WPAm53hw26L2J1WcNhBcCM/3wL28hCkbwujHnHkB4+iBi4Cmp2C27XCGtaeLy1qtpWjS
         Jka7302eNnNP941M+CgNzp/KjyWxNibe5csfRmN9R1IDRaZtqw1PNTyyXED0NEGS65Rs
         04vWUZmtyjra78Wdv9K2AmnPDCIU/8I9xW5jOF85evh3nMV1sr2i1gW4aDU6tbfbKTz+
         j9se8y9vGZ+lrb5N6n8jt5YxCgXx/SJ72Ptb/Kqt3oISrXk+CsXmgP6ZDfaSX/9mgdzI
         I3YQ==
X-Gm-Message-State: AFeK/H2lDmj1I4cPACC5fQdvk8uNHV22vAyV0QsNGYZ3LUrZ+eWQszH4vxOnrxx+tbXovLiUkxK/ZdtaLXtF+A==
X-Received: by 10.223.172.77 with SMTP id v71mr37185693wrc.131.1490131445850;
 Tue, 21 Mar 2017 14:24:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.107.213 with HTTP; Tue, 21 Mar 2017 14:24:05 -0700 (PDT)
X-Originating-IP: [89.12.102.28]
In-Reply-To: <20170320221429.qefqowtwe2ptvgdg@genre.crustytoothpaste.net>
References: <CAMX8fZU-HeKzd8VYh8R=U8f8V-px+4V==M3CJSS677K0ErwPtA@mail.gmail.com>
 <CAGZ79kY1g-4c+GXZy3p-q=MsBY94esxsfs2=OPuhOH_o5oGc_Q@mail.gmail.com> <20170320221429.qefqowtwe2ptvgdg@genre.crustytoothpaste.net>
From:   Alex Hoffman <spec@gal.ro>
Date:   Tue, 21 Mar 2017 22:24:05 +0100
X-Google-Sender-Auth: XnMTrjpyA2FTS2rqOJwzB7id028
Message-ID: <CAMX8fZXqTfKQXxV_pZEieN=1ap8ocVnnwZUvpGuw5rWo5_Yhfg@mail.gmail.com>
Subject: Re: [PATCH] Correct compile errors when DEBUG_BISECT=1 after
 supporting other hash algorithms
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, Alex Hoffman <spec@gal.ro>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Brian,

We definitely prefer the wrapper function oid_to_hex() to
sha1_to_hex(). Thanks for feedback.
Below is the updated patch:

---
 bisect.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bisect.c b/bisect.c
index 30808cadf..7b65acbcd 100644
--- a/bisect.c
+++ b/bisect.c
@@ -131,7 +131,7 @@ static void show_list(const char *debug, int
counted, int nr,
                unsigned flags = commit->object.flags;
                enum object_type type;
                unsigned long size;
-               char *buf = read_sha1_file(commit->object.sha1, &type, &size);
+               char *buf = read_sha1_file(commit->object.oid.hash,
&type, &size);
                const char *subject_start;
                int subject_len;

@@ -143,10 +143,10 @@ static void show_list(const char *debug, int
counted, int nr,
                        fprintf(stderr, "%3d", weight(p));
                else
                        fprintf(stderr, "---");
-               fprintf(stderr, " %.*s", 8, sha1_to_hex(commit->object.sha1));
+               fprintf(stderr, " %.*s", 8, oid_to_hex(&commit->object.oid));
                for (pp = commit->parents; pp; pp = pp->next)
                        fprintf(stderr, " %.*s", 8,
-                               sha1_to_hex(pp->item->object.sha1));
+                                       oid_to_hex(&pp->item->object.oid));

                subject_len = find_commit_subject(buf, &subject_start);
                if (subject_len)
-- 
2.12.0.400.g54ad2d445.dirty
