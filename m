From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Improvements to integer option parsing
Date: Mon, 22 Jun 2015 15:09:31 -0700
Message-ID: <xmqq7fqvfl9g.fsf@gitster.dls.corp.google.com>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
	<1434911144-6781-1-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Tue Jun 23 00:09:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z79uM-0005Ny-BC
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 00:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbbFVWJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 18:09:35 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:36548 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507AbbFVWJe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 18:09:34 -0400
Received: by iecvh10 with SMTP id vh10so28588110iec.3
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 15:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=4m5XFt9TfYd+aHfJhdGZKBuvCvxqzkfweq5JBaGsdco=;
        b=Dv3ddtMJ2+fSnlaUb4m11ZM8QHHqUVz+GNYFEBE6c84KUorNSSwBh3Q9xq4VckD6aF
         WQkhbuTNBdQ8WAoi7FzaRsTCLKUJORvqax/b0BerliJOW3iWf0cPcti2b6ya/GSayLJY
         X089dqvD0IZRuavYb99WDX7NiDypun1/TUU3HR+JkFn3RSsUQpMCAI6ZKCpdf8CQofy6
         keDNvg0dt87v67L9UCahWwNAikVYZBn+dmxg+1CjerI+OTVKhnP8X1Hhr3M6FvcuiF6E
         mACBVgPThc4Aw9LSVz0KPkOrMSaB9/0kHPldBT5PEMWSe0mraA+cg5/4af6qxsmdPRUy
         IZqg==
X-Received: by 10.107.148.144 with SMTP id w138mr42488990iod.12.1435010973483;
        Mon, 22 Jun 2015 15:09:33 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b0be:ae3d:b206:8e25])
        by mx.google.com with ESMTPSA id z195sm13674273iod.33.2015.06.22.15.09.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Jun 2015 15:09:32 -0700 (PDT)
In-Reply-To: <1434911144-6781-1-git-send-email-charles@hashpling.org> (Charles
	Bailey's message of "Sun, 21 Jun 2015 19:25:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272428>

Charles Bailey <charles@hashpling.org> writes:

> This is a re-roll of the first two patches in my previous series which used to
> include "filter-objects" which is now a separate topic.
>
> [PATCH 1/2] Correct test-parse-options to handle negative ints
>
> The first one has changed only in that I've moved the additional test to a more
> logical place in the test file.
>
> [PATCH 2/2] Move unsigned long option parsing out of pack-objects.c
>
> I've made the following changes to the second commit:
>
> - renamed this OPT_MAGNITUDE to try and convey something that is
> both unsigned and might benefit from a 'scale' suffix. I'm expecting
> more discussion on the name!

I think that name is very sensible.

> - marginally improved the opterror message on failed parses

I'd queue with "s/a integer/a non-negative integer/".

> - noted the change in behavior for the error messages generated for
> pack-objects' --max-pack-size and --window-memory in the commit message

Thanks.  Queued.
