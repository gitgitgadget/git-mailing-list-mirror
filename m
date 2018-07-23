Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3F941F597
	for <e@80x24.org>; Mon, 23 Jul 2018 18:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387941AbeGWTh5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 15:37:57 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36788 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeGWTh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 15:37:57 -0400
Received: by mail-pl0-f65.google.com with SMTP id e11-v6so587304plb.3
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 11:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xgVzDEgu8YA/JxUBkuxA4mGVdaABlCQZVkbd0tX/fFM=;
        b=ArF2AJjQgGEZkivOK3CVltICbaPURBRPFBs4eGlCrsVaVqhPq8gvJ50y3LtE+JPnUN
         vUnHhVeozrATuzwK/tAgIIugZlf9Uz5YyRnK4inXkfG5XhkUZs83bVjYChcwE1v4zD8C
         4MfQpVsNgaf10LNDgMQ6nEu6ccGw9fKghugWzzaErpQVc+1892X06YVNHDdkTSxGLY4y
         CZosHjsIRtTPymRCAY7U4yCIGI+ye0j3PRewguL7IQ7VrtY+CQZhCIg8vxptjq6cEzeE
         GqwUaSDeiX/4bUrlOrZnMR9tvYen9I2+K9H9wuB7pwWSkpsHzeT7EIkfZGIIe4utTPc2
         wsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xgVzDEgu8YA/JxUBkuxA4mGVdaABlCQZVkbd0tX/fFM=;
        b=aU/6IjvGkXh5ro+9D0SFNpt3WAQHiSC7kb145HN9OKTrYRyFk68eUPe5LAf1DR9u37
         duRi/m+3wUUgcfIe9Ty+nW3c8ZmZjrLg9DUH9ExKqyEDovCWNq3hug+PKqay+4XFxRP6
         YhABpu6ZiZ04zQVZjNx0VJTFA8BAxOgWhX3Lx+IWsrRW82j2A2n2ZkT1/3ZScOPw96G3
         CXXYqwpmqlOkzwEEbXjhDJc23AQmwdmvliPv2TlIdJ4vXMygtotS+lMVvXLGofAhq1cA
         KvMnMa21tcD47W+Npt7Y2kOOe7eNR4/bXJStml4ayO90Mt7tiXE9BGY6X51Vp3ecZ2mi
         hSpg==
X-Gm-Message-State: AOUpUlF4yyHwhTSogjjJTebJeIx31bkKclm2hSL5NKSPc/wUufH/ysuA
        NMaI+RJGh8YDf2fi6Ah4e2c=
X-Google-Smtp-Source: AAOMgpf+cdOsjrP5B6/L/HGsFPdgjrk65iiuataYmqcjOa2dm56ktL8ACKw947UnIksyRXvaPX72ng==
X-Received: by 2002:a17:902:209:: with SMTP id 9-v6mr14063241plc.270.1532370926326;
        Mon, 23 Jul 2018 11:35:26 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 13-v6sm13906204pfw.131.2018.07.23.11.35.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 11:35:25 -0700 (PDT)
Date:   Mon, 23 Jul 2018 11:35:24 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     demerphq <demerphq@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, agl@google.com,
        keccak@noekeon.org
Subject: Re: Hash algorithm analysis
Message-ID: <20180723183523.GB9285@aiede.svl.corp.google.com>
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
 <20180609224913.GC38834@genre.crustytoothpaste.net>
 <20180611192942.GC20665@aiede.svl.corp.google.com>
 <20180720215220.GB18502@genre.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.1807220036340.71@tvgsbejvaqbjf.bet>
 <20180721235941.GG18502@genre.crustytoothpaste.net>
 <CANgJU+X39NoEoMyLu+FX38=x19LrRqatz_dUpUAc+WFV+Uw+=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANgJU+X39NoEoMyLu+FX38=x19LrRqatz_dUpUAc+WFV+Uw+=A@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Yves,

demerphq wrote:
> On Sun, 22 Jul 2018 at 01:59, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:

>> I will admit that I don't love making this decision by myself, because
>> right now, whatever I pick, somebody is going to be unhappy.
[...]
> I do not envy you this decision.
>
> Personally I would aim towards pushing this decision out to the git
> user base and facilitating things so we can choose whatever hash
> function (and config) we wish, including ones not invented yet.

There are two separate pieces to this.

One is configurability at compile time.  So far that has definitely
been a goal, because we want to be ready to start the transition to
another hash, and quickly, as soon as the new hash is discovered to be
weak.  This also means that people can experiment with new hashes and
in a controlled environment (where the users can afford to build from
source), some users might prefer some bespoke hash for reasons only
known to them. ;-)

Another piece is configurability at run time.  This is a harder sell
because it has some negative effects in the ecosystem:

 - performance impact from users having to maintain a translation table
   between the different hash functions in use

 - security impact, in the form of downgrade attacks

 - dependency bloat, from Git having to be able to compute all hash
   functions permitted in that run-time configuration

The security impact can be mitigated by keeping the list of supported
hashes small (i.e. two or three instead of 10ish).  Each additional
hash function is a potential liability (just as in SSL), so they have
to earn their keep.

The performance impact is unavoidable if we encourage Git servers to
pick their favorite hash function instead of making a decision in the
project.  This can in turn affect security, since it would increase
the switching cost away from SHA-1, with the likely effect being that
most users stay on SHA-1.  I don't want to go there.

So I would say, support for arbitrary hash functions at compile time
and in file formats is important and I encourage you to hold us to
that (when reviewing patches, etc).  But in the standard Git build
configuration that most people run, I believe it is best to support
only SHA-1 + our chosen replacement hash.

Thanks,
Jonathan
