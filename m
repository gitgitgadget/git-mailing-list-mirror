Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 756E61FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 18:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbdBFSKa (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 13:10:30 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33425 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbdBFSKa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 13:10:30 -0500
Received: by mail-pf0-f193.google.com with SMTP id e4so7374382pfg.0
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 10:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rZasCarsPFBQfpc5zsNr3Ui0rqVj4woHAMR2gjvmaJk=;
        b=oXm0lFm6D9q74DbuQgl/qIzZY5oIiZla2XpAgKpEHGjzs4nq7RjgwuaT5fCKVIerIu
         pL9rqC8abQZRreYQGDIfeMIiGTib5cpTFaVCHtt1DOt2ujrfn+FmvTdV2p+bQG8liPXn
         fNbIMbex1RWXq/lwbvOawKT+TmyVM4lHHovaYMIwAIf/1sxHkgYljsMZstjOFslX5n2L
         aucgtMAoDouFW/4Ux9jkwy604jKNgX8C6LX4IM+QLZMjecGk/FhIyJvSKJ9JPCpdpD1H
         l9vxj0J8ccOUI0ExdAlFTGXlIK5lLAzp+srcls6Ly05C3zfVKQkB42mKrewwv5d4RMVG
         4n3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rZasCarsPFBQfpc5zsNr3Ui0rqVj4woHAMR2gjvmaJk=;
        b=m9PnLSVwpYd7/j3Lpdpvg2aGY9GDPozkaSAmtaFCHW48Sf6q/ZOyvvHW53kLyF74t+
         H6lL+S3Ao/DLZhe36aXGwWKliOQ4OufQui4SghK9LFmbJGoQurgNSRViQxvKLB5UiTfn
         ypji0dqVzs9n9tlLZ/kvHp9t3lvzGklY6TsholB2ERkZ5UFbFhcPY+lt2UvAaaNfi/WZ
         Kr0IjFBPjgsIdvrQ0QEYyAXepNbcY5K4RueVxYGjfdcCSHVquDONiWFYqV2IUYQO4uB4
         vGyptJzwUr6b+SVL6yXz6mlvppqHe2rvdBAyHiJ0BXMGHAYZNMpuvnoyiR77LLoorNhF
         MkWA==
X-Gm-Message-State: AIkVDXJiBTED3Zo7u1+aLyZEunoEZXpgGYYQV5JCbysBULCmolulYqN3URPpl/QL/j8/bQ==
X-Received: by 10.98.65.15 with SMTP id o15mr14587463pfa.42.1486404629244;
        Mon, 06 Feb 2017 10:10:29 -0800 (PST)
Received: from localhost ([139.59.1.28])
        by smtp.gmail.com with ESMTPSA id t133sm4386319pgc.24.2017.02.06.10.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Feb 2017 10:10:28 -0800 (PST)
Date:   Mon, 6 Feb 2017 18:10:26 +0000
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, pranit.bauva@gmail.com, Matthieu.Moy@imag.fr,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx
Subject: Re: [PATCH/RFC] WIP: log: allow "-" as a short-hand for "previous
 branch"
Message-ID: <20170206181026.GA4010@ubuntu-512mb-blr1-01.localdomain>
References: <1486299439-2859-1-git-send-email-kannan.siddharth12@gmail.com>
 <xmqqtw882n08.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtw882n08.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Junio, I did some more digging into the codepath:

On Sun, Feb 05, 2017 at 04:15:03PM -0800, Junio C Hamano wrote:
> 
> A correct solution needs to know if the argument is at the position
> where a revision (or revision range) is expected and then give the
> tip of the previous branch when it sees "-" (and other combinations
> this patch tries to cover).  In other words, the parser always knows
> what it is parsing, and if and only if it is parsing a rev, react to
> "-" and think "ah, the user wants me to use the tip of the previous
> branch".
> 
> But the code that knows that it expects to see a revision already
> exists, and it is the real parser.  In the above snippet,
> setup_revisions() is the one that does the real parsing of argv[].
> The code there knows when it wants to see a rev, and takes argv[i]
> and turns into an object to call add_pending_object().  That codepath
> may not yet know that "-" means the tip of the previous branch, and
> that is where the change needs to go.

Inside setup_revisions, it tries to parse arguments and options. In
there, is this line of code:

    if (*arg == '-') {

Once control enters this branch, it will either parse the argument as
an option / pseudo-option, or simply leave this argument as is in the
argv[] array and move forward with the other arguments.

So, first I need to teach setup_revisions that something starting with
a "-" might be a revision or a revision range.

After this, going further down the codepath, in
revision.c:handle_revision_arg: 

The argument is parsed to find out if it is of the form
rev1...rev2 or rev1..rev2 or just rev1, etc.

(a) -> If `..` or `...` was found, then two pointers "this" and "next"
now hold the from and to revisions, and the function
get_sha1_committish is called on them. In case both were found to be
committish, then the char pointers now hold the sha1 in them, they are
parsed into objects.

(b) -> Else look for "r1^@", "r1^!" (This could be "-^@", "-^!") To
get r1, again the function get_sha1_committish is called with only r1
as the parameter.

(c) -> Else look for "r1^-"

(d) -> Else look for the argument using the same get_sha1_committish
function (It any "^" was present in it, it has already been noted and
removed)

Cases (a), (b) and (d) can be handled by putting this inside
get_sha1_committish. (Further discussion about that below)

Case (c) is a bit confusing. This could be something like "-^-", and
something like "^-" could mean "Not commits on previous branch" or it
could mean "All commits on this branch except for the parent of HEAD"
Please tell me if this is confusing or undesired altogether.
Personally, I feel that people who have been using "^-" would be
very confused if it's behaviour changed.

So, all the code till now points at adding the patch for "-" = "@{-1}"
inside get_sha1_committish or downstream from there.

get_sha1_committish 
-> get_sha1_with_context 
-> get_sha1_with_context_1
-> get_sha1_1 
  -> peel_onion -> calling get_sha1_basic again with the ref
  only (after peeling) 
  -> get_sha1_basic -> includes parsing of "@{-N}" type revs. So, 
  this indicates that if we can convert the "-" appropriately 
  before this point, then it would be good.
  -> get_short_sha1

So, this patch reduces to the following 2 tasks:

1. Teach setup_revisions that something starting with "-" can be an
argument as well
2. Teach get_sha1_basic that "-" means the tip of the previous branch
perhaps by replacing it with "@{-1}" just before the reflog parsing is
done

> A correct solution will be a lot more involved, of course, and I
> think it will be larger than a reasonable microproject for people
> new to the codebase.

So true :) I had spent a fair bit of time already on my previous patch,
and I thought I might as well complete my research into this, and send
this write-up to the mailing list, so that I could write a patch some
time later. In case you would prefer for me to not work on this
anymore because I am new to the codebase, I will leave it at this.

- Siddharth Kannan
