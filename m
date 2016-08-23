Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 543452018E
	for <e@80x24.org>; Tue, 23 Aug 2016 20:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755645AbcHWUZA (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 16:25:00 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36663 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754598AbcHWUY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 16:24:59 -0400
Received: by mail-wm0-f52.google.com with SMTP id q128so177097857wma.1
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 13:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=08RgoSwjL23iGfbfCV+YwY+5+LMB+42aCU3ip6VwUT4=;
        b=mpc09NJ47ZrioeP0XIGH2pcyMz0OghP+ICn1v7F//SZKvsXesf/WMwIgGI37L/V31N
         FfiA6sl1Kp6EJdKIuOnBM94tAS+2Selg2+EWqDKIDGa197OPzv0ulZ149REe64jwP/6U
         NBF0slNS3LemsnBK299cin3cGjSMkO0OsQoP6cmK2/7tbcegD8oiUUdOcwXWi2UmZFUl
         wpEBtB+KMMT8QQmL5N0P8gsdpS8AqSbEFx5e0p2sD4Nlq/zg0HQHo/0scrCHQWvb1ErL
         tPOr0nlYtblB/De2D+PWDm0uiblUNOVXDhOYuiutwmIcJHMaM39YiTqLTZZ1NbC2Cgbn
         7s7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=08RgoSwjL23iGfbfCV+YwY+5+LMB+42aCU3ip6VwUT4=;
        b=aeScP6EdY3/UoXVfTph56Tl9Iw4hg1Si/J5EfKv5G459ebRqh/z3pwq/kuDK0zuYSW
         0kOnnJFUuIO4HpTqZnXhm4q6GhrotovQWLubu7lloXlSus6WdLZrcT/LOiF6phB4eMjp
         N7qfsd9BZ5HzUif/A0nHBqbmL+jFw9QppCFZqg2QTiE2K39NB3Xh/cZMW4vpM3OeJeOA
         RsflUZtHfPVhZu1RTue18sZq9//qXOK04EQpQHCgPHWIaAAD6dhcRkWhiLhF8g2kguQZ
         EwL9plzbxlSOeCIy6bN4rAFMl1Ik1uNsmlXWqSjzi1EUGcZTYl8eYGvDJdRLXbGMgqkr
         G6Pw==
X-Gm-Message-State: AEkooutazIwD8JldPlBcXwqKJ5NCO82soIorkRN7PjGLCESQGXL8OCKIDc3beYK8ANzkGg==
X-Received: by 10.194.116.1 with SMTP id js1mr26023287wjb.183.1471983897405;
        Tue, 23 Aug 2016 13:24:57 -0700 (PDT)
Received: from [192.168.1.26] (dgr170.neoplus.adsl.tpnet.pl. [83.23.173.170])
        by smtp.googlemail.com with ESMTPSA id 3sm6387525wms.1.2016.08.23.13.24.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Aug 2016 13:24:56 -0700 (PDT)
Subject: Re: Extending "extended SHA1" syntax to traverse through gitlinks?
To:     Josh Triplett <josh@joshtriplett.org>
References: <9bad3d13-3257-2077-a734-f985c375b8d3@gmail.com>
 <20160821142634.dorgzldjvc3qiaby@x>
 <ab6e29c1-ea6d-c1c5-e69f-867c16cc736a@gmail.com>
 <20160823065359.34cirqig56fugnwy@x>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <b2f7ff11-23b4-1065-2207-43f736c91988@gmail.com>
Date:   Tue, 23 Aug 2016 22:24:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160823065359.34cirqig56fugnwy@x>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 23.08.2016 o 08:53, Josh Triplett pisze:
> On Mon, Aug 22, 2016 at 08:39:19PM +0200, Jakub Narębski wrote:
>> W dniu 21.08.2016 o 16:26, Josh Triplett pisze:
>>> On Sun, Aug 21, 2016 at 03:46:36PM +0200, Jakub Narębski wrote:
>>>> W dniu 21.08.2016 o 00:50, Josh Triplett pisze:
>>>>>
[...]
>>>> And with the above manual resolving, you can see the problem with
>>>> implementing it: the git-cat-file (in submodule) and git-rev-parse
>>>> (in supermodule) are across repository boundary.
>>>
>>> Only if the gitlink points to a commit that doesn't exist in the same
>>> repository.  A gitlink can point to a commit you already have.
>>
>> The idea of submodules is that tree object in superproject includes
>> link to commit of subproject (so called gitlink).  Tree object is
>> in superproject repository, while gitlinked commit is in submodule
>> repository.
>>
>> True, with modern Git the submodule repository is embedded in .git
>> area of superproject, with '.git' in submodule being gitling file,
>> but by design those objects are in different repositories, in different
>> object databases.
> 
> git-submodule handles them that way by default, yes.  But a gitlink
> doesn't inherently have to point to a separate repository, and even a
> submodule could point to an object available in the same repository
> (perhaps via another ref).
> 
> git-series creates such gitlinks, for instance.

The point is that submodule has it's own object database.  It might
be the same as superproject's, but you need to handle submodule objects
being in separate submodule repository anyway.  Common repository is
just a special case.

By the way, this also means that proposed "extended extended SHA1"
syntax would be useful to user's of submodules...

>>>> Also the problem with proposed syntax is that is not very visible.
>>>> But perhaps it is all right.  Maybe :/ as separator would be better,
>>>> or using parentheses or braces?
>>>
>>> It seems as visible as the standard commit:path syntax; the second colon
>>> seems just as visible as the first.  :/ already has a different meaning
>>> (text search), so that would introduce inconsistency.
>>
>> Actually ":/" has a special meaning only if it is at beginning:
> 
> True, but it seems inconsistent to have :/ mean search if at the
> beginning, or traversal if not.

Right.  It would also mean that if we have directory or submodule
called 'foo:', then 'foo:/bar' would be ambiguous where it was not
before.

BTW. currently there is not much need for quoting, at least not for
the ':' as separator.  Files with ':' in them, even if they are
named 'HEAD:foo' can be distinguished with ./HEAD:foo, or with
':(top)HEAD:foo'.  This would not be the case if supermodule to
submodule separator was ':'; the '//' is safe-ish.

Also, '//' would have additional meaning, in that left hand side
and right hand side are in [possibly] different repositories.


Sidenote (on MS Windows):
 samsung@notebook MINGW64 ~/test (master)
 $ echo 'HEAD:A..B' >'HEAD:A..B'

 samsung@notebook MINGW64 ~/test (master)
 $ git add 'HEAD:A..B'
 fatal: pathspec 'HEAD:A..B' did not match any files

 samsung@notebook MINGW64 ~/test (master)
 $ ls
 A  A..B  B  HEAD:A..B  file  sub/  subm/


>> But perhaps '//' would be better.
> 
> That does seem unambiguous, and it can't conflict with an existing file.
> Does it seem reasonable to allow that for the initial commit as well
> ('committish//file', as well as 'commit//gitlink//file')?

I don't think we can change this without breaking scripts (because it
would be breaking backward compatibility).  And adding new syntax...

The problem might be shells sanitizing input, that is turning '//'
into '/' before passing it to command; I don't know if it is a problem.
Probably not.

> Also, while that handles traversal into the tree contained in the
> gitlinked commit, what about navigating by commit (using '~' and '^',
> for instance)?  Does it seem reasonable to allow those as well, perhaps
> only if you use // to reach the gitlink?  For instance,
> 'commit//gitlink~3', or 'commit//gitlink^{tree}'?

I don't know which of those work, and which do not:

  HEAD:path/to/submodule~3
  :0:path/to/submodule^{tree}
  HEAD~3:path/to/submodule

But I think the following should work:

  v1.0.1~2^2~4:path/to/submodule~3//inner/subm~4//sub/file


NOTE that the syntax allows to start at revision, at the index state
of superproject, but it only goes to state recorder, or to be recorded
in the superproject.  There is no syntax to find out HEAD or index
version of submodule, unless you are within submodule, isn't it?

Best,
-- 
Jakub Narębski

