From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 4/4] cache-tree: Write updated cache-tree after commit
Date: Sun, 13 Jul 2014 14:58:20 -0400
Message-ID: <CAPig+cTqd8LMMA+MsSiuxnyXy+pYDj57UdVmYHNnvW5NBG8W0Q@mail.gmail.com>
References: <1405120947-3142-1-git-send-email-dturner@twitter.com>
	<1405120947-3142-4-git-send-email-dturner@twitter.com>
	<CAPig+cQpzomDmwVqgDGrP4qC1OujRXu5e1wc=EwX61k_RpLbKg@mail.gmail.com>
	<xmqqbnst18dh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 20:58:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6Oyg-0000yh-6T
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 20:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbaGMS6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2014 14:58:23 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:52573 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbaGMS6V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 14:58:21 -0400
Received: by mail-lb0-f171.google.com with SMTP id l4so298233lbv.16
        for <git@vger.kernel.org>; Sun, 13 Jul 2014 11:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=2Tyewl8NxpV+HsKPstg/5t3O96nqI0kvqun3n75yeGg=;
        b=ecAwcyOflgsRuHUSpTdBwHWOL9cXhextz0sYE+4O03Y92Qa5+qfx1IEYoPzTY80lHU
         xKbH0GX94voxhtNYe2XKBNJFkc43OMve46kSUUTsabRE0Ar4lytp8mqdMs/nTmvCDw0B
         lyXreU/pngAa6aQFMo0pv0hb2hXFgnOOO8L4FXR948io8LmZNBNmTQipq6pJu4pDrENI
         /SCbX5VNQX2PdhOsfqsS7tuio7UHK4uxyYdEA2oekycJs2ovdj5eIHXQQeFs17OxexvV
         VgdTneMwybkIV/KYrkjRMIjTXxQogSbHSzv7BqMN5ydYJJYwCq9LMFXSiN4O0hJ7GPRV
         H4xA==
X-Received: by 10.112.150.65 with SMTP id ug1mr9896885lbb.46.1405277900112;
 Sun, 13 Jul 2014 11:58:20 -0700 (PDT)
Received: by 10.114.78.167 with HTTP; Sun, 13 Jul 2014 11:58:20 -0700 (PDT)
In-Reply-To: <xmqqbnst18dh.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: V8aCjV92-VvyVTFIuVjMwJfJTC0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253455>

On Sun, Jul 13, 2014 at 1:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>>> +       (echo p; echo 1; echo; echo s; echo n; echo y; echo q) | git commit --interactive -m foo
>>
>> Broken &&-chain.
>>
>> Would a printf make this more readable?
>>
>>     printf "p\n1\n\ns\nn\ny\nq\n" | git commt ... &&
>>
>> Perhaps not.
>
> But
>
>         printf "%s\n" p 1 "" s n y q
>
> is vastly more readable, I would think.

Yes, that's much nicer (and I should have thought of it myself
considering that I made effectively the same suggestion elsewhere
[1]).

> Don't we have test_write_lines which is exactly that, though?

Indeed, that's even better.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/233260/focus=234499
