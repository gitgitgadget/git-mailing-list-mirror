Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DB961F42D
	for <e@80x24.org>; Thu, 31 May 2018 19:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754101AbeEaTWM (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 15:22:12 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51168 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754030AbeEaTWL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 15:22:11 -0400
Received: by mail-wm0-f66.google.com with SMTP id t11-v6so55944177wmt.0
        for <git@vger.kernel.org>; Thu, 31 May 2018 12:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XUUNKwla6QF1z7jQbDI1zo2TF+o4pYbiPl2utlN0htE=;
        b=C2Oc9F998IaBSa2hyW7+dZCJgKf69QGDtHK4pJ1EIy0g5xO+FvinfyQCEyMycFUuUA
         FifrPlQcaHPq5KR/LkCJU6gP6U7poPnierY10sTI4AqFke10rZRLaOHEBlvDcVisjtT7
         aFVmCreNwLSu27BhLNYbRSRc7CxGxvjPI9otzRYAk8SUt2MLWdbtSdwHrLCMW9/fADnE
         /Cv0jVTmopZHGl7Y0hkl+1QsTjfy41EQ+EqfzIpPB/uCch2spIglNnO3GpPHnE7l4YbM
         lMJNuy0zdePpUSS0YGEfEL436l/TU4V5kOqb4LQqeRaSZCNhMbADm6IXVk5xlIeRco3M
         G2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XUUNKwla6QF1z7jQbDI1zo2TF+o4pYbiPl2utlN0htE=;
        b=e07HG7Z3/9wJpdMeXkRthlWj7/C/OjOsg62w8SdubRvO2Ozggc4IK07aNLjwM9vS6v
         mPCwEWGlM9FLWMt24adupF5dfF3Q7bLtQDCLxWkcfOr/LS1DrZUviIzJHB0GwqtOlOrA
         3EvS0dka8OiZjwTzRzAniw3JADD84eTRiLo+lECNp6FKZ4Ac3sXuTnDnlj2xcSRWZiH9
         Y+8XW8FjYq6GSe61ir7YCHelY9pP9NFeQETmDg12H7o1wQp8Inskl0xFsGGUKgdqadNa
         EXM3RKKasFUdqA+wNnAIIAd7FExK4yMfo+Y3Pn/VPGECpa+G9girWFJX7S8Xgn5B5qpG
         ud2g==
X-Gm-Message-State: ALKqPwetH8QjzOJihEDO/N3EyJCTf0zcvHqihDbgCupPBR5pVVuKPykc
        lrGBNwrG70/ql65a2WQeJzM=
X-Google-Smtp-Source: ADUXVKK3BPAqfbelCO+0CIckhiTGVA09w41pgxDnQR2NLLJzdn+6KsPtDeZ3KV7EcnroZfGkdg0OvQ==
X-Received: by 2002:a1c:ee5d:: with SMTP id m90-v6mr718143wmh.113.1527794530030;
        Thu, 31 May 2018 12:22:10 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id q2-v6sm36762128wrm.26.2018.05.31.12.22.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 12:22:09 -0700 (PDT)
Date:   Thu, 31 May 2018 20:22:45 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/2] note git-security@googlegroups.com in more places
Message-ID: <20180531192245.GB26159@hank.intra.tgummerer.com>
References: <20180527140433.32277-1-t.gummerer@gmail.com>
 <20180530205255.13090-1-t.gummerer@gmail.com>
 <20180530205255.13090-2-t.gummerer@gmail.com>
 <20180530233716.GE671367@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530233716.GE671367@genre.crustytoothpaste.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/30, brian m. carlson wrote:
> On Wed, May 30, 2018 at 09:52:55PM +0100, Thomas Gummerer wrote:
> > Add a mention of the security mailing list to the README, and to
> > Documentation/SubmittingPatches..  2caa7b8d27 ("git manpage: note
> > git-security@googlegroups.com", 2018-03-08) already added it to the
> > man page, but for developers either the README, or the documentation
> > on how to contribute (SubmittingPatches) may be the first place to
> > look.
> > 
> > Use the same wording as we already have on the git-scm.com website and
> > in the man page for the README, while the wording is adjusted in
> > SubmittingPatches to match the surrounding document better.
> > 
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >  Documentation/SubmittingPatches | 13 +++++++++++++
> >  README.md                       |  3 +++
> >  2 files changed, 16 insertions(+)
> > 
> > diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> > index 27553128f5..c8f9deb391 100644
> > --- a/Documentation/SubmittingPatches
> > +++ b/Documentation/SubmittingPatches
> > @@ -176,6 +176,12 @@ that is fine, but please mark it as such.
> >  [[send-patches]]
> >  === Sending your patches.
> >  
> > +:security-ml: footnoteref:[security-ml,The Git Security mailing list: git-security@googlegroups.com]
> > +
> > +Before sending any patches, please note that patches that may be
> > +security relevant should be submitted privately to the Git Security
> > +mailing list{security-ml}, instead of the public mailing list.
> > +
> >  Learn to use format-patch and send-email if possible.  These commands
> >  are optimized for the workflow of sending patches, avoiding many ways
> >  your existing e-mail client that is optimized for "multipart/*" mime
> > @@ -259,6 +265,13 @@ patch, format it as "multipart/signed", not a text/plain message
> >  that starts with `-----BEGIN PGP SIGNED MESSAGE-----`.  That is
> >  not a text/plain, it's something else.
> >  
> > +:security-ml-ref: footnoteref:[security-ml]
> 
> My only feedback here is that using the footnoteref syntax to refer to
> the previous footnote potentially makes this a little less readable for
> plain text users, although it also reduces duplication.  I'm not sure I
> feel strongly one way or the other on this.

Yeah, using the plain footnote syntax we end up with two footnotes
that are exactly the same, which felt a little awkward.  But I don't
feel strongly either, so if the consensus is to duplicate the footnote
for better readability in plain text I'm happy to change that.

To really improve the readability we'd probably have to duplicate the
attribute as well, which I wanted to avoid (altough it's not
completely possible with the footnoteref syntax either).

> Otherwise, this looked fine to me.
> -- 
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204
