Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 170D120372
	for <e@80x24.org>; Tue, 10 Oct 2017 00:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755770AbdJJAzZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 20:55:25 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37960 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755506AbdJJAzY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 20:55:24 -0400
Received: by mail-pf0-f194.google.com with SMTP id a7so31433496pfj.5
        for <git@vger.kernel.org>; Mon, 09 Oct 2017 17:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ey9/XQHHPs07wo6t31uDRR20EgtwZQuFReBuyMhkW84=;
        b=JNcg0WSmpqaf5kwSq0EMOyiUqGZkO9r3hkLdC0as0IGT/4AcVQ7ei925kXmQ6gYnum
         yNrx5bhbeBC6VzSGBOyvnvK5y+6RQ3sMoIhjkyMSS0fXBvhTXTQI/o82JzhIkWYvJeXN
         trg1y9io5M+8aZO1Sr1AlfWufJeA2ODQO6B9ZaIdn3oFNdDE9Avjt29+s2nHr3e6QfjP
         wWzTtSaObVLlplOfk7ZwbLPW2uiYhnY1H8XbYKthJnxm6vbUDG6+vXxZcbdkZn/ztPsR
         gxsjjPU5R0m3iDweGp2+gqFipRQwF1qSA+hlVXS9bol0p2Md6HMGSEEQ/qYaNcD8sn1e
         YQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ey9/XQHHPs07wo6t31uDRR20EgtwZQuFReBuyMhkW84=;
        b=YEQ6xFfD2CvdWnv+LCVJlMqsI9JNuNhXfyz2SjW+wXJAYQDzhq9yGy7aul7FZv4fYE
         qvfw84kNDRtDnWSNEHT4Z2FtFlcutVbiOUZ9SyrpeIiqePXEjMU8Ebcd1aoNo5udQh3b
         VXYHSRr1EoAAFnYYqphLlXXOMVgkZXay6sgekCppaqpcDKoX2VVSr86dw5u1L/1kAvdE
         pDJLNO/Aozjw7ut3xaeB28rMTs0Euihlwna3i05dNy3/0LKE85VIfVqXXF2szvwHapoW
         uJWU4kbL4wb3cYqo4O78z7Qgz3Ba2dpTEHB7Xmgx8FSxQ/7qdwqdy7lFh/mkPFtFHqMU
         E/GQ==
X-Gm-Message-State: AMCzsaUlzyTLLdE9Hzj0HPTcoaRleAVjiW5gG8bbysE4rpYDfJxODbVP
        EOOoxosd72cejG0UB+r29E5Ww10v
X-Google-Smtp-Source: AOwi7QAV3gnBecIBXEhvUkMZ5nQm+nmsXaIpZB9v1bZuhZRdCDFJXAwauD6z+PwvcMZbI7J2AYecHA==
X-Received: by 10.99.171.77 with SMTP id k13mr10782470pgp.229.1507596923638;
        Mon, 09 Oct 2017 17:55:23 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:c9c7:66a0:181:dab2])
        by smtp.gmail.com with ESMTPSA id z26sm17705994pfa.49.2017.10.09.17.55.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Oct 2017 17:55:23 -0700 (PDT)
Date:   Mon, 9 Oct 2017 17:55:20 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] submodule: spell out API of submodule_move_head
Message-ID: <20171010005520.GN19555@aiede.mtv.corp.google.com>
References: <20171009220615.27541-1-sbeller@google.com>
 <xmqqtvz7rh68.fsf@gitster.mtv.corp.google.com>
 <20171010002731.GM19555@aiede.mtv.corp.google.com>
 <xmqqmv4zrfye.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmv4zrfye.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> Junio C Hamano wrote:

>>> This is not a new issue (the removed comment did not mention this at
>>> all), but is it correct to say that updates to "index and work tree"
>>> was as if we did "git -C $path checkout new" (and of course, HEAD in
>>> the $path submodule must be at 'old')?
>>
>> I don't understand the question.  This comment doesn't say it's like
>> "git checkout" --- are you saying it should?
>
> No, I am pointing out that this comment does not say what it's like
> clearly enough.  s/is it correct/am I correct/ would have been less
> prone to get misunderstood, I guess.

No problem.  I think a word or two about how it's like read-tree
in the docstring could be an improvement.

> If it behaves like two-tree "read-tree -m -u", I'd say that the best
> explanation an average developer would understand is that the update
> done to "index and work tree" is like using 'git checkout' to switch
> to the branch whose tip is 'new'.

If it says it's like "git checkout", then I fear that can just lead to
more confusion, since "git checkout" does a number of things (e.g.
updating the HEAD symref) that this function does not do.

It could say that it's like "git reset --keep", I suppose.

[...]
>>> What should happen if 'old' does not match reality (i.e. old is NULL
>>> but HEAD does point at some commit, old and HEAD are different,
>>> etc.)?  Should the call be aborted?
>>
>> No.
>
> ... and that is because?
>
> When does it make sense to do a two-tree "read-tree -m -u" giving
> the 'old' that is very different from the real 'old' tree-ish that
> corresponds to where your index started at?

Because that is not the purpose of the function.

The caller is responsible for setting 'old' appropriately.  A word or
two in that direction would not be a terrible thing.

All that said, I want this function to go away completely. :)
Documenting how it currently behaves is just a good way to understand
what is happening when doing so.

Thanks,
Jonathan
