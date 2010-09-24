From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC PATCHv2 12/16] t6050 (replace): add missing &&
Date: Fri, 24 Sep 2010 23:04:22 +0000
Message-ID: <AANLkTikDbuMh9fRhyMDjq=ysUkiCuku=dfKTqnJ_7M7=@mail.gmail.com>
References: <1285366976-22216-1-git-send-email-newren@gmail.com>
	<1285366976-22216-13-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 01:04:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzHJd-00057Y-7M
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 01:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758312Ab0IXXEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 19:04:24 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42276 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757481Ab0IXXEX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 19:04:23 -0400
Received: by iwn5 with SMTP id 5so2748397iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 16:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=dr/Orlo3WAnfBdgodJ01gUZl0xDuATEPK71CmCcUkKU=;
        b=k/I+YptLEX0LqS5fVKFa5oHkxB7UZP5N39TQDL59qX8kHJfrg3n0kgiflmkHN99xXU
         sPRv64N2vrh713aBZutfIWFa4wIc2k29k3WIAwv1UTnjfz7c5E1yzQbAjMFwMcogWWO1
         uURZPPKR8/1EPJqeCCKIzyq572kE+JPWL6kE8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=nFji3J97+aOt6f9SGiH0FPeEJY7bn6E5dJN2TkvqrlRqgnajtUdaqNc9TT7JEisCSg
         ihmSggMaOF8V5I0iabpEuxpdJq8zqWhzu0jaNMPOJfOoJxbwyJJhxpHs2U4US/vj08tQ
         d7DtPA/wmfYE0bjdn3hf3WQJIWBtcc/okf9PU=
Received: by 10.231.149.207 with SMTP id u15mr4626281ibv.13.1285369462931;
 Fri, 24 Sep 2010 16:04:22 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Fri, 24 Sep 2010 16:04:22 -0700 (PDT)
In-Reply-To: <1285366976-22216-13-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157101>

On Fri, Sep 24, 2010 at 22:22, Elijah Newren <newren@gmail.com> wrote:
> FIXME: Is the grep really meant to fail?

It should be "! grep" not "test_must_fail grep". test_must_fail is for
git, not posix commands. If grep starts segfaulting we're screwed
anyway.

And this should use files and test_cmp or grep them if possible, not
use pipes. It's hard to debug these when they fail.
