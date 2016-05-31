From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] pretty: support "mboxrd" output format
Date: Tue, 31 May 2016 16:12:16 -0400
Message-ID: <CAPig+cSrqs7W2hSz6Z4_O9U52gUJFCqTSfRL0E0b=d=bO9RCEQ@mail.gmail.com>
References: <20160530232142.21098-1-e@80x24.org>
	<20160530232142.21098-2-e@80x24.org>
	<CAPig+cQrSJe03_RtSyf5KO2vE3Rri7t70-he8SXA9Y4oBYY_Ww@mail.gmail.com>
	<20160531074506.GA8911@dcvr.yhbt.net>
	<CAPig+cQrQfxWrGhpvtb-GKYfK0tMLsx9JJ+eWRRx00F8mNXrLg@mail.gmail.com>
	<20160531182932.GA27021@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Wong <e@80x24.org>
X-From: git-owner@vger.kernel.org Tue May 31 22:12:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7q1W-0002UN-Q4
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 22:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbcEaUMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 16:12:18 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36600 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbcEaUMS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 16:12:18 -0400
Received: by mail-io0-f195.google.com with SMTP id m17so250772ioi.3
        for <git@vger.kernel.org>; Tue, 31 May 2016 13:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=aGgFzxC8GufXG2ynixx4uZcqgdxDV2YhTSRHgyhAHz0=;
        b=Jyk+HJkX8+o7KSnmFTdF6xrxhHST38hyyxTs3qCg5Iuy6LX4LCZHr0ME3FnQ3krP7D
         LRV7GvgcuYFc/wTiVB4ivQML30WHPXhlXgEEv18QXszuOSmColf3HBRQWbxLV762aX6h
         zZa/NolqEJIAEFdH03M6ZJJCn1ex5KatPYLXaRHlmkG4CBDwWahSBTL8jTrlNjfreoxs
         HwPLt3sMGn0OGlcaqxfi/Kfe24/TqMJmKu2mEMFFxdegjhGwUfG0Fr/mKSN1dwmpCJlH
         y6lkqc5x2vIUHdTDKdoIU+PVE3rYkyOtCa+Je5/9yRIbsFQxZqncgMKqjf9gf9vQ7aZy
         MKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=aGgFzxC8GufXG2ynixx4uZcqgdxDV2YhTSRHgyhAHz0=;
        b=CifCGDdY3YILe3+nosESDYuJqxMsKeC9QXuXNI+fdWV1Obz4esOg3/QjTWdkKU2LUc
         8e6r9GBATwYHnE78fpIOVSgSU+6kGnnQMUiDGueTUnDflfovXMEy9cO54q8j+i+q07vf
         1/Yi2So46WpZ0MRgR7zmS0OvelasPpNr/TVPPjeAapW1pzoQfbhLYz8041nKpXky0hUu
         9UaKSGI4NMhbEIXXztzPJ050l16J6E7qWXgnGBkTsfnkcKSINa0Q6Z1xpc/zc9voR81d
         YCV632o5dM136/MAIwV+xr8QUB1JE0FFshFhvT/TGXYkz9jKWXZ1rtKAHOrbbrZFuvDc
         2pcg==
X-Gm-Message-State: ALyK8tKO0cix8iDiyW911H5Z7WoTs+p+nc5CMNWs7hj8QEwUpXo+yTneGK6GLO2HrWnopve22XRxU89eAqId5Q==
X-Received: by 10.107.132.40 with SMTP id g40mr555793iod.34.1464725537053;
 Tue, 31 May 2016 13:12:17 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Tue, 31 May 2016 13:12:16 -0700 (PDT)
In-Reply-To: <20160531182932.GA27021@dcvr.yhbt.net>
X-Google-Sender-Auth: B0VA40vCeTMoNKf0OUqbly3m1gE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296010>

On Tue, May 31, 2016 at 2:29 PM, Eric Wong <e@80x24.org> wrote:
> Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Tue, May 31, 2016 at 3:45 AM, Eric Wong <e@80x24.org> wrote:
>> > Eric Sunshine <sunshine@sunshineco.com> wrote:
> <snip>  Ah thanks, I can see your point-of-view, now.
> I always had the '^' in my mind since I've written the same
> thing in Perl and Ruby.

On reflection, even with the '^' anchor, it isn't safe the way it's
coded since '^' will match following a newline, won't it? Therefore,
because 'line' isn't necessarily NUL-terminated, the pattern could
match on some line beyond what get_one_line() considers the "current
line".

This makes the hand-coded is_mboxrd_from() even more attractive; plus
you can re-use it in patch 2.
