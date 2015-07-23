From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Config variables and scripting // was Re: [RFC/PATCH] log: add log.firstparent option
Date: Thu, 23 Jul 2015 10:37:05 -0700
Message-ID: <xmqqoaj2pygu.fsf@gitster.dls.corp.google.com>
References: <20150723012343.GA21000@peff.net>
	<20150723044007.GA3651@gmail.com> <20150723051445.GA24029@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	Josh Bleecher Snyder <josharian@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 23 19:37:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIKQz-0006nh-0n
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 19:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754231AbbGWRhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 13:37:11 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35815 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754215AbbGWRhI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 13:37:08 -0400
Received: by pabkd10 with SMTP id kd10so89015303pab.2
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 10:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=17G5KCvY0RScRPxUihT1wLRibaBarfraMys4Ef6qnCw=;
        b=ARa0l8vZVFyaOnBPOet0uBWbP/eCfRgy+lnlfAwuyhn20yW8Eh2YTCchFzqHFALcpy
         iMt+RDBpaRScTuFgZ/3HdUeJr9J/UdiCp+/UVQdSOZfjRBIkdaJzhltUVrNHl2wYy8cH
         k+9Lv57WKGn0MDul2P+aK2NJqV8a8oSmxzCl8tOgk71iIATSixY7O7DP99/BQIbw9k/Y
         t7ypDQO7eQU1tuco2tk5Kfq9wpkoclIwx+Y3NeqDHF1yQdlQJ9cruCl3vjy34qTheT5f
         QawQIq8zl5rW8QaypA6DdjnH7+7+usBE+33ZfP0XRLaGzP3FUVH3yKgoSL9jvc65L+NP
         dfQw==
X-Received: by 10.66.236.167 with SMTP id uv7mr20293885pac.134.1437673027955;
        Thu, 23 Jul 2015 10:37:07 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:156f:a37c:e915:d6df])
        by smtp.gmail.com with ESMTPSA id h12sm10065118pdk.77.2015.07.23.10.37.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 23 Jul 2015 10:37:06 -0700 (PDT)
In-Reply-To: <20150723051445.GA24029@peff.net> (Jeff King's message of "Wed,
	22 Jul 2015 22:14:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274513>

Jeff King <peff@peff.net> writes:

> I am sympathetic, though. There are some things that git-log can do that
> rev-list cannot, so people end up using it in scripts. I think you can
> avoid it with a "rev-list | diff-tree" pipeline, though I'm not 100%
> sure if that covers all cases. But I would much rather see a solution
> along the lines of making the plumbing cover more cases, rather than
> trying to make the porcelain behave in a script.

Very well said.
