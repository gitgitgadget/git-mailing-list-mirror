Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5388420437
	for <e@80x24.org>; Fri, 13 Oct 2017 14:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758223AbdJMOZO (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 10:25:14 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:49193 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753478AbdJMOZM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 10:25:12 -0400
Received: by mail-qt0-f179.google.com with SMTP id k31so19864867qta.6
        for <git@vger.kernel.org>; Fri, 13 Oct 2017 07:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=r39MdBFT/0PGvLX2wkJbsS/iMrqdh8EEuG7PSpmU74s=;
        b=HzrF2E+ZYwXhSZ7OJwpyvMgAlaKuTm+7Q0/6jzbgbWaaDk+OgBxLqvazJzzS1Bkqr8
         JuBvMBJpi+g+AChb0eCUHGeNajuUrfl8ciJikxF2hXTsFAA1MQdqAy6oBRlRhRCsSzsR
         ye/n19JyjoOx8KyFUqhsgu9kAvmt0NBqvJoP3aFmO2vxDxtjMVBLEJp+Upv3Py4+PrlT
         yXEW20eBK7h2+1ddWAiCjv0NxtqHhRfO40cDeOzjgPNGD0Vzwu0rws/20Eiyq5w085W6
         elSG398pbS7ndvM/hcguw3PNMQjDI1cwELTMeF39Jj6NJ9J/7LAxf1+AsqSI3/JZZo7C
         P5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=r39MdBFT/0PGvLX2wkJbsS/iMrqdh8EEuG7PSpmU74s=;
        b=M75lGVEwsk3OGK9VaJVLe7CKQCBiZisMKUhFQC8ilmf3sLVoIKQhtxuQiFKItlkcN/
         nhDnt1V9KbdbmPy3mU8Dx1lYANwpzBKFDfrTatHuiMGEc0/4upZseFrt8JvPdg2P+fBJ
         sxxHZG6IJFPEX3inohc0i/FoRSXvZXa8ERPfthJkj+uPtgfVfOrXOsBKJ6+oySq56OK/
         E9//YVmYKQPCayAPmOtgyLQQv7a+AJTAKB8lgNio7mou9FeWJYc5Zc7UWN0x0BUMIzgX
         Y3USp//fI8de32+hM/kfH3vS2XWtXt51QESMz2sAmYXWQUz7skoLakxtF0p8wmbUAuDg
         GZnw==
X-Gm-Message-State: AMCzsaXxl7L2y0upiQgPqR7v0fBxFnBV3own5MG2R3rxXNqW3vIWPUxp
        NxUZbUimDeVuLSbjSWzkec2rW1Xm
X-Google-Smtp-Source: AOwi7QA3tzNSk8WNPxiK08SvSjLhVYPQNpJs0vctCyVVyhG/XK2aH4cCavnRuOQHmD9GCWptlS3lyA==
X-Received: by 10.237.56.200 with SMTP id k66mr2115304qte.70.1507904711782;
        Fri, 13 Oct 2017 07:25:11 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010::7cc])
        by smtp.gmail.com with ESMTPSA id s6sm601433qkd.55.2017.10.13.07.25.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Oct 2017 07:25:11 -0700 (PDT)
Subject: Re: git-clone causes out of memory
To:     Jeff King <peff@peff.net>
Cc:     Constantine <hi-angel@yandex.ru>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Mike Hommey <mh@glandium.org>, git <git@vger.kernel.org>
References: <CAP8UFD3vniWZQ9Wb1oMo-bbj8n7CTjTHUNhBRwg6jN9x0+ApAQ@mail.gmail.com>
 <xmqqr2u7uuc8.fsf@gitster.mtv.corp.google.com>
 <2f9b8856-dacc-768d-32c2-985f5f145ba7@yandex.ru>
 <20171013124456.qsbaol7txdgdb6wq@sigill.intra.peff.net>
 <f35d03b5-a525-87b3-a426-bd892edf0c36@gmail.com>
 <a4ebf552-35d4-d55f-6f08-731afa2cd2de@gmail.com>
 <20171013135058.q7vhufdtin42ddic@sigill.intra.peff.net>
 <53f98311-3c5f-9863-5f6c-bc4f25fad317@gmail.com>
 <20171013135636.o2vhktt7aqx6luuy@sigill.intra.peff.net>
 <20171013141018.62zvezivkkhloc5d@sigill.intra.peff.net>
 <20171013142004.ocxpdkkbcxpi52yv@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <42cbcb4f-7f9d-df69-f55e-0ba42b931957@gmail.com>
Date:   Fri, 13 Oct 2017 10:25:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171013142004.ocxpdkkbcxpi52yv@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/13/2017 10:20 AM, Jeff King wrote:
> On Fri, Oct 13, 2017 at 10:10:18AM -0400, Jeff King wrote:
>
>> Hmm. So this patch makes it go fast:
>>
>> diff --git a/revision.c b/revision.c
>> index d167223e69..b52ea4e9d8 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -409,7 +409,7 @@ static void file_add_remove(struct diff_options *options,
>>   	int diff = addremove == '+' ? REV_TREE_NEW : REV_TREE_OLD;
>>   
>>   	tree_difference |= diff;
>> -	if (tree_difference == REV_TREE_DIFFERENT)
>> +	if (tree_difference & REV_TREE_DIFFERENT)
>>   		DIFF_OPT_SET(options, HAS_CHANGES);
>>   }
>>   
>>
>> But that essentially makes the conditional a noop (since we know we set
>> either NEW or OLD above and DIFFERENT is the union of those flags).
>>
>> I'm not sure I understand why file_add_remove() would ever want to avoid
>> setting HAS_CHANGES (certainly its companion file_change() always does).
>> This goes back to Junio's dd47aa3133 (try-to-simplify-commit: use
>> diff-tree --quiet machinery., 2007-03-14).
>>
>> Maybe I am missing something, but AFAICT this was always buggy. But
>> since it only affects adds and deletes, maybe nobody noticed? I'm also
>> not sure if it only causes a slowdown, or if this could cause us to
>> erroneously mark something as TREESAME which isn't (I _do_ think people
>> would have noticed that).
> Answering my own question a little, there is a hint in the comment
> a few lines above:
>
>    /*
>     * The goal is to get REV_TREE_NEW as the result only if the
>     * diff consists of all '+' (and no other changes), REV_TREE_OLD
>     * if the whole diff is removal of old data, and otherwise
>     * REV_TREE_DIFFERENT (of course if the trees are the same we
>     * want REV_TREE_SAME).
>     * That means that once we get to REV_TREE_DIFFERENT, we do not
>     * have to look any further.
>     */
>
> So my patch above is breaking that. But it's not clear from that comment
> why we care about knowing the different between NEW, OLD, and DIFFERENT.
>
> Grepping around for REV_TREE_NEW and REV_TREE_OLD, I think the answer is
> in try_to_simplify_commit():
>
>       case REV_TREE_NEW:
>                if (revs->remove_empty_trees &&
>                    rev_same_tree_as_empty(revs, p)) {
>                        /* We are adding all the specified
>                         * paths from this parent, so the
>                         * history beyond this parent is not
>                         * interesting.  Remove its parents
>                         * (they are grandparents for us).
>                         * IOW, we pretend this parent is a
>                         * "root" commit.
>                         */
>                        if (parse_commit(p) < 0)
>                                die("cannot simplify commit %s (invalid %s)",
>                                    oid_to_hex(&commit->object.oid),
>                                    oid_to_hex(&p->object.oid));
>                        p->parents = NULL;
>                }
>      /* fallthrough */
>      case REV_TREE_OLD:
>      case REV_TREE_DIFFERENT:
>
> So when --remove-empty is not in effect (and it's not by default), we
> don't care about OLD vs NEW, and we should be able to optimize further.
>
> -Peff

This does appear to be the problem. The missing DIFF_OPT_HAS_CHANGES is 
causing diff_can_quit_early() to return false. Due to the corner-case of 
the bug it seems it will not be a huge performance improvement in most 
cases. Still worth fixing and I'm looking at your suggestions to try and 
learn this area better.

It will speed up natural cases of someone adding or renaming a folder 
with a lot of contents, including someone initializing a repository from 
an existing codebase. This git bomb case happens to add all of the 
folders at once, which is why the performance is so noticeable. I use a 
version of this "exponential file growth" for testing that increases the 
folder-depth one commit at a time, so the contents are rather small in 
the first "add", hence not noticing this issue.

Thanks,
-Stolee
