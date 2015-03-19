From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 4/4] t0302: test credential-store support for XDG_CONFIG_HOME
Date: Thu, 19 Mar 2015 17:53:10 -0400
Message-ID: <CAPig+cS3rZgTZRYsC2ofNAFHs9WsGO1AqW01dt734AZf6edBzQ@mail.gmail.com>
References: <1426662276-8728-1-git-send-email-pyokagan@gmail.com>
	<1426662276-8728-4-git-send-email-pyokagan@gmail.com>
	<CAPig+cR-87-dWXUKoKvphrdb_Y=7268G5uerAiPYDsj-UQiuRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 22:53:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYiNQ-0001eM-6h
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 22:53:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbbCSVxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 17:53:12 -0400
Received: from mail-yh0-f50.google.com ([209.85.213.50]:33587 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbbCSVxK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 17:53:10 -0400
Received: by yhpt93 with SMTP id t93so31573000yhp.0
        for <git@vger.kernel.org>; Thu, 19 Mar 2015 14:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=53HuMnIEIW8HKBrd4t87imZapWK+8kefdToQnGWOuZA=;
        b=EVBx8iGW2CXJVhskFvqOouDYSLFuFoFRsQbhcbLqAjNhxw19HBesrXeB0mnUtCCJvs
         dTIJTLjgNlsG0Mf78sqRBac1F87RfRM6FiKIjZ5dGWhqQb895SzwuyPJYO/xENdu5poB
         lZYjFGIxqeZq8VNb7d7/PjB7COoH4Z8X85ohCYhLBjEnU5pxv6r0wojWyCJub3EctnDp
         0enA67whE9EpwekoYJ34G1VkWkTi0Nf1aEkEdRUhnFmK13DOVHE/I4Lt3H5lp/q6FLeU
         WNsBCbM6ZLiQq3f2dJB4u6i140f6k808Bdy6UMGl3+/lhVHGAvLthYTZHMuQ8E6+R9IL
         1UVQ==
X-Received: by 10.170.174.196 with SMTP id q187mr16918549ykd.2.1426801990267;
 Thu, 19 Mar 2015 14:53:10 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Thu, 19 Mar 2015 14:53:10 -0700 (PDT)
In-Reply-To: <CAPig+cR-87-dWXUKoKvphrdb_Y=7268G5uerAiPYDsj-UQiuRw@mail.gmail.com>
X-Google-Sender-Auth: 81DaBX6XY9YxdIFkLI-yelMGC6M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265844>

On Wed, Mar 18, 2015 at 3:26 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Mar 18, 2015 at 3:04 AM, Paul Tan <pyokagan@gmail.com> wrote:
>> t0302 now tests git-credential-store's support for the XDG user-specific
>> configuration file $XDG_CONFIG_HOME/git/credentials. Specifically:
>> ---
>>
>> The previous version can be found at [1].
>>
>> [1] http://thread.gmane.org/gmane.comp.version-control.git/265305/focus=265308
>>
>> * Merge related, but previously separate, tests together in order to
>>   make the test suite easier to understand.
>>
>> * Instead of setting/unsetting XDG_CONFIG_HOME in separate tests, set
>>   it, and unset it immediately before and after "helper_test store" is
>>   called in order to make it localized to only the command that it
>>   should affect.
>>
>> * Add test, previously missing, to check that only the home credentials
>>   file is written to if both the xdg and home files exist.
>>
>> * Correct mislabelling of "home-user"/"home-pass" to the proper
>>   "xdg-user"/"xdg-pass".
>>
>> * Use "rm -f" instead of "test_might_fail rm".
>
> This round looks much better. Thanks.
>
> Most of the comments below are just nit-picky, with one or two genuine
> (minor) issues.

I should add that the nit-picky items are not necessarily actionable.
As the person doing the actual work, it's okay if you disagree and
feel that they are not worth the effort of addressing.

(The genuine issues, on the other hand, ought to be addressed.)
