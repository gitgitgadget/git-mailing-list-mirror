Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCDD320C2E
	for <e@80x24.org>; Wed, 18 Jan 2017 21:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752689AbdARVGs (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 16:06:48 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34709 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752172AbdARVGr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 16:06:47 -0500
Received: by mail-lf0-f66.google.com with SMTP id q89so3321069lfi.1
        for <git@vger.kernel.org>; Wed, 18 Jan 2017 13:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=T2VXDBDkB0Vuhr0+wkz8vxmGDCon2y5Cme2gyr8XHo8=;
        b=OSZNj/L9ZBW0vU7QUFv+PO53tJSoaJ4dBmesDQX7sgoP6bjVs3O2RU0NXpHHDbMN6q
         mKTMwiXPbOmkgH/SLS7v8JKFw4aibZxd64vgW8z/RhzSpvJnw5g2lXvclVuseM4qJVZ/
         CZvgS0Tt+qX5lWhFeACf+zM/4h6TqD+KXOevFUbQ5AF4dWk+HRi46REirH3qu1NZyHSz
         GhPBC19cwYt74bXlh4pucpUabwIf7lL3AhdxWvXOQ/UWG5Rm4oNDA+dN7ixlWAl9oFSm
         H/+LhnjO+Ig82vACLr1a7gr/jmmq94z6MWnUr0TqM9jfNzOhH+qvKqxxolzhI6lVK55f
         G6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=T2VXDBDkB0Vuhr0+wkz8vxmGDCon2y5Cme2gyr8XHo8=;
        b=QYZLyl097Ab0U+itKtMOp6seenQFCZ6FoH+KrUUNDuqkLYl3ypuWaBJkSjqvU21q5w
         jE1kenj5/wIX/VL+0lk8DIgndQAkTObwiTomlUy6fum9BB0KZsGjwvaVXQj+QeXKeKPq
         PtsRGcw5CUHMVIdV7JH+n2Cly4YIGZbuvwlwwQmsQLZtg5LTQHiPiD5t+wF7e5dFeSxG
         ESyIZ7yqeTvNzpzFpgDqgOICTwhux4+nel8udTtfwln1wxzTpuco9BkgRmotIj2s5kB6
         hco0sWMhL1IZgOw1zf2PhaouhwWJXIg2bXBn3Xa68aXDvdKN8I62KRRfqaN93LfxWB3g
         TJYQ==
X-Gm-Message-State: AIkVDXIA+3DYGCuv3HSIw20nXCMpLskpW9h5GjDqPDhL32vQsk9cLsza6XNzIvMzujQGin5liK0G2jcwEYVnhg==
X-Received: by 10.25.33.21 with SMTP id h21mr1807884lfh.114.1484773590477;
 Wed, 18 Jan 2017 13:06:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Wed, 18 Jan 2017 13:06:09 -0800 (PST)
In-Reply-To: <xmqqlgu886lf.fsf@gitster.mtv.corp.google.com>
References: <20170118000930.5431-1-jacob.e.keller@intel.com> <xmqqlgu886lf.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 18 Jan 2017 13:06:09 -0800
Message-ID: <CA+P7+xqM58tQ3=jkX3q4YkB_Jz=u6bf2FC1-f738-xCCGP3brg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] extend git-describe pattern matching
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2017 at 12:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> ** v3 fixes a minor typo in one of the test cases, so please ignore v2
>>    I left the interdiff as between v1 and v3 instead of v2 **
>
> Very much appreciated.
>
> I just finished reading this round through and didn't have any major
> issues.  I sent comments on the way the feature is explained to the
> end users and history readers, though.
>
> Thanks.

Ok. I am currently taking a look at the exclude_list that was
mentioned, and I will see if it makes sense to go that route. If we
do, it would open up a way to make the git-describe logic similar to
git-log (which is probably good), and if we want to do this, it's best
to do it now before we add any additional arguments (ie: before we
create a conflicting user interface).

Thanks,
Jake
