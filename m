Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69103201C8
	for <e@80x24.org>; Mon, 13 Nov 2017 03:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751293AbdKMDHC (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 22:07:02 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:46476 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751204AbdKMDHB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 22:07:01 -0500
Received: by mail-pg0-f44.google.com with SMTP id t10so10659980pgo.3
        for <git@vger.kernel.org>; Sun, 12 Nov 2017 19:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=SW9tN2jsmuF0LA9YGKeiNHX997qAya4YrILMIqH/BNw=;
        b=Ph/k3cMIaWeCsLCj8EON5TyMt0RD5tWC7S7250EOwOcb5rL9EWyqyrdg46pRDQU/xs
         PjxpkDArz1w2gTcaVNx8SgW9DgUZBH7EDXmm+JtA420VqxM6PlY6uYztbQozm9YwjDgW
         0CHrRijc+sP+tkKvzla7KVfIOrWLcHNcom5Y+YVToXHobrdRG1ad9DmQDk8m0O25uyvE
         ieLxpG4W1DkTzrYQeVqsHjSEq6iSVCiI9CVMSVDZ1OG2FLIOlDcoUXfFsuNRteO37onO
         E5U2pWN0QGnrgiMRsp/7TqDl1GrOYa2ctIBCYLC/VPeFDOglCJVxQ8DoThVYKZfeW4Zo
         iSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=SW9tN2jsmuF0LA9YGKeiNHX997qAya4YrILMIqH/BNw=;
        b=Q2UHDL55bpYbpWwC4bqtx1HsHWJB9RaKTvYb5VedIV1CMq3nekxFCufVRlamIRP/zp
         xr5fMlSeTCGvDSOHxg0aVf+Gzf3ft6Cr+hBltuOCAX8PYHjMC48fxDKyrRBIgzfu8Y7y
         cO2Jghq1MoGNeQFBO9jvbnlnC3vxLQ/6l5VRDGY3AEeNcy+KB8LXqy81GHx0j9m8sEin
         WCUu6VriWg9SWzXfjhAtxLY6JDDJi8UiwlvLJEih2lp5nRa5dFb4PWytuuFxvMEH39HN
         aw5gOPOIweupRmG7qjtm/4QGqaaCaO+8+AnComTvz15Ww1POX8/qVM3pbGLmkNjMFTIx
         YP4w==
X-Gm-Message-State: AJaThX6L4zDp7zfJz1yIZCZ5KHRStt8djjABr+W64E+KERNZ2oCKQ4vE
        LF557af0vzCzOzY/h12WBOY=
X-Google-Smtp-Source: AGs4zMYU0VHyF0gbc8Qtw5sd8Ky3qdmYEQ+ztITTU9IlKvGFjH2FFsWrffLsx2qCmxPoCvVrQN9ARA==
X-Received: by 10.98.15.155 with SMTP id 27mr8339584pfp.82.1510542421388;
        Sun, 12 Nov 2017 19:07:01 -0800 (PST)
Received: from unique-pc ([117.209.192.7])
        by smtp.gmail.com with ESMTPSA id l1sm24493514pgp.92.2017.11.12.19.06.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Nov 2017 19:07:00 -0800 (PST)
Message-ID: <1510542413.5134.2.camel@gmail.com>
Subject: Re: [RFC PATCH v3 2/4] branch: re-order function arguments to
 group related arguments
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
In-Reply-To: <xmqqefp2c3i0.fsf@gitster.mtv.corp.google.com>
References: <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
         <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
         <20171102065407.25404-3-kaartic.sivaraam@gmail.com>
         <xmqqbmkgjh32.fsf@gitster.mtv.corp.google.com>
         <1510493270.2683.6.camel@gmail.com>
         <xmqqefp2c3i0.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Mon, 13 Nov 2017 08:36:53 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2017-11-13 at 11:32 +0900, Junio C Hamano wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
> > I've tried to improve it, does the following paragraph sound clear
> > enough?
> > 
> >     branch: group related arguments of create_branch()
> >         
> >     New arguments were added to create_branch() whenever the need
> >     arised and they were added to tail of the argument list. This
> >     resulted in the related arguments not being close to each other.
> 
> OK, I understand what you wanted to say.  But I do not think that is
> based on a true history.
> 
>  - f9a482e6 ("checkout: suppress tracking message with "-q"",
>    2012-03-26) adds 'quiet' just after 'clobber_head', exactly
>    because they are related, and leaves 'track' at the end.
> 
>  - 39bd6f72 ("Allow checkout -B <current-branch> to update the
>    current branch", 2011-11-26) adds 'clobber_head' not at the end but
>    before 'track', which is left at the end.  
> 
>  - c847f537 ("Detached HEAD (experimental)", 2007-01-01) split 'start'
>    into 'start_name' and 'start_sha1' (the latter was laster removed)
>    and this was not a mindless "add at the end", either.
> 
>  - 0746d19a ("git-branch, git-checkout: autosetup for remote branch
>    tracking", 2007-03-08) did add track at the end, but that is
>    justifiable, as it has no relation to any other parameter.
> 

Seems I wasn't careful enough in noticing how the arguments were added.
I seemed to have overlooked the fact that 39bd6f72 added 'clobber_head'
"before" track which resulted in the vague commit message. Anyways,
thanks for taking the time to dig into this.


> You could call 39bd6f72 somewhat questionable as 'clobber_head' is
> related to 'force' more strongly than it is to 'reflog' [*1*], but
> it is unfair to blame anything else having done a mindless "add at
> the end".
> 

Yep, you're right. How does the following sound?

    branch: group related arguments of create_branch()
    
    39bd6f726 (Allow checkout -B <current-branch> to update the current
    branch, 2011-11-26) added 'clobber_head' (now, 'clobber_head_ok')
    "before" 'track' as 'track' was closely related 'clobber_head' for
    the purpose the commit wanted to achieve. Looking from the perspective
    of how the arguments are used it turns out that 'clobber_head' is
    more related to 'force' than it is to 'track'.
    
    So, re-order the arguments to keep the related arguments close
    to each other.
    
-- 
Kaartic
