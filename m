From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6] blame: add support for --[no-]progress option
Date: Sat, 12 Dec 2015 19:40:24 -0500
Message-ID: <CAPig+cQ__eueXdeq=CHUicz727hx-THuJxt20_PXGgo=KzK0xA@mail.gmail.com>
References: <1449964625-27737-1-git-send-email-eantoranz@gmail.com>
	<CAPig+cQq2Y0m0UJVCMb-9B8qrGNXV7ecf5hDETdgX5w4oUuAvw@mail.gmail.com>
	<CAOc6etar5DU0w_RFRgUAzK39R43cP=eSwT_=0u2NbgKhdPi8Sg@mail.gmail.com>
	<CAOc6etYAbT8Yc3NwB4Rh1dShjDQB_PR2K-HvXpx6dTcB=YaB8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 01:40:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7uiD-0000u0-M0
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 01:40:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbbLMAk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2015 19:40:26 -0500
Received: from mail-vk0-f49.google.com ([209.85.213.49]:36211 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbbLMAkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2015 19:40:25 -0500
Received: by vkay187 with SMTP id y187so135836845vka.3
        for <git@vger.kernel.org>; Sat, 12 Dec 2015 16:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=cGL9ATkxtKrHezFstbNkDTAHy7bB2/9Du8qYMZVXpAc=;
        b=DFIUrgbaXLAW++EwcJFowZWM0rfRlVDd1uL/J8MuXKkbaJ+nSeX2uF7QBnI8cetmt2
         tL+NNASRYioUEEPaO+c8Vk/OyFMcvir6N73+IdboxEXIr9cN2+XjQia107i2vdTuEC/9
         84fT+94/pkV/X8VPka9bb4aCT+xsu+Zm7joF8I87L4tBm9XZJPtB32SnBgOhvcRKY35A
         GY7ezZif0c0N5Xq72TBntmTYpjrMTm8sr2byUdWOUGOsBs2lI9uoLNxFTL6CA7S9Ym1g
         SPPz4Pv/2c/grFhxbT0jJWPex1CKnEJQiGzUsFYGvcLNxNfOKeTeiuA4lOvAJsNPdfAb
         +uKg==
X-Received: by 10.31.58.142 with SMTP id h136mr19713065vka.115.1449967224722;
 Sat, 12 Dec 2015 16:40:24 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sat, 12 Dec 2015 16:40:24 -0800 (PST)
In-Reply-To: <CAOc6etYAbT8Yc3NwB4Rh1dShjDQB_PR2K-HvXpx6dTcB=YaB8w@mail.gmail.com>
X-Google-Sender-Auth: X68K6LJfOOvD5HefcsVnRzl0gqA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282312>

On Sat, Dec 12, 2015 at 7:36 PM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> On Sat, Dec 12, 2015 at 6:30 PM, Edmundo Carmona Antoranz
> <eantoranz@gmail.com> wrote:
> Hmmmm.... if the code in assign_blame changed to this, it would be
> possible to allow the -1 to go through:
>
> if (show_progress > 0)
>     pi.progress = start_progress_delay(_("Blaming lines"),
> sb->num_lines, 50, 1);
>
> But then I think it would be more 'concise' if we had the value set to
> 0/1 instead of expecting to see a possible value of -1 there (or
> anywhere else) after progressing if progress will be shown or not in
> the piece of code we are chatting about.

The name "show_progress" does read like a boolean rather than a
tristate, so making sure its value is 0 or 1 after option processing
(as your current patch does) is probably the best way to go. I don't
otherwise feel strongly about it.
