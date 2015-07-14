From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v4 42/44] builtin-am: implement legacy -b/--binary option
Date: Tue, 14 Jul 2015 18:09:53 +0800
Message-ID: <CACRoPnS91zpbwrQvduTK_3OYJ+BnWHgbouTBC5RxrBmXaffDuA@mail.gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
	<1435500366-31700-43-git-send-email-pyokagan@gmail.com>
	<CAGZ79kaCV-PbMOBKgPAdX0VK3vWVYrJy_gQJF6dxX9JZhatpcg@mail.gmail.com>
	<CABPQNSakaoyNRuNz=bcDYWdy4e2O3M4UuYoOT5JAV1mt-BiAOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	GIT Mailing-list <git@vger.kernel.org>, kusmabite@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 14 12:10:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZExA3-0000BY-IY
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 12:10:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622AbbGNKJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2015 06:09:56 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:35759 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754612AbbGNKJy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 06:09:54 -0400
Received: by lahh5 with SMTP id h5so3096622lah.2
        for <git@vger.kernel.org>; Tue, 14 Jul 2015 03:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VY7iVYbOqBkJElgRGPQGJoqIrBXBIpi5VA7PPZw3rB8=;
        b=MWn1stvPDfCbCtO5pbvsYFkHnP2DNY4XPqA0QGV5U+aLLpZmF8h0flvunjbHERRxQ0
         7bI3lslLOqs8s6qe/x+zKtqtt/G7pJFAD1rF9xOU6N6nVY63NyB46TYVfy7dRmQm6XU7
         5+RlrSoWpFbbZhqnEEK8YRHTIw4CpjIkoLpQ3hqysBtoE61iu6jmknGyXFD9/rOkDJn3
         8PydgBwRFuvn8RGhTBJ+cCa54zCjxFD27WsMRGiQ00TxebFS3r4EpQLYNA1rZVpuSpN1
         s8Zmo9p1OGHz1KPG0EpPBuCbPp5dheeh0igqhd/KindPRS7HGfOHtJ2duqy8ivhZanvu
         5Q2A==
X-Received: by 10.112.93.100 with SMTP id ct4mr24736480lbb.66.1436868593656;
 Tue, 14 Jul 2015 03:09:53 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Tue, 14 Jul 2015 03:09:53 -0700 (PDT)
In-Reply-To: <CABPQNSakaoyNRuNz=bcDYWdy4e2O3M4UuYoOT5JAV1mt-BiAOw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273948>

On Thu, Jul 9, 2015 at 5:17 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Jun 29, 2015 10:06 PM, "Stefan Beller" <sbeller@google.com> wrote:
>>
>> On Sun, Jun 28, 2015 at 7:06 AM, Paul Tan <pyokagan@gmail.com> wrote:
>> > The -b/--binary option was initially implemented in 087b674 (git-am:
>> > --binary; document --resume and --binary., 2005-11-16). The option will
>> > pass the --binary flag to git-apply to allow it to apply binary patches.
>> >
>> > However, in 2b6eef9 (Make apply --binary a no-op., 2006-09-06), --binary
>> > was been made a no-op in git-apply. Following that, since cb3a160
>> > (git-am: ignore --binary option, 2008-08-09), the --binary option in
>> > git-am is ignored as well.
>> >
>> > In 6c15a1c (am: officially deprecate -b/--binary option, 2012-03-13),
>> > the --binary option was tweaked to its present behavior: when set, the
>> > message:
>> >
>> >         The -b/--binary option has been a no-op for long time, and it
>> >         will be removed. Please do not use it anymore.
>> >
>> > will be printed.
>>
>> I wonder if now would be the right time? The rewrite aim's at full
>> feature compatibility, but we may want to revert this commit on
>> top of patch 44 later.
>>
>
> I would just remove the deprecated hack from the old implementation in the
> beginning of the series.

Junio, what do you think?

Regards,
Paul
