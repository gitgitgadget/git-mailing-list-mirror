From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/43] refs lmdb backend
Date: Thu, 03 Sep 2015 16:10:13 -0700
Message-ID: <xmqqfv2vgkve.fsf@gitster.mtv.corp.google.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 01:10:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXdeA-0005II-1E
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 01:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758063AbbICXKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 19:10:16 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34607 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757471AbbICXKP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 19:10:15 -0400
Received: by padhy16 with SMTP id hy16so1783197pad.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 16:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=zLmIv/CNIfiTU0L8eFoU4otI+j/i/zXF1ne08dlMDME=;
        b=kUvac8uGTNCZkK6Q9VGFqdGjYhdXb/vtAbYbQQz4miQVX3wmgfUKonQSoS1Yfmw2ok
         IyJpu3J0plBgRT//sk8eBFsvINbd4WR6i1Gqd/yPFX/iOP9DFFls0qeRU26j50DvC7W3
         VOmMmuQhLksWranSacFVJrukF+LJBFm2poYqR7nVXKjeZm/zeawDPZI9LUkRGve85cxZ
         WjMpKyDFrEogxyCzVc4T5T4IAmYaLKpBchrnyFFsab0iWCEY3zCkhGaUCbm0RPbWYDej
         r4T6GAOjHM0yBV30iz1i5I6aHZ3/CPNOrVflZu1CVMtT2CaY81B3XAAVZsUx85tfXgIn
         rNYA==
X-Received: by 10.68.212.35 with SMTP id nh3mr995580pbc.78.1441321814749;
        Thu, 03 Sep 2015 16:10:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:71da:b56c:f873:e611])
        by smtp.gmail.com with ESMTPSA id db3sm203385pdb.83.2015.09.03.16.10.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 16:10:14 -0700 (PDT)
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Wed, 2 Sep 2015 21:54:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277279>

David Turner <dturner@twopensource.com> writes:

> I think I've broken about all of the standalone stuff out, so here's
> the main enchilada.
>
> This series depends on at least the following topics in pu:
> dt/refs-bisection
> dt/refs-pseudo
> dt/reflog-tests
> kn/for-each-tag (patch 21 and corresponding bits of 42 depend on this;
> we could skip them, but I wanted this to apply on top of pu)
>
> As before, I tested by hacking the test suite to run under the lmdb
> backend and changing a few dozen tests.  The remaiing failures are
> documented in Documentation/technical/refs-be-lmdb.txt, except for one
> in t1404 where this version gives a different error message (but still
> an error).
>
> As Jeff King suggested last time I sent this around, I've made the
> reflog format slightly more efficient.  Now it stores shas in a binary
> format, and only uses a header entry if there are no real entries.
>
> Also, now per-worktree refs live in the filesystem.
>
> I've also made a number of fixes to memory leaks, formatting,
> factoring, etc.
>
> As Michael Haggerty suggested, I'm now using struct ref_transaction as
> a base struct for the ref transaction structs.
>
> Looking forward to reviews.

[03/43] seems to be missing, but without the list of changes in the
cover letter it is hard to tell what got dropped.
