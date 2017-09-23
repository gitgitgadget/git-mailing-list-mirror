Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FFD82047F
	for <e@80x24.org>; Sat, 23 Sep 2017 07:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750808AbdIWHEH (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 03:04:07 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:56681 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbdIWHEG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 03:04:06 -0400
Received: by mail-it0-f52.google.com with SMTP id g18so3029191itg.5
        for <git@vger.kernel.org>; Sat, 23 Sep 2017 00:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=yGab5ozy97DWRxa9zE/KlMCRg61WYo4ndcWPnRXPJGU=;
        b=M/wUEHvxQRe9PCd4GP9D2G0MeXPTP8gfJEiOTy3FGGMW9WVf0VRqaTvxVntX5dbSr2
         cm1LRRSBbcKqwuqkClMjowkMqgJbWxrmJ2oSNWs2qFtg5WtuNl+u3Ku8BtSLwHhZ+A6K
         ujak7lL7f404UMEnAlIts29NN82SotE+WJINyQhdW62fXnfWR6l4HUM7pwIMKxLEexof
         gzEAv5eNGBxGTySZtuWc+gICuPAk59rUesDfFExq+3bjD/BiQSYle+ZQvymYi/HSZPLd
         l1AKFemXtfETAjJW4t4uRHabIDyqr7a4j03l859G3S8i3GfV3cSuwcRTV/2sCgdr7+g7
         HbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=yGab5ozy97DWRxa9zE/KlMCRg61WYo4ndcWPnRXPJGU=;
        b=cEZkvHWhYyr3HiyLZgz2vFnsZba8n/F2Ci4Efs9FTWsuPetD3BYGXCs3CC9ITS4F7C
         VdM365I6XCdfZwxL0nQKwTTLXgGGmC17JFvT6Hr+OSZ5DcBlN41/xRpwGfokNXOUZTXI
         +5KsmyRbT47hnoEebUrBVmnsDivODr7u/eWRKnkDBenkStJofJslGSUAH+9U04cgZtEj
         VhohLO5brJT3nEM7aFt4+qVEOdcNTh1K55cs6QzWS295mOKHmJUsBzGkpUDCPle5g7r6
         oyqRirlPfMWdva3qtabmu4MiYyC4drHV8bMMWN0UKWEV5XPV8XGFGj2vJgZH4XrHm90g
         4+HQ==
X-Gm-Message-State: AHPjjUggTJu8gxMomVM6Io+UyDYGm73GoN4LYwbq3ZxASdcPZinupgA2
        m7lUzkvxWxyMu39soe4GrFE=
X-Google-Smtp-Source: AOwi7QCiZ8hEGCV1OfNfx3ob2WNLI1mXXS07wcrENg4cGTNHYWI4+teOosjX83BtI4gACmERBmIMAw==
X-Received: by 10.36.111.148 with SMTP id x142mr9710665itb.72.1506150246038;
        Sat, 23 Sep 2017 00:04:06 -0700 (PDT)
Received: from unique-pc ([2405:204:70c5:34d4:d97c:af1b:33e7:ca29])
        by smtp.googlemail.com with ESMTPSA id v5sm747462iob.5.2017.09.23.00.04.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Sep 2017 00:04:05 -0700 (PDT)
Message-ID: <1506150231.3877.3.camel@gmail.com>
Subject: Re: Behaviour of 'git stash show' when a stash has untracked files
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
In-Reply-To: <20170920193630.l7ifret5dpqgxiwm@sigill.intra.peff.net>
References: <1505626069.9625.6.camel@gmail.com>
         <xmqqfubinddb.fsf@gitster.mtv.corp.google.com>
         <20170920193630.l7ifret5dpqgxiwm@sigill.intra.peff.net>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sat, 23 Sep 2017 12:33:51 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2017-09-20 at 15:36 -0400, Jeff King wrote:
> 
> Or sometimes people are just really behind in reading the mailing list. ;)
> 
> This seemed familiar, and indeed there was some discussion a few months
> ago:
> 
>   https://public-inbox.org/git/CAOtcWM3mrQEqDnjMipzea7Kp+VueBFsZDL2zcJ=y0wgj9N4Vjw@mail.gmail.com/
> 
> I sketched out a possible solution in:
> 
>   https://public-inbox.org/git/20170317141417.g2oenl67k74nlqrq@sigill.intra.peff.net/
> 

It seems I should have searched the list without being lazy before I
sent this one. Anyways, the output of the patch there sound a little
interesting.

> though I share your concerns over whether people would be annoyed to see
> the existing "stash show" output changed.
> 

Though I'm not sure whether people would be annoyed about the change in
output, I personally find it a little odd to show the contents of
untracked files as if they have been "added" to the index (although
there is notice that these are "untracked-files"). I think that might
puzzle some users.

That said, when I actually sent this mail I was thinking of an
implementation of the following sort (thanks Peff!),

diff --git a/git-stash.sh b/git-stash.sh
index 8b2ce9afd..b79adc138 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -401,7 +401,10 @@ show_stash () {
                fi
        fi
 
-       git diff ${FLAGS} $b_commit $w_commit
+       {
+               git diff ${FLAGS} $b_commit $w_commit
+               test -n "$u_commit" && git show  --pretty=format:'%nUntracked files: ' ${FLAGS} $u_commit -- .
+       } | git_pager
 }
 
 show_help () {

I would like to turn this off when patch mode is requested, but I
currently couldn't. I would also like to print only the names of the
files, if possible.

I find this kind of output better than showing nothing at all or
showing the output of untracked files in the form of a diff when patch
mode is requested. IOW, this satisfies my expectation though I'm not
sure how much this would be useful to others.

---
Kaartic
