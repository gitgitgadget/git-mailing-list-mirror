Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B91B20359
	for <e@80x24.org>; Fri,  7 Jul 2017 17:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752317AbdGGRNL (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 13:13:11 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:34517 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbdGGRNK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 13:13:10 -0400
Received: by mail-wr0-f175.google.com with SMTP id 77so55365220wrb.1
        for <git@vger.kernel.org>; Fri, 07 Jul 2017 10:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aIM6V4OByViyfBL4pT7AOtQNBKjTN+W5BxXWBPPienU=;
        b=TIGtWdwc12SiHLN65cNzUQ3/rXG+FO2URit/02Zj2j/VCX30lf2RSjw2MP27wGWSG+
         thjhOK/SIXaL4p6dGkrnbtj7Hfw7qAC+lrUg5Pi+P1SyEy80NsPuZIInUkseqcDmLD1m
         mbLGLih+mdLlJJdFlKnXtANujzs9SoGkiUQ6NZW4tNU36k0D+Dc5rApjay4Is9Uuma70
         os1OkI2ifHPBuqVKad5BYMP6+kugDhIMjo0PIsLv3YloUIEqb0c4zhBildBiaajFoQkT
         zsmThiNUdmX8Sl9Sv7ue0Q9M7O1jncRV8PmnQR56eotUj+FWXpgl9XFvJdoLxafSEWgv
         rn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aIM6V4OByViyfBL4pT7AOtQNBKjTN+W5BxXWBPPienU=;
        b=cP4dZZ7akTFCQtRr9Tw1IzpW9caNu51/BNgxEQNAmwenVGWrvw8bl7LzMSlBuuTL4w
         iZ+mCA05fYG2q69yPFI8S2UWZnRJySFH0it2S2Vdo2O1yIYSqvkVFh7NE95206h9+0zc
         XMOy/O2VwtPWYm4FQhqOlUQzYOUnNqwG1Qjg9Lwv/ixAAVo3b5gtYekD9vL3ps39fxS2
         fFWmB9miDIS6nkaVVhEJrjee8+gKjMEV62Hr+0ZqME2LSR23XMFl9PG/q+gL3LkB9XBj
         L4vSFdqDbPz+aMNxMF4dPeuUIlFH4bx9btGAAYbByfv6NIiqdjxAGTU3RPC3vFSqETD1
         zbwg==
X-Gm-Message-State: AIVw111fWvQnyuCQyvV8gQ3cDQijRsP7qwFRdMij7P/cWRKNNVmO/Z09
        PEWP+zyuVw3dsQ==
X-Received: by 10.28.35.201 with SMTP id j192mr3054715wmj.103.1499447584118;
        Fri, 07 Jul 2017 10:13:04 -0700 (PDT)
Received: from ltop.local (6.37-64-87.adsl-dyn.isp.belgacom.be. [87.64.37.6])
        by smtp.gmail.com with ESMTPSA id r70sm927668wmb.16.2017.07.07.10.13.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jul 2017 10:13:03 -0700 (PDT)
Date:   Fri, 7 Jul 2017 19:13:01 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: bug during checkout of remote branch and uncommited changes ?
Message-ID: <20170707171300.kd5hqcujbvubw73q@ltop.local>
References: <20170707123727.dgd5rub2ycrg525y@ltop.local>
 <xmqqd19cckfw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd19cckfw.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/20170428 (1.8.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 07, 2017 at 08:53:39AM -0700, Junio C Hamano wrote:
> Luc Van Oostenryck <luc.vanoostenryck@gmail.com> writes:
> 
> > 	$ git reset --hard
> > 	patching file afile.c
> 
> Is that a message from something?  It does not sound like something
> "git reset --hard" would say.

Indeed, sorry. This is the result of a 'git diff | patch -p1 -R' to
which I'm used since a long time ago. I have no more reason to use
it but ... habits ... :)
 
But doing 'git reset --hard' gives exactly the same result.

> > 	$ git co <abranch>
> > 	fatal: Not tracking: ambiguous information for ref refs/remotes/<aremote>/<abranch>
> >
> > What can be ambiguous here?
> 
> I think the message "Not tracking" is given when there is a remote
> other than <aremote> that also has <abranch>.

Mmmm, no I don't have that.
At this point there is (in .git):
	refs/remotes/<aremote>/<abranch>
	refs/heads/<abranch>
The second one didn't existed before the checkout attempt, of course.
	
> Between the time you
> got the message and the time you tried to checkout <abranch>, did
> anything happen to cause the second attempt succeed?

No.
At least here, the scenario I gave allow to fully reproduce the problem.

Would you like any other information?

-- Luc
