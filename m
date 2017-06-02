Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 442DF20D13
	for <e@80x24.org>; Fri,  2 Jun 2017 17:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751187AbdFBRzp (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 13:55:45 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34202 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbdFBRzo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 13:55:44 -0400
Received: by mail-pf0-f193.google.com with SMTP id w69so13081719pfk.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 10:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DiFeiaa/cbDF4tASIaTdPtvy82qRBLTfGW9CAwlDzPs=;
        b=h3J+42invtMqGVGxAyOG72r46uJAZLWpsb4QTNN87wYbGIaD96n2i5Kd97SJyS0hw7
         19ZhLkHfcUWSPkd3ayHQDXAsr1/gcEFc5SNT5O6aZ2AMSXBh2gTIG9SoH759EF66AwEc
         8+++mheTRhe9WYpMq2zi3btTBbKgWLXQl3G2mklKsfrG9CBdLgWxgux2W70EbgyiTIMA
         pqN5PimTIOMH32he9bn2DxC0t5+YJ2zWrL7l52Wovp8QKt/BXjZQp68RZ/B69Rz3uEpZ
         SRk2ATfT/8LagKkhK8WV0EY9sTw9YI5BPCtfDO8ReEdKOp85AKQEWCedz1iNdF58dpIb
         y9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DiFeiaa/cbDF4tASIaTdPtvy82qRBLTfGW9CAwlDzPs=;
        b=OifDceqK7iJ40yo8iWyRVNw6yKjKh8w2yprAE6DMuj31yJn0QGCINvChnV8IaVRslR
         ByxTVQjXvXC3cP3x+RVtI24C/PEOKcq/L1qhydHjHTwu0oVJ2uuez8k8sTg0Iz2NjaCv
         Y7gdLopQe8ooI9K2aNrFV0XYkWeoXaq3uK0oaw7Zn7CgAQXMAuaIZp5FVNmKz/qVjm9b
         iwD1HKmacSWPtveHk9itAebf3ocXE3Opt8mcbc5oc7wQqoYEclB3ov6UEiSmwt14tysv
         pvVZc7Hh1DiA0YaDUWMpzOdi+ih0IhrnKBINevjKrX0+S1h4WvbwnFG9MxS+ey+g0rHx
         PA4Q==
X-Gm-Message-State: AODbwcBEx9sxzVpgawXCYxabmGMNCJ0tZM0Cc5vJv+X0hX7UxKPbMSSw
        29+cE8mSVmUV5w==
X-Received: by 10.84.174.67 with SMTP id q61mr1091661plb.97.1496426143510;
        Fri, 02 Jun 2017 10:55:43 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:9141:378b:960d:5b13])
        by smtp.gmail.com with ESMTPSA id s17sm44547654pfk.112.2017.06.02.10.55.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Jun 2017 10:55:42 -0700 (PDT)
Date:   Fri, 2 Jun 2017 10:54:55 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: pushing for a new hash, was Re: [PATCH 2/3] rebase: Add tests
 for console output
Message-ID: <20170602175455.GA30988@aiede.mtv.corp.google.com>
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
 <20170531104213.16944-3-phillip.wood@talktalk.net>
 <alpine.DEB.2.21.1.1706011329350.3610@virtualbox>
 <xmqq7f0v46q3.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kaM9ryT1gWx=L6S90HPCaDPNZ6H124HAJscpeJCQFDN8Q@mail.gmail.com>
 <alpine.DEB.2.21.1.1706021442190.171564@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1706021442190.171564@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

Johannes Schindelin wrote:
> On Thu, 1 Jun 2017, Stefan Beller wrote:

>> We had a discussion off list how much of the test suite is in bad shape,
>> and "$ git grep ^index" points out a lot of places as well.
>
> Maybe we should call out a specific month (or even a longer period) during
> which we try to push toward that new hash function, and focus more on
> those tasks (and on critical bug fixes, if any) than anything else.

Thanks for offering. ;-)

Here's a rough list of some useful tasks, in no particular order:

1. bc/object-id: This patch series continues, eliminating assumptions
   about the size of object ids by encapsulating them in a struct.
   One straightforward way to find code that still needs to be
   converted is to grep for "sha" --- often the conversion patches
   change function and variable names to refer to oid_ where they used
   to use sha1_, making the stragglers easier to spot.

2. Hard-coded object ids in tests: As Stefan hinted, many tests beyond
   t00* make assumptions about the exact values of object ids.  That's
   bad for maintainability for other reasons beyond the hash function
   transition, too.

   It should be possible to suss them out by patching git's sha1
   routine to use the ones-complement of sha1 (~sha1) instead and
   seeing which tests fail.

3. Repository format extension to use a different hash function: we
   want git to be able to work with two hash functions: sha1 and
   something else.  For interoperability and simplity, it is useful
   for a single git binary to support both hash functions.

   That means a repository needs to be able to specify what hash
   function is used for the objects in that repository.  This can be
   configured by setting '[core] repositoryformatversion=1' (to avoid
   confusing old versions of git) and
   '[extensions] experimentalNewHashFunction = true'.
   Documentation/technical/repository-version.txt has more details.

   We can start experimenting with this using e.g. the ~sha1 function
   described at (2), or the 160-bit hash of the patch author's choice
   (e.g. truncated blake2bp-256).

4. When choosing a hash function, people may argue about performance.
   It would be useful for run some benchmarks for git (running
   the test suite, t/perf tests, etc) using a variety of hash
   functions as input to such a discussion.

5. Longer hash: Even once all object id references in git use struct
   object_id (see (1)), we need to tackle other assumptions about
   object id size in git and its tests.

   It should be possible to suss them out by replacing git's sha1
   routine with a 40-byte hash: sha1 with each byte repeated (sha1+sha1)
   and seeing what fails.

6. Repository format extension for longer hash: As in (3), we could
   add a repository format extension to experiment with using the
   sha1+sha1 function.

7. Avoiding wasted memory from unused hash functions: struct object_id
   has definition 'unsigned char hash[GIT_MAX_RAWSZ]', where
   GIT_MAX_RAWSZ is the size of the largest supported hash function.
   When operating on a repository that only uses sha1, this wastes
   memory.

   Avoid that by making object identifiers variable-sized.  That is,
   something like

     struct object_id {
     	union {
	  unsigned char hash20[20];
	  unsigned char hash32[32];
	} *hash;
     }

   or

     struct object_id {
       unsigned char *hash;
     }

   The hard part is that allocation and destruction have to be
   explicit instead of happening automatically when an object_id is an
   automatic variable.

8. Implement
   http://public-inbox.org/git/20170307001709.GC26789@aiede.mtv.corp.google.com/
   :)  I'd like to send a breakdown of that too, but that probably
   should happen in a separate message.

9. We can use help from security experts in all of this.  Fuzzing,
   analysis of how we use cryptography, security review of other parts
   of the design, and information to help choose a hash function are
   all appreciated.

> I also wonder how we can attract (back) cryptographic talent to help us
> avoid repeating mistakes when picking a new hash algorithm.
>
> So far, the only undisputable expert opinion I read was from the Keccak
> team, and I did not have the impression that their opinion had any impact
> on the discussion. Needless to say: I think it should. Cryptography is
> hard. We proved it ;-)

Do you have some ideas in mind here?

How did you get the impression that their opinion had no impact?  We
have been getting feedback about the choice of hash function both on
and off list from a variety of people, some indisputably security
experts.  Sometimes the best one can do is to just listen.

For what it's worth my personal opinion is currently leaning toward
blake2bp-256 as choice of hash function, not SHA2 or SHA3.  But we
still have time to learn more and make a better decision.

Thanks and hope that helps,
Jonathan
