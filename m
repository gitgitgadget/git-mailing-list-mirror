Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 010B52018A
	for <e@80x24.org>; Mon, 27 Jun 2016 19:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752291AbcF0T1j (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 15:27:39 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:35856 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbcF0T1h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 15:27:37 -0400
Received: by mail-lf0-f41.google.com with SMTP id q132so162985192lfe.3
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 12:27:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=atX5k7XRXmW6hhcMn5ijmjAWeWIXba6C+BiZ37q9g08=;
        b=JsANGIwdhO2HvsipdhU6fJJ9obIN6g1nmfuD9Fz0D7WdR3t8oiWuxPd/hOyqO9V7Xk
         d3eH0X14757Sej12cdViyHlOfMrVhcYLlMNCWSEM2h5E8M7gOXJpuB1uCyQBCydvaNVp
         0ErOnTHBS1TO2MFxmUgFg1iQ3BfQcLbXCHSt9gaTAxVKiOhyYoaZMMG4uq3kIDxgXbPH
         dFj87oTPWrj9c9//2ieY2oGTS7I7BJyrMNF6weUKGR8armB9GAHtAbhwocw9yOo/aPRO
         S5DWhJkXILcnNl0WDDG0rVRWS90JQ4t/FKTLf8usjJQMMnuwliz2VsOADDJ/ca0sK01H
         U7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=atX5k7XRXmW6hhcMn5ijmjAWeWIXba6C+BiZ37q9g08=;
        b=cYeccE7/wWMLO/H8B7CEFdkwYanbkfy9QolG22OjyTvTO/WlROCyvT8h2HffcZ7ZjC
         CYLckkSRxT4GjyMzyO3yh9kkyZsPHZKVvndrnTVVl8kaLz3dsyCkIS+WIDnjXgWCMflb
         fWMpUtAGr+Na5YM9FyoZHhgOYWUMkv+6vVe6cpViZvmZboBCs4ezN81ivTJj3zmrWfQl
         835/V2u2dTO0JzBryaD2UcgeKaegKIVXV2XHaApc0bYFt3SrlzwvrEOWo13Sc+5KvYhL
         Doak9RmEHjfilpcvJmV/H0lyFGs6yDUCEyjZV22rhsAPuTznelBqht96nqamHUqQ8A2R
         /YtA==
X-Gm-Message-State: ALyK8tIgLu+FH+R/TaFm/NXmOUj5IVjsie1bqiIUFPfbScgOw6WtaTFFVTUdzTCYMA+qYA==
X-Received: by 10.25.91.76 with SMTP id p73mr720171lfb.181.1467055654865;
        Mon, 27 Jun 2016 12:27:34 -0700 (PDT)
Received: from duynguyen (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id k18sm3557546lfg.47.2016.06.27.12.27.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jun 2016 12:27:34 -0700 (PDT)
Date:	Mon, 27 Jun 2016 21:27:32 +0200
From:	Duy Nguyen <pclouds@gmail.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	marcnarc@xiplink.com
Subject: Re: [PATCH v4 0/5] Better ref summary alignment in "git fetch"
Message-ID: <20160627192732.GA5774@duynguyen>
References: <20160605031141.23513-1-pclouds@gmail.com>
 <20160626055810.26960-1-pclouds@gmail.com>
 <20160627184354.GA9594@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160627184354.GA9594@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 27, 2016 at 02:43:54PM -0400, Jeff King wrote:
> On Sun, Jun 26, 2016 at 07:58:05AM +0200, Nguyễn Thái Ngọc Duy wrote:
> 
> > v4 is a cleaned up version of v3. Tests are added. Typos in
> > git-fetch.txt are corrected. The "{ -> origin/}master" format is
> > dropped.
> 
> Thanks for continuing to look into this.
> 
> I tried it on my most-horrible example case, and the results were...just
> OK. Because the variable-length part of each line comes first, the
> alignment code means that the "origin/$" bit of every line gets bumped
> out. And if you have a single large branch name, then everybody gets
> bumped out very far, even to the point of wrapping. E.g., I get
> something like (with fetch.output=compact, obviously):
> 
>   From ...
>    * [new branch]      branch1                      -> origin/$
>    * [new branch]      branch2                      -> origin/$
>    * [new branch]      some-really-long-branch-name -> origin/$
>    + 1234abc..5678def  branch3                      -> origin/$ (forced
>     update)
>    * [new branch]      branch4                      -> origin/$
>

Yeah, '$' lowers the chances of wrapping but in corner cases, it'll be
just as bad.

Junio's suggestion is one way to go. Another is Marc's idea of
breaking lines, so we could in theory have something like this

   From ...
    * [new branch]      branch1    -> origin/$
    * [new branch]      branch2    -> origin/$
    * [new branch]      some-really-long-branch-name
                           -> origin/$
    + 1234abc..5678def  branch3    -> origin/$ (forced update)
    * [new branch]      branch4    -> origin/$

Or, for a very long branch name, we could put replace a big chunk of
it with an ellipsis. If it's long enough, I guess you can still figure
the branch name with a big gap in the middle (or left or right).

   From ...
    * [new branch]      branch1             -> origin/$
    * [new branch]      branch2             -> origin/$
    * [new branch]      some-re...anch-name -> origin/$
    + 1234abc..5678def  branch3             -> origin/$ (forced update)
    * [new branch]      branch4             -> origin/$

And with that we get dangerously close to full customization using
pretty placeholders :)

> One of the nice things about Junio's "{ -> origin/}" suggestion is that
> it puts the variable-length part at the end, so there's no extra
> alignment required. And you'd get something like:
> 
>   From ...
>    * [new branch]      { -> origin/}branch1
>    * [new branch]      { -> origin/}branch2
>    * [new branch]      { -> origin/}some-really-long-branch-name
>    + 1234abc..5678def  { -> origin/}branch3 (forced update)
>    * [new branch]      { -> origin/}branch4
> 
> -Peff
