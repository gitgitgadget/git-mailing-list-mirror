From: Johan Herland <johan@herland.net>
Subject: Re: Re: Extended splitting for "git add --interactive"
Date: Thu, 27 Nov 2014 11:14:45 +0100
Message-ID: <CALKQrgcHvjuynbmRZWAKWu-Ld1-h7eqEZEBqorPTHW9m8onDGg@mail.gmail.com>
References: <5475F7E7020000A100018050@gwsmtp1.uni-regensburg.de>
	<xmqq3895rdr1.fsf@gitster.dls.corp.google.com>
	<5476F4FA020000A100018078@gwsmtp1.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Thu Nov 27 11:15:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xtw6V-0005Mt-N9
	for gcvg-git-2@plane.gmane.org; Thu, 27 Nov 2014 11:15:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754016AbaK0KPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2014 05:15:09 -0500
Received: from mail12.copyleft.no ([188.94.218.224]:48391 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbaK0KPE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2014 05:15:04 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1Xtw68-0000bc-0q
	for git@vger.kernel.org; Thu, 27 Nov 2014 11:15:02 +0100
Received: from mail-pa0-f45.google.com ([209.85.220.45])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Xtw67-000CQM-Kr
	for git@vger.kernel.org; Thu, 27 Nov 2014 11:14:51 +0100
Received: by mail-pa0-f45.google.com with SMTP id lj1so4766133pab.32
        for <git@vger.kernel.org>; Thu, 27 Nov 2014 02:14:45 -0800 (PST)
X-Received: by 10.67.30.194 with SMTP id kg2mr62703275pad.8.1417083285121;
 Thu, 27 Nov 2014 02:14:45 -0800 (PST)
Received: by 10.70.75.161 with HTTP; Thu, 27 Nov 2014 02:14:45 -0800 (PST)
In-Reply-To: <5476F4FA020000A100018078@gwsmtp1.uni-regensburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260343>

On Thu, Nov 27, 2014 at 9:55 AM, Ulrich Windl
<Ulrich.Windl@rz.uni-regensburg.de> wrote:
> I probably forgot to mention the obvious: My enhancement request was
> for cases where git would reject so split a hunk. I don't want to
> change the default split (if it finds a point to split).
> So maybe call it a "2nd-level-split". Only if split refuses to split,
> you could avoid using "edit" to manually split.
> I know that in general such things can't be right, but you can
> either reject the new hunks or use "edit". I just guessed the feature
> could save some time on the average.

FWIW, I would very much like a "2nd-level split" where it simply splits
into individual lines. I think it's not worth trying to be extra clever
about it. For your example, I'd simply want the following behavior:

  -AAA
  -BBB
  +CCC
  +DDD
  Stage this hunk? SPLIT

  -AAA
  Stage this hunk? YES

  -BBB
  Stage this hunk? NO

  +CCC
  Stage this hunk? YES

  +DDD
  Stage this hunk? NO

This would allow me to stage the following:

  -AAA
  +CCC

and leave the following unstaged:

  -BBB
  +DDD

but would also allow any other combination.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
