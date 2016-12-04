Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB6061FC96
	for <e@80x24.org>; Sun,  4 Dec 2016 09:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750882AbcLDJhE (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Dec 2016 04:37:04 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36052 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750774AbcLDJhD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Dec 2016 04:37:03 -0500
Received: by mail-pg0-f67.google.com with SMTP id x23so12983932pgx.3
        for <git@vger.kernel.org>; Sun, 04 Dec 2016 01:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id
         :content-transfer-encoding:mime-version:date:cc;
        bh=S74EYyWT9reuXILMnARQLoyxfp/QRmvXW2ze4iJCxW4=;
        b=ht7r76NFtwB53zOj+rLmle9PXWq/IkufFzOb6rgXZTxX9kHSZoNZ36VZ+jGvvXAj0T
         v1QbAp4Ciuic8qocp/SenG6QMNucLoXKN2DBSQ2m1cyg6ihwxJSZB3jyR6j8xsvnIAbD
         B1GrDS3bWvLLdh/NNxwTZXDEyjq/xam2Sjr43+QkF9oOv7HNxDTeI/8aAAiF94nsi5LH
         6UMpQb1C52zKcTyI7stCYMhjuU8rSTsqfs2FCdEnIgLaW1xy0UEji2fKepOtKsgyGBxZ
         ZX7ZmXP952Rwbx2TAydB+WP6HDNOJgLsvSqhtg8H2IiIKBJbtQk+n2IOt9a99tlLwKCc
         1ayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:in-reply-to:subject:references
         :message-id:content-transfer-encoding:mime-version:date:cc;
        bh=S74EYyWT9reuXILMnARQLoyxfp/QRmvXW2ze4iJCxW4=;
        b=kBWOjPV7kiTAxd84UCu+mfhnUWZNDbE/7UpgueZywYBaA+qmhBPzeABQWxhLF6Obr3
         wlo1WBaT4DHqNKsM7B5UFIfPmb3cWdtDm2oqVdwklJNzJgWUCEO7vZF3WZpPOpmN0EqV
         Pwynq2HeeIl1ZIGBYYYlAA31PDtbFlawHL02QRbXrCajJA9ax4efE6lzgLMQ7a7Fw4hM
         BYH6X1jPiWvWUC/0NQR6Fn6olPwiFuBDC0rlcEWvxcJtpm2fMetwGaOt58MTcsG1kzTr
         ehqDBspnr3f68fny6vM+ZJGCpQAMKz2PEVAh97cWkyfbz7OJv6MnxBWozNSSFl5EbHFg
         OnqA==
X-Gm-Message-State: AKaTC018nPcjQEHZcxLobYZSdWVhep2JVsbntrrgTh3Qa27VMy7wnB51zBH5UPjDohLxyA==
X-Received: by 10.84.210.46 with SMTP id z43mr114183192plh.175.1480844222885;
        Sun, 04 Dec 2016 01:37:02 -0800 (PST)
Received: from ?IPv6:2002:46b5:ad14::223:12ff:fe05:eebd? ([2002:46b5:ad14:0:223:12ff:fe05:eebd])
        by smtp.gmail.com with ESMTPSA id j190sm19396990pgd.23.2016.12.04.01.37.01
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 04 Dec 2016 01:37:02 -0800 (PST)
From:   "Kyle J. McKay" <mackyle@gmail.com>
To:     Jeff King <peff@peff.net>
In-Reply-To: <20161204045554.advzvylytdmt2bh2@sigill.intra.peff.net>
Subject: Re: Git v2.11.0 breaks max depth nested alternates
References: <fe33de5b5f0b3da68b249cc4a49a6d7@3c843fe6ba8f3c586a21345a2783aa0> <20161204045554.advzvylytdmt2bh2@sigill.intra.peff.net>
Message-Id: <E3C2AF2A-FE07-4C94-B549-3BDAF9B3DB5D@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v936)
Date:   Sun, 4 Dec 2016 01:37:00 -0800
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Dec 3, 2016, at 20:55, Jeff King wrote:

> So I do think this is worth dealing with, but I'm also curious why
> you're hitting the depth-5 limit. I'm guessing it has to do with  
> hosting
> a hierarchy of related repos. But is your system then always in danger
> of busting the 5-limit if people create too deep a repository  
> hierarchy?

No we check for the limit.  Anything at the limit gets broken by the  
quarantine change though.

> Specifically, I'm wondering if it would be sufficient to just bump  
> it to
> 6. Or 100.

Well, if we left the current limit in place, but as you say:

> Of course any static bump runs into the funny case where a repo
> _usually_ works, but fails when pushed to. Which is kind of nasty and
> unintuitive. And your patch fixes that,

Yes.  That's not nice, hence the patch.  Without the fix, pushing  
might work sometimes until you actually need to access cut-off objects  
at pre-receive time.  So you might be able to push sometimes and  
sometimes it breaks.

> and we can leave the idea of
> bumping the static depth number as an orthogonal issue (that  
> personally,
> I do not care about much about either way).

The patch is a step on that road.  It doesn't go that far but all it  
would take is connecting the introduced variable to a config item.   
But you still need to bump it by 1 during quarantine operations.  Such  
support would even allow alternates to be disallowed (except during  
quarantine).  I wonder if there's an opportunity for further pack  
operation optimizations in such a case (you know there are no  
alternates because they're not allowed)?

>> diff --git a/common-main.c b/common-main.c
>> index c654f955..9f747491 100644
>> --- a/common-main.c
>> +++ b/common-main.c
>> @@ -37,5 +37,8 @@ int main(int argc, const char **argv)
>>
>> 	restore_sigpipe_to_default();
>>
>> +	if (getenv(GIT_QUARANTINE_ENVIRONMENT))
>> +		alt_odb_max_depth++;
>> +
>> 	return cmd_main(argc, argv);
>
> After reading your problem description, my initial thought was to
> increment the counter when we allocate the tmp-objdir, and decrement
> when it is destroyed. Because the parent receive-pack process adds  
> it to
> its alternates, too. But:
>
>  1. Receive-pack doesn't care; it adds the tmp-objdir as an alternate,
>     rather than adding it as its main object dir and bumping down the
>     main one.
>
>  2. There would have to be some way of communicating to sub-processes
>     that they should bump their max-depth by one.

All true.  And I had similar thoughts.  Perhaps we should add your  
comments to the patch description?  There seems to be a trend towards  
having longer patch descriptions these days... ;)

> You've basically used the quarantine-path variable as the
> inter-process flag for (2). Which feels a little funny, because its
> value is unrelated to the alt-odb setup. But it is a reliable  
> signal, so
> there's a certain elegance. It's probably the best option, given that
> the alternative is a specific variable to say "hey, bump your
> max-alt-odb-depth by one". That's pretty ugly, too. :)

You took the words right out of my mouth...   I guess I need to work  
on doing a better job of dumping my stream-of-thoughts that go into a  
patch into the emails to the list.

Most all of your comments could be dumped into the patch description  
as-is to pimp it out some.  I have no objection to that, even adding  
an "Additional-analysis-by:" (or similar) credit line too.  :)

--Kyle
