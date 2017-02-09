Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F7821FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 17:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752228AbdBIRUH (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 12:20:07 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35042 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752426AbdBIRSK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 12:18:10 -0500
Received: by mail-pg0-f52.google.com with SMTP id 194so2254821pgd.2
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 09:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J7ml9SQqssDa1/GeZdCICSGRxLToxag66M7Qrgz5E9U=;
        b=AxH4Pf411GpsVUVPzrdgM+oVhbLO2u4jvy13Y0fp1N+kh9UU+JiVUPd5igk92glgSQ
         zxEGmc4ezjFpIG2dBdcGY3/5VCUqOP+OGClLMXWOp0+D388ZwLpNNac7jQ4thTpCLo41
         gdxQGAEd1IGBm1sN/c7mexjqPyJ3uaDIXcdW4zaaAU1tWQ5kgysy14prtmz8+Y1t8q23
         O8NNzZvE4slSdPDtPNEz5+Ki4k/uan+bihMpwKtmWFzaZNMfABkLuoqP4r+Rlrb4yUFQ
         l9EAbDPixgxDFpRUuoovL43Bn8lrslHlLX9+H0AefKcknVnzFSe7olf17C0KD1Gn3GfE
         RbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J7ml9SQqssDa1/GeZdCICSGRxLToxag66M7Qrgz5E9U=;
        b=Z6sCyGQRMp4sAdj+IQ88Kzx1Hhq87N4bH/pdimGgEeJiL1hnC83xO6AgrjvEdAYcQ/
         sgnyBSNSRxOxLUjN/XasF7dM35kEcrz049IA70opuJtzKEbXrgRPzcZNUsr6VvBY8/pD
         wo1VfZW2bP7rHRhtWjU7mYQujg9g4jKGOPacusk/pNQVbEaQsRHF8HEZ/bFAOhlxsJZ7
         YcJ0NYmLU/1r4xlOOEqLBQM/EJZ0JPciIGz7l6m5+B7IHPwqU2CnttiqfoE/2HLb40Ue
         avv7Fck8U3Yi9eld9qeiu5SOZ4RcH24/aaxN1jf73ZZ7sK2XG66lix3LLfzqylqbDFHK
         qrcw==
X-Gm-Message-State: AMke39mK+0jJkejKRYuQLZNzgVfbMeXLgwibasse9QDXq8iUkxE1vZ6Cz3mOkWQNAzRsdg8g
X-Received: by 10.98.106.132 with SMTP id f126mr4952521pfc.1.1486660687015;
        Thu, 09 Feb 2017 09:18:07 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:4d26:4a9a:574c:db32])
        by smtp.gmail.com with ESMTPSA id u28sm30651452pgo.20.2017.02.09.09.18.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Feb 2017 09:18:05 -0800 (PST)
Date:   Thu, 9 Feb 2017 09:18:04 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com
Subject: Re: [PATCH v3 00/27] Revamp the attribute system; another round
Message-ID: <20170209171804.GA61274@google.com>
References: <20170123203525.185058-1-bmwill@google.com>
 <20170128020207.179015-1-bmwill@google.com>
 <xmqqwpd8s8vd.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwpd8s8vd.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/02, Junio C Hamano wrote:
> 	prepare the <question, answer> array
> 	for path taken from some set:
> 		do_something(the array, path)
> 
> That way, do_something() do not have to keep allocating,
> initializing and destroying the array.
> 
> But after looking at the current set of codepaths, before coming to
> the conclusion that we need to split the static part that is
> specific to the callsite for git_check_attr() and the dynamic part
> that is specific to the <callsite, thread> pair, I noticed that
> typically the callers that can prepare the array before going into
> the loop (which will eventually be spread across multiple threads)
> are many levels away in the callchain, and they are not even aware
> of what attributes are going to be requested in the leaf level
> helper functions.  In other words, the approach to hoist "the
> <question, answer> array" up in the callchain would not scale.  A
> caller that loops over paths in the index and check them out does
> not want to know (and we do not want to tell it) what exact
> attributes are involved in the decision convert_to_working_tree()
> makes for each path, for example.

This was something that I was envisioning as well, though I didn't dig
very deep into the call stack.  Another means of doing this could be to
have the attr_check structure allocated and then have it configured at a
later point for the particular question being asked:

  alloc struct attr_check c;
  ... many call sites down
  configure(c, questions)
  for path
    do_something(c, path)

That also allows the same structure to be reused (just reconfigured) if
different attributes are needed at a later point in time.  Of course
this is just an idea and I'm not sure if this is the best way to do it
either.

> 
> So how would we split questions and answers in a way that is not
> naive and inefficient?  
> 
> I envision that we would allow the attribute subsystem to keep track
> of the dynamic part, which will receive the answers, holds working
> area like check_all_attr[], and has the equivalent to the "attr
> stack", indexed by <thread-id, callsite> pair (and the
> identification of "callsite" can be done by using the address of the
> static part, i.e. the array of questions that we initialize just
> once when interning the list of attribute names for the first time).
> 
> The API to prepare and ask for attributes may look like:
> 
> 	static struct attr_static_part Q;
> 	struct attr_dynamic_part *D;
> 
> 	attr_check_init(&Q, "text", ...);
> 	D = git_attr_check(&Q, path);
> 
> where Q contains an array of interned attributes (i.e. questions)
> and other immutable things that is unique to this callsite, but can
> be shared across multiple threads asking the same question from
> here.  As an internal implementation detail, it probably will have a
> mutex to make sure that init will run only once.
> 
> Then the implementation of git_attr_check(&Q, path) would be:
> 
>     - see if there is already the "dynaic part" allocated for the
>       current thread asking the question Q.  If there is not,
>       allocate one and remember it, so that it can be reused in
>       later calls by the same thread; if there is, use that existing
>       one.
> 
>     - reinitialize the "dynamic part" as needed, e.g. clear the
>       equivalent to check_all_attr[], adjust the equivalent to
>       attr_stack for the current path, etc.  Just like the current
>       code optimizes for the case where the entire program (a single
>       thread) will ask the same question for paths in traversal
>       order (i.e. falling in the same directory), this will optimize
>       for the access pattern where each thread asks the same
>       question for paths in its traversal order.
> 
>     - do what the current collect_some_attrs() thing does.
> 
> And this hopefully won't be as costly as the naive and inefficient
> one.

I agree, this sort of implementation wouldn't suffer from the same
allocation penalty that the naive implementation suffers from.  This
would be slightly challenging to ensure that there aren't any memory
leaks, well not leaks but rather memory that isn't freed.  i.e. When a
thread terminates we would want to reclaim the memory used for the
dynamic part which is stored inside the attribute system.

> 
> The reason why I was pushing hard to split the static part and the
> dynamic part in our redesign of the API is primarily because I didn't
> want to update the API callers twice.  But I'd imagine that your v3
> (and your earlier "do not discard attr stack, but keep them around,
> holding their tips in a hashmap for quick reuse") would at least lay
> the foundation for the eventual shape of the API, let's bite the
> bullet and accept that we will need to update the callers again
> anyway.
> 
> Thanks.
> 

At least v3 gets the attribute system to a state where further
improvements should be relatively easy to make.  And now as long as each
thread has a unique attr_check structure, multiple callers can exist
inside the attribute system at the same time.  There is still more work
to be done on it though.  Still my biggest complaint is the "direction"
aspect of the system.  I would love to also eliminate that as global
state at some point though I'm not sure how at this point.

-- 
Brandon Williams
