Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0499209A9
	for <e@80x24.org>; Tue, 20 Sep 2016 18:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932640AbcITSyk (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 14:54:40 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:36857 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932189AbcITSyj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 14:54:39 -0400
Received: by mail-qt0-f175.google.com with SMTP id l91so11999488qte.3
        for <git@vger.kernel.org>; Tue, 20 Sep 2016 11:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EPIJe0ummRf68j7A0/AUndGjrVdBKZpWxdiAY2nYgWk=;
        b=lnAtp+44SSWzL2n7W4jBmfgIRxjNBbwTi39RoXuZbKEQ+wthded3DqU5ZUpt1heOQW
         s2D6zJvmN0d+46ZWNUoEGcKM5aij045jdH8QdWZopo0dNs17yJhm1cYUTIqvrqJXXN8T
         LY/zGtG5mr2KoGwoyZ+YgZqPkJH9py6zZVOvFbOlXRVFC98MN6Yl0QJqm+2nSytZXlth
         BaNli/bxkAq4U6bs6r6pt3DcXv4Xa9eoqDPKOaIgvxPhxfaTWYCBdD6qphQsThVt9Law
         fdGIhvNDf0JjQjO0fv1CgCCP5TUO69Lj0VW5s5Jp3PxkAXQh1506f3Gjr5MQoSXpnc39
         tWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EPIJe0ummRf68j7A0/AUndGjrVdBKZpWxdiAY2nYgWk=;
        b=aL3liP4cykjYjFLLhCzkA9M5OLLR8ZdBBtzdCCH6LclIWhmZfDFLVBEFeF8tE6YHf1
         aALHkiaYwEfGlTQwHW4sjbzmWZ0Ezu4nlyoUH6FNDqZOVgqHrt9PI8M5phmMaa8VdLGC
         SsVwTV32ljdkSnj/zJEjlue5E1lXul5idLEEDSMhhCl5aBRkvOquTJEz+2gdts2nXohK
         vcGZQZkL32zE+Q5Ah7HApEjf6/FEmpA+nQhevss+J6LK+IviQol5u7xZ/pUo1YoGOvJQ
         rwGNLkc4HRze837Q4QpEssTiczJ9RT1PKxO7hdgDCd2/BwAuwoRExSVYesRgtDnHlemo
         FMXQ==
X-Gm-Message-State: AE9vXwP2KcouZTco7hdytvkOC73kzXt3OTvY0JGVB5jSrJ79Jr8Btu6mZZcFZvBDXhJQT3sd2mzYChI1el353wf6
X-Received: by 10.237.43.163 with SMTP id e32mr37777617qtd.124.1474397678315;
 Tue, 20 Sep 2016 11:54:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.105.1 with HTTP; Tue, 20 Sep 2016 11:54:37 -0700 (PDT)
In-Reply-To: <20160920162309.l0neYMQ3l%steffen@sdaoden.eu>
References: <20160920162309.l0neYMQ3l%steffen@sdaoden.eu>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 20 Sep 2016 11:54:37 -0700
Message-ID: <CAGyf7-FR11Ludt3vNZX7Ek4n_JLSON5+Y9By83GvNgpg94TWcg@mail.gmail.com>
Subject: Re: v2.9.3 and v2.10.0: `name-ref' HEAD gives wrong branch name
To:     Steffen Nurpmeso <steffen@sdaoden.eu>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 20, 2016 at 9:23 AM, Steffen Nurpmeso <steffen@sdaoden.eu> wrote:
> Hello again,
>
> yah, sorry, i'm back again..
> I try to find a way to find the name of the current branch in an
> automated way, because i need to ensure that a commit happens on
> it and no other branch.  Now the problem arises that the commit
> ref at the time of that commit maybe shared in between several
> different branches, but no more thereafter, of course:
>
>   ?0[steffen@wales ]$ git branch|grep '^*'
>   * stable/v14.9
>   ?0[steffen@wales ]$ git name-rev --name-only HEAD
>   stable/v14.8
>
> Is there another way except looking into .git/HEAD or using sed(1)
> on the output of `branch' to find the right name?

Have you tried "git symbolic-ref HEAD"?

$ git symbolic-ref HEAD
refs/heads/master

If you don't want the fully-qualified ref, you can add --short:

$ git symbolic-ref --short HEAD
master

> Thank you.
> Ciao!
>
> --steffen
