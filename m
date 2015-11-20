From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v6 0/6] Add Travis CI support
Date: Fri, 20 Nov 2015 09:46:10 +0100
Message-ID: <46C55D27-0B59-41AA-84AD-FED095EBDEE4@gmail.com>
References: <1447923491-15330-1-git-send-email-larsxschneider@gmail.com> <20151119141409.GB9353@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, luke@diamand.org, sunshine@sunshineco.com,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 20 09:46:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzhKp-0003L3-R3
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 09:46:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162172AbbKTIqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 03:46:16 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34691 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161149AbbKTIqO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Nov 2015 03:46:14 -0500
Received: by wmvv187 with SMTP id v187so61598646wmv.1
        for <git@vger.kernel.org>; Fri, 20 Nov 2015 00:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9kfnoyZnvtxfz5CVak+J5j22D9mV+AmNd4rWic8mp9Q=;
        b=wofgfG+QD8/eRg5lQ4E+F73UT8/KqQscMwZDSqSw7NJUZxqYuJOchJtBuqe7wJyEQq
         3JU92bap80dns+3ckas1l/FhVmQ4iNd7+HBqT8N/wdst9ayV3i9yTHFHpXc5o9+9nsch
         8AE/sihn2Tq0qEvobvuVSI4f3jBOCKmUa2paz7OYUYFOhXQFqD+/0aaow+JW8Qyb6wyN
         eJIGAALo+OK5SqslRKgjqsVllznae9hpZaoyAcJjhZRVJxm4QDd+N6VGE7xrzYoq5G5p
         peUifRpex+YxvTuGeGNCY64a+BAvz8TUNOBG06GImkbwL2zLnNkLJTzMMORQXzpvlrrU
         fEEw==
X-Received: by 10.194.2.5 with SMTP id 5mr13225758wjq.153.1448009172377;
        Fri, 20 Nov 2015 00:46:12 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB7A5B.dip0.t-ipconnect.de. [93.219.122.91])
        by smtp.gmail.com with ESMTPSA id pn6sm11613824wjb.15.2015.11.20.00.46.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Nov 2015 00:46:11 -0800 (PST)
In-Reply-To: <20151119141409.GB9353@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281499>


On 19 Nov 2015, at 15:14, Jeff King <peff@peff.net> wrote:

> On Thu, Nov 19, 2015 at 09:58:05AM +0100, larsxschneider@gmail.com wrote:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> diff to v5:
>> * check if PID file still exists on P4D cleanup (thanks Luke)
>> * fix space/tab formatting error
>> * add sleep to timeout loops (thanks Luke)
>> * replace 'date +%s' with platform independent Python function (thanks Eric and Luke)
>> 
>> With the patches of this series the Travis CI test stability increases.
>> However, as I am "stress testing" the Travis CI infrastructure you can
>> see that it is not perfect: https://travis-ci.org/larsxschneider/git/builds
> 
> I peeked at a few, and it looks like just p4 tests failing now?

Yes, in particular t9810-git-p4-rcs.sh and t9816-git-p4-locked.sh. I would probably disable these test in Travis CI until I've found a way to make it stable.

> 
>> Nevertheless, I believe that Travis CI integration has still value as
>> contributors can test their patches easily on Linux and OS X before
>> posting them.
>> 
>> @junio / @peff: Do you consider merging this?
> 
> I think I'd prefer to split it into 3 separate topics (de-flaking
> test_must_fail, p4 test improvements, and the Travis file). Then they
> can proceed independently. I can take care of that split when applying.

Sounds good to me!

> 
>> Lars Schneider (6):
>>  implement test_might_fail using a refactored test_must_fail
> 
> You mentioned in the v5 cover that this one was from Junio. Should it be
> "From: Junio ..." in the pseudo-header?

Yes, this one was from Junio with a minor fix from my end if I recall correctly. What do you mean by "pseudo-header"? The "email-header" in the patch file? 

> 
>>  add "ok=sigpipe" to test_must_fail and use it to fix flaky tests
> 
> Looks OK.

"Looks OK" means I can/should add "Acked-by: Jeff King <peff@peff.net>" ? Bare with me, I am still learning ;-)

> 
>>  git-p4: retry kill/cleanup operations in tests with timeout
>>  git-p4: add p4d timeout in tests
>>  git-p4: add trap to kill p4d on test exit
> 
> These are all fairly gross, and I don't have p4d to test with myself.
> But if we assume they're all necessary, I suppose it's the best we can
> do.

Unfortunately I think they are necessary. However, if someone finds a better way for stable p4d tests then I would be happy to see them go away, again.

> 
>>  Add Travis CI support
> 
> I'll leave some comments directly in response to this one.
> 

Thanks for taking the time to review this!

- Lars
