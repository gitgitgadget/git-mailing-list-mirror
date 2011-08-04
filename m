From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 17/18] revert: Introduce --continue to continue the operation
Date: Thu, 4 Aug 2011 14:52:33 +0530
Message-ID: <CALkWK0nvfV=JXm6g5W4K899MN+Qbbq72xRn-YsJtn_ceUexp+g@mail.gmail.com>
References: <1312222025-28453-1-git-send-email-artagnon@gmail.com>
 <1312222025-28453-18-git-send-email-artagnon@gmail.com> <201108040657.24610.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Aug 04 11:22:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qou8p-0002NS-8h
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 11:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937Ab1HDJWz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Aug 2011 05:22:55 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53325 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055Ab1HDJWy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2011 05:22:54 -0400
Received: by wwe5 with SMTP id 5so1697812wwe.1
        for <git@vger.kernel.org>; Thu, 04 Aug 2011 02:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=R0U0j+XiXyvlN6VOf7ThFGnH8s+L6VRPihOswTJFYgo=;
        b=ZIsKYpUr04vUUiNForEDv6YujRY9YueO9xeMhs7LtnYsVRr+es42BKgMmrTt01HAil
         7+2lhqsRDkrC1qO5+6J5sCME10sK4tf6DqSLdQJAqXVTG9t3uCrV2mqDgcDJmd+mQ45F
         XZmI0c8xGspD9+D5LaOoqaZi1aR4LKfpUrd1o=
Received: by 10.216.188.207 with SMTP id a57mr484078wen.94.1312449773085; Thu,
 04 Aug 2011 02:22:53 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Thu, 4 Aug 2011 02:22:33 -0700 (PDT)
In-Reply-To: <201108040657.24610.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178709>

Hi Christian,

Christian Couder writes:
> On Monday 01 August 2011 20:07:04 Ramkumar Ramachandra wrote:
>> +test_expect_success '--continue complains when there are unresolved
>> conflicts' '
>> + =C2=A0 =C2=A0 pristine_detach initial &&
>> + =C2=A0 =C2=A0 test_must_fail git cherry-pick base..picked &&
>> + =C2=A0 =C2=A0 test_must_fail git cherry-pick --continue
>> +'
>
> When I try to manually run the above test I get:
>
> -----------------------------------
>
> $ pristine_detach initial
> Warning: you are leaving 1 commit behind, not connected to
> any of your branches:
>
> =C2=A030b20f1 unrelatedpick
>
> HEAD is now at df2a63d... initial
> $
> $ git cherry-pick base..picked
> [detached HEAD 30b20f1] unrelatedpick
> =C2=A0Author: A U Thor <author@example.com>
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
> Auto-merging foo
> CONFLICT (content): Merge conflict in foo
> error: could not apply fdc0b12... picked
> hint: after resolving the conflicts, mark the corrected paths
> hint: with 'git add <paths>' or 'git rm <paths>'
> hint: and commit the result with 'git commit'
> $
> $ git cherry-pick --continue
> fatal: No cherry-pick in progress

Good catch.  It should be "base..anotherpick".  Fixed now.

-- Ram
