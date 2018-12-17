Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E53221F405
	for <e@80x24.org>; Mon, 17 Dec 2018 15:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387560AbeLQPb4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 10:31:56 -0500
Received: from mail-lf1-f52.google.com ([209.85.167.52]:40001 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbeLQPbz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 10:31:55 -0500
Received: by mail-lf1-f52.google.com with SMTP id v5so9763839lfe.7
        for <git@vger.kernel.org>; Mon, 17 Dec 2018 07:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o3ONIntZy8JLEE6GFA/p8kmj/iGEW9jJ/099MIxQOxQ=;
        b=nyi/Zb7WgK51Sb2Ha3qH2zy6l59nx/BWV8KF4/HxxjNYRfRx4LjfsTg4DxwSnjj392
         dCxYmoVcNYcep6EAQkXicZ499Fr2dAx4wYoevrE69dMWaAXr/JjFTZtz/qG0PwHIgSKp
         A1zZSyo1CH8r3RBdUTLHQVqVLvJpCDgCJnhgMYJFMyhMnOr2OWYNsFyP0aPeYnlXrwWf
         eKfe7uyoeyVwXRDLWruoJIfHOWe61t7pVXAKN/dG/HjMrhpk3oXFcGw7gtZWSlRGaMDU
         UvvyCBS+jxSrVOzP99H6G0voFjuDJNhPrkfjkiNlBpvw2uoAbBtUuur9ANdYvYHAx0f2
         hu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o3ONIntZy8JLEE6GFA/p8kmj/iGEW9jJ/099MIxQOxQ=;
        b=GiqUr1ERT9yfpCU3oBfume3OfhMVfZPeZ5L3oR40DlqeIyp7lTq8gc2bjA5F31e7pi
         qWQlJ8cUcEr2dmRYFJrfmJbPpsJRj1jMMp6s03bq/lV8C6BD8wNRgj9LpocB7MvC9EZb
         g37PsFcqzO86P8F54JpBvQBlt8YfQGAAYbDAUG4sY4fu2gG+7oe7dziXaRHFFmHzcLIG
         LvF/8kJWY9SInd/hqbrkAheVHMSRZW8QQoLRybPBEmhBglm+a5UzEDkRRduHB9y9eHus
         TP1WyLTsB/GBde2Lt4eAya0xhNmkwFTB1ph8ncfKdNhqwDy4mbtAPns65UnvOuWqMp4e
         oajg==
X-Gm-Message-State: AA+aEWZxjfUijiHMJIqVNhWyQLXTfMQtkd+bzwzwbhvZNUxa6/BG/qY+
        sFw46y0xLOaz3wlZqOX622ZZcv5G
X-Google-Smtp-Source: AFSGD/X4gA6Gc4AjHdbAyuZMjYijVY5Jo6DpQkg7BmpjGHTxyOG18s7VRY9cCE0ckLyhwISzW/IN7A==
X-Received: by 2002:a19:aace:: with SMTP id t197mr7484462lfe.7.1545060713391;
        Mon, 17 Dec 2018 07:31:53 -0800 (PST)
Received: from duynguyen.home (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id e97-v6sm2660661lji.51.2018.12.17.07.31.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 07:31:51 -0800 (PST)
Date:   Mon, 17 Dec 2018 16:31:49 +0100
From:   Duy Nguyen <pclouds@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Farhan Khan <khanzf@gmail.com>, git@vger.kernel.org
Subject: Re: pack file object size question
Message-ID: <20181217153149.GA30261@duynguyen.home>
References: <CAFd4kYCHefqRsiFK=K7MHp=MTwOBXB5979WobEm3w1J5q1bZ0w@mail.gmail.com>
 <20181216221457.GH75890@google.com>
 <CAFd4kYAaMLvOhR_XvwoQ=y4c6CZC=+-q5BmAXO79qTKOLNFtZg@mail.gmail.com>
 <20181217001446.GL75890@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217001446.GL75890@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 16, 2018 at 04:14:46PM -0800, Jonathan Nieder wrote:
> Hi,
> 
> Farhan Khan wrote:
> >> Farhan Khan wrote:
> 
> >>> I am having trouble figuring out the boundary between two objects in
> >>> the pack file.
> [...]
> >              I think the issue is, the compressed object has a fixed
> > size and git inflates it, then moves on to the next object. I am
> > trying to figure out how where it identifies the size of the object.
> 
> Do you mean the compressed size or uncompressed size?
> 
> It sounds to me like pack-format.txt needs to do a better job of
> distinguishing the two.

How about something like this?

I mostly wrote this based on memory (and a very quick look at
index-pack) but I think we never ever really stored compressed
sizes. The "length" field (even in loose format) is always about
uncompressed size.

-- 8< --
diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index cab5bdd2ff..4fd49f61d6 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -31,6 +31,11 @@ Git pack format
 	 is an OBJ_OFS_DELTA object
      compressed delta data
 
+     Note: The length (in bytes) is of uncompressed objects or
+     deltified representation. We're supposed to reach the end of zlib
+     stream once we have inflated the given length, otherwise it's a
+     corrupted pack file.
+
      Observation: length of each object is encoded in a variable
      length format and is not constrained to 32-bit or anything.
 
@@ -199,7 +204,8 @@ Pack file entry: <+
 		is the size before compression).
 	If it is REF_DELTA, then
 	  20-byte base object name SHA-1 (the size above is the
-		size of the delta data that follows).
+		size of the delta data that follows, before
+		compression).
           delta data, deflated.
 	If it is OFS_DELTA, then
 	  n-byte offset (see below) interpreted as a negative
-- 8< --
