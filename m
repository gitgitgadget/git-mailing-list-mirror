From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Using clean/smudge filters with difftool
Date: Thu, 18 Jun 2015 15:55:54 -0700
Message-ID: <xmqqr3p8bp8l.fsf@gitster.dls.corp.google.com>
References: <5582BA1F.1030409@drmicha.warpmail.net>
	<CAGA3++LrVSs3rMkg=S2Og48pz1yEBxwpcRsPt7sNLENRh1ooAg@mail.gmail.com>
	<20150618132622.GJ18226@serenity.lan>
	<CAGA3+++_mx=O=Un0pip8Q41X5PZBLmES=Hd=U=aSowryx5r=8w@mail.gmail.com>
	<20150618141116.GK18226@serenity.lan>
	<CAGA3+++ibw=8Q1LtM6yJrZ7Q4eVs_MEHmPAzctSVSREXMmBiMQ@mail.gmail.com>
	<20150618142852.GL18226@serenity.lan>
	<CAGA3+++LqZ8Qv6tpuoqQwi37kO5LLODwcbFQtvneorjiV4KARw@mail.gmail.com>
	<20150618160133.GO18226@serenity.lan>
	<xmqqsi9oeqhn.fsf@gitster.dls.corp.google.com>
	<20150618223927.GP18226@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Florian Aspart <florian.aspart@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Jun 19 00:56:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5ij5-00067f-4l
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 00:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbbFRWz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 18:55:59 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:35251 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbbFRWz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 18:55:57 -0400
Received: by iefd2 with SMTP id d2so8064718ief.2
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 15:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=A/UC4vtpr+8HqbCp3kHdD58xZXkFlrRUHwpN6sp7Hto=;
        b=EeYn3T0T75BCgoPE7oFjEUx9Pv4hbhuZgAR1f5ullnJiLqBYjR4s9x6WQLc42W7zqH
         VaioM2Ae3YKvM2KdWR6navsZt5VFbEnLkYWBu79iD3Ifejl+1RPjPyUe2PEAiZLT+Q+f
         gKb+EgGhHig3y2Ltw3/pzB1SLFg4gPxQnYQmjYGpbW+/c7rcma+5KXcC6YYEBy1OWxus
         UxYJR/qQFAYOc4yTzuGQOYZUn6safbblt+KaK+hEWEb+xoG9WCqvSh9+QrBMrtKBWzsD
         nsJwxJgVfFeF7g1KY7jxzTlWHwFFH5GBOREFl7WUNQ8JPKII9Pi91zCOhkIqy7Ut0496
         JR9g==
X-Received: by 10.50.141.164 with SMTP id rp4mr655790igb.2.1434668155591;
        Thu, 18 Jun 2015 15:55:55 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e04a:861:67b3:9e25])
        by mx.google.com with ESMTPSA id 191sm5853704iof.18.2015.06.18.15.55.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jun 2015 15:55:55 -0700 (PDT)
In-Reply-To: <20150618223927.GP18226@serenity.lan> (John Keeping's message of
	"Thu, 18 Jun 2015 23:39:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272093>

John Keeping <john@keeping.me.uk> writes:

> I think the summary is that there are some scenarios where the external
> diff tool should see the smudged version and others where the clean
> version is more appropriate and Git should support both options.  It
> seems this is a property of the filter, so I wonder if the best solution
> is a new "filter.<name>.extdiff = [clean|smudge]" configuration
> variable (there's probably a better name for the variable than
> "extdiff").

Not just the external diff, but the textconv filter obeys the same
rule.  The setting should be done the same way for both, if we are
going to go in that direction.
