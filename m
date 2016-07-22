Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62BCC203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 17:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726AbcGVRm4 (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 13:42:56 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:37755 "EHLO
	mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488AbcGVRmz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 13:42:55 -0400
Received: by mail-it0-f45.google.com with SMTP id f6so53155408ith.0
        for <git@vger.kernel.org>; Fri, 22 Jul 2016 10:42:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LFz2R+9aVVsMYHPEMgflk8j7+LP+3S0f/SDFPOvTVCQ=;
        b=NtXOo7/ylHnmyjVUYJOs7kD82BwzQ/khNuSHoOEJGoeWR+d0snRkHLfocXnL7A/TyN
         AMW7l3Uy9XPXl5RzRLjU8yv+H4b8pMy6Pz+KTHPquKXZH1t6nGljps3mlFDJ+74rMmGm
         7mrsMAiloyqc4ZXwY7SuEAXG2Zp/o6lAAt5ffeF/SYLHh5s0uIRRf4eux8TZm2k/N6mq
         plz1h4ZchoGMucqYcMUe3SkOB6vr4Ada3hZ0mi8sfgNr4EAm1DYJ/GV5GSJGfss8l4zF
         cVPrxWiXHctN/r/mejM8ilzHhH/c3gBDI5sbxKys6DclM6P40lVdXa8rAXs3yJ9nb/lo
         GO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LFz2R+9aVVsMYHPEMgflk8j7+LP+3S0f/SDFPOvTVCQ=;
        b=EIqkU5l+dM+ngP3p6mPFFyDPlty8WfcE3VJzqVLFi2CWzrtQYCr6/YgJ7pCVYOe6U5
         dSQ8JP2ZfhtTAVALnWU93jG8ej/uwr8MqhJ8ERjGQqb4eVZPY10F9rW4yGQgk6SJGOzN
         Sy4amnYGLiiuOCBw6ZAvgxMs/BdOfMX8OP8ZZTIYvOtwVbVDafSuZ06tgeuXGBkn/Ltx
         P5+8zSlem9Y065MCnyYx6jZU+LjRYCcA+scOrjfxqG2JGiIp9TpAy9h564vikBCo2sF5
         b1bRqVAb+ZPC7TGWKVtMMps0T1Xa5n4Ej2fKbaErSk4aOCCSjdSMI1cYwSWtp2eCy2JN
         y35Q==
X-Gm-Message-State: AEkoousdNDuC6DQ71cO0bLj9Rn+7oodJbjayTk69Be+EeFByiv2cx4e0f/93GWbDtZ/BO4+MMoPOPVFB8gKibQ==
X-Received: by 10.36.81.15 with SMTP id s15mr5863867ita.57.1469209374445; Fri,
 22 Jul 2016 10:42:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Fri, 22 Jul 2016 10:42:25 -0700 (PDT)
In-Reply-To: <CAGZ79ka-isR4DL7ZqOp8cXE1bmUOnd33yu=pZZHaqNmPWH3PYQ@mail.gmail.com>
References: <CACsJy8ADRWNL3FR2TtWShviT4Lc4m1xaY8VOPP26Foyq+_A-3g@mail.gmail.com>
 <20160720172419.25473-1-pclouds@gmail.com> <20160720172419.25473-4-pclouds@gmail.com>
 <CAGZ79kZB8U+ERNeYpZ-i7Ldip7xbz0ND53g4bzMkzFC3pnyv+w@mail.gmail.com>
 <CACsJy8CSnmnzDMGpMvvkhWRfJvp1L+pfOZ=eYp5JF0GWNH6D0Q@mail.gmail.com> <CAGZ79ka-isR4DL7ZqOp8cXE1bmUOnd33yu=pZZHaqNmPWH3PYQ@mail.gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Fri, 22 Jul 2016 19:42:25 +0200
Message-ID: <CACsJy8DKEV3FNmb1vWinRvb-FHSO_VftG7RevQ3TOFhP-Dm0cw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] submodule: support running in multiple worktree setup
To:	Stefan Beller <sbeller@google.com>
Cc:	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Max Kirillov <max@max630.net>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 22, 2016 at 7:25 PM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Jul 22, 2016 at 10:09 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>
>> I just quickly glanced through the rest of this mail because, as a
>> submodule ignorant, it's just mumbo jumbo to me. But what I see here
>> is, there may be problems if we choose to share some submodule info,
>> but I haven't seen any good thing from sharing any submodule info at
>> all.
>
> Okay. :(

Didn't mean to make you feel sad :)


> I assume the sharing is beneficial. (As a work-tree ignorant) I thought
> we had this main work tree, which also holds the repository, whereas
> the other working trees have a light weight implementation (e.g. just
> a .git file pointing back to the main working tree/git dir).

The main worktree is special for historical reason. But from the user
point of view (and even developer's at a certain level) they should be
treated equally. Think of it like cloning the same repo multiple
times. Only now you save disk space because there's only one object
database.

> So in a way my mental model is more like the config sharing here
> You can configure things in ~/.gitconfig for example that have effects
> on more than one repo. Similarly you would want to configure things
> in one repo, that has effect on more than one working tree?
>
> And my assumption was to have the repository specific parts be shared,
> whereas the working tree specific things should not be shared.

I think that's a good assumption. Although I would rather be not
sharing by default and let the user initiate it when they want to
share something. Like ~/..gitconfig, we never write anything there
unless the user asks us to explicitly (with git config --user).
Accidental share could have negative effect.

>> I can imagine long term you may want to just clone a submodule repo
>> once and share it across worktrees that use it, so maybe it's just me
>> not seeing things and this may be a step towards that.
>
> Just as Junio put it:
>> I agree that when a top-level superproject has multiple worktrees
>> these multiple worktrees may want to have the same submodule in
>> different states, but I'd imagine that they want to share the same
>> physical repository (i.e. $GIT_DIR/modules/$name of the primary
>> worktree of the superproject)---is everybody involved in the
>> discussion share this assumption?
>
> I agree with that as well.

Yeah. We have a long way to go though. As I see it, you may need ref
namespace as well (so they look like separate clones), which has never
been used on the client side before. Either that or odb alternates...

>> And because I have not heard any bad thing about the new config
>> design, I'm going to drop submodule patches from this series and focus
>> on polishing config stuff.
>
> Oh, sorry for not focusing on that part. The design of git config --worktree
> is sound IMO.

This makes me happy (I know other people can still find flaws in it,
and I'm ok with that). This config split thing has been wrecking my
brain for a long time, find the the "right" way to do with minimum
impacts :)
-- 
Duy
