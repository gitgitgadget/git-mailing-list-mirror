Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D59BC433FE
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 17:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0EC2206D8
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 17:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgLCRua (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 12:50:30 -0500
Received: from mail.javad.com ([54.86.164.124]:38318 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgLCRua (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 12:50:30 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id A7E003E96D;
        Thu,  3 Dec 2020 17:49:46 +0000 (UTC)
Received: from osv by osv with local (Exim 4.92)
        (envelope-from <sorganov@gmail.com>)
        id 1kksjg-0003y4-5y; Thu, 03 Dec 2020 20:49:44 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org
Subject: Re: [PATCH v1 06/27] diff-merges: rename all functions to have
 common prefix
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201108213838.4880-1-sorganov@gmail.com>
        <20201108213838.4880-7-sorganov@gmail.com>
        <xmqqeek7k8wy.fsf@gitster.c.googlers.com>
Date:   Thu, 03 Dec 2020 20:49:44 +0300
In-Reply-To: <xmqqeek7k8wy.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 02 Dec 2020 16:52:45 -0800")
Message-ID: <87ft4mhj9j.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Use the same "diff_merges" prefix for all the diff merges function
>> names.
>>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  builtin/log.c |  4 ++--
>>  diff-merges.c | 10 +++++-----
>>  diff-merges.h | 15 ++++++++++-----
>>  revision.c    |  6 +++---
>>  4 files changed, 20 insertions(+), 15 deletions(-)
>>
>> diff --git a/builtin/log.c b/builtin/log.c
>> index ad3092fdd854..77a7bba543ad 100644
>> --- a/builtin/log.c
>> +++ b/builtin/log.c
>> @@ -599,7 +599,7 @@ static int show_tree_object(const struct object_id *oid,
>>  static void show_setup_revisions_tweak(struct rev_info *rev,
>>  				       struct setup_revision_opt *opt)
>>  {
>> -	rev_diff_merges_default_to_dense_combined(rev);
>> +	diff_merges_default_to_dense_combined(rev);
>>  	if (!rev->diffopt.output_format)
>>  		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
>>  }
>> @@ -724,7 +724,7 @@ static void log_setup_revisions_tweak(struct rev_info *rev,
>>  	if (!rev->diffopt.output_format && rev->combine_merges)
>>  		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
>>  
>> -	rev_diff_merges_first_parent_defaults_to_enable(rev);
>> +	diff_merges_first_parent_defaults_to_enable(rev);
>
> Even with a different prefix, this name does not make it clear what
> is going on to its readers.  The other name is OK, though.

As this name goes away later, let's relax this one, and focus on the
final name, OK?

Thanks,
-- Sergey Organov
