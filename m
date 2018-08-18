Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12B2F1F954
	for <e@80x24.org>; Sat, 18 Aug 2018 20:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbeHRXvn (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 19:51:43 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:44928 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbeHRXvn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 19:51:43 -0400
Received: by mail-pf1-f180.google.com with SMTP id k21-v6so4935252pff.11
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 13:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=esl+TKY9i1S5PwxL6hhor40Xr61Owlbs5sjsW6/KVAo=;
        b=EGJCpHqigomPijWLVnNKSCErJBNVbtQyKQP3O1iVveRTilHyesnby6NYqC7ypIvI+i
         3TqBrXHkt0+1qFIvN7JCZnKLw0QMEsrV+N14uY/IEJaxv9Qh86zNsAG0frjFlYGvVwuG
         XFXWmJjYFhnckPF7+RtWrsvWWTjcY+9X82ZstbVenPcGcFlIAuefToW2e/vL/lynrg17
         HU9CiF1RYaNfDFzbS3UHPAJpTbEjdlfkHGY2t+1wi5CbPUzHfYef+6NvnMlYxrN2n5t4
         HDaW035kx8XPkdVMNljYhJXrSrbUXg23lqwH1xPjoH/9iCy9AbfDUc6iZycecwVjdzil
         /7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=esl+TKY9i1S5PwxL6hhor40Xr61Owlbs5sjsW6/KVAo=;
        b=Ep+t5v6OJXWudUI12dhsDQXHBh6LZods7VCZpeOOjXshl1XNEsToABixDXHroSIwkf
         rRVyqeU2ujYMIXq2RZXbbYRe7n7bdMIxw00GIooih3vCviWmxb9h8aTarCTk+fi2GyuU
         dumhMwz7Do5l6/qNCkgK1xmXQbYfi+3uxrDuwg2ewhv30Cpzb0H+7aAJCAxXlE+7siRU
         kM2XMkWsYpIGEw2/YQA6xWKzq8dUVi8hXp3VdF92CDwWUU6rYC9FS5BMI6ZFaoGWudtK
         uZx6hjHTuXDuDEhVWYsXxjsbS8mfFfsLFFdBTtsnyGK5VpWKg+GN9WpdcajWtqMPXXLN
         9thA==
X-Gm-Message-State: AOUpUlFqlmBTA7TNkzds6OZ64HzWRymjAxQJ2NlOZZYHhUuy6cR0cxYQ
        7zx807Cn5CdRu3w3f3UnCbOPDKZW
X-Google-Smtp-Source: AA+uWPxAVbWPFN2wgqjwBXwNtioD85gBn8Qrk+om+A+LBeEIE/37Dbsy7l+T25HPxdsNKyUQ6QYCvw==
X-Received: by 2002:a62:571b:: with SMTP id l27-v6mr41848946pfb.29.1534624965874;
        Sat, 18 Aug 2018 13:42:45 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id x25-v6sm6027792pgv.63.2018.08.18.13.42.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 13:42:45 -0700 (PDT)
Date:   Sat, 18 Aug 2018 13:42:43 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Michael =?iso-8859-1?Q?Mur=E9?= <batolettre@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-bug: Distributed bug tracker embedded in git
Message-ID: <20180818204243.GA136983@aiede.svl.corp.google.com>
References: <CACSZ0Pwzs2e7E5RUEPDcEUsa=inzCyBAptU7YaCUw+5=MutSsA@mail.gmail.com>
 <20180818054300.GB241538@aiede.svl.corp.google.com>
 <874lfrrhfp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874lfrrhfp.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:
> On Sat, Aug 18 2018, Jonathan Nieder wrote:
>> Michael Muré wrote:

>>> I released today git-bug, a distributed bug tracker
[...]
>> I am a bit unhappy about the namespace grab.  Not for trademark
>> reasons: the Git trademark rules are pretty clear about this kind of
>> usage being okay.  Instead, the unhappiness comes because a future Git
>> command like "git bug" to produce a bug report with appropriate
>> diagnostics for a bug in Git seems like a likely and useful thing to
>> get added to Git some day.  And now the name's taken.
>>
>> Is it too late to ask if it's possible to come up with a less generic
>> name?
>
> Wouldn't we call such a thing "git-reportbug", or "git gitbug", with
> reference to Debian reportbug or perl's perlbug?

I hope you're kidding about "git gitbug".

[...]
> 1) Accept the status quo where people do create third party tools, much
>    of which are way too obscure to matter (e.g. I'm sure someone's
>    created a tool/alias called range-diff before, but we didn't
>    care).
>
>    If those tools become popular enough in the wild they get own that
>    namespace, e.g. we're not going to ship a "git-annex" or "git-lfs"
>    ourselves implementing some unrelated features

That's fair.  Let me spell out my thinking a little more.

This framework would lead me to rephrase my question to Michael a
different way.  Instead of saying that I'm not happy with the
namespace grab, I should say something more severe:

  Don't be surprised if Git itself makes a "git bug" command in the
  future, and be prepared to rename.

Is that preferable, in your opinion?

I still think it's a reasonable thing for me to ask about, if only to
save Michael some trouble later.

Thanks,
Jonathan
