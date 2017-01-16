Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FB2B20A17
	for <e@80x24.org>; Mon, 16 Jan 2017 22:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750990AbdAPW3W (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 17:29:22 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32787 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbdAPW3V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 17:29:21 -0500
Received: by mail-wm0-f67.google.com with SMTP id r144so34072689wme.0
        for <git@vger.kernel.org>; Mon, 16 Jan 2017 14:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UXFOf5Rpp9YFKx5uUO7gUChWnd8N3LTfUVDLj1KUXRI=;
        b=dc251r89uOSXUWOs3XQxHSSxJIwNS3/0SRHzDoLrOcdOJ1bJaHQtk25ZRQ2cbKnf4a
         cYOlStBzPPaO+knupgdRlXoHsMic4KEp5yhBAESj+fYl6HidY0mkV4j3gtRm6aZjfYuc
         e2ZtIC6PkMGWBpidmRHKjP3Lnhh/dxx0y5H3cWp+2+8t4T2ryyqMFOqWLTil6NFS6ZFh
         xMjRRFbHNeqYPxs9vKysDCQ6VeDq2s++n9bsFAE0I7DnQKINrOCWqR/hMQR5NY7pT7ZK
         4o6dbRuU2kwsxnXq4W5yBS07saLqWsg5ha2HJcbJ6vEVltmL+bEUuRUAQDNF8wnfcdUZ
         WA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UXFOf5Rpp9YFKx5uUO7gUChWnd8N3LTfUVDLj1KUXRI=;
        b=aobC2LXonswQ/rOstDt53mdzkbl7yXVuj6WBaeVXCwu4GxVV1gv1Kefsy2HW4dQtXn
         Ia2w6ymLINIEAOugw2LKg3geTwpDkjeLqaIoCm3MzDAv4icBVcMR7Lj0MdEehQpwj47d
         CDJUZXJbplgIo6fSL6mrHEAGfV907ww0/aOSBKyE+5l0TyvBcdIJ9kejkX+MZKWuF9Un
         VYm0tyZOLKVbiuTY9jIx/7g8wgwyhOKF5vMgYB4WPAL4FSaJX2XohAblr+BtSRSI/HuU
         zrdTKTjy2y92vwJYTlGL7e39a/jrNIqRiLE2IGRWbHOLXhZuSUEjeb9q5u28NNydH+CH
         LDqg==
X-Gm-Message-State: AIkVDXIJ4j27JSiN0CnxETvov9pynnUaEbiCc8ywISexy8untdz5W9foa6x4jSgd2a248g==
X-Received: by 10.223.128.77 with SMTP id 71mr25276185wrk.48.1484605760375;
        Mon, 16 Jan 2017 14:29:20 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id r6sm31769819wmd.4.2017.01.16.14.29.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jan 2017 14:29:19 -0800 (PST)
Date:   Mon, 16 Jan 2017 22:29:27 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, kes-kes@yandex.ru
Subject: Re: [RFC] stash: support filename argument
Message-ID: <20170116222927.GA31189@hank>
References: <20170115142542.11999-1-t.gummerer@gmail.com>
 <xmqqvatfc0rt.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqvatfc0rt.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/15, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > While working on a repository, it's often helpful to stash the changes
> > of a single or multiple files, and leave others alone.  Unfortunately
> > git currently offers no such option.  git stash -p can be used to work
> > around this, but it's often impractical when there are a lot of changes
> > over multiple files.
> >
> > Add a --file option to git stash save, which allows for stashing a
> > single file.  Specifying the --file argument multiple times allows
> > stashing more than one file at a time.
> >
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >
> > Marked as RFC and without documentation updates to first get a feeling
> > for the user interface, and whether people are interested in this
> > change.
> >
> > Ideally I wanted the the user interface to look like something like:
> > git stash save -- [<filename1,...>], but unfortunately that's already
> > taken up by the stash message.  So to preserve backward compatibility
> > I used the new --file argument.
> 
> I haven't spent enough time to think if it even makes sense to
> "stash" partially, leaving the working tree still dirty.  My initial
> reaction was "then stashing away the dirty WIP state to get a spiffy
> clean working environment becomes impossible", and I still need time
> to recover from that ;-)  So as to the desirablity of this "feature",
> I have no strong opinion for or against yet.

As others mentioned, this would be similar to stash -p.  My main
usecase is stashing away a config file or changes in one test file
while I forget to test something without these changes.  I definitely
used git stash -p on more than one occasion to simulate this behaviour
before.

> But if we were to do this, then we should bite the bullet and
> declare that "stash save <message>" was a mistake.  It should have
> been "stash save -m <message>" and we should transition to that (one
> easy way out would be to find another verb that is not 'save').
>
> Then we can do "git stash save [-m <msg>] [--] [pathspec...]" which
> follows the usual command line convention.

I like this interface much better than the one in my patch.  I'm not
sure about the verb we could use for the transition, maybe 'push'.  If
anyone can come up with a different suggestion I'd be happy to hear
it, as I'm not very good at naming things.

-- 
Thomas
