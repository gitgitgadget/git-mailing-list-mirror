From: Taylor Braun-Jones <taylor@braun-jones.org>
Subject: Re: fetching from an hg remote fails with bare git repositories
Date: Thu, 6 Aug 2015 14:21:01 -0400
Message-ID: <CAKfKJYtujyEBH4JhTyt=PzZbpB-iYhi=h5FbjAM2j9cuDGh1Hw@mail.gmail.com>
References: <CAKfKJYuuO+eak-L2SUVUEmoOj16bgV6LL0S=g-LzFjTxZUcRzQ@mail.gmail.com>
 <CAGZ79kawh0himmR+DuvcQB0O1rRVBhkg9ycCLvPdbp1m0sHKtQ@mail.gmail.com>
 <CAKfKJYshy58eQMXTusUTf0dc2B7uVU+=rzdSicSG0JAuODSBug@mail.gmail.com> <20150804230359.GA27965@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Aug 06 20:21:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNPnF-0005JF-B0
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 20:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755861AbbHFSVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 14:21:25 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:34864 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755692AbbHFSVX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 14:21:23 -0400
Received: by igr7 with SMTP id 7so16669305igr.0
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 11:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=braun-jones.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IlLB/o3ENprOOe5Ww/TWH2+6sKTFZy6zq/vc5ll8gv0=;
        b=G43sse1836o1c3AK4hwBvSjXGT3X/JThn+UmDyWBM2hkihY4rhZ6fp1KZ5d7H+noaO
         +Ad1ATC+x+ogJoVP7Y6Pbw7tbtdhIGl6uAOdV6t0iYz8DsrPBAvqLMtuuvIH1Sd7KLgV
         7eqGTwz4/U/VbeC0hm7ny1MULbM2iLIgASRtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=IlLB/o3ENprOOe5Ww/TWH2+6sKTFZy6zq/vc5ll8gv0=;
        b=BIJKOoN+oY+hcYOlCMfrWIdSghO5ghI39Wf4D6zqx2cNNFCVfZ9qwK/yC/MHz2YeKS
         HR+xcJGcyPwFx5xvt0EaFGkqS+MQ52e6+qUWUQgdy5AAQ0xbKNkwgJogBEPK6UDv2RQL
         pdMNtLBpZXmcSflQBngLicp8YPlJ3KR41ZD68gjQZOfOSwsEH8+L0bGxOksvUIc/oHH+
         SqkaEyMfWFmyULeu6eTk2gA12n81tsclUubvdvuu9Hs+2sfFkWvHK3SelCUM4FBayAiH
         TDQH9qbHvYfMihrRSluDwvugrmvvHlsuO7h6beA/GWnB1O/NMLz2qAOS7QayDhliGbo0
         XYlw==
X-Gm-Message-State: ALoCoQmsX2izaPDbdknhuu43/x6DeO42c+3QpPO8Yr6ZrJaYO7NlUNEcwWNqTcVXeBg+/i7Kyx7q
X-Received: by 10.50.134.226 with SMTP id pn2mr5994929igb.21.1438885282605;
        Thu, 06 Aug 2015 11:21:22 -0700 (PDT)
Received: from mail-io0-f180.google.com (mail-io0-f180.google.com. [209.85.223.180])
        by smtp.gmail.com with ESMTPSA id j3sm1916776ige.0.2015.08.06.11.21.20
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Aug 2015 11:21:21 -0700 (PDT)
Received: by ioeg141 with SMTP id g141so89593158ioe.3
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 11:21:20 -0700 (PDT)
X-Received: by 10.107.153.206 with SMTP id b197mr4692327ioe.71.1438885280422;
 Thu, 06 Aug 2015 11:21:20 -0700 (PDT)
Received: by 10.107.8.37 with HTTP; Thu, 6 Aug 2015 11:21:01 -0700 (PDT)
In-Reply-To: <20150804230359.GA27965@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275432>

On Tue, Aug 4, 2015 at 7:03 PM, Mike Hommey <mh@glandium.org> wrote:
> Another missing detail is what you're using for mercurial support in
> git. I would guess https://github.com/felipec/git-remote-hg.

Yes. I was going off some outdated information on the web that told me
the felipec/git-remote-hg had moved to mainline git. I now see that
has been undone.

> Shameless plug, you may want to give a try to
> https://github.com/glandium/git-cinnabar.

Thanks, I'll keep an eye on the project for support for pushing merge
commits. That missing feature is a show-stopper for me right now.
Since git-cinnabar is not doing a full hg clone under the hood, is
there a chance that it will support shallow clones? (even before the
native hg client has this feature...)

> Anyways, your error looks like what I fixed in 33cae54, which git
> describe tells me made it to git 2.3.2.

Yep, grabbing the latest version of git (2.5.0) solved the problem.
Sorry for the bother.

Taylor
