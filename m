Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D424A20966
	for <e@80x24.org>; Tue, 21 Mar 2017 20:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933676AbdCUUs3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 16:48:29 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34088 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932478AbdCUUs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 16:48:27 -0400
Received: by mail-wm0-f66.google.com with SMTP id u132so5273713wmg.1
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 13:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9zgHs/QQ27/KmRUWbgRhfiV5RXtn0fnyoP5bj0LSY1o=;
        b=SRdrkxPIOdx2fGHC7NOo6sFkaSPuYEz7xCEyhbaye9KoCxNU/y3Zmm2bhsv/Uvr42V
         0B8y/t1xAf/cmasAhQycYtYYj2nA15q5Pz+tQ6olNMb+EZeJFaq91936ucUZyWjh4OaO
         BuHL9wkKfdNzARCV6D6n7fbE95byT5bfCRtOovZw7Td8i0TsbKMQAm1ljwE7IGKOzzQJ
         SSKMjz7318w1+XImXXjBkwD3vfhqiiAC11GLanD+t7mXegLkVxGeibdP77e2+J00rYnM
         ky5VZipk9RZX4BfPsBzz04hyvh0o45a1edTlrI3SV8OhkOjU88KqxNazzZOA94uBPYhC
         lO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9zgHs/QQ27/KmRUWbgRhfiV5RXtn0fnyoP5bj0LSY1o=;
        b=KwtvH+pAPHK4yWCKXZL76K5W/1s1uvUjwP84Aw98rPG8i85qxLOUh2XT2RAO7kxUmW
         jPmadg1zIqxwcahVXoy9F1mIhgTlaYDryo516EqdxyXxGhVz7yuy9q+Bup/eXGhqfBCW
         iNraSUlNtEX72V5rhh+I1cE4ZadV86GOfzisjfMggCnLqbqq2R44N8xaKU2nTKkeMKAY
         bS/6qFGN3+/KzTEd9rmz4J1N3XzgDtqKaAEA2m8Rc5FaoTu2zUHMnkll2XLwujmOVzIi
         OpurhHlMS9DhRpSR4Jdg3O2OEkiM3/dwSwX4vHHuXgWMTPOqj+0FHlpXqQNVXzV88nXU
         eakw==
X-Gm-Message-State: AFeK/H0a8/gx2UxhnBFkogEBm683DrtEudzK2W7KGLIsRIgGApGAG3r+a1JQnCmxnZwJEQ==
X-Received: by 10.28.137.208 with SMTP id l199mr4307264wmd.65.1490129305815;
        Tue, 21 Mar 2017 13:48:25 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id l21sm26278638wrl.59.2017.03.21.13.48.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Mar 2017 13:48:25 -0700 (PDT)
Date:   Tue, 21 Mar 2017 20:48:42 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH/RFC 1/3] stash: show less information for stash push --
 <pathspec>
Message-ID: <20170321204842.GD27158@hank>
References: <20170318183658.GC27158@hank>
 <20170319202351.8825-1-t.gummerer@gmail.com>
 <20170319202351.8825-2-t.gummerer@gmail.com>
 <xmqqk27jx2ej.fsf@gitster.mtv.corp.google.com>
 <20170320184855.x7m2gxwdqdt3lnet@sigill.intra.peff.net>
 <xmqqtw6nvip1.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtw6nvip1.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/20, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Mon, Mar 20, 2017 at 10:51:16AM -0700, Junio C Hamano wrote:
> >
> >> > diff --git a/git-stash.sh b/git-stash.sh
> >> > index 9c70662cc8..59f055e27b 100755
> >> > --- a/git-stash.sh
> >> > +++ b/git-stash.sh
> >> > @@ -299,10 +299,10 @@ push_stash () {
> >> >  	then
> >> >  		if test $# != 0
> >> >  		then
> >> > -			git reset ${GIT_QUIET:+-q} -- "$@"
> >> > +			git reset -q -- "$@"
> >> >  			git ls-files -z --modified -- "$@" |
> >> >  			git checkout-index -z --force --stdin
> >> > -			git clean --force ${GIT_QUIET:+-q} -d -- "$@"
> >> > +			git clean --force -q -d -- "$@"
> >> >  		else
> >> >  			git reset --hard ${GIT_QUIET:+-q}
> >> >  		fi
> >> 
> >> Yup, we only said "HEAD is now at ..." in the non-pathspec case (and
> >> we of course still do).  We didn't report changes to which paths
> >> have been reverted in (or which new paths are removed from) the
> >> working tree to the original state (and we of course still don't).
> >> 
> >> The messages from reset and clean that reports these probably do not
> >> need to be shown by default to the users (they can always check with
> >> "git stash show" when they are curious or when they want to double
> >> check).
> >
> > I'm not sure if you are arguing here that the non-pathspec case should
> > move to an unconditional "-q", too, to suppress the "HEAD is now at"
> > message.  But I think that is a good suggestion. It would make the two
> > cases consistent, and it is not really adding anything of value (it is
> > always just HEAD, and if you do not provide a custom message, the
> > short-sha1 and subject are already in the "Saved..." line above).
> 
> I wasn't suggesting it (I was just saying that these extra messages
> are not something we found necessary for consistency with the
> original codepath when we added the pathspec support).  I wasn't
> even thinking about what the original codepath did, i.e. when the
> command is run without pathspec.
> 
> I too suspect that most of the ${GIT_QUIET:+-q} can just become an
> unconditional -q as you do.

Thanks both, I do agree that passing -q unconditionally is probably
the right thing to do.  Will do that, and also pass -q unconditionally
to the git reset I addressed in 2/3 here in the re-roll.
