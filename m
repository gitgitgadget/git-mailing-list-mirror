From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then slowest to fastest
Date: Wed, 20 Jan 2016 10:22:16 +0100
Message-ID: <DBA834D2-BFC9-4A2F-94D9-A1D0D60377BD@gmail.com>
References: <1453195469-51696-1-git-send-email-larsxschneider@gmail.com> <20160119191234.GA17562@sigill.intra.peff.net> <xmqqegdd8997.fsf@gitster.mtv.corp.google.com> <20160120002606.GA9359@glandium.org> <xmqqfuxt6n00.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Mike Hommey <mh@glandium.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 10:22:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLoyB-0001Ji-GD
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 10:22:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934302AbcATJWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 04:22:24 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38542 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934034AbcATJWU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2016 04:22:20 -0500
Received: by mail-wm0-f49.google.com with SMTP id b14so18653225wmb.1
        for <git@vger.kernel.org>; Wed, 20 Jan 2016 01:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dUETfVn2kRbmwk079jRHP4g32Qal1Dw+2k2b/9/2EPc=;
        b=cpqj9IKT3rs/FMIpcGME0sJnAg5xXWF/38sO5ec4C6s8UC36p2X7iGnz3eUBrkspJ1
         6pZJ92R8WZbhIAftAOdTpa/BGZ/VzBvm+WD6no7ExyJzvJ1WG0oSYVcsRp0zuuFA9sBh
         xxbcEuLD8Dq7rn9cF+sdzNaR+wBhoHK3GOUKXUBka+g6XWL9zW8Nph0b+EAfJD3MelqL
         tQXj99R9unJScGJlnL1QDVwE/kYOB1qikGK4VXTR5Iy4m8pGnkWbUt67B73is2dmVUsU
         02wsyoYXwp6FDVHqjR+Z8mogCo9TA+8SYVJrhV217CbfVEW69/ejbJQee56dcC7kMgWW
         HDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=dUETfVn2kRbmwk079jRHP4g32Qal1Dw+2k2b/9/2EPc=;
        b=m/Zu+CETIcApqytlv4zcHCSrgPwiCLT72q/2saOuZdR47bIrWc33djDI7d6GNZ/aAr
         loKX0QUzoEb3gIU00t/LcBaZdU5gQ7vusmXEeItMWQpKVoq9mXp9V3EO5wsKgvlQiftR
         iVVFu6C327tfOLn90e05ZL57pHxmHlCfYcLK9Xo2dh7nzF2weLiqXwu7/YYnqr7r3Uai
         L0p+fZBMmMp3Le2/ZynzVTfo67x4jUT68w8FxHyQF+xPQO7nLylPb0uAIslolIUO+frh
         fFieYIWaH+6Q1KLMfB2gm1wxe4lEuBdDFvqOKF/lHA/xrTJ42is/gQz5OvCo51cjTe01
         0v8A==
X-Gm-Message-State: ALoCoQnJcBW2M0/RSyPwwz0NBY8f6jv6IiDHkGbtInXFCAYqcRNGevowblgR6gb1NRPO8H1Mnb2grU7n+Xb8VQAUpNVHXJx+7A==
X-Received: by 10.194.249.69 with SMTP id ys5mr33110343wjc.97.1453281739260;
        Wed, 20 Jan 2016 01:22:19 -0800 (PST)
Received: from slxbook3.fritz.box (p508BA58E.dip0.t-ipconnect.de. [80.139.165.142])
        by smtp.gmail.com with ESMTPSA id u4sm32132264wjz.4.2016.01.20.01.22.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jan 2016 01:22:18 -0800 (PST)
In-Reply-To: <xmqqfuxt6n00.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284433>


On 20 Jan 2016, at 02:46, Junio C Hamano <gitster@pobox.com> wrote:

> Mike Hommey <mh@glandium.org> writes:
> 
>> On Tue, Jan 19, 2016 at 03:00:52PM -0800, Junio C Hamano wrote:
>> 
>>> I think 3 comes from this:
>>> 
>>>  http://thread.gmane.org/gmane.comp.version-control.git/279348/focus=279674
>> 
>> Having recently looked into this, the relevant travis-ci documentation
>> is:
>> https://docs.travis-ci.com/user/ci-environment/
>> 
>> which says all environments have 2 cores, so you won't get much from
>> anything higher than -j3.
>> 
>> The following document also says something slightly different:
>> https://docs.travis-ci.com/user/speeding-up-the-build#Parallelizing-your-build-on-one-VM
>> 
>> "Travis CI VMs run on 1.5 virtual cores."
> 
> Yup, that 1.5 was already mentioned in the earlier thread, but many
> tests are mostly I/O bound, so 1.5 (or 2 for that matter) does not
> mean we should not go higher than -j2 or -j3.  What I meant was that
> the 3 comes from the old discussion "let's be nice to those who
> offer this to us for free".

I tested different settings and found that running prove with "-j5" seems to be
the fastest option for the Travis CI machines. However, I also noticed that 
I got more test failures with higher parallelism (Dscho reported similar 
observations [1]).

Especially t0025-crlf-auto.sh failed multiple times ([2], [3]) on the OS X builds
when I increase the parallelism:

not ok 4 - text=true causes a CRLF file to be normalized 
not ok 9 - text=auto, autocrlf=true _does_ normalize CRLF files 

Anyone an idea why that might be the case?

Thanks,
Lars

[1] http://article.gmane.org/gmane.comp.version-control.git/279660
[2] https://travis-ci.org/larsxschneider/git/jobs/103461538
[3] https://travis-ci.org/larsxschneider/git/jobs/103461458