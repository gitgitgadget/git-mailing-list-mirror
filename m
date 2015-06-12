From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Fix power checking on OS X
Date: Fri, 12 Jun 2015 11:58:44 -0400
Message-ID: <CAPig+cQrVoYdLrcmdw698LX=bgXkBZvyD35+K6yLLP4H-W-N=w@mail.gmail.com>
References: <1434033445-35903-1-git-send-email-pastith@gmail.com>
	<CAPig+cRzKpCePO0gXy7Rok4X7=r6tas28tv48g92YzP9tVP2AA@mail.gmail.com>
	<CACvVhd7sKiz+gTDY_RVjFf1i3Rt2pYWVsgjewyPHL1ajS5LTcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Panagiotis Astithas <pastith@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 17:58:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3RM2-0006z2-Ve
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 17:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbbFLP6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 11:58:46 -0400
Received: from mail-yh0-f41.google.com ([209.85.213.41]:35357 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbbFLP6p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 11:58:45 -0400
Received: by yhak3 with SMTP id k3so15562112yha.2
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 08:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=SEa/fpnN/AtOkYg5Nwnjg9FPp8xrqBrAYUWUo9HYSAI=;
        b=DDfsmOGxcJhWSL5geP6B2CEGKUgL6f5+/aIb4ydCbESboiQdNg0xohjN3fDvZNHrpR
         nQ1LixLnj0ag/vR+1TcwG7UkpKd8S/bhBF01m6Gh/jFxmT3ZIbm0DeMxoQn4RAJ/OChm
         04Vr3Y9r+X9Bo+AvHkiqfcq8elS/8nJ/l8AyYqjj3CaXaD8wO4eir8E9wYsEsDyqXI6i
         /iJkLq4wlwv9HWby4kM+IAREPuIVQCyEkU2cee8H1XqyXRcOfG5+lTcIFsrC3dQlNFjN
         GtJBAgBzKUtj8Ec2kYpZxx1Td3hSZO9LfwTQAeu7fgc9FIOpG+rjZIqGQWPx2YU3LQQh
         OMYw==
X-Received: by 10.129.76.79 with SMTP id z76mr19842663ywa.17.1434124724676;
 Fri, 12 Jun 2015 08:58:44 -0700 (PDT)
Received: by 10.37.36.214 with HTTP; Fri, 12 Jun 2015 08:58:44 -0700 (PDT)
In-Reply-To: <CACvVhd7sKiz+gTDY_RVjFf1i3Rt2pYWVsgjewyPHL1ajS5LTcQ@mail.gmail.com>
X-Google-Sender-Auth: Qw7Kw7edlMddrqkZ30yTrK1HzGA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271493>

On Fri, Jun 12, 2015 at 4:53 AM, Panagiotis Astithas <pastith@gmail.com> wrote:
> On Fri, Jun 12, 2015 at 6:46 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Thu, Jun 11, 2015 at 10:37 AM, Panagiotis Astithas <pastith@gmail.com> wrote:
>>> The output of "pmset -g batt" changed at some point from
>>> "Currently drawing from 'AC Power'" to the slightly different
>>> "Now drawing from 'AC Power'". Starting the match from "drawing"
>>> makes the check work in both old and new versions of OS X.
>>
>> Would it make sense to try to future-proof this further by searching
>> only for "'AC" (including the leading single-quote) or just "AC"
>> (without the leading quote)?
>>
>> (Genuine question. I don't have a strong feeling about it.)
>
> It's a reasonable idea, although I'm wondering what are the odds of
> pmset changing to output a string when running on battery in the
> future, containing something like "no longer on 'AC Power'". That's
> probably too far out though.

That was my concern, as well, hence not feeling strongly about it.
