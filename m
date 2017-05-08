Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.8 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8E8A20188
	for <e@80x24.org>; Mon,  8 May 2017 04:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751426AbdEHE1W (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 00:27:22 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34452 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbdEHE1V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 00:27:21 -0400
Received: by mail-pg0-f68.google.com with SMTP id u187so8821729pgb.1
        for <git@vger.kernel.org>; Sun, 07 May 2017 21:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V75bzINf/vZJakISPOE3x2BInu/Bh6q88RMpa3YqziY=;
        b=Wv0CF6pyN5q4UT81fXt16qFjDNSuK1v62Mqx5BRmXi+zw+ApK7wO4Q2MLxWi7ZCW5U
         T5AfxF4nkxtjflP8mrXNCE51+jj1V2sV+p/ET0BtjzFzSsenN/AYBmNe4lZRzqgR8K4a
         TXytM0V1xLe03eXtXP2opQoxxFRz/ElhZKECeIytFVglMPfJmngqGm5dKYiGYCJ03xtO
         lO9R3OqkfhNKxuFZFYIl5KyrFsjwV2XRddJHv2WHt+DRDDeOWopuWNXil89QYFkWHNb+
         JhpvcSWDv8A7vyBL6KO3tW4slTsC4JDby2AJxxsOfVWy2ghJ9KWmzdjjtxBx+GPMWYrk
         ifxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V75bzINf/vZJakISPOE3x2BInu/Bh6q88RMpa3YqziY=;
        b=UZ/KrobNgJlaXJfa14e4FagnDzfo9kyIBSSS10A8mZZJ/cKht2PHJeFZoStyOuI6o2
         GAOOHU7TWuuPpss6AuQcFkWaa6F3rOpzhsbZuX0ES/HRKcyYX5Fbjlwa89JiPWYmUzJX
         deG6j95oHmCpDQAKA+T8ZjGHgC2+MbPSR3sbK4rIbG/EZwZTfVdEIy4lpIHoQErtfy5z
         C8XYeDDNcR6EoRBdBky7R1QVN7uZWE9vD0lX/LiELpEbF1/ddRChDkc846iH87elEH26
         Xppk9bvrCcgano/mgDaG6PTas5IFWdcHNWvamXE2BNom0mSyKi4VRv0jNgBS8//EeGza
         gFdQ==
X-Gm-Message-State: AN3rC/47c0EMFvRNibWDtzzJmkGsXwFzYf2Ie9LQ9Pg6iH4x4m9qugfo
        +oXUnl+hXGU/HaeA
X-Received: by 10.84.222.136 with SMTP id x8mr42530004pls.50.1494217640591;
        Sun, 07 May 2017 21:27:20 -0700 (PDT)
Received: from HP ([116.56.129.184])
        by smtp.gmail.com with ESMTPSA id e207sm20106155pfh.121.2017.05.07.21.27.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 May 2017 21:27:19 -0700 (PDT)
Date:   Mon, 8 May 2017 20:27:08 +0800
From:   Yubin Ruan <ablacktshirt@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] Add warning when git discard changes on another branch?
Message-ID: <20170508122705.GB3540@HP>
References: <20170507233512.GA9332@HP>
 <xmqqzieo9hfo.fsf@gitster.mtv.corp.google.com>
 <20170508111836.GB3014@HP>
 <xmqqvapc9fsg.fsf@gitster.mtv.corp.google.com>
 <xmqqlgq89dzl.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlgq89dzl.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 08, 2017 at 01:19:58PM +0900, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > But to help "some users are not aware of this" situation, an opt-in
> > "feature" would not help all that much.  The same number of lines in
> > the documentation to tell end-users how to toggle on such a "safety"
> > feature can be spent to teach them that their local changes in the
> > working tree do *not* belong to any particular branch, and as soon
> > as it is understood, the user would be OK.
> >
> > So...
> 
> It might help if we treat this similarly to how we treat the
> "detached HEAD" state.  By default when you do "git checkout HEAD^0"
> (not "git checkout --detach HEAD"), you would get a large warning,
> which you can silence by the advice.detachedhead configuration.  In
> addition to the list of "these paths have local modifications" that
> we show as a reminder, perhaps you want to show a warning that tells
> the user that the local modifications in these paths are not
> recorded anywhere else, or somesuch, and silence it with a new
> advice.* variable?

That would be helpful. But, frankly, if a user would be aware of that `advice.*'
variable, he would have enough knowledge of Git to be aware of that situation.
So, I think that 'M lala.txt' in transitions from branch to branch would be
sufficient.

---
Yubin
