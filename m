From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v13 5/8] bisect: introduce --no-checkout support into porcelain.
Date: Wed, 3 Aug 2011 23:24:21 +1000
Message-ID: <CAH3AnrpQZJprVtkNH1oeGXADzy1HA20xSTD8Cwpo3=ymOjgYhA@mail.gmail.com>
References: <1312284545-2426-1-git-send-email-jon.seymour@gmail.com>
	<CAP8UFD3XzUjxiz6QQzyTOYzfiWrF4ckiv0h+gvi7YuZkma6yiw@mail.gmail.com>
	<CAH3AnrrkAeN3BgnnFBsbzh=37tC6f6aRACgk94wxW85qFQpfVw@mail.gmail.com>
	<201108030727.04246.chriscool@tuxfamily.org>
	<CAH3Anroaq+fH3T3_G1HsS3ecdNdpReaKLC5v=x37rDqSmtghww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, j6t@kdbg.org, jnareb@gmail.com
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Aug 03 15:24:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QobQx-00014T-CC
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 15:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755830Ab1HCNYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 09:24:23 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34030 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755668Ab1HCNYW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 09:24:22 -0400
Received: by vws1 with SMTP id 1so293559vws.19
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 06:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mSyd4+NbNny173JPcjaScmhheAUWVDC3a8vCqQEUjXk=;
        b=wcZoSklU7P5CEhgU+z9W8HK/haNQPOsz8ElyTZBkWV5kmzaDlyyT/wqAZtpZs2uJn9
         UNofsoQcSw2kboid3cdMNMLT8dX4hk2jh1EwYuBeph5w3/C2asI7cPAzOkOCcXWQDDg6
         uj8Bk+3P5XszD2ld55JRF3jH6J9Ud6oe19qW0=
Received: by 10.52.93.113 with SMTP id ct17mr3646735vdb.231.1312377861751;
 Wed, 03 Aug 2011 06:24:21 -0700 (PDT)
Received: by 10.52.183.39 with HTTP; Wed, 3 Aug 2011 06:24:21 -0700 (PDT)
In-Reply-To: <CAH3Anroaq+fH3T3_G1HsS3ecdNdpReaKLC5v=x37rDqSmtghww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178569>

On Wed, Aug 3, 2011 at 10:46 PM, Jon Seymour <jon.seymour@gmail.com> wrote:
> On Wed, Aug 3, 2011 at 3:27 PM, Christian Couder
> <chriscool@tuxfamily.org> wrote:
>> On Tuesday 02 August 2011 16:41:13 Jon Seymour wrote:
>>> On Tue, Aug 2, 2011 at 10:04 PM, Christian Couder
>>>
>>> If I was to do this, I'd prefer to change uses of $BISECT_MODE with a
>>> call to a function bisect_mode() that does the same thing.
>>
>> Yeah, I think it would be a good idea to have a bisect_mode() function.
>> I don't like very much to blindly call some code when we might not need it.
>>
>
Mmmm.

Actually, there is a neater way to do this.

I'll such use the existence of BISECT_HEAD to inform the
implementation of bisect_mode().

This avoids the need for a separate .git/BISECT_MODE file.

jon.
