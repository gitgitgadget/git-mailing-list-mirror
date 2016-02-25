From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: using git-diff as a diff replacement?
Date: Wed, 24 Feb 2016 18:43:26 -0800
Message-ID: <CA+P7+xr-OH=nptBS9us5iWKkDr7FX-dfAjJZvBzPkUQ7JPKLzg@mail.gmail.com>
References: <CA+P7+xq7gobJbbRxm51APMQ8408jyvW64=1y3wo3jz3rjMsDqA@mail.gmail.com>
 <CACsJy8DTKOhOxdiQbRSddMSTMCQAFmZDdm6G1QeY6TpDf2HuKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 03:43:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYluB-0000x1-3Z
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 03:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505AbcBYCnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 21:43:47 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:33851 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbcBYCnq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 21:43:46 -0500
Received: by mail-io0-f182.google.com with SMTP id 9so68950511iom.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 18:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gXZhLSOShg4pT13cV+CDHVW6QgIIFjjwr7KxhCjQAGA=;
        b=wzFAXZHFXnhUw8QXdA9tjIJTN2L1+h9aJ8NBKUZmcnVDxy/fEH/vjg9gMPuV+1ZqQ5
         HtSJ6gFZb/TmlQt7kUe+ArNmdZX6RRGqzBL6tqY3guhR5a+tOZQB4ed64E2PaoMVhyma
         oVV6tph/BiNKYu/xNlep1qbUhDLnDE3G1ZJwrylwRaJ99kD5fx4b1BDPVnQfDdUC+Hxz
         c8r3/zA68JOcbPSjukEhon1JtvH4hCY7F1I5JNeEnGVGdkOMd2yxnMcdJIy12Myc4/v7
         AR639PD/ElBsYmPfb6chS47GeKNAu2yytmjq+ObaxJCHz4FcQPV7bob+v/Nb6A9BpyW7
         aJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gXZhLSOShg4pT13cV+CDHVW6QgIIFjjwr7KxhCjQAGA=;
        b=Z5YcEX5JOVOaOEdqv2Ym2xwU00bYNl0isjs9R6G3cldQuRxCcFLYmj/yptCsye2mr5
         6gunG9sHABrUQmjzijbHoT/not8TGz9fihlvsOZkxdKWS3ZU2DVSZzYWGioR0pjIxSSI
         6l2F7lwTb+9IPqYZPalRg9d9QXWu7bN7yUWwCWxVRTiBLD+byRaQiEFgqrljxR5JydYt
         PRAorMLGwEmq8YwJyIYiGFy0IjoWzXkAdK5qb2Lh5pycFmsygSiF+fzpnhktlZ+mcVad
         DaVuYJ104Jz+cERXQgMkRodhXl3iW9yv5GwtMAWEOmuX4Cw3pk/RV3m+hUY41DhDi+8t
         zwIQ==
X-Gm-Message-State: AG10YOQgj89FTn3hkP2SlQfHpBdEsS+Vx5nWkeKYT3y8MltZFwk0zuG6gJrBu4oqvY+69ANs6nsRr/YLOlDptw==
X-Received: by 10.107.156.14 with SMTP id f14mr959233ioe.0.1456368225656; Wed,
 24 Feb 2016 18:43:45 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Wed, 24 Feb 2016 18:43:26 -0800 (PST)
In-Reply-To: <CACsJy8DTKOhOxdiQbRSddMSTMCQAFmZDdm6G1QeY6TpDf2HuKg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287314>

On Wed, Feb 24, 2016 at 6:38 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Feb 25, 2016 at 5:21 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> Hey,
>>
>> I know that running "git diff <path> <path>" when outside a git
>> project will result in a normal diff being run. I happen to prefer the
>> diff algorithm and diff output of "git diff" but there does not seem
>> to be a way to have this behavior from within a git tree.
>
> git diff --no-index <path> <path>
>
> ?
> --
> Duy

Yep thanks.. I swear I did git help diff, but I guess I am blind. This
does what I want, and I had my shell alias diff so I don't forget :D

Thanks,
Jake
