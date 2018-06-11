Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC4671F403
	for <e@80x24.org>; Mon, 11 Jun 2018 16:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932573AbeFKQOM (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 12:14:12 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:52533 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932436AbeFKQOM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 12:14:12 -0400
Received: by mail-wm0-f43.google.com with SMTP id p126-v6so15719648wmb.2
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 09:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=KMn21k0LmOmAYeQkJ1IL8iWSz8GKFKHZ4W3ovqAzkro=;
        b=oMkO5op71xhlTtGwA0SHmeKsk3X33TFuoEQL5eP2r+xdEW7jrCOw4PBUMEDdfJsOcT
         R0oyo9low1hO0o8etdHwkA1yZPyMp7SQXQ8hnkZqPV/7dIytCPhFvD+rFI3TrBE2SF9F
         1duWwi1D/228gPNEODNF9En+6O74+SFYuJlEKsHRvBJxrLtnUWfzUD7tEIBVZXsawnc/
         BfS1NI7woMW2IzVDjLNpb128vSd1NMa9LL1aLhssVRSHyP+RJxZz9YcvzHDJJ9wdQLCb
         aCezVMQya0g/GGcm5r7eMyXACjqVdviW8ZOV6jfsYJDNsPAwiTNN4xGQv3R2DFNPCESi
         hEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=KMn21k0LmOmAYeQkJ1IL8iWSz8GKFKHZ4W3ovqAzkro=;
        b=kl6ufjsV6Q030LAGF0GPYSmjEM0gkN1s03orMR2Jtmses1jq/0cB4xxsZV2OqYTkZn
         1qCh7kC2XS1wlpm0ndaBF9lz4+nM0THaGr32c/xZ88FPbN9kTAcZL3BGisQHQ5f/VHAv
         SRUap3C/S7ltU0PYnXRRwYuz93a7YGogxyLBA/4/kYtTmiQxc3nOB1PBUfSSn+WAZBTm
         QXLidWlAO2d46OFhyRfLruHX0VOQe2S9xhRgMMnHcXSj4IqqK4HiIdsldt1TmVBCq9Kd
         nyJ4ojd6Z6Z1jcLFEK5w4rANcluykgtM2gnwSSYJiB/M2i3UHTSKAtv0A4bzwjxFE9SO
         zdaw==
X-Gm-Message-State: APt69E1ZeRCNoIZab9eT5uD09UJYglTZYvFK2nvDX0Ty7HgDG69AXeZf
        cyO+DjMGLg3fskFj+ElSxMw=
X-Google-Smtp-Source: ADUXVKLpk+NT0tAqDy4CA8aFwx99gStx8Wa427i58cT8pphyr4BnikIeqFy+ijRHxDs96vgDSqTZzA==
X-Received: by 2002:a1c:16cc:: with SMTP id 195-v6mr3616770wmw.87.1528733650592;
        Mon, 11 Jun 2018 09:14:10 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b124-v6sm11598773wmf.11.2018.06.11.09.14.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 09:14:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.18.0-rc1
References: <xmqqwove4pzo.fsf@gitster-ct.c.googlers.com>
        <781A6400-477F-4A7B-8C17-65BFD280B331@gmail.com>
Date:   Tue, 12 Jun 2018 01:14:09 +0900
In-Reply-To: <781A6400-477F-4A7B-8C17-65BFD280B331@gmail.com> (Lars
        Schneider's message of "Mon, 4 Jun 2018 18:27:52 -0700")
Message-ID: <xmqqmuw147xq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 04 Jun 2018, at 06:53, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> A release candidate Git v2.18.0-rc1 is now available for testing
>> at the usual places.  It is comprised of 842 non-merge commits
>> since v2.17.0, contributed by 65 people, 20 of which are new faces.
>> 
>> ...
>> 
>> * The new "checkout-encoding" attribute can ask Git to convert the
>>   contents to the specified encoding when checking out to the working
>>   tree (and the other way around when checking in).
>
> Did you call the feature "checkout-encoding" here intentionally?
> The attribute is called "working-tree-encoding" in the final and
> merged round. Shouldn't we call it that way here too?

No.  Yes, absolutely.  Thanks.

 Documentation/RelNotes/2.18.0.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.18.0.txt b/Documentation/RelNotes/2.18.0.txt
index 8d0ee5c426..ecd9f8849e 100644
--- a/Documentation/RelNotes/2.18.0.txt
+++ b/Documentation/RelNotes/2.18.0.txt
@@ -50,7 +50,7 @@ UI, Workflows & Features
    have been replaced with a stub that errors out and tells the user
    there are replacements.
 
- * The new "checkout-encoding" attribute can ask Git to convert the
+ * The new "working-tree-encoding" attribute can ask Git to convert the
    contents to the specified encoding when checking out to the working
    tree (and the other way around when checking in).
 
