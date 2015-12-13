From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH v6] blame: add support for --[no-]progress option
Date: Sat, 12 Dec 2015 18:40:13 -0600
Message-ID: <CAOc6etYCZOA9SOxWp3cKuY0z249jeb5vYAhvbLEohYGeVqi6Bg@mail.gmail.com>
References: <1449964625-27737-1-git-send-email-eantoranz@gmail.com>
	<CAPig+cQq2Y0m0UJVCMb-9B8qrGNXV7ecf5hDETdgX5w4oUuAvw@mail.gmail.com>
	<CAOc6etar5DU0w_RFRgUAzK39R43cP=eSwT_=0u2NbgKhdPi8Sg@mail.gmail.com>
	<CAPig+cQjWgTR9Sd-CutkbuBa1Czp5YApsYoFXc9HS1H08cno7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 01:40:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7ui4-0000Rv-L8
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 01:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbbLMAkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2015 19:40:15 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35489 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbbLMAkO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2015 19:40:14 -0500
Received: by pfd5 with SMTP id 5so23839681pfd.2
        for <git@vger.kernel.org>; Sat, 12 Dec 2015 16:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dd1pHyrlLMlPeDxjRxo0Pj6Gh5IhBxkqqjEDUqjIrWc=;
        b=ceV5oduffgQszqMhIRnLnPuODYK2z9usrkZpiFdZDF0/7VOmE/pVEX6Ub2kK/ISkee
         QuzuDIp7jfqura0Mn5O99cdzZ1AAonQXIznkhvNorEyxJoS9z3gRNajEE0zHXWoWsCC5
         mKIeOc/L2z2kTX3fn9jRyC9eDpi1u1NdZc/3xx7Cv+LMpoKc5J1DbMmxPT5h8a/4Klri
         HW0VVvrKprYM55cELJyLivk51WbOEBxcHpl+jlv5NnsfH0tfjsgbErZlRwB3oLrlpMC/
         d5+ebzRgAHHENWdv5RtZ6JoY9h4nNbkDVdJWj0hkFgWe5+dzE31bgnjy03xr0TlNjXDO
         0fsg==
X-Received: by 10.98.16.205 with SMTP id 74mr4945804pfq.150.1449967213883;
 Sat, 12 Dec 2015 16:40:13 -0800 (PST)
Received: by 10.66.89.42 with HTTP; Sat, 12 Dec 2015 16:40:13 -0800 (PST)
In-Reply-To: <CAPig+cQjWgTR9Sd-CutkbuBa1Czp5YApsYoFXc9HS1H08cno7A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282311>

On Sat, Dec 12, 2015 at 6:37 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>
>> Because, if the user didn't provide --[no-]progress option, then the
>> value in show_progress will move forward being -1 and then in
>> assign_blame, there will be progress output if you chose --incremental
>> or porcelain. So, if you chose --incremental or porcelain, we better
>> set the value to 0 to make sure there will be _no_ progress. Agree?
>
> Yeah, I was thinking of that and had the correct interpretation in
> mind when reading the code, but then blocked it out of my brain for
> some reason when actually composing the response.

Good! So, the only things to modify would be:
- documentation to reflect new policy
- no need to check for show_progress to ask to finish up struct
progress instance.

Let's give some time to allow for more comments before my next patch
version.... so, say, 5 minutes.
