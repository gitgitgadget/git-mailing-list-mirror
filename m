Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2349C1F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 13:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755111AbcHXNRD (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 09:17:03 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:33156 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754119AbcHXNRC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 09:17:02 -0400
Received: by mail-wm0-f54.google.com with SMTP id d196so33184916wmd.0
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 06:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=zX1atcYijoKeZxj2sTCD/6BrD0h4Mu6j81l5YvlCQZw=;
        b=tTnSW2O6PZP050UBbr1StjLg2CqYNukCD6DytBgvQwsBETD+P1TWjtjBwOHA/p5D52
         wwfHfU9EhDu+gM7/9Y6njjWPhlU9D1oAGQK+38/NHnB8gPqEF4wDLapn6FLb8C/1BLYa
         ojQhBWBat1cKP+G5veF9CEySQfo51VjRrLgKvaY5jL9n6TsAPeXstlvMpc/NfovNQvL4
         VF9yXcDBWa38a4+al4MO/mEzr3oHfbOMzyQ/Y2HJOBuDbl66mdzqL6I+bUQClBAzp//A
         2kTaWpNSDefLW3YpBAK5/i8dw/LbIAZIwmHo8ZzBegf5w6R8RBIKj4tk44v+TQwZjBg8
         2edw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=zX1atcYijoKeZxj2sTCD/6BrD0h4Mu6j81l5YvlCQZw=;
        b=RlqTy+fVyC7fZJ71FrZTTBjGP/ltaqeMQTYRHicAsxWZVvDdwY3yZziif0QN/58MIg
         hwsyYCcQ++2FI7DLHa+qi/81TAnot3kR/hA5cUvwP7rZO/IaH1lg54JUl9JaV9Pqt+PO
         zaPs3bZlP7Q2KRQewZ+7EsT5fFy8hS6lrPRkhmp2SX5DNB043+Azy8UPPJnHf8CsYWus
         QhdPwv2ymxgGYygPM4FQYWf7kroKqjsyjBXTkvNx+Ix9rHoeTn7Mp7JXrexiEc4K+9rh
         XP9te1BYFV1R10XYReCc89565A2fhZu3Ywio9YJ2IjM7OJ2b4/xBwycN1mzEeivr4Uyd
         1CxQ==
X-Gm-Message-State: AEkoouvXgwwuEj1CHiUduV0DIPZyhfEdtKwUOWNKsKhQPxCeULBguiYDi4HArjJGmZGH9A==
X-Received: by 10.194.120.164 with SMTP id ld4mr2715894wjb.81.1472044620511;
        Wed, 24 Aug 2016 06:17:00 -0700 (PDT)
Received: from [192.168.1.26] (epy16.neoplus.adsl.tpnet.pl. [83.20.66.16])
        by smtp.googlemail.com with ESMTPSA id c139sm33655293wme.4.2016.08.24.06.16.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Aug 2016 06:16:59 -0700 (PDT)
Subject: Re: Extending "extended SHA1" syntax to traverse through gitlinks?
To:     Junio C Hamano <gitster@pobox.com>
References: <9bad3d13-3257-2077-a734-f985c375b8d3@gmail.com>
 <20160821142634.dorgzldjvc3qiaby@x>
 <ab6e29c1-ea6d-c1c5-e69f-867c16cc736a@gmail.com>
 <20160823065359.34cirqig56fugnwy@x>
 <b2f7ff11-23b4-1065-2207-43f736c91988@gmail.com>
 <xmqq60qqu3rl.fsf@gitster.mtv.corp.google.com>
Cc:     Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <b264e17a-12ff-69ca-f130-78d2635a0f85@gmail.com>
Date:   Wed, 24 Aug 2016 15:16:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <xmqq60qqu3rl.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 24.08.2016 o 07:36, Junio C Hamano pisze:
> Jakub Narębski <jnareb@gmail.com> writes:
> 
>> The point is that submodule has it's own object database.  It might
>> be the same as superproject's, but you need to handle submodule objects
>> being in separate submodule repository anyway.  Common repository is
>> just a special case.
>>
>> By the way, this also means that proposed "extended extended SHA1"
>> syntax would be useful to user's of submodules...
> 
> Not really.
> 
> I think that you gave a prime example why <treeish>:<path1>//<path2>
> is not a useful thing for submodules.  When the syntax resolves to a
> 40-hex object name, that object name by itself is not useful.
> 
> You also need to carry an additional piece of information that lets
> you identify the location of the repository, in which the object
> name is valid, in the current user's context (i.e. somewhere in the
> superproject where the submodule lives).  In other words, you'd need
> to carry <treeish>:<path1> around anyway for the object name to be
> useful, so there is no good reason why anybody should insist that
> the plumbing level resolve <treeish>:<path1>//<path2> directly to an
> object name in the first place.

Not really.

The above means only that the support for new syntax would be not
as easy as adding it to 'git rev-parse' (and it's built-in equivalent),
except for the case where submodule uses the same object database as
supermodule.

So it wouldn't be as easy (on conceptual level) as adding support
for ':/<text>' or '<commit>^{/<text>}'.  It would be at least as
hard, if not harder, as adding support for '@{-1}' and its '-'
shortcut.


Josh, what was the reason behind proposing this feature? Was it
conceived as adding completeness to gitrevisions syntax, a low-hanging
fruit?  It isn't (the latter).  Or was it some problem with submodule
handling that you would want to use this syntax for?

As for usefulness: this fills the hole in accessing submodules, one
that could be handled by combining plumbing-level commands.  Namely,
there are 5 states of submodule (as I understand it)

 * recorded in ref / commit in supermodule
 * recorded in the index in supermodule
 - recorded in ref / commit in submodule
 - recorded in the index in submodule
 - state of worktree in submodule

The last three can be easyly acessed by cd-ing to submodule.  The first
two are not easy to get, AFAIUC.

-- 
Jakub Narębski
