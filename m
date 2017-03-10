Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB37D202C1
	for <e@80x24.org>; Fri, 10 Mar 2017 00:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754694AbdCJAX3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 19:23:29 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35795 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754118AbdCJAX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 19:23:28 -0500
Received: by mail-wr0-f193.google.com with SMTP id u108so9785012wrb.2
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 16:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=8xjC8G18TtmBwJJRsVGxg5awpTtVTCRkLQ2WNBZ1nvE=;
        b=aQmzA/fhMlpPvfnLC3ViVH9uXRT7AyQyn9fmp5RFDfbQkOf/WT9f/PvPFklYRW7vWE
         0b1Viu9AxX8efHVC2NnW70JBtDWfz4FgMNudY9IuSSbg19mHNFWt7GLw3Dp/vPOM1blQ
         kE2GitjKJYnB6PSd7z0wiC3HPPTGwUrb9oR2bw0Sx6mdkxJWoL9zMe4CGVjoXXAKVLle
         /WNj2Avl3ICqoISGbG3rYMzq+ohXxvBqM4my8rd2srhDzp9KEUrpds0qi7ZcVYOWzTj4
         q0MsSLxjvkbpBib06G3pMAr/GLMvtaKmQaYuQqq7AC7YRsBDRM51j21R4cadbxiSRKgp
         kVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=8xjC8G18TtmBwJJRsVGxg5awpTtVTCRkLQ2WNBZ1nvE=;
        b=JXmY1AvwCFRBkpyiO/jeoiFY7Ys6MKuxQ2JF4O5ChYIo6zMQZOsnoRyZZcR3I0uNzr
         5w+Cg8ww+KoDBJmerxOxYF5nI/3Cf712io6lJ9RjqaPfgLWqvbw1rjsPOw8yn+UFJ9Dg
         85HAV0DVtDSEg7KjKaefzdMqDmp1WUXFwo6AuE0k7zN5NacIxpGYr9Ey5z+ubOmll+yR
         sFtlboy6cVyvOT32JZeA8pA0XgkvajPnNkejL1cq1wiCzwY9oj/cRJE8qnBWzKyYVaJo
         7ROmTO479fy7foevXviJvrWn60jAJmi1s3AJi0esVRu9AdO0Dn9m3Wx62UMWV2YTW0rN
         0xJw==
X-Gm-Message-State: AMke39n/sVIsAojNOeZYVlqQ3Otq26gU+ns3PCKEQ+AJ9WdaLbyNtODY9oceLfHK3TucgQ==
X-Received: by 10.223.150.10 with SMTP id b10mr12732598wra.98.1489105401004;
        Thu, 09 Mar 2017 16:23:21 -0800 (PST)
Received: from [192.168.5.102] ([87.116.180.47])
        by smtp.gmail.com with ESMTPSA id 63sm10232888wrh.68.2017.03.09.16.23.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Mar 2017 16:23:20 -0800 (PST)
Subject: Re: Possible bug: git pull --rebase discards local commits
To:     Junio C Hamano <gitster@pobox.com>,
        Joshua Phillips <jphillips@imap.cc>
References: <1471969497.3553135.703756633.0F6CCC4C@webmail.messagingengine.com>
 <xmqqvayruvwk.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Laszlo Kiss <kisslas.git@gmail.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <85fefe0a-fe0e-cf1b-78c3-a8e2e85f53c2@gmail.com>
Date:   Fri, 10 Mar 2017 01:23:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <xmqqvayruvwk.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 23/08/2016 21:28, Junio C Hamano wrote:
> Joshua Phillips <jphillips@imap.cc> writes:
> > I've found a case where git pull --rebase discards commits in my branch
> > if the remote-tracking branch was rewound (and the remote tracking
> > branch's reflog contains my branch's latest commit). This is due to
> > git-pull's usage of git merge-base --fork-point.
> >
> > On one hand, this behaviour might be correct since the remote repository
> > essentially removed that commit from master by 'reset --hard'. On the
> > other hand, I was surprised that git pull --rebase discarded a commit in
> > my branch.
> 
> Yup, that sounds like a bad way to handle the situation.  After all,
> the upstream may have first accepted your first attempt, and then
> decided that it was premature and rewound it, expecting you to give
> an improved reroll.  But I also agree with you that it may be
> correct to drop it because the upstream already rejected it.
> 
> Since Git cannot tell between these two cases, we should play safer
> than what the current code does, I would think.

Were there any news in this regards so far? Would it be (more) 
sensible/safe to report the dropped commits, too? Something like:

  Dropping: Commit B
  Applying: Commit X
  Applying: Commit Y

... where "Applying: *" are standard "git rebase" output lines, and 
"Dropping: *" a newly proposed one (example graphs (1.1) to (1.3) 
shown below[1]).

That said, applied commits might even be considered pretty 
uninteresting here (as they`re kept/transferred over anyway), a noise 
drowning what otherwise might be really important - the dropped/lost 
ones...?

It does feel a bit scary learning that you may _silently_ lose 
commits, especially as --fork-point is used by default for both 
vanilla `git rebase` and `git pull --rebase`.

P.S. As a relatively new user, I actually just got aware of this 
behavior from another, recently posted e-mail[2], having me 
investigate further, yet thought replying here might be better as it 
got some attention already (adding author of that other e-mail, 
Laszlo Kiss, to Cc).

Regards,
Buga

[1] Example graphs:

  (1.1) ---A---B (master)
                \
                 X---Y (topic)

  (1.2)      C---D (master)
            /
        ---A---B
                \
                 X---Y (topic)

  (1.3)            X'---Y' (topic)
                  /
             C---D (master)
            /
        ---A

  Note that I didn`t use "origin/master" but just "master" on purpose, 
  as the branch being tracked doesn`t have to be a remote one, making 
  the lost local commits confusion even greater.

[2] https://public-inbox.org/git/CAO0LFki4PN8zz2xpoSpjTHJGS=NG_suQYR27EcmzEMiaCw9kuA@mail.gmail.com/
