From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] t8005: avoid grep on non-ASCII data
Date: Sun, 21 Feb 2016 18:40:04 -0500
Message-ID: <CAPig+cQQWAsd9MB4yUKaFePdVoJqrqWEZCFakQxTiWKJWW+4cw@mail.gmail.com>
References: <20160219193310.GA1299@sigill.intra.peff.net>
	<cover.1456075680.git.john@keeping.me.uk>
	<81ec83acd004ef050a4c8df62fb158b41f0a0a80.1456075680.git.john@keeping.me.uk>
	<CAPig+cQ9n4Eg73Uyeg_g_4wzebuwn8=0R-LMb8F9QLFxanwVVg@mail.gmail.com>
	<xmqqsi0l8wt8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 00:40:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXdbo-0003r4-Rb
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 00:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514AbcBUXkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 18:40:06 -0500
Received: from mail-vk0-f49.google.com ([209.85.213.49]:34397 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434AbcBUXkF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 18:40:05 -0500
Received: by mail-vk0-f49.google.com with SMTP id e185so115576894vkb.1
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 15:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=SK9O7MffRoz6yFoWa0j1bgI1eD/fUJYlHbUuGBR4hco=;
        b=m3yR23koNwKs+dzdxa177h1Va3YYJEnEUGPMFZX26s9wTHdqQk2zbnLFqhf4eKdbfi
         vV2tXM5OQ2vIr4MEas9z6VLuR3CDYVXKgcGzR3mfccDqq6L+Al2FjTcP/kt+38BPe/pj
         B1Z9yE0n3W7XbVW1p3mPEiU93Yo2Tkbe/PS7egw7ZV5p+C6u3Rbc5gmGSOFvOkdcsy4h
         pd9N6tm8IHO8TQjuzbylhvXutbi6p3uyq0gguPbbQ0Bxux0Lp3TGxFDwlIV1BrGgJFiw
         eIibFg2JhlAig1kMrNvz9ogFqV8VUu2qOQAuALe+V5riK+LNxflNk18q8fQ5rywCWFZI
         IDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=SK9O7MffRoz6yFoWa0j1bgI1eD/fUJYlHbUuGBR4hco=;
        b=J4MwQ3kY70xokYQcCNlHOFcR4aiwb9oJC/nAPAYuYwMybRBd+9QBN1j+rM/KGGTH+6
         1iIlYyQgyJPG0x+5oTDZey6yA+vIyeiPjC7NI+KC0cQ5Q56wVYLfu7eoHnkUuiRgndYV
         0zz4J5Qch3SJCrnQTwW+IlunJKoloZWOxpQjDBejsVml1tIzEXbCC7XVb5eorDOI2swQ
         RjKqh1X086f+fr3VBELObMi0DdqDQQN7V+SG0GEALJy8+X6/UmOyFLDw1yifDFK/OA09
         U2oxnVcUUV3Ay4nLYqBkmQtjr94l4seHKlo+HyX2+EhKyWupYbq3koEaN1NRxAuBbcK0
         rbzw==
X-Gm-Message-State: AG10YOTVkTv2EzO0JoTivBTS6y0QXiVCVoaHqt4pkdABeSSUc3DYkiJjJHbODUOUO+af+dVV08ctcqUlGZh5nQ==
X-Received: by 10.31.168.76 with SMTP id r73mr20795084vke.117.1456098004851;
 Sun, 21 Feb 2016 15:40:04 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 21 Feb 2016 15:40:04 -0800 (PST)
In-Reply-To: <xmqqsi0l8wt8.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: VVijOXczrVJb6-YsPnlvsWCQ32A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286849>

On Sun, Feb 21, 2016 at 6:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> These tests all crash and burn with BSD sed (including Mac OS X) since
>> you're not restricting yourself to BRE (basic regular expressions).
>> You _could_ request extended regular expressions, which do work on
>> those platforms, as well as with GNU sed:
>>
>>     sed -nEe "/^(author|summary) /p" ...
>
> An obvious way to avoid any RE is to write it as two separate
> statements.

Yes, that's even better; now I feel stupid for not thinking of it.
