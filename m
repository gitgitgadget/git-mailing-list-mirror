From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/7] submodule groups
Date: Thu, 12 May 2016 08:32:46 -0700
Message-ID: <CAGZ79ka-d9skygE-LeoFz4ENY48mnn9CzVDmLvYSXH3PNVy3ug@mail.gmail.com>
References: <1462928397-1708-1-git-send-email-sbeller@google.com>
	<xmqq37pnj04f.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 12 17:33:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0sbm-000059-Gk
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 17:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbcELPct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 11:32:49 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:33634 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932527AbcELPcs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 11:32:48 -0400
Received: by mail-yw0-f176.google.com with SMTP id t10so86166692ywa.0
        for <git@vger.kernel.org>; Thu, 12 May 2016 08:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ga7cCmj2EcyqLRxEV2TmvYAgKnTaYxzQz1mIk0+kRUA=;
        b=Cyw75p5P7KF47FQO1MYPL12xFqcBkfLg1soBU1pRRKguqKdO1dShiSODg51aZ6sA6r
         OVkkACufmrK1R0bBXuZMxuszrd1YwSupGRhEgL2z0BBXZkKf6ndrPdkowrmm5yXQSmo8
         yF/TdpgJ4B/PIaz2EIP90x9ZphncyE29J8wFkZawteSfypM7zBNbvdOWx25UWwe0Vx0R
         23lBO5uAlHhqPnNu5xGMTUHjGuMG+xss57Ft40TT17hKM3zvlJm588XiHARayve5S3Bn
         0Wzk9kdweek6590hsU3jMEw3UKPDYtKDPjWGKa7I8SkufuxlFYyHotVFb1FJOGrOSCWK
         6tvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ga7cCmj2EcyqLRxEV2TmvYAgKnTaYxzQz1mIk0+kRUA=;
        b=mFjNLLLJyop5ANDkyZceWaiESQZRuTSbnYdDje5jAW2wwJh2mfoKwJ2XebUBoVwhSK
         N9Oo/eakP6DxEDICf7peVAP+zC8ZusIMrqqB22f/Q5uBCiDCLARcrp2pTrlGTKxYJWa0
         Mqo8XT1az2J4ql8bARa/1Fei3Ozsfnw7bm3kqjr07CMLIGxYRHix4UGG5v5mwPq7zUK7
         bnHHB84bKo52YUDDBxLbPkUp0VwMj6vsfrwVgyTCSlwEPMP6DmKi06nYnclOAW70Z0uJ
         cihzZRmNOtATPgo4dHpi/QX4FjgcRYGEAiwO6G/WF4GHvKRqYqmBU1dP7716dv5xmAxV
         NQuA==
X-Gm-Message-State: AOPr4FVlsUsgjxhdfAAL6s0uUQEzYlRtbSCDcf/jIhchh35RvyE4aPKL3am8kMYCpdIwXRO3TMW0gXjyXcN2M3uc
X-Received: by 10.129.90.196 with SMTP id o187mr4636102ywb.37.1463067167046;
 Thu, 12 May 2016 08:32:47 -0700 (PDT)
Received: by 10.37.29.7 with HTTP; Thu, 12 May 2016 08:32:46 -0700 (PDT)
In-Reply-To: <xmqq37pnj04f.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294407>

On Wed, May 11, 2016 at 10:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>     git cmd -- \*.perl \*.pl \*.pm
>
> I've often wondered if it would be a good idea to let attributes
> file to specify "these paths form the group Perl" with something
> like:
>
>     *.pm        group=perl
>     *.pl        group=perl
>     *.perl      group=perl
>     *.h         group=c
>     *.c         group=c
>
> and say
>
>     git cmd -- ':(group=perl)'
>
> instead.

How is that different to the file size example I gave earlier?
You could have a change which includes:

    -    *.pl    group=prolog
    +    *.pl   group=perl

What happens in the diff/log case then (just as a file can pass an
arbitrary file size within that change) ? These file attributes are as
arbitrary as sizes as well as submodule labels or names.
