Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69BDF1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 23:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750986AbeBGXmH (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 18:42:07 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41173 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750736AbeBGXmF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 18:42:05 -0500
Received: by mail-wr0-f194.google.com with SMTP id u60so173477wrb.8
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 15:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mCLC/RqMyk22PddN0jSZ3a4MIbUrR58im7TEbTmRz7w=;
        b=cWVfDFPiRdexA0eZa6U5lKCWWabXOgGA2jOq5oSqME3R6MP9SuQLikEqSF+r7nMJQn
         riLo4Qum9wxOuX0tusbGwZMIfZWNyjXknC2/Dp5bUlvgmHPyfjPyYe24/5YRYhcSsDKc
         6yI2s5eQ10aINwTK7CduXZPHwCypw7FaKA7HPg15PcOzG4LKX16IUHBREccrTzTAsR1N
         0v05z40CxYKxuE5K8HQWztGXppRTX6vuIDtaMeehREPIBA0oev38Kvbh+sCQzUvFKXig
         hZ9oqtgdpbiCxtxZvDtJgxNdLYrPbtPq1sTWqb3camcPi58kOG+Rj3Ogtu6VMNVsBGKs
         FrBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mCLC/RqMyk22PddN0jSZ3a4MIbUrR58im7TEbTmRz7w=;
        b=WSY8WUYWMd6QeLFOqhCSKKLdPeK17gf0uhTGDFV0yvI3ph7LqHn/KfVXdieL9nss1X
         remAN42ZictgX2nXswDrb0db9IyzBAVpi8HUFYghK3VcX2WloMkdvAaGH9kyVEcwQNnC
         W9vY+B9EKnaWL5CjLrMgYoqlBzsEmMIP4ucUP1YTRkaOJxpCmaRfS/UqyeLH+xNdCvEg
         F6olQAnSvT4VQ+s/wl2XcmcLMjVxs1cxltMPJDGqhTUuKy158Kg2+pwPbzzCxbB6nJdM
         kZOKPZX1HOt7Ru7a1BSBKxLFWRYW469HM6+fpqcxs/UJca8GA8cChrS2Mw5DpwBm3lBT
         BGpQ==
X-Gm-Message-State: APf1xPC4CezO9F7mr1GgpcGof3zoikVA5nZ8/HCsgeB/xcSFV8g2smXP
        JzyvZvUSseHBaxGKCinAGUY=
X-Google-Smtp-Source: AH8x224wfkaIp43qFjnH5Rag2RYF0SackLR1xwIuvx61DMhZsevkVBWLw86CEY8qIbHwn77S/2Vcmw==
X-Received: by 10.223.200.140 with SMTP id k12mr7455896wrh.146.1518046924193;
        Wed, 07 Feb 2018 15:42:04 -0800 (PST)
Received: from localhost.localdomain (x4db1262f.dyn.telefonica.de. [77.177.38.47])
        by smtp.gmail.com with ESMTPSA id b65sm3735093wrd.26.2018.02.07.15.42.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Feb 2018 15:42:03 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 01/41] parse-options: support --git-completion-helper
Date:   Thu,  8 Feb 2018 00:41:52 +0100
Message-Id: <20180207234152.5087-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.158.ge6451079d
In-Reply-To: <CAPig+cSxxEn5q_5gv9JDXprnnocTTaLaugnhYmpHJz5tzOAkEg@mail.gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com> <20180131110547.20577-2-pclouds@gmail.com> <CAPig+cT5GkhFJ9XFDSirGjfoji4qUCM8LA6abdRsaT=g3prznQ@mail.gmail.com> <CACsJy8B0D=u5fGA2QWuG6QG-fmReg=GayC54+pSFjXHDrnKh3w@mail.gmail.com> <CAPig+cSLYDJaxCyAH_zK0cat2-60OZGWGy_ZLHwitHfZ7oA78w@mail.gmail.com> <CACsJy8D5iGVDHKoMeQjm+Seea_pTixsb8Xq6D1w17Y9M42iAPw@mail.gmail.com> <CAPig+cRWzvcDUjw7CR78nZ0cbE-mPkB1a4UZqiChR0NUKSZOVw@mail.gmail.com> <20180205095608.GA12370@ash> <CAPig+cSxxEn5q_5gv9JDXprnnocTTaLaugnhYmpHJz5tzOAkEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> > OK how about some thing like this fixup patch? __gitcomp_builtin now
> > allows to add extra options as well as remove some.
> >
> > -- 8< --
> >  __gitcomp_builtin ()
> >  {
> > +       local incl="$2"
> > +       local excl="$3"
> > +               options="$(__git ${cmd/_/ } --git-completion-helper) $incl "
> > +               for i in $excl; do
> > +                       options="${options/$i /}"
> 
> Is 'options' guaranteed to end with a space?

It is, note the space before the closing double quote in:

  options="$(__git ${cmd/_/ } --git-completion-helper) $incl "

> If not, then this
> expulsion will fail for the very last option. I'd think you can get by
> fine with just "${options/$i}".

I would prefer a space both at the beginning and at the end of the
pattern.  Please excuse the contrived corner case, but it could still
fail if the option to be excluded is a suffix of an other option:

  $ o="$(echo --foo--bar --baz --bar) "
  $ echo "'${o/--bar /}'"       # exclude '--bar'
  '--foo--baz --bar '

Maybe we'll never have --opt--ions with a doubledash in them[1], but
still...

  $ o=" $(echo --foo--bar --baz --bar) "
  $ echo "'${o/ --bar / }'"
  ' --foo--bar --baz '


[1] - Interestingly, grep shows that the German translation does
      contain a '--reset--author'.
 
