From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 1/2] commit: add parse_commit_repl() to replace
 commits at parsing time
Date: Wed, 18 Aug 2010 14:37:02 +1000
Message-ID: <AANLkTimZOOMnbbu_gHoeE2Bo_uDajN6Nw64eOtRFfVmM@mail.gmail.com>
References: <20100817015901.5592.25471.chriscool@tuxfamily.org>
	<7vbp91aqfk.fsf@alter.siamese.dyndns.org>
	<AANLkTimu0r_3L7_YJgfMVb6saFOyOK-mHLiKyTG_6Q5O@mail.gmail.com>
	<201008180607.54675.chriscool@tuxfamily.org>
	<20100818042459.GD21185@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 06:37:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlaOk-0002BL-Q3
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 06:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367Ab0HREhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 00:37:06 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42615 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961Ab0HREhE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 00:37:04 -0400
Received: by wwi17 with SMTP id 17so241543wwi.1
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 21:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=9kyM6QenbPqL3icD5D5Q7BOXHSZobwlAq/EMhAji6uQ=;
        b=uL/mSDT9ZM6/HEDOU1XCrg1anFmC//faTltnTDRb9ZFeoNSRXUbo8ccw4AmRqwkIOL
         oVDyfb305Sk3Hs734UTLIvWXRP3t8gCBihiTJXkCT70s7l/vsA+o69FhbYbEgSVpag2L
         4DTAgNYa/II7tgUuFZkJELS3FOg5YsCFgFc1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=xZXgQBSGGzxJAQS2WKkFQV93k7NEHAhvTBxhQYtTgbfh1X/gy5aYDbOpjX81ww6J1s
         gJqMwo2tre1PDEoqEEmdeTnwxWqE9d+L3rsojvksteE0EX1orIazmNgflAqFveDVztsx
         RrkbFMP6GeQrbneU77tzUXZr4U+/Y7GXTHAqc=
Received: by 10.216.175.12 with SMTP id y12mr1546808wel.61.1282106222345; Tue,
 17 Aug 2010 21:37:02 -0700 (PDT)
Received: by 10.216.173.133 with HTTP; Tue, 17 Aug 2010 21:37:02 -0700 (PDT)
In-Reply-To: <20100818042459.GD21185@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153812>

On Wed, Aug 18, 2010 at 2:24 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Christian Couder wrote:
>
>> The downside is that the sha1 will not be
>> consistent with the content anymore and that it will be more difficult to
>> realize that an object has been replaced as there will be no sha1 change to be
>> seen.
>
> Maybe in the long run it would make sense to keep a "replaced" flag
> and use it to mark the replace objects specially in some user-facing
> commands (like log --format=medium).

Sounds good (if uses really need to know that). It can be used for
commit grafts too.

You would need to find an available bit flag first though. Currently
object.flags is used for different purposes and its bit definitions
are not centralized. So it's hard to find a "good" bit that no one
uses yet, to become the "replaced" bit. OK I'm getting off-topic now.
-- 
Duy
