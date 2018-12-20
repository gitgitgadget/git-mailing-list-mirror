Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49DAA1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 08:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbeLTIn4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 03:43:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45701 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbeLTIn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 03:43:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id t6so793997wrr.12
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 00:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SIIeS6djCFK3SxuIT1Ea61odvq84hHN70Jbr1JnUxgQ=;
        b=aHWrBl0vJ3Efe1mvihM8Mk3IkjK7KadSmEAiT+NYz66o3qKPITW6nREEtMq6VQb78P
         djO0eE+zFjZs9uWjgSpgCKaIkafp2jQnYmWZ4C4k26VPHRhNzIZfOnXZ5aRqXEh5huzK
         swbgfTwVJ+fhDP9p+a+64SJjSeB81hYmDuEYdR3WEpNiK6zRimkBHU33X6i3AWmWUBMU
         ZkpljSO1gowhj7/HOGOD+4My6YCh0N65m64gIAtVTEMSnOoVh+p1l4yKZDV72KRnCwLc
         VBxaVvvR7A+jRy0DQCcUQWwbRHSy3epDM7klN+bgdcM8HRYXnr7USXPL1uGS3UgN5k0Y
         cxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SIIeS6djCFK3SxuIT1Ea61odvq84hHN70Jbr1JnUxgQ=;
        b=hJdtKBn1MUKWT+3yiQKC8wVPv554vZLBGENLA1jBxgSyRO/5odSF98ey4H/SLTnzgt
         jOe+/AKG3vRtl1PJJ2aGE0lhew7LfZdoSky01N8XdJMYgmcEUZSeJkB6mq2AIX9d9Bt9
         Xe2ZoGN4OgrbhvdO7zo/gQWm5iRpTsV2NUBa89QLr3arNsF/sG/BG/FlSxpKk5zi8DCL
         Cg1uQvSIBJK2Un2F2uRzhSwo6+la6yVE2jXGvadJTg62rtekj0BRrUqWSxCizWQCmw63
         UQHnnbZfJCOizrpmxOmpNaC1+K50I7QPkt2yYGqSL0b09jCvqVbK0uQ8q2NqUeJsqgcA
         mq4w==
X-Gm-Message-State: AA+aEWau/MhAY0agRA13W6hnE2+1r5N65MOQd6NmsPFZM4xv/DlF+ewU
        hUxafQktaxFZaJXtUENCs+I=
X-Google-Smtp-Source: AFSGD/UU9wbBJ2jX3VjUVrXokieLUtNK+6QeGE2ZYMYIp2SxVRXZnu/DmR26sEBSyQbyUl5eCrgafg==
X-Received: by 2002:adf:dfd1:: with SMTP id q17mr22791049wrn.27.1545295433969;
        Thu, 20 Dec 2018 00:43:53 -0800 (PST)
Received: from localhost (host174-110-dynamic.249-95-r.retail.telecomitalia.it. [95.249.110.174])
        by smtp.gmail.com with ESMTPSA id y13sm7972397wme.2.2018.12.20.00.43.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 00:43:52 -0800 (PST)
Date:   Thu, 20 Dec 2018 08:43:51 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/8] introduce no-overlay and cached mode in git checkout
Message-ID: <20181220084351.GA8083@hank.intra.tgummerer.com>
References: <20181209200449.16342-1-t.gummerer@gmail.com>
 <xmqqa7le2gc2.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa7le2gc2.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > Basically the idea is to also delete files when the match <pathspec>
> > in 'git checkout <tree-ish> -- <pathspec>' in the current tree, but
> > don't match <pathspec> in <tree-ish>.
> 
> I cannot quite parse it, but perhaps.
> 
> 	"git checkout --no-overlay <tree-ish> -- <pathspec>" can
> 	remove paths in the index and in the working tree that match
> 	<pathspec>, if they do not appear in <tree-ish>.
> 
> If a new file D/F is in the index and in the working tree but not in
> HEAD, "git checkout HEAD D/" or "git checkout HEAD D/F" would not
> remove D/F from the index or the working tree.
> 
> With the --no-overlay option, it would, and that is often closer to
> the wish of the user who wanted to say "restore the working tree
> state of D/ (or D/F) from the state recorded in HEAD".

Yeah thanks, that reads much better.

> > The final step in the series is to actually make use of this in 'git
> > stash', which simplifies the code there a bit.  I am however happy to
> > hold off on this step until the stash-in-C series is merged, so we
> > don't delay that further.
> 
> I think that is probably a good idea, for now.
> 
> > In addition to the no-overlay mode, we also add a --cached mode, which
> > works only on the index, thus similar to 'git reset <tree-ish> -- <pathspec>'.
> >
> > Actually deprecating 'git reset <tree-ish> -- <pathspec>' should come
> > later,...
> 
> Or we may not even need to deprecate it.  IIRC, what "stash" wished
> to exist was "git reset --hard <tree-ish> -- <pathspec>", which, if
> the command followed "--cached/--index" convention, would have been
> called "git reset --index ...".  Did we actually have the need for
> "--cached" mode?

I don't have a pressing need for "--cached".  I mainly included it
because you described "git reset <tree-ish> -- <pathspec>" as bad UI
in the original thread [*1*], which after reading that message I agree
with.  It also seemed to cause some confusion in [*2*].  Since it was
fairly easy to introduce a "--cached" mode it seemed like a potential
UI improvement in the long term to deprecate 'git reset <tree-ish> --
<pathspec>'.

That said, this series is probably not the right place to introduce
this feature, as it should mainly be focused on the no-overlay mode.
I'll drop the patch from v2.

We can revisit whether we want to introduce a "--cached" mode in 'git
checkout' at some point in the future.  

> > probably not before Duy's restore-files command lands, as 'git
> > checkout --no-overlay <tree-ish> -- <pathspec>' is a bit cumbersome to
> > type compared to 'git reset <tree-ish> -- <pathspec>'.
> 
> Yes, between "checkout --cached" and "checkout --no-overlay", the
> latter is much more important, as the latter is what a missing "git
> reset --hard <tree-ish> -- <pathspec>" would have been, but the
> former can be written with an existing command.
> 
> > My hope is also that the no-overlay mode could become the new default
> > in the restore-files command Duy is currently working on.
> 
> Yup, that is my hope, too ;-).

*1*: <xmqq4loqplou.fsf@gitster.mtv.corp.google.com>
*2*: <alpine.LFD.2.21.1812081103500.29142@localhost.localdomain>
