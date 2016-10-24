Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6720A20193
	for <e@80x24.org>; Mon, 24 Oct 2016 19:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941486AbcJXTSI (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 15:18:08 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:34771 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938979AbcJXTSG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 15:18:06 -0400
Received: by mail-qt0-f174.google.com with SMTP id q7so133799786qtq.1
        for <git@vger.kernel.org>; Mon, 24 Oct 2016 12:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fstF33Gn+h6iUamETPQIfV9qpNHEQbRol0BHF8hQlm4=;
        b=Ek3qVnUL0PmsghDH+1rIpXul5WZ3s1Ph7139zLzrobCQBBL8M1Wdkh7wv0zA/+4ow1
         JwESivXW9i6N9u01xPaqC3FfrH5VFIHeem5mBK1j//BRz4Mf1rBuRlhrNvNzTbnVMxrJ
         nbienwfbyBGFnksLw7sYGpQObGJytiEGl+nERgL6pW+DF/i3QEivotgNqnSBLaoLNV2t
         cbblBVwjEapHXvJm+6AvRPjsXioCyeka9dvNM5z6Hf71af9TtD3kmTNFBjBRAtSl7+Ps
         kK0pxn15/O8rjxcWITCBc2Eu8BuBQ0k5N65aDYiTJU6NT0C9On8BBPlNQwX/sbbAiQfI
         eSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fstF33Gn+h6iUamETPQIfV9qpNHEQbRol0BHF8hQlm4=;
        b=hSHpBvwblOVl0RctgHDFR1YGQdCwoxQUoeHqlM7ig6amWy9FwA23BrjoN/GG2bstBM
         tMUJkSGoFu5t9QDf98lHCzOugeKnohkEW1Y3ssgGybig6jSbvkYoAPm5GrG1yDPqR6fI
         1r2r2K2DpnClykTyZ5PK7pM36B26guxjGIcjpCFi8b3VErOuYPyYQtpYWWHjUETZkA79
         RBRf8IF6Sn3MQI14AGpLjqppN3Y+4Uj7WuG/LvS/cucPS1MHE4greD+grgfYhscD6c+r
         DEIFh4VlWds9Q/omH217cwxzwa/FlNgO9FhTmX+vh747oRFlci/BmVNNhHEaQ2S0aQiz
         0wcg==
X-Gm-Message-State: ABUngveAmTndFoBT2umPKvmLDyhv0SBx9DT7huF5tgFomo/ja/A3sgMuI0QLIgji5EN4e1gZ457eDSkfuRD09uA1
X-Received: by 10.237.47.194 with SMTP id m60mr16544281qtd.55.1477336685339;
 Mon, 24 Oct 2016 12:18:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Mon, 24 Oct 2016 12:18:04 -0700 (PDT)
In-Reply-To: <xmqqr37560gv.fsf@gitster.mtv.corp.google.com>
References: <20161022233225.8883-1-sbeller@google.com> <20161022233225.8883-28-sbeller@google.com>
 <xmqqr37560gv.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 24 Oct 2016 12:18:04 -0700
Message-ID: <CAGZ79kb7PaqnyXZ7u0z8Q__ahTLKX8RQwV=dw7vbD4C9LnjOtw@mail.gmail.com>
Subject: Re: [PATCH 27/36] attr: convert to new threadsafe API
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 24, 2016 at 11:55 AM, Junio C Hamano <gitster@pobox.com> wrote:

>
> Make that a double-asterisk.  The same problem appears in an updated
> example in technical/api-gitattributes.txt doc, but the example in
> the commit log message (below) is correct.

The implementation is actually using a double pointer, see below,
I forgot commit message and documentation

>>     GIT_ATTR_RESULT_INIT_FOR(myresult, 1);
>
> Are you sure about this?  We've called attr_check_initl() already so
> if this is declaring myresult, it would be decl-after-stmt.

I forgot to update the commit message and Documentation.
GIT_ATTR_RESULT_INIT_FOR is gone in the header
and in the implementation.  I'll update that patch
to be consistent throughout all of {Documentation,
commit message, implementation}.

>
> The latter half is questionable.  If it is "static" it wouldn't be
> thread safe, no?  I think the diff in this patch for archive.c shows
> that we only expect
>
>         struct git_attr_result result[2];
>
> upfront without RESULT_INIT_FOR(), and the reason why there is no
> need to free the result[] is because it is on the stack.  And each
> element in result[] may point at a string, but the string belongs to
> the attr subsystem and must not be freed.
>

Same as above, it's bogus.

Thanks,
Stefan
