Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24129203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 14:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756631AbcG0OiQ (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 10:38:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34251 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756604AbcG0OiN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 10:38:13 -0400
Received: by mail-wm0-f65.google.com with SMTP id q128so6790307wma.1
        for <git@vger.kernel.org>; Wed, 27 Jul 2016 07:38:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=s5H7SVgs6tUzZVyyPSC3fSbUw96mo/lDS28KV3g2LpQ=;
        b=NF5AK1MJQOYKPn+NOYk4dAvXckbASBAgORAvbO9eJ77GZpwMtDJpaD+f3CaYb429PK
         MQXKkQKFAMSEG8WR62P2dEkmj/Q9clpAYLJBWgeSfDPWnTMLHS/kFo94iveqKs/smtQD
         E4LAdR4sBCIaVR9gzriX7HEHXW4tVkldUr6HtsNj4jzuVy63CKhSJwG82I61Ep7TACVK
         caASioFmmpCqNIGciIXvJ4PHR8xRB3NmllTLKcflJOmFEEKigRyNcOpw4blLODlSUCib
         CjgiWM9TcnIakgzHpgT/ElxI3uqEzXwNw/GUpdCYCb7zAROUKRckBMEzWMJAuaYwUxng
         SAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=s5H7SVgs6tUzZVyyPSC3fSbUw96mo/lDS28KV3g2LpQ=;
        b=V2w/t09jkvztpUTf+eYIE7xEx/2VHewtmUpcPPv/oEnmIB+DVWSXMyRUk11Bmp8vbs
         fda43InGrlCyu3NiGHsdSW2qkV4X3xKFfb5Or//Y176+2mGSLp/PZg7ENxYA4nGnIsFe
         xODyXCTI84x9QvScfcrLb/DI1yXvfdDdaelCA7cwUdx915fhXlyvI3JgQt3o5BDt16PP
         vEKtdbuHsSa8pctKpYaSJqn+pPKjoaVgk5uJpt/WOpGLjteJwGkOflsqKR6ZY7grLGa/
         cCj6p10zdUNtCg3UdSvQ3NtH8MftuF1kc1wPDAO7pfAHFbVO9dcBkw3BoKmdM94sS9fQ
         vxXw==
X-Gm-Message-State: AEkooutzRHgN40X1vszspZS/u/k7gSjOtuaBqnldRpMr8zezCjNlWqt8HyvEEryfaVn8Eg==
X-Received: by 10.194.110.229 with SMTP id id5mr30738704wjb.23.1469630291853;
        Wed, 27 Jul 2016 07:38:11 -0700 (PDT)
Received: from [192.168.1.26] (eps206.neoplus.adsl.tpnet.pl. [83.20.60.206])
        by smtp.googlemail.com with ESMTPSA id g184sm38699913wme.15.2016.07.27.07.38.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jul 2016 07:38:10 -0700 (PDT)
Subject: Re: [PATCH v4 3/4] submodule: support running in multiple worktree
 setup
To:	Stefan Beller <sbeller@google.com>, Duy Nguyen <pclouds@gmail.com>
References: <CACsJy8ADRWNL3FR2TtWShviT4Lc4m1xaY8VOPP26Foyq+_A-3g@mail.gmail.com>
 <20160720172419.25473-1-pclouds@gmail.com>
 <20160720172419.25473-4-pclouds@gmail.com>
 <CAGZ79kZB8U+ERNeYpZ-i7Ldip7xbz0ND53g4bzMkzFC3pnyv+w@mail.gmail.com>
 <CACsJy8CSnmnzDMGpMvvkhWRfJvp1L+pfOZ=eYp5JF0GWNH6D0Q@mail.gmail.com>
 <CAGZ79ka-isR4DL7ZqOp8cXE1bmUOnd33yu=pZZHaqNmPWH3PYQ@mail.gmail.com>
 <CACsJy8DKEV3FNmb1vWinRvb-FHSO_VftG7RevQ3TOFhP-Dm0cw@mail.gmail.com>
 <CAGZ79kYbmoKPAPMVkTUycSKVtT6HLK-Y_eGXSX+z69G3+udR8Q@mail.gmail.com>
 <CACsJy8DgeSOh-RScmcrSwy7PgeQXwA2R6w9mRmHzuWR4djg=4w@mail.gmail.com>
 <CAGZ79kYGj7q=SQyHvFdmXasJppTVw56xSBMiSERdx22B+A68gQ@mail.gmail.com>
Cc:	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Max Kirillov <max@max630.net>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <5798C744.5080308@gmail.com>
Date:	Wed, 27 Jul 2016 16:37:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYGj7q=SQyHvFdmXasJppTVw56xSBMiSERdx22B+A68gQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-26 o 20:15, Stefan Beller pisze:
> On Tue, Jul 26, 2016 at 10:20 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Tue, Jul 26, 2016 at 1:25 AM, Stefan Beller <sbeller@google.com> wrote:
>>> So what is the design philosophy in worktrees? How much independence does
>>> one working tree have?
>>
>> git-worktree started out as an alternative for git-stash: hmm.. i need
>> to make some changes in another branch, okay let's leave this worktree
>> (with all its messy stuff) as-is, create another worktree, make those
>> changes, then delete the worktree and go back here. There's already
>> another way of doing that without git-stash: you clone the repo, fix
>> your stuff, push back and delete the new repo.
>>
>> I know I have not really answered your questions. But I think it gives
>> an idea what are the typical use cases for multiple worktrees. How
>> much independence would need to be decided case-by-case, I think.
> 
> Thanks!

Hopefully the Git User's Survey 2016 would answer what people really
use worktrees for, and what use submodules for.  You are welcome to
submit proposed questions for the survey:
  http://thread.gmane.org/gmane.comp.version-control.git/299032

> My sudden interest in worktrees came up when I learned the
> `--reference` flag for submodule operations is broken for
> our use case, and instead of fixing the `--reference` flag,
> I think the worktree approach is generally saner (i.e. with the
> references you may have nasty gc issues IIUC, but in the
> worktree world gc knows about all the working trees, detached
> heads and branches.)

I think the problem with `--reference` is that it does not
setup backreferences to prevent gc removing borrowed objects;
which is a hard problem to solve, except for limited cases...
like git-worktree.
 
> So I think the current workflow for submodules
> may need some redesign anyway as the submodule
> commands were designed with a strict "one working
> tree only" assumption.
> 
> Submodule URLs  are stored in 3 places:
>  A) In the .gitmodules file of the superproject
>  B) In the option submodule.<name>.URL in the superproject
>  C) In the remote.origin.URL in the submodule
> 
> A) is a recommendation from the superproject to make life
> of downstream easier to find and setup the whole thing.
> You can ignore that if you want, though generally a caring
> upstream provides good URLs here.

Also, this URL might have change if the repository moves
to other server; even when checking out ancient version
we usually want to use current URL, not the one in currently
checked-out .gitmodules file.
 
> C) is where we actually fetch from (and hope it has all
> the sha1s that are recorded as gitlinks in the superproject)

Is it? Or is it only the case if you do `git fetch` or
equivalent from within inside of submodule? You can fetch
updates using `git submodule ...` from supermodule, isn't it?
But I might be wrong here.

Also: if .git file is gitfile link, do submodule even has
it's own configuration file?

> 
> B) seems like a hack to enable the workflow as below:

It has overloaded meaning, being used both for current URL
of submodule as seen in supermodule, AND that submodule
is checked out / needs to be checked out in the worktree
of a supermodule.  There might be the case when you check
out (in given worktree) a version of a supermodule that
do not include submodule at all, but you want to know that
when going back, this submodule is to be checked out (or not).

The second information needs to be per-worktree. How to
solve it, be it per-worktree configuration (not shared),
or a special configuration variable, or worktree having
unshared copy of configuration -- this what is discussed.

> Current workflow for handling submodule URLs:
>  1) Clone the superproject
>  2) Run git submodule init on desired submodules

Or 1-2) clone the superproject recursively, with all its
submodules.

>  3) Inspect .git/config to see if any submodule URL needs adaption

Which is usually not needed.

>  4) Run git submodule update to obtain the submodules from
>     the configured place

Or 2+4) run `git submodule update --init`

>  5) In case of superproject adapting the URL
>     -> git submodule sync, which overwrites the submodule.<name>.URL in the
>     superprojects .git/config as well as configuring the
>     remote."$remote".url in the submodule

This takes information from current .gitmodules, isn't it?

>  6) In case of users desire to change the URL
>     -> No one command to solve it; possible workaround: edit
>     .gitmodules and git submodule sync, or configure  the submodule.<name>.URL
>     in the superprojects .git/config as well as configuring the remote."$remote".url in
>     the submodule separately. Although just changing the submodules remote works
>     just as well (until you remove and re-clone the submodule)
[...]


> "Moving back" sounds like you use the worktree feature for short lived
> things only. (e.g. in the man page you refer to the hot fix your boss wants
> you to make urgently).
> 
> I thought the worktree feature is more useful for long term "branches",
> e.g. I have one worktree of git now that tracks origin/master so I can
> use that to "make install" to repair my local broken version of git.
> 
> (I could have a worktree "continuous integration", where I only run tests
> in. I could have one worktree for Documentation changes only.)
> 
> This long lived stuff probably doesn't make sense for the a single
> repository, but in combination with submodules (which is another way
> to approach the "sparse/narrow" desire of a large project), I think
> that makes sense, because the "continuous integration" shares a lot
> of submodules with my "regular everyday hacking" or the "I need to
> test my colleague work now" worktree.

One thing that git-worktree would be very useful, if it could work
with submodules: you could use separate worktrees to easily test
if the supermodule works with and without its submodules present.
 
[...]
> If you switch a branch (or to any sha1), the submodule currently stays
> "as-is" and may be updated using "submodule update", which goes through
> the list of existing (checked out) submodules and checks them out to the
> sha1 pointed to by the superprojects gitlink.

Which might be simply a problem that submodule UI is not mature enough.
I would like to see automatic switch of submodule contents, if 
configured so.

-- 
Jakub Narębski

