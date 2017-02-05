Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51FE61FC46
	for <e@80x24.org>; Sun,  5 Feb 2017 04:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751774AbdBEELF (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 23:11:05 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35756 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751612AbdBEELE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 23:11:04 -0500
Received: by mail-pg0-f46.google.com with SMTP id 194so18254429pgd.2
        for <git@vger.kernel.org>; Sat, 04 Feb 2017 20:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9PfWx2iFhMLD9JCeeqnW6gN8o5uffNNLjtPfMB/Ybg8=;
        b=MMDslXbcMYAJ7Ru6CKgT6Ot/c6o1j+7A3Y1FCKxpwydAOECLZXopSioXanEjv75n2e
         SIyYLpJ9j5rlKDk/oqRQph/pOlUrAA1ypkUvTWdl+GPSvE1VQrQDw57Qno/L52loDUYk
         Fca1/kaT0Ko2krd9MXUZNxLLZZo/egIzlJkx/3oMlhOO7naHS2NnpuN79Et4Ft3+oga9
         t1rbC1OewfBAfsNTOpJspVZuS7qVyNk8JEWd+dtDU6QLqDSXjImBcsAMtvv3mX5W9OXR
         bH+kIdk2wHBbtgNJc0isK1g0DjUzP/aIIotuTf7p946IwYovNHOqryEBMdcI4jX5fIEh
         AdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9PfWx2iFhMLD9JCeeqnW6gN8o5uffNNLjtPfMB/Ybg8=;
        b=HeE6osdyHUY7Dzu1D8pnrlK66vpif+m0rChWh83xctwSutekMMO6XAk010nve/vu/L
         duW+TQnpnUYFk6OKbiiNL10kz90Ct+LQ0SB6Dj2U1KhCLAwFUBJUDNCkm1xItAXnuSP7
         WgnXS446b8q7uxopzQKBFY/9BkrT6Q4HgAzhoPXnsJT/eJg8Q67MtaCSjoR83WOxeF3J
         nm9By9tBwX6YSQsWOedT6qtb2TmboB/9pT3sJ3QkdUxjxLYrpv2mG+2vQVs4H3qCo8OZ
         CvZ6jCDALNYY9iEXl8XtNEVkN01zJClFa47oEkV18lMYFwwYbMutsykSLV0V8zFnne4A
         24Hw==
X-Gm-Message-State: AIkVDXIaVrAtRalax68ZXfseGLeb/O1Yz5qTQ3yNuXroC1rvbhwHhvulZjwHId1L0KOKKQ==
X-Received: by 10.98.34.82 with SMTP id i79mr5933412pfi.120.1486267863989;
        Sat, 04 Feb 2017 20:11:03 -0800 (PST)
Received: from gmail.com (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id m6sm78355984pfm.22.2017.02.04.20.11.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Feb 2017 20:11:02 -0800 (PST)
Date:   Sat, 4 Feb 2017 20:10:59 -0800
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] tag: add a config option for setting --annotate by
 default
Message-ID: <20170205041059.k6amkuynvv5o4iyi@gmail.com>
References: <20170204021402.15927-1-davvid@gmail.com>
 <xmqqlgtm8s5k.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlgtm8s5k.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 03, 2017 at 09:02:47PM -0800, Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > Make it easier for users to remember to annotate their tags.
> > Allow setting the default value for "--annotate" via the "tag.annotate"
> > configuration variable.
> >
> > Signed-off-by: David Aguilar <davvid@gmail.com>
> > ---
> 
> I do not care too strongly about this, but I need to point out that
> this will have fallout to tools and scripts.  E.g. if you have this
> configured and try to create a new tag in gitk, wouldn't this part
> 
> 	if {$msg != {}} {
> 	    exec git tag -a -m $msg $tag $id
> 	} else {
> 	    exec git tag $tag $id
> 	}
> 
> try to open an editor somehow to get the message even when $msg is
> an empty string?  I think the same problem already exists for the
> tag.forceSignAnnotated variable we already have added, though.

That's true.  I should have put "RFC" in the subject line.
Let's drop this patch unless there's others that find it useful.

How do you feel about a patch to add "git merge --signoff", for
consistency with "git commit"?

The rationale is that there might be situations (evil merges, or
even regular merges depending on the project) where someone
might want to signoff on their merges.
-- 
David
