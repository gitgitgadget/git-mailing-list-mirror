Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE71420248
	for <e@80x24.org>; Thu, 14 Mar 2019 14:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfCNOub (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 10:50:31 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55782 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfCNOub (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 10:50:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id 4so3286848wmf.5
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 07:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=g011RL0jIc8A8xWqNVOX+ArbPiKQbEb9SH/c/4tGLdo=;
        b=KaXO4tLgxBjrheE5j3r7AuJaqAPGQmrP8f68OnTUXYxwZ1aTmaLl/5TcyA1eAKt4HZ
         YVQwoqCOTvvSeXiVv3lPj24huAfQ1dhk1sTv9OjjEWtFD23WycJSdIOclUuql9KT9Gai
         CknbnPLa7GXSkKRsP2OGsJOm7EsCC3Mj7Z6pNeR3XCNDFjkddtQdx/Q1g5gxiXJNZjz1
         Nn7qfZcdZkktoEiuA8Bd6IbWV5anXjDEmQnb7/vrQOmi/NjTQKyptzTDoP49yyU65+hX
         etur3fynUr1FjcJmvG1v02N0leKgwP/SYee0FiCdpeV3y47o7oyvaYaNgnMLvdZbO3dc
         JhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=g011RL0jIc8A8xWqNVOX+ArbPiKQbEb9SH/c/4tGLdo=;
        b=qiT00ikgAxTJzb1bopk2HxFpz7aMMh8d5zBqHsxtIOehD+BVzkXmQo6+7iE4m6hxpg
         xc5gq4umBiPOjc+LDzuz34X870F/zqhLFs7P9HeJoD05Zh+dLhBvPXvryJqCw6PxNJ10
         rG3ywyHj2UaWVcz6ZIxG5Cppyx3NoG83U0lIlZRGQ72WdTvawvKqUFpTMqIrvQZDXVOx
         qqpp9qZqpRoJc/3fVLnGcAxmPQQwg5dnmGgKx1izjSov34j7XXUuGLSbJJvGok11AMuW
         gPEo9J/YVBTyVPe6RZocHGrgaepZWuzJBpVQkpIwgWF7gAbf2vIH3oye0SO5cUxOGBEY
         eWNQ==
X-Gm-Message-State: APjAAAU+eJtAsFhNOwWA+UTKtz+cLvFFczTrY1HRe2j3a+ROVHeuwLSg
        lNJ0KBScDyYw11ck/oyeL4Q=
X-Google-Smtp-Source: APXvYqw/MeGscJcExjHwVzay9QI3SRwXRTQngdZVkXtuk/vbi0Ka5I2YJ8mYctuQki2TrN1j+tRINA==
X-Received: by 2002:a1c:f20e:: with SMTP id s14mr2932545wmc.69.1552575029522;
        Thu, 14 Mar 2019 07:50:29 -0700 (PDT)
Received: from szeder.dev (x4d0c0ea6.dyn.telefonica.de. [77.12.14.166])
        by smtp.gmail.com with ESMTPSA id u14sm18450802wrr.42.2019.03.14.07.50.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 07:50:28 -0700 (PDT)
Date:   Thu, 14 Mar 2019 15:50:26 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 01/11] test-lib: fix interrupt handling with 'dash' and
 '--verbose-log -x'
Message-ID: <20190314145026.GF28939@szeder.dev>
References: <20190313122419.2210-1-szeder.dev@gmail.com>
 <20190313122419.2210-2-szeder.dev@gmail.com>
 <xmqq1s3aci66.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq1s3aci66.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 11:18:41AM +0900, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > Putting these together, when a test script run with 'dash' and
> > '--verbose-log -x' is interrupted, then 'dash' tries to write the
> > trace output from the EXIT trap to the script's original standard
> > error, but it very likely can't, because the 'tee' downstream of the
> > pipe is interrupted as well.  This causes the shell running the test
> > script to die because of SIGPIPE, without running any of the commands
> > in the EXIT trap.
> 
> So... the clean-up actions do not get a chance to run because the
> shell that is going to execute would be killed by SIGPIPE because
> tee that is reading from it goes away?

Yes.

> While I like the patch very much, I also wonder if it is possible to
> tell tee to not to die upon seeing INT, TERM, etc.

'tee -i' ignores only INT, but not TERM and HUP.

What could work is something like:

  <re-executing the test script> | (
        # Ignore common interrupt signals to prevent 'tee' from dying
        # while the upstream test process still produces output.
        trap '' INT TERM HUP
        tee logfile
  )

but I'm not sure what should happen with a process ignoring HUP when
it still produces output to the terminal after that terminal has been
closed, i.e. this 'tee' process.  FWIW, In my quick test such a
process continued happily without receiving SIGPIPE or other
unpleasantness.

>  When the shell
> upstream of tee exits (after performing clean-up actions), tee that
> is reading from it will exit, too, and will not be left behind (I do
> not mean to say it that is a better alternative solution---I am just
> trying to see if I read the problem correctly from the description
> given above).
> 
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index 8665b0a9b6..db3875d1e4 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -631,7 +631,10 @@ die () {
> >  
> >  GIT_EXIT_OK=
> >  trap 'die' EXIT
> > -trap 'exit $?' INT TERM HUP
> > +# Disable '-x' tracing, because with some shells, notably dash, it
> > +# prevents running the cleanup commands when a test script run with
> > +# '--verbose-log -x' is interrupted.
> > +trap '{ code=$?; set +x; } 2>/dev/null; exit $code' INT TERM HUP
> >  
> >  # The user-facing functions are loaded from a separate file so that
> >  # test_perf subshells can have them too
> 
> Thanks.
