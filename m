From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t9902: protect test from stray build artifacts
Date: Thu, 24 Jan 2013 18:59:10 -0800
Message-ID: <20130125025910.GB26524@elie.Belkin>
References: <201301212330.10824.jn.avila@free.fr>
 <7v7gn6f6ya.fsf@alter.siamese.dyndns.org>
 <20130122003954.GA23297@sigill.intra.peff.net>
 <7vehha89j5.fsf_-_@alter.siamese.dyndns.org>
 <20130125011349.GB27657@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	git@vger.kernel.org,
	Daniel Baumann <daniel.baumann@progress-technologies.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 25 03:59:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyZWD-00077k-9r
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 03:59:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756556Ab3AYC7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 21:59:21 -0500
Received: from mail-pb0-f54.google.com ([209.85.160.54]:37179 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755374Ab3AYC7R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 21:59:17 -0500
Received: by mail-pb0-f54.google.com with SMTP id rr4so3983321pbb.27
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 18:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=glenYd/5jqhtF0qUeIrfNzdYoN4xgplMV3YZCX+/z4A=;
        b=JkyFWOPXS+QwwpHxvM9u9L86437V18KTCXmcCmU2lAsYAhG5oAyq6tdWzOKRA9YS43
         OU7DDdsJRuAhEw9kQPoB7huzcc260COZpY1T8IwTmrtGljMvDqwtc3bLiDDWKv+5/sFm
         a1hJ1YAXX6pHCjUXKBgzYUdJYeT1ExfopwwqgYHMNBh1+OQHumk+ouoF8pq/Kviex9sw
         jv/JK60rXIB4DkuBHlEN3c37sggqkkyG2SKhuwEc8JXO1bPQbxoGuvaq3dFF5zUQKhgG
         c0ZYXbI0AdhU6IJlYpVFfnQ+N7OWkqeOziEqPpT5KKw3Ol2zGUpW2m3KCsP9yyA+fHp0
         M2eQ==
X-Received: by 10.68.220.198 with SMTP id py6mr10600175pbc.119.1359082756694;
        Thu, 24 Jan 2013 18:59:16 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id im5sm15950877pbc.55.2013.01.24.18.59.14
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 24 Jan 2013 18:59:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130125011349.GB27657@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214481>

Jeff King wrote:
> On Thu, Jan 24, 2013 at 03:07:42PM -0800, Junio C Hamano wrote[1]:

>> Instrument the completion script and give it a way for us to tell
>> what (subset of) subcommands we are going to ship.
[...]
> The only thing I might add is a test just to double-check that "git help
> -a" is parsed correctly. Like:
>
>   test_expect_success 'command completion works without test harness' '
>            GIT_TESTING_COMMAND_COMPLETION= run_completion "git bun" &&
>            grep "^bundle\$" out
>   '

Yes.  Since there are no other 'git help -a' tests, I think we need
this.

Aside from that, the fix looks good to me.

Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/214167/focus=214469
