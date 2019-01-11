Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE03E211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 18:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389621AbfAKSvY (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 13:51:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36537 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731464AbfAKSvY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 13:51:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id u4so16306095wrp.3
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 10:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=KAPssxjbp7DlRA1AeaoqlGps1dbniFollvGpiXv3Arg=;
        b=bOLTFE5YHAXbhtFa2d62E++JIZavkfFrrAmtsu9Y0uhENGH2+mcIqbNH2ONa+8ReLH
         2TAth1UUoddPOftNHMH6pgOT1+qp3FQfOG9WQJ9NsnQ2m/d7zJE9O81AtOkQN1yy9nqH
         009LpJiE5C8vgSBj0SsnV0eeCwJWkaGz46Rjyn0bd3tUpmgTylyG900fYdRObnuSU/VB
         iBLPabFxYiew2TlHNSHZohHUE4t6eOT9Gt+eB7x8pDmENzvvlCCRiQ27EdXWeoTLDF+8
         olqffOFkzqClFImVZD4o5/WNQqhFHkyduzLyub5YDYV3CF+5YbO0mlAiAXv1TWCDUjbY
         Vd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KAPssxjbp7DlRA1AeaoqlGps1dbniFollvGpiXv3Arg=;
        b=E1sFA8kxFsD9n8fZ87UqIvo5PXQt9gsaNivKAMztymqZKnSrGg6dUbhx7+UpI1HWBZ
         kbkEFPxig1qUvVPYBi3Pi3bPSZX4JgCUdRDoXf7Z57XW1opo4XXINc3kVw84qYZb5G2Q
         z0EQbdyD4pZagcklAJThhIp+E1uh4FSJAjIQzhyj1345Y2xJQ16v1gVW6uq+nXd+QDrM
         Zto6WATcdjJ4vl3dTW9NdVKg2vHN8lC6geL++E0iQlYLLyWRPTQUt6/if6Z+MX5yD3mN
         dhGuYKp30Ly7zaf744fuj+nB0hwOJ3CjOiDovdFO2Mym8BWKy9BgB0XvVTSQWTmK86ZR
         w2LQ==
X-Gm-Message-State: AJcUuke/uDIWwPD/R3o3xh/ZwYd87GO+9Nd/Xw1uyttIVajbLMWzLSIi
        Njq6FguvJdZc/wS3A/MX0d0=
X-Google-Smtp-Source: ALg8bN6SOi/Hhew2SbBZ9BTby3j4FFupXrsTKD0PNviUBra21hyMWYDJz+qFtqppilYxfzNAhwVeKg==
X-Received: by 2002:adf:bb8d:: with SMTP id q13mr14498573wrg.183.1547232681773;
        Fri, 11 Jan 2019 10:51:21 -0800 (PST)
Received: from szeder.dev (x4db349c7.dyn.telefonica.de. [77.179.73.199])
        by smtp.gmail.com with ESMTPSA id j24sm76789831wrd.86.2019.01.11.10.51.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 10:51:20 -0800 (PST)
Date:   Fri, 11 Jan 2019 19:51:18 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/5] compat/obstack: fix -Wcast-function-type warnings
Message-ID: <20190111185118.GD840@szeder.dev>
References: <20181220162452.17732-1-szeder.dev@gmail.com>
 <20181220162452.17732-2-szeder.dev@gmail.com>
 <87zhszeqsr.fsf@evledraar.gmail.com>
 <xmqqef9k1a4n.fsf@gitster-ct.c.googlers.com>
 <20190111003743.GA840@szeder.dev>
 <xmqq4lafysve.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq4lafysve.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 11, 2019 at 10:03:01AM -0800, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > On Thu, Jan 10, 2019 at 01:22:00PM -0800, Junio C Hamano wrote:
> >> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> >>  ...
> >> > I.e. is this another case where we're blindly fixing bugs but should
> >> > just re-import upstream's code instead?
> >> 
> >> Good point.  I am inclined to queue the remainder of the series
> >> without this one for now.
> >
> > Note that without this first patch the linux-gcc build job will fail
> > with the above compiler error, and that's the only build job that runs
> > the test suite with all the misc test knobs (split-index,
> > commit-graph, etc.) enabled.
> 
> I know.  
> 
> The point is to give more incentive to try what was suggested
> earlier by Ævar (in short, "try to do the right thing, before
> hacking around locally in this project" ;-)

Well, first I'm not sure what changes Ævar meant to be backported.
Back then I briefly glanced at glibc's gitweb [1], but didn't see
anything remotely relevant to these compiler errors.

As to re-importing obstack.{c,h} from upstream, we've made some
portability fixes to these files, and neither of the commit messages
of those fixes mention that they are backports from upstream.  OTOH,
one of those commits mentions platforms like
"i686-apple-darwin10-gcc-4.2.1 (GCC) 4.2.1, SunOS 5.10", which makes
me suspect that the re-import will be susceptible to those portability
issues again.  Therefore, I think re-importing these files from
upstream is beyond the scope of this patch series (and might not be
the right thing at all).


[1] https://sourceware.org/git/?p=glibc.git;a=history;f=malloc/obstack.c;h=1669641983512d64f66c1ad659562f77ef48adfd;hb=refs/heads/master

