Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54DAA2036D
	for <e@80x24.org>; Tue, 21 Nov 2017 20:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751309AbdKUUwN (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 15:52:13 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33320 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751067AbdKUUwM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 15:52:12 -0500
Received: by mail-wm0-f42.google.com with SMTP id g130so11419085wme.0
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 12:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8Zt9JyuZd2560Af0GnmZ9fyPeS9Ac7rhpohe0kc1Xuc=;
        b=T5NxDI2gTNlK+GElOfXqnK1ri59F+1RNIpyCF56YUwFwTwZKBA9T6dRhZVROMOTkuG
         gDje4MgDU8VJt0BOHW0mfjix26rOFcWLMY3RL5dqyMEQi2uX3uefUQr1FalWlX8t3PTA
         TpiUQ6oNyle9t+WaCaYHl3qC1BhkjUobf6uELpe6vi6ryKCVddkmYkcboU68e4KvaTHx
         RiFhTWftCQEOeZnFlxM0oyJTUc2UeYonhwt8Szdx/3pgqh6XvAZUGs/B1p0rMtZz9cUV
         42zH7CYTdd0jX2Y60HO04cbVqMC/T8ucYkwG2Y3aIWESWRP68DixCD1bvYgTi1Q7BagQ
         4uog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8Zt9JyuZd2560Af0GnmZ9fyPeS9Ac7rhpohe0kc1Xuc=;
        b=i89Wb/x1U5BZuINGNO3nNgtyetSPo/FFeKeoLf/zc9Q4VbT1MrO7IB2alSLOtrNQ3I
         Vjk/41+JCI5V20yvJRmyXr4FtHvRveDTdYljDs6IaD2XEXGD7+M5aJywRnfPsMoHw/F5
         20pE+HS00Z5+BtTXF7h3FC1I3Lt+W5DlFyD5i4d5BtCuu2CRLguh/jl10JsLa0efaWcS
         9NhVMRJZDphmKkhXuf618/1C16qGKl3e0+DFskKvExnEbj/gqvEA4JmvQimeobHpY3Ho
         LOt2RsXbAFrHk1apuqPz5Uy+A/Tt5pXpUAeoSY4CkFW4RGLbbPqTbzlbUde6p6mgSfsl
         2WuA==
X-Gm-Message-State: AJaThX6CfOFeknp4RDUVMcae7VdwLBmr3RmeE/Lx/i/GgqolPUEeEsnK
        0VqIByI1SD1hAs6WV4chC0E=
X-Google-Smtp-Source: AGs4zMYJoHJcTiLm6qY5l4RAJNI7om5daWaQKFr4q88Kj8ZS1pY2ivVMktH3/h703f524++e0yKQ7A==
X-Received: by 10.28.70.66 with SMTP id t63mr2444034wma.106.1511297531243;
        Tue, 21 Nov 2017 12:52:11 -0800 (PST)
Received: from laptop ([46.233.112.42])
        by smtp.gmail.com with ESMTPSA id e131sm14114900wmg.1.2017.11.21.12.52.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Nov 2017 12:52:10 -0800 (PST)
Date:   Tue, 21 Nov 2017 20:52:08 +0000
From:   Thomas Adam <thomas@xteddy.org>
To:     Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH] git-send-email: fix get_maintainer.pl regression
Message-ID: <20171121205206.fvwjkkwhil4abmmk@laptop>
References: <20171116154814.23785-1-alex.bennee@linaro.org>
 <CAPig+cTXq6jSN9f2_xyj=Jfv_cg2kUFUtA5uVkZDrRRSi2x7vg@mail.gmail.com>
 <87wp2jwe9o.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wp2jwe9o.fsf@linaro.org>
User-Agent: NeoMutt/20171013-21-a9a9c7-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 08:46:59PM +0000, Alex Bennée wrote:
> 
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > Aside from those observations, it looks like the tokenizer in this
> > function is broken. For any input with the address enclosed in "<" and
> > ">", the comment is lost entirely; it doesn't even end up in the
> > @tokens array. Since you're already fixing bugs/regressions in this
> > code, perhaps that's something you'd like to tackle as well in a
> > separate patch? ("No" is an acceptable answer, of course.)
> >
> >>                 } elsif ($token eq "<") {
> >>                         push @phrase, (splice @address), (splice @buffer);
> >>                 } elsif ($token eq ">") {
> 
> I can have a go but my perl-fu has weakened somewhat since I stopped
> having to maintain perl code for a living. It's almost as though my
> brain was glad to dump the knowledge ;-)
> 
> I guess we could maintain a nesting count and a current token type and
> use that to more intelligently direct the nested portions to the
> appropriate bits. Maybe Matthieu or Remi (CC'ed) might want to chime in
> on other options?

Trying to come up with a reinvention of regexps for email addresses is asking
for trouble, not to mention a crappy rod for your own back.  Don't do that.
This is why people use Mail::Address.

https://metacpan.org/pod/distribution/MailTools/lib/Mail/Address.pod

-- Thomas Adam
