Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BA092018E
	for <e@80x24.org>; Sun, 10 Jul 2016 15:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757180AbcGJPJh (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 11:09:37 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:36993 "EHLO
	mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbcGJPJg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2016 11:09:36 -0400
Received: by mail-it0-f43.google.com with SMTP id f6so38067124ith.0
        for <git@vger.kernel.org>; Sun, 10 Jul 2016 08:09:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M8cBx9nYIT5A2lS8V8S1r7pu+PFrmaS8KQFImmv1Wd0=;
        b=kigMFhu30AcaY5ZAIAnd66en3DnHAgf4X3A8dJMN55e1A191uEfkoXn9mveelHrnvS
         MxRwU7lOFm+wWgUY6mRTIlQsr2zZrxEbBg3WjhW2GrgOVA04ivMSvaug5wsVhD3K1noe
         f1bexugAXBuEIoSsPpMjoFq0utQglLhifASEO1MlgloZvop9iMO4NKeBRScJIVLWt4tC
         SSPHvooID0+h4L214L4EAMs+/7nYmHPuGh9iS2tjq1i8ljwNUhcCBREzfqBZ5lqQ/oqZ
         /rz+slgzrDGZeVxigf80hIREktBdjX0mJbgLFolOvAVVDpHTwm4f2PAlk1mnh8S4FHZt
         iEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M8cBx9nYIT5A2lS8V8S1r7pu+PFrmaS8KQFImmv1Wd0=;
        b=YXDY762ApilqUIzhCBxiGFukpDUlWTFNepZWbhhKPdhlEZuI1QaJJ3LxE2LP1tfnQS
         boHrrPuYQuUw/eHRDsphFhndyEoUGPw5obOLvn+lQ8KrRoR6CiQU/KCHeLRxubT+GPCw
         0fQqQ1EZA8Qi8AuhYbAQgvskt0ByITzRJq4KssqOlKTccuNSANR9M7Y9K+QLLoETYV81
         7ZheWrmL/3U2OD5HuKRvg20DskrPgyF796hp5RKggF0TxuKII5B/1jaVvufx8mLCNKAw
         LGyfgA1sgKKOnBmu0n/sB5Lf3z1hinRbSD15bgbvVyNC3850u5AW3NouZxsrtIUFSlp3
         eIVg==
X-Gm-Message-State: ALyK8tKqiviV6S7I5SCpeIJpFQS3UH5oUfZsxmdLEgolzr0Tb3ZBpppILB00OEnrp6kTZQZ4wLIyH3rJ+o8COA==
X-Received: by 10.36.84.79 with SMTP id t76mr6795575ita.63.1468163375731; Sun,
 10 Jul 2016 08:09:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Sun, 10 Jul 2016 08:09:06 -0700 (PDT)
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sun, 10 Jul 2016 17:09:06 +0200
Message-ID: <CACsJy8CNJfQxnn94b=+mjfPVvNzJu3sD3w_g8yCUHY0UQCbfLQ@mail.gmail.com>
Subject: Re: [PATCH 00/38] Virtualization of the refs API
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jun 3, 2016 at 11:03 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Since the that ref-iterator [1] changes seem to have gotten a positive
> reception, let's try to keep up the momentum. I hope I'm not
> overloading the review pipeline...
>
> I think all of the groundwork is in place now to virtualize the refs
> API. This will open the way to storing refs in ways other than the
> familiar loose refs / packed refs format, such as David Turner's
> proposed LMDB-based storage [2].
>
> This is a long patch series, but most of the patches are pretty simple
> and formulaic. The goal is to implement a `ref_store`. In the language
> of object-oriented programming, `ref_store` is an abstract base class
> representing a reference storage backend. It provides methods to read,
> write, and delete references and symrefs, and to iterate over
> references, reflogs, and reflog entries, plus a number of other
> things—19 methods in all.

I probably don't know what I'm talking about because I don't follow
your work closely enough. Please ignore if this is nonsense. But if we
extend/change API, we might need to update git-for-each-ref too, to
expose it to shell scripts and external commands. I guess for
iteration there's nothing else more needed, but we may need to
introduction new options for the storage thing, e.g. to select
storage...
-- 
Duy
