From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] make commit --verbose work with --no-status
Date: Thu, 04 Jun 2015 11:39:45 -0700
Message-ID: <xmqqd21buxla.fsf@gitster.dls.corp.google.com>
References: <1433440591-30917-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Git Mailing List" <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 20:39:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0a3V-0007nx-08
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 20:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617AbbFDSjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 14:39:48 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:35305 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501AbbFDSjr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 14:39:47 -0400
Received: by igbzc4 with SMTP id zc4so15611553igb.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 11:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=PXY8Ocpdi+WLUIC9cC3bAHyGpwHd1XKMUUWQLNF/d0A=;
        b=XXA34rtaNgXnz7m1WoO83ilW48oVvTN9HPsLnGWcfo8f0S9T01XubSjrdA3lFPTLNa
         eO4hKeS8JRbJgbzqpAn6jfrvEYAblmIO10HO51OFZZQhR3YkkYFYPKPuyIDw2dOSszjS
         +NsMk2A8sEhKcSOY10wVnexF8tjYngj5oqTbZV9SXf1F567Gsi2R6mCJntsLxNrUCTgr
         0AbzjsOmxDja8QUgvm3V2QhqXX7cCWy8DxAn5z70AqgToWrs1qo7zzblOU/92BpPgN7O
         dMezy2p3x+I2rtz3i7WuCUCdr3bHqYuVHtdYQzRDpPeA7dvgwu77ZnV1rShJUlgdJsyI
         e27g==
X-Received: by 10.43.167.137 with SMTP id ne9mr5874115icc.7.1433443187065;
        Thu, 04 Jun 2015 11:39:47 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:8c50:e66f:fc40:1825])
        by mx.google.com with ESMTPSA id k74sm1703177iok.30.2015.06.04.11.39.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Jun 2015 11:39:46 -0700 (PDT)
In-Reply-To: <1433440591-30917-1-git-send-email-rctay89@gmail.com> (Tay Ray
	Chuan's message of "Fri, 5 Jun 2015 01:56:29 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270793>

Tay Ray Chuan <rctay89@gmail.com> writes:

> When running git-commit`, --verbose appends a diff to the prepared
> message, while --no-status omits git-status output.

The --verbose option is called --verbose and not --diff or --patch
for a reason, though.  The default is to show extra information as
comments, and verbose tells us to make that extra information more
verbose.  We call that extra information "status", so it is natural
for "--no-status" to drop that extra information.

> ; thus, one would
> expect --verbose --no-status to give a commit message with a diff of
> the commit without git-status output.
>
> However, this is not what happens

And for a good reason, I would think.
