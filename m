Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24E611F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 16:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKLQ36 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 11:29:58 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40757 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfKLQ36 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 11:29:58 -0500
Received: by mail-lf1-f66.google.com with SMTP id j26so6269311lfh.7
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 08:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deltaq.org; s=deltaq;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QVekJxEK/TfnZbryK06nbBZHHmzpOcA1dssYxYDjM+s=;
        b=ccMl3UNjHJmLsaIOtLJhntGiReYJbCQTDQLAXG0byWWmznzqSBmCkKGQ7/xRHaMvpG
         vpsRHce8POuU6oQ8hNAaQZiju93dhRvPUaRXbjkynujBd0O7fB1ye0VCRsRozWeLAwbp
         bZtdEwrx2OUZ3n87k3pNKmpoIz/BG7b/DLfoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QVekJxEK/TfnZbryK06nbBZHHmzpOcA1dssYxYDjM+s=;
        b=JUOJ9Lt6N1fv17ig/IBeYNNrlx3XHfYbh5jkBH6zJNlNqj1pMvS1xdIpn0kEZ+58Zp
         mikRKNc8XdliZE70IXU2I9xG1g5H5LUYnQapGA0+eQzCQD8kGAfcgytlu1H5bFLlNHOr
         iTAQg/klGMfhQOnOPmPSagRD+ChWQTSmjdu7Js9NoHUxOgJqaggW+MGgyV9/PHY739we
         TT30WJVWbPoeDaOJaN9Q7CJvGA1F4XtZEZ4S9842qt4B2KOwharTSd7JEpbslOtHbWUw
         dClBYKpFcBWlBtWTSCx0cExKs5wpBzK3yV6ENG2o2MP9T3f9zMrhyW9sQ+rQNe/H0Am/
         MmyA==
X-Gm-Message-State: APjAAAXTJeeVccvi3hacyMsIazlSaOyiJkYEeTLBTk4t4q0+vWpLU3J4
        owowJs5gzMBFurYBiOBN566i7rIbGDk0Gc8KrZRdyjn8yUVdsQ==
X-Google-Smtp-Source: APXvYqydDbiyzvI4quj9mUf+qvqBQDjpFFFqUJZcwoqb6bQ/FE0bQ3IRxBocG13/PMn7Fw4URoGTnqtIs8kj+F9+1mc=
X-Received: by 2002:ac2:5298:: with SMTP id q24mr1009335lfm.74.1573576190609;
 Tue, 12 Nov 2019 08:29:50 -0800 (PST)
MIME-Version: 1.0
References: <pull.436.git.1572418123.gitgitgadget@gmail.com>
 <pull.436.v2.git.1573110335.gitgitgadget@gmail.com> <9469beb59937f87647190cf7f56544b8c27e20b6.1573110335.git.gitgitgadget@gmail.com>
 <20191111192526.crllpe3phitneu3p@yadavpratyush.com> <CAPSOpYv0NNihiWF2LL=czoP7N2CGNSkB8SBNTZ65iOZVOBPqbA@mail.gmail.com>
 <a1dd45d5-8dac-e86f-c964-957ff0b8dfb8@iee.email> <CAPSOpYsbBX3d_oWJHtKHD7b0cXcELF=t-zYNEVpU3sf8qzD4Ew@mail.gmail.com>
 <11812626-07f7-5610-cd13-ce4bdda4f674@iee.email>
In-Reply-To: <11812626-07f7-5610-cd13-ce4bdda4f674@iee.email>
From:   Jonathan Gilbert <logic@deltaq.org>
Date:   Tue, 12 Nov 2019 10:29:36 -0600
Message-ID: <CAPSOpYt71DGzkQxQDaMm88hR5bO8npKEY7tBPTypZ+aE1yp6gA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] git-gui: revert untracked files by deleting them
To:     Philip Oakley <philipoakley@iee.email>
Cc:     "Pratyush Yadav me-at-yadavpratyush.com |GitHub Public/Example Allow|" 
        <172q77k4bxwj0zt@sneakemail.com>,
        Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Jonathan Gilbert <JonathanG@iqmetrix.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 12, 2019 at 4:45 AM Philip Oakley <philipoakley@iee.email> wrote:
> On 12/11/2019 04:49, Jonathan Gilbert wrote:
> > On Mon, Nov 11, 2019 at 4:59 PM Philip Oakley <philipoakley@iee.email> wrote:
> >> sounds like "Currying" a function but with the parameters taken in any
> >> order, though, in a sense, perhaps not generating intermediate functions...
> > It's like currying if you could pass g(x) = f(x, y) to one block of
> > code and h(y) = f(x, y) to another block of code, so that each of g
> > and h are each like curried versions of f that "bake in" one of the
> > arguments, without having to know which one will get called first. :-)
> >
> > Jonathan Gilbert
> So that would be called "Chording"...
> (Is there a 'proper' technical term for that approach?)

Not an entirely implausible term :-) The only other implementation
I've ever seen was Microsoft's "Polyphonic C#", which got rolled into
C-omega. I'm pretty sure, though, that it was never referred to as
something you _do to_ a function, but rather as a _different type_ of
function -- as in, the function hasn't been "chorded", it "is a
chord". Very little literature one way or the other though, and this
is the first actual, live use case for the structure I've encountered
in my years of programming :-)

Jonathan Gilbert
