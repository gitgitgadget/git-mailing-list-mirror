From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 0/3] config: add '--sources' option to print the source of a config value
Date: Tue, 16 Feb 2016 10:40:34 +0100
Message-ID: <186152EC-C19A-464E-A81B-B614E56AF1DE@gmail.com>
References: <1455531466-16617-1-git-send-email-larsxschneider@gmail.com> <20160215180552.GC26443@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, sschuberth@gmail.com,
	ramsay@ramsayjones.plus.com, sunshine@sunshineco.com,
	hvoigt@hvoigt.net, sbeller@google.com, Johannes.Schindelin@gmx.de,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 10:40:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVc7m-0000bA-D3
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 10:40:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754515AbcBPJkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 04:40:41 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33630 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754415AbcBPJki (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 04:40:38 -0500
Received: by mail-wm0-f52.google.com with SMTP id g62so182715415wme.0
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 01:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=raoG3YwyqIxlSSMOPuWaUG+bCYAYo2Udoubp5sKYl0A=;
        b=uMrOIRfxp2YxJQsnlAeW9UGbSsxWKW2bRZLAdIvoKo6Igdveb6ywjYUW8sSEY1p58/
         IQlpcHVplQvC31tM7odJVbBiYqwsMcLlvJCZuFBDNirwGYBiLKCJ16pRjhsJk0s4NSPS
         YEoXRznsAPf5rIsX0O+phLlje9udmA8iBx9uf/ySBf6JaNOqsm1B4XCovkQ/ZWK3ijiS
         jwpYiKI93tXToJGO/hRF7wEEGADw7VkR/eoLgu+oODronUy5WcWqf+v+51AJSiWHI77p
         /gk4yc5a3Spz7UGDvL/b+kqzr+rJoozyeClLdZB8mlbWomhe1fNguQFqfEXcJTlBTw/k
         gEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=raoG3YwyqIxlSSMOPuWaUG+bCYAYo2Udoubp5sKYl0A=;
        b=iTEaKhHnJaj2QMN1odZwoZ+bX81vmWShIpvLI4xUB6NFw0avMBdDwmauUyUBEpO48J
         nVVxRTmam2yxJZiYUVS610bxn+mLjMhm+cSDron532NmgmN+7mnWhwLyIJGO4iadwqVJ
         kSD6dLqwsNbyEHHFdt4vdkKcV22q85OTcvVq2uOBLcpaqGxHChxIVpWTGNxfivA6/mX+
         RFnol/Iu59r1c6E+bMqyYST87ElRLT+KZs9bW0H9jk2kx01w0hXRYqBcFbra6RBdLFOp
         kMWsDM6WsvytRYeXASkLE7EGKZIBpll3AUr+poIPhm0EOSp00cW4zuWRzOj1LAIf7Pk/
         tB3g==
X-Gm-Message-State: AG10YOQ+6GtVaGRsiuhIih8IHxrWMQcYnkNyHrKhh/HcVXimQiSjHVzNoYy9a/DEh/9l6w==
X-Received: by 10.194.95.40 with SMTP id dh8mr23927991wjb.146.1455615637412;
        Tue, 16 Feb 2016 01:40:37 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB43DD.dip0.t-ipconnect.de. [93.219.67.221])
        by smtp.gmail.com with ESMTPSA id 198sm19756969wml.22.2016.02.16.01.40.35
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Feb 2016 01:40:36 -0800 (PST)
In-Reply-To: <20160215180552.GC26443@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286330>


On 15 Feb 2016, at 19:05, Jeff King <peff@peff.net> wrote:

> On Mon, Feb 15, 2016 at 11:17:43AM +0100, larsxschneider@gmail.com wrote:
> 
>> I like the idea of a "test set up block" within a test script. In order
>> to clean up nicely before any subsequent tests I would like to propose
>> a "tear down" block. Would that work as a compromise in our "test cases
>> depend on earlier test cases" discussion?
> 
> I don't have any real problem with what you've written in the final
> patch, but I also don't think it's accomplishing much (and is more lines
> of code, and more running processes).
> 
> If you want to run test N without having run all of 1..N-1, what you
> really want is some known, reliable state when that test starts. But the
> tests before it do not necessarily know what that state is.  The best
> they can do is roughly restore the original state before they ran. But:
> 
>  1. What does the state consist of? Which files (and their contents)
>     are important to the test?
> 
>     In your tear-down you get rid of $INCLUDE_DIR, and you zero-out the
>     config files. But you leave expect, output, output.raw, and the
>     oddly named $CUSTOM_CONFIG_FILE. Nor do you clean up the
>     environment variables.
Good argument - I can't disagree.

> 
>     To be clear, I think it's perfectly fine to leave those. But you
>     are still making assumptions about what the next test relies on.
> 
>  2. We may create a clean slate, but that is probably not what the next
>     test wants. It will want to do its own setup. I.e., it will
>     probably not want a blank .git/config, and will create it itself,
>     just as you did in your setup step.
> 
> So rather than tearing down, I think we are better off trying to make
> tests themselves (or blocks of them) set up their own assumptions. E.g.,
> by overwriting files rather than appending to them. By using unique
> filenames, commit messages, etc for their tests. That's less of a big
> deal here, but in many tests that create commits, "test_commit foo"
> would fail a second time, because there are no changes to "foo". Doing
> "test_commit subdir/check-diff-in-subdir" is less likely to clash
> without another test.
> 
> Sometimes we _are_ better off with a teardown step, because subsequent
> tests would not reasonably think to clear some state we've set (e.g., in
> non-config tests, if we set some random config variable, we use
> test_config to tear it down afterwards rather than have each test clean
> out all of the config). So there's definitely a subjective judgement
> call on what is "reasonable" there. But I find it unlikely that your
> tear-down will help anybody in this case. Further tests will not care
> about $INCLUDE_DIR unless they reference it, and any further tests would
> set up their own .git/config, etc.

OK, I will remove the block in the next roll. Thanks for explaining
your thoughts on this.

- Lars
