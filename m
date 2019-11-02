Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9F0F1F454
	for <e@80x24.org>; Sat,  2 Nov 2019 01:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfKBBCV (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 21:02:21 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46279 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfKBBCU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 21:02:20 -0400
Received: by mail-pl1-f194.google.com with SMTP id q21so5050769plr.13
        for <git@vger.kernel.org>; Fri, 01 Nov 2019 18:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LHopyCyU/MVqYfttuo+VC5L6szs2n0C6geJyN69XS5M=;
        b=LR+FLxZjGYp7cdqyjfh87cSj5pn5gRUeJSfaF8w0Iede/EyoEESkl75ezgi9/w1hMq
         czav9gDouKJ8lPcXJIsBXa6A+M8aD7L+bR7sUyOdlRV9QIF8AGsfNHgbYb5/V/nB4uEH
         5RKrTHdfc1DSGkIkI4TybcGsExRqK0W9exuK6u3Eso+u4qcnfDcfcTk/Qr4w8ZFTSSo2
         JQmLDcd5T/gcdMZhS9djkLwi8W/mUhCY0Ie8cdeq1GKdY5RZMF7/ftJR4+LTVijmH0r8
         6Xczrqmd4W7tjmO1RI0fvfEgIJeh3k58AconyaJsfTEot+YqnTIH/bDymroXy1OTfHYx
         e3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LHopyCyU/MVqYfttuo+VC5L6szs2n0C6geJyN69XS5M=;
        b=FZHdprU9HU6m3VsORAHSx4Q/3IBYn2Bv9WKUBDbjwjbfP2qcIUl39fUisoPnqnZ5Hw
         oIMwIGU3A/W38o+ubceOdUkwuIzO9PteiODS7PXAOlEKgJenvGXoOpCdyftprbada24l
         dWjKqTNgpSmQIy2JS9RLJfdEAwk0DC6BisQt2kndDqYvRQl2+VE/AgaB4Tmj0LGtWHt3
         AaaMC6paUUwqxO2TbOCxUNM4idieTtZFZH0PLWxq95m55W1tklc0Nkjg55cPZNx2U5m7
         PeFVFeBzdWL1rj4HQG73yul03ziruvJwYIediCvNZP0dJ8faGVu+8WbTvlx0oxQSwl1Z
         Y1Vw==
X-Gm-Message-State: APjAAAURGMQ0kcoNT9bJ5+KyrlYCIijPKUOelANaSAE1MnjbhH0hoPfj
        a4fMMpMuToviDPAEl1IxOSY=
X-Google-Smtp-Source: APXvYqx9hcs80+fqTZ1rmSzD+pbua+xlnFOUJNqqYH2VQpSvTd7XAlw904gB8eSw0eIihjk3Bwmcbg==
X-Received: by 2002:a17:902:a988:: with SMTP id bh8mr15727809plb.303.1572656538474;
        Fri, 01 Nov 2019 18:02:18 -0700 (PDT)
Received: from localhost ([2402:800:6374:e1c2:8c5a:c959:6fca:fa1a])
        by smtp.gmail.com with ESMTPSA id f33sm7218672pgl.33.2019.11.01.18.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 18:02:17 -0700 (PDT)
Date:   Sat, 2 Nov 2019 08:02:15 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] sequencer: reencode to utf-8 before arrange
 rebase's todo list
Message-ID: <20191102010215.GB17624@danh.dev>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <cover.1572596278.git.congdanhqx@gmail.com>
 <b7927b27235422ac53595cfaa63b4f1cbe009013.1572596278.git.congdanhqx@gmail.com>
 <20191101165921.GD26219@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191101165921.GD26219@sigill.intra.peff.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-11-01 12:59:21 -0400, Jeff King wrote:
> On Fri, Nov 01, 2019 at 03:25:11PM +0700, Doan Tran Cong Danh wrote:
> 
> > for encoding in utf-8 iso-8859-1; do
> > 	# commit using the encoding
> > 	echo $encoding >file && git add file
> > 	echo "éñcödèd with $encoding" | iconv -f utf-8 -t $encoding |
> > 	  git -c i18n.commitEncoding=$encoding commit -F -
> > 	# and then fixup without it
> > 	echo "$encoding fixed" >file && git add file
> > 	git commit --fixup HEAD
> > done
> > git rebase -i --autosquash --root
> 
> Is it worth adding this as a test in t3900?

I think yes, but with a little more work.
I'll make it as a separated patch in a re-roll.

> >  		parse_commit(item->commit);
> > -		commit_buffer = get_commit_buffer(item->commit, NULL);
> > +		commit_buffer = logmsg_reencode(item->commit, NULL, "UTF-8");
> 
> I think there are several other spots in this file that could use the
> same treatment. But I can live with it if you want to just fix the one
> that's bugging you and move on. It's still a strict improvement.

There're 6 more occurence of get_commit_buffer in sequencer.c, and 13
occurences in other C source files. I'll try to figure out if it's
safe to change.

Anyway, if we're going to working with a single encoding internally,
can we take other extreme approach: reencode the commit message to
utf-8 before writing the commit object? (Is there any codepoint in
other encoding that can't be reencoded to utf-8?)
Since git-log and friends are doing 2 steps conversion for commit
message for now (reencode to utf-8 first, then reencode again to
get_log_output_encoding()). With this new approach, first step is
likely a noop (but must be kept for backward compatible).

-- 
Danh
