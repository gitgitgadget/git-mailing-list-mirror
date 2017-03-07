Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 062F520133
	for <e@80x24.org>; Tue,  7 Mar 2017 01:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754614AbdCGBHm (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 20:07:42 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34973 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753106AbdCGBHj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 20:07:39 -0500
Received: by mail-pf0-f176.google.com with SMTP id j5so67437650pfb.2
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 17:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8bZrVa6vBclni06ggRL3K09RCfkQ7vzUgMbFnCmbpe8=;
        b=ufGEiItS5sUiH0CGG3eZzyeg7mx+zfjBnw9Sfz2wST9pcQzWy4hKpLUne0HsYlcuVM
         3BXN5p9gGcbsvcP1yEJ/BuICBOyUg73nlmbuzjl7jFL/CQmqsYC/U1sJBOdqlzhkwpmE
         75nWEIYGFUutC2/vHICI2BepTigOi8II+XIs7UF4dCKk7Zf1dDOu7Iz9J7GvRjQHRACR
         nlIe8iWYIieFqs+PnbGefDrffU4BBVXKYbzQ4bTKW7ocwq4wYGYESDeaYcT/g26had3b
         9U/mJRtaRlA+XUaGJGe2O+MkIBRCideZX4EEO7ZRzbom1WtYK+Z0d3IjP+aYDgfJc72c
         Xb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8bZrVa6vBclni06ggRL3K09RCfkQ7vzUgMbFnCmbpe8=;
        b=KGpkv6vqGw1bXdtvq1keZVwxLMR4sW3IXOHiKhK7+92xzELrALKuT9ZhzR5NEF0UkM
         EFcEtqcjI6elb1bigcgI9dRi7nYDOuMRHYZdIJdv3TT17OeX0kg20Ug5rSgkgZx80duQ
         oHCf4C9SRArYBmuSscxXdL8bmuY1YUZUqqhAeDV9Nsg/zCoxR3d40A0LuCf3HdwY0fna
         pZGJWNLT3pPoq/PHvNs2SQ48XVH1svezfL3TIG0c7jRqWfphOwbRxSvC0NOpuan+2LZq
         q+X5ykjcKNoAs6Y92owwd0KySsJaTjf4BuC/e39CHmsxfL7t90YhIEjunwIpEbMzvZDQ
         FLzg==
X-Gm-Message-State: AMke39n6yvzrHIteYCqX36VlTh0dCU/wk1Gyp6u9asioA2wMyS2RKP0OvP5tvHE4/PdmcqvBwOdoEPwALtBuVBx9
X-Received: by 10.99.134.199 with SMTP id x190mr23516041pgd.194.1488848297137;
 Mon, 06 Mar 2017 16:58:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Mon, 6 Mar 2017 16:58:16 -0800 (PST)
In-Reply-To: <xmqq4lz6ymlt.fsf@junio-linux.mtv.corp.google.com>
References: <CAGZ79kYxD9B_+3vBgO+Z-wh2GMg_REazA-xpTSAqe3_64VMV3w@mail.gmail.com>
 <xmqqshmqm4ur.fsf@junio-linux.mtv.corp.google.com> <CAGZ79kZU+-5D0bHSA1duRLnvjb+P67AzGhESS6J1z5qtO8SXsQ@mail.gmail.com>
 <xmqq4lz6ymlt.fsf@junio-linux.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 6 Mar 2017 16:58:16 -0800
Message-ID: <CAGZ79kYaUsyU9toKjiCahtUC2Ze7KnZ+iMByu6woyZEnH_10kA@mail.gmail.com>
Subject: Re: [Request for Documentation] Differentiate signed (commits/tags/pushes)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     tom@oxix.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 6, 2017 at 4:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> "tag -s" also has the benefit of being retroactive.  You can create
>>> commit, think about it for a week and then later tag it.  And ask
>>> others to also tag the same one.  You cannot do so with "commit -s".
>>
>> ok, so there is *no* advantage of signing a commit over tags?
>
> Did I say anything that remotely resembles that?  Puzzled.

Well that was brain having a short circuit.

>
> If the reason you want to have GPG signature on a commit is not
> because you want to mark some meaningful place in the history, but
> you are signing each and every ones out of some random reason,

and I am looking for these "some random reason"s.
If it is e.g. a ISO9001 requirement, I'll happily accept that as such.

By signing things, you certify your intent, i.e. by signing a commit,
you certify that you intent to create the commit as-is in some repository
on some branch (unlike the push certificate that specifies the repo and
branch).

> there
> is no reason why you would want "tag -s" them, so you can see it as
> an advantage of "commit -s" over "tag -s", because to such a
> project, all commits that are not tagged look the same and there is
> no "landmark" value to use "tag -s" for each and every one of them.

Okay. They are two different things, but to me they seem to archive
the same thing, with a tag having more niceties provided.
e.g. when you make a new release, you could just bump the version
in the versions file and sign the commit. As the commit is part of the
master branch it would not get lost.

The formerly mentioned "not polluting the refs/tags namespace"
is applicable to mergetags, that are a side tangent to signing
the commit vs creating a tag?

Now as Jakub mentions that signed commits came before the
mergetags were introduced, the existence of signed commits
sort of makes sense, as they were there first, but now are
superseded by more powerful tools.

> It is entirely reasonable to sign a merge commit that merges a
> signed tag.  They serve two different and unrelated purposes.

The signed tag that gets merged certifies the intent of the lieutenant
to ask for this specific content to be pulled and integrated, whereas
the signing of the commit certifies that the integrator intends to create
the merge commit as-is and e.g. resolve the merge conflicts as recorded.

Thanks,
Stefan
