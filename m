From: Shawn Landden <shawn@churchofgit.com>
Subject: Re: [PATCH] systemd socket activation support
Date: Thu, 2 Apr 2015 09:18:20 -0700
Message-ID: <CAJusiZWBZpoUpD-nOtBbHOWYsQGT=roe1Qvx0u-AogjasyGmJg@mail.gmail.com>
References: <1427937796-10060-1-git-send-email-shawn@churchofgit.com>
	<CAPig+cQVLGAYKNJf2dZGpnZbU-GBzeVKpQG48cpFtX8uYZ_LPQ@mail.gmail.com>
	<xmqq4moyleh3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 18:18:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ydhp5-0005IX-CI
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 18:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbbDBQSX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 12:18:23 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:34760 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbbDBQSW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 12:18:22 -0400
Received: by lagg8 with SMTP id g8so63845805lag.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2015 09:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Ol81FAjdWMi5gGXmFV1kjMKmRXTl47GkDLKIPLZ3ckA=;
        b=U/igxlquAzLbTBTGZ3CZqOCTEIP/TV9qGQ2ImiKQVm2aEEZOvYMh6rbXFJ3PbpvMwL
         v57yfgXeVkBwbf8CeirfShYTGE9zbbLZ0Jr+10ND9rQB7EU7azWYbeJb0+QRYI0360Zf
         pfIuamnnZpmaEsGqPlGHx9XD/mv7iKwkFYQiVvtPJCzhphwVoHzTrWz/3ZUZjJSfWs2x
         c+moHBZz6OeYEmgW2kolsUOmkxpN3qlPGJCI+hLUqLa2Y1YVdwJm+MY32S5ADX8EQkUO
         l+22/TrVKU1jLXp16NWaZBcJou7cLHSzeR2y6Z/OKolmPNZJPM8Y6KqUyJSKtRBvQeYy
         5kag==
X-Received: by 10.112.219.135 with SMTP id po7mr40755675lbc.111.1427991500874;
 Thu, 02 Apr 2015 09:18:20 -0700 (PDT)
Received: by 10.25.77.66 with HTTP; Thu, 2 Apr 2015 09:18:20 -0700 (PDT)
In-Reply-To: <xmqq4moyleh3.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: O5natuepFyvbHU2jbmZ1rhoPNEk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266647>

On Thu, Apr 2, 2015 at 8:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Wed, Apr 1, 2015 at 9:23 PM, Shawn Landden <shawn@churchofgit.com> wrote:
>>> From: Shawn Landden <shawnlandden@gmail.com>
>>>
>>> [PATCH] systemd socket activation support
>>
>> This patch feels like an RFC rather than a properly fleshed-out
>> submission. If so, indicate such in the subject. Also, mention the
>> area you're touching, followed by a colon, followed by the summary of
>> the change:
>>
>>     [PATCH/RFC] daemon: add systemd support
>> ...
>
> Everything Eric said ;-)
>
> Another thing is that this must be a build-time conditional.  Not
> all platforms can use systemd in the first place, and some people
> may choose not to use it even if the platform is capable of.
>
> I was somewhat surprised that sd-daemon.c needed to be built on our
> side, not used from systemd support library, as what it did looked
> very common and not specific to our needs. I would have expected to
> see inclusion of "sd-daemon.h" with -lsystemd-daemon or something on
> the command line.
There is a libsystemd, but when we are using so little of it it seems
cleaner to being it to us instead. I can do that in the next patch....
along with build conditional.


-- 
Shawn Landden
