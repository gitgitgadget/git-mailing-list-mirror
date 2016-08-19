Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 109351F859
	for <e@80x24.org>; Fri, 19 Aug 2016 22:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755725AbcHSWD1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 18:03:27 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35048 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755534AbcHSWD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 18:03:26 -0400
Received: by mail-yw0-f193.google.com with SMTP id r9so1320149ywg.2
        for <git@vger.kernel.org>; Fri, 19 Aug 2016 15:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tBRrbBCyELwuyiwDU4JGBfrS0u6oXEwlgn68jMkzcbM=;
        b=uU2iAsgo/Wm6pbc+ZGp5YQhXk52JWwuO0NSGzSOKNhU4StQFNg7NVP0CNNW2MAWoHW
         zgOIv6wqotu+nZa9j7Me6VwDmF2DrJ2bfVt/Gta+WfXrbWUBr7hy/8xn1GPUSnopG3wi
         jh65swBLdhaVXWCk9HJg2zKteKXW1Js9DnfkF3cOdu4t21GQF7d4OB803nS/WRi/O0ma
         I+MTi793dxHMptszJm44JQlRUdTZqq8YpJqkAptyfj3Homek5eF8mMFYizlsmGGX8C9S
         z3/UAAj7L9YSCxBbMYfa9DkIPRF4mwMv+qBRyAjVISZMXaUf+BPm6+FE6f4P63Jt6NG1
         ZcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tBRrbBCyELwuyiwDU4JGBfrS0u6oXEwlgn68jMkzcbM=;
        b=iAfnR/hvW8iTw9dddxfhFGL+i2XU95ej2Doqy96Q2d4DOV262lDJxvnNpdVC2+YFnq
         FAo6VMAJWc6a9+UGhmEGREbpfBOljUPAHr0IW5xaEh7K/zUP/KkyLA+QFoSt4iP95gu0
         Ey2AjqpSqy2VD3eh6+b563/V2oKozLn8Rv1f6CWMtdSar5c5DiCI5kVBSFeoqaFpQcp1
         oEDmSVw/Wnp1lLN+X9+yTONrlmvD8xt4L3jAbnUC5Azdhsl4VL1dzjFj8RLB3H5gOZkt
         qy47Kcm+4ajJqkcGgv5A3ElWOfQRpsBcIfY+nvjSTuUTpuh5PrHsTgOScZ8GhBcP8PE/
         ThZw==
X-Gm-Message-State: AEkoouv0WiLZpEv+ScdvlDbbgh4SM7HSY6Nl7IYmts6nyN/HcLuoURGoX3wjpyeUvuVAY7LXwg6KTVd8sGC1wA==
X-Received: by 10.13.197.195 with SMTP id h186mr8065611ywd.54.1471644205404;
 Fri, 19 Aug 2016 15:03:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.199 with HTTP; Fri, 19 Aug 2016 15:03:05 -0700 (PDT)
In-Reply-To: <xmqqmvk8zasi.fsf@gitster.mtv.corp.google.com>
References: <20160819000031.24854-1-jacob.e.keller@intel.com>
 <20160819000031.24854-9-jacob.e.keller@intel.com> <xmqqmvk8zasi.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 19 Aug 2016 15:03:05 -0700
Message-ID: <CA+P7+xrdcDOak2Cw8FNq0_LGeAQZG8aJy6NnAvD0Umzr6NxVkA@mail.gmail.com>
Subject: Re: [PATCH v8 8/8] diff: teach diff to display submodule difference
 with an inline diff
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2016 at 2:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> diff --git a/diff.h b/diff.h
>> index ea5aba668eaa..192c0eedd0ff 100644
>> --- a/diff.h
>> +++ b/diff.h
>> @@ -112,6 +112,7 @@ enum diff_words_type {
>>  enum diff_submodule_format {
>>       DIFF_SUBMODULE_SHORT = 0,
>>       DIFF_SUBMODULE_LOG,
>> +     DIFF_SUBMODULE_INLINE_DIFF,
>
> Same trailing comma.
>
>>  };
>>
>>  struct diff_options {
>> diff --git a/submodule.c b/submodule.c
>> index 7108b4786bc1..cecd3cd98de4 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -435,6 +435,68 @@ void show_submodule_summary(FILE *f, const char *path,
>>       clear_commit_marks(right, ~0);
>>  }
>>
>> +void show_submodule_inline_diff(FILE *f, const char *path,
>> +             const char *line_prefix,
>> +             struct object_id *one, struct object_id *two,
>> +             unsigned dirty_submodule, const char *meta,
>> +             const char *del, const char *add, const char *reset,
>> +             const struct diff_options *o)
>> +{
>> +     const struct object_id *old = &empty_tree_oid, *new = &empty_tree_oid;
>> +     struct commit *left = NULL, *right = NULL;
>> +     struct strbuf submodule_dir = STRBUF_INIT;
>> +     struct child_process cp = CHILD_PROCESS_INIT;
>> +
>> +     show_submodule_header(f, path, line_prefix, one, two, dirty_submodule,
>> +                           meta, reset, &left, &right);
>> +
>> +     /* We need a valid left and right commit to display a difference */
>> +     if (!(left || is_null_oid(one)) ||
>> +         !(right || is_null_oid(two)))
>> +             goto done;
>> +
>> +     if (left)
>> +             old = one;
>> +     if (right)
>> +             new = two;
>> +
>> +     fflush(f);
>> +     cp.git_cmd = 1;
>> +     cp.dir = path;
>> +     cp.out = dup(fileno(f));
>> +     cp.no_stdin = 1;
>> +
>> +     /* TODO: other options may need to be passed here. */
>> +     argv_array_pushl(&cp.args, "diff");
>
> I think you meant argv_array_push() here.  Or ", NULL" at the end if
> you anticipate you would grow more args after "diff" later and keep
> using pushl().

I had added an argument at one point and accidentally forgot to
convert back to push(). Oops!

Regards,
Jake
