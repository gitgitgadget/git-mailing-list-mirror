From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] disable grafts during fetch/push/bundle
Date: Tue, 4 Mar 2014 20:07:56 -0500
Message-ID: <CAPig+cTDbEHM0Ko-h=08T683kgsmjR07WaejZZc4Q_UfEp_UVA@mail.gmail.com>
References: <20140304174806.GA11561@sigill.intra.peff.net>
	<CAPig+cTzOxn5t0JOwxQyVrU___QPAQvwHR-zqFccaEQw+mYUCA@mail.gmail.com>
	<20140305003721.GA11509@sigill.intra.peff.net>
	<CAPig+cRqyG_JXSO-DsdP0mAjfmgS+FUCxLz+0+rHeUXrjmcjJg@mail.gmail.com>
	<20140305010529.GA11923@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 05 02:08:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WL0JV-00032T-2t
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 02:08:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756227AbaCEBH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 20:07:57 -0500
Received: from mail-yh0-f49.google.com ([209.85.213.49]:42550 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755102AbaCEBH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 20:07:56 -0500
Received: by mail-yh0-f49.google.com with SMTP id z6so357380yhz.8
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 17:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=R1UhjsE0PrOdFcmh4LZ7ZhRVUg3dEiOfaO1WzByuCTE=;
        b=DyANzV1MWNgr6GW08Tew/gZK+xqQm0kIdiB5dyizVX81iS4DwqCQzGUiO3Gkjv/X+n
         ykHw1M0BFiX1/lr4MsKe4pEXjBDPZb7QNQ2cCMaGk2nXiRIapfR56YMnSq8DRaKxP5UE
         SfflIo8dJiQrSNHUcvWeNTtrDj6eFLXIMb0CIK1ulFBvfQXnXXuTwbRS6qdpSm+lQ+ui
         TQFK8MkwdR0sDUFCKJNjUnZ8EbppnK+SQxhdufbMTD84PsCfXAkMSwbRm5pC/Hbxg3Qm
         0QEC/KO1E90GQZdLOKgir8EKebThqu0n9U+ONI4WuCoE5xxQR13L6AhjX/RybNsI7uEn
         w0CA==
X-Received: by 10.236.87.6 with SMTP id x6mr30830yhe.149.1393981676128; Tue,
 04 Mar 2014 17:07:56 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Tue, 4 Mar 2014 17:07:56 -0800 (PST)
In-Reply-To: <20140305010529.GA11923@sigill.intra.peff.net>
X-Google-Sender-Auth: VK4iyF1dddgPLauDJO0qs1axbcY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243413>

On Tue, Mar 4, 2014 at 8:05 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 04, 2014 at 08:00:44PM -0500, Eric Sunshine wrote:
>
>> >> > +int commit_grafts_loaded(void)
>> >> > +{
>> >> > +       return !!commit_graft_nr;
>> >> > +}
>> >>
>> >> Did you mean !!commit_graft ?
>> >
>> > Shouldn't they produce the same results?
>>
>> Yes they should, but the use of !! seemed to imply that you wanted to
>> apply it to the pointer value. (If you indeed intended to use
>> commit_graft_nr, then 'return commit_graft_nr', without !!, would have
>> been sufficient and idiomatic C.)
>
> I just wanted to normalize the return value to a boolean 0/1. Even when
> the input is an int, it eliminates surprises when you try to assign the
> result to a bitfield or other smaller-width type.

Thanks for the explanation.
