Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F7E520964
	for <e@80x24.org>; Tue,  4 Apr 2017 16:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753477AbdDDQxZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 12:53:25 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35636 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752869AbdDDQxY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 12:53:24 -0400
Received: by mail-pg0-f44.google.com with SMTP id 81so158038398pgh.2
        for <git@vger.kernel.org>; Tue, 04 Apr 2017 09:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0s5GZqu3qwTXZtq3WUfusONaZT/b1rhfStpFNilq8I8=;
        b=TE//6osesxupOBgOynxNeoC9H1ER7G5/Ljo333U/fWJ16qrIotkcEJFVq3qyI+ZHcC
         WDP5YWpEIX7djPgJlkD3i1UV388I2jX5feMrMrs3+gZ0gBPi1InbaMZhaD0hd+rTpRzy
         02s0dIP9EC9p25BrRhdLbZpGInz4ec/pgzBan2e/HY1LECCdGWr4vJkdNuclm0E/uUeu
         aNdNG+HBF5vWZuJbWthbeM7gaN5Ngr04+SXGrulBSJrK2wLW7Z9ytKOhEyIGPXOo1T0k
         u1A/TcY/LxW/TNdyechyF1ZJwaIHqq7stSyXp2Xgo8rbHis7kEZgjiVX3GiEfieSdAaT
         ee6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0s5GZqu3qwTXZtq3WUfusONaZT/b1rhfStpFNilq8I8=;
        b=laQ10w0Zyp7iyFaRp00sxJRDsd2rVC/Ym3ExDO5YjjVPo1pxm2/H0lWOwQYGGlSAIl
         CxFqoyjvsM2x0HxWor5shUZrHOSqpOzbGTLUym8fcDNwFyHPZgGUtH37arQpxAgyADir
         HtgtFlU0tTjBg1cqv6VD8fUpL0jdGPMH2gNLBVlSNK+EzId1CKZGz7seXNtxWEBualhf
         6N+teE7aG1If37Gi5xQEBt72cMQKKJeQIMuHSyGBpYTfT7qppiH2j1NGzErx8sHN+XVN
         wMkquUC/dcFhVCL8dbZbkNdWrquYNirQioBDCmL98X07H5T2HLvBGbzqsHYPKdlKsaTl
         /Pdw==
X-Gm-Message-State: AFeK/H3kCmjf7y4IiGyaYxEJrejSjWEzjal4P3VBI6oLaVLFE9kC1Oovmm/nFsktulfjQCv6
X-Received: by 10.84.175.129 with SMTP id t1mr29930041plb.17.1491324804041;
        Tue, 04 Apr 2017 09:53:24 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:c58e:393:23cb:53be])
        by smtp.gmail.com with ESMTPSA id n24sm32979548pgc.43.2017.04.04.09.53.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 04 Apr 2017 09:53:23 -0700 (PDT)
Date:   Tue, 4 Apr 2017 09:53:21 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>, frank@gevaerts.be
Subject: Re: [RFC] dropping support for ancient versions of curl
Message-ID: <20170404165321.GC189807@google.com>
References: <20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net>
 <CACBZZX78oKU5HuBEqb9qLy7--wcwhC_mW6x7Q+tB4suxohSCsQ@mail.gmail.com>
 <20170404083341.uajswm3qdzyvzxsp@sigill.intra.peff.net>
 <CACBZZX5D2cYf0-ob_Da0EsxRtZHfegezPtCGA10-sjfi0A+AoQ@mail.gmail.com>
 <alpine.DEB.2.20.1704041351350.4268@virtualbox>
 <CACBZZX6W+fbCg7xXKuM=iqnSYFENBYxYT1WJmoOvYYCBEkX=hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX6W+fbCg7xXKuM=iqnSYFENBYxYT1WJmoOvYYCBEkX=hQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/04, Ævar Arnfjörð Bjarmason wrote:
> On Tue, Apr 4, 2017 at 1:54 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> > On Tue, 4 Apr 2017, Ævar Arnfjörð Bjarmason wrote:
> >
> >> I think it's completely fine to include your patch as-is. At some
> >> point we need to pass the burden of dealing with these old software
> >> versions, saying that you should use a <10 year old library isn't
> >> unreasonable. Anyone packaging new git on RHEL5 or derivatives can
> >> just package a newer libcurl as well.
> >
> > But how much maintenance burden is it, really? Is the continued use of
> > those #ifdef's really worth this much discussion, let alone applying a
> > patch that may break users who have so far been happy?
> >
> > It would be a different thing if we had to have hacks to support old cURL
> > versions, where we need to ship entire >10kB source files that tap into
> > internal data structures that may, or may not have changed. Such a hack, I
> > would be happy to discuss when we could possibly remove it.
> >
> > But a couple of #ifdef's? C'mon, man, we can carry this *without sweat*
> > indefinitely ;-)
> 
> I don't really care about applying this patch, but I wouldn't mind
> seeing it applied.
> 
> I just wanted to clarify the counteractive point that it's not unusual
> for some (particularly corporate) environments to be compiling fresh
> upstream releases of some software against really ancient versions of
> other upstream libraries.
> 
> But as Frank Gevaerts's reply (thanks!) which came after your reply
> points out, this code has already been broken since v2.12.0, so it's
> rarely used enough that nobody's reported being unable to compile git
> 2.12.0 on e.g. CentOS 5 >2 months since release.
> 
> I think this is a stronger argument for removing stuff like this. At
> some point we're shipping code nobody's tested in combination with the
> rest of our code. This can easily becomes a source of bugs as someone
> e.g. compiling a new git on co5 becomes literally the first person to
> ever test some new combination of codepaths we've added around mostly
> unused ifdefs.

I'm all for seeing a patch like this applied.  I agree that we can't
expect the world to be running the most up-to-date version of curl but
we should be able to select some "oldest" version we will support which
can be bumped up every couple of years.  

I mean, ensuring that you are running with an up-to-date version of curl
is really important when it comes to all of the security fixes that have
been made in each revision.

-- 
Brandon Williams
