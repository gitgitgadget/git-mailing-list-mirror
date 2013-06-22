From: "Eduardo D'Avila" <erdavila@gmail.com>
Subject: Re: [PATCH 1/4] t9903: add tests for git-prompt pcmode
Date: Sat, 22 Jun 2013 13:32:38 -0300
Message-ID: <CAOz-D1L3mrqTKwpnRVEEfZayFNX+eKVNC1-Ewy45tmf9MPQhtQ@mail.gmail.com>
References: <cover.1371780085.git.erdavila@gmail.com> <3dd104f19a995081d8c8bf89bc9e33052077e052.1371780085.git.erdavila@gmail.com>
 <20130622130604.GK20052@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Simon Oosthoek <s.oosthoek@xs4all.nl>,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Jun 22 18:33:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqQkX-0000rx-73
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 18:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633Ab3FVQc7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Jun 2013 12:32:59 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:39898 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891Ab3FVQc6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Jun 2013 12:32:58 -0400
Received: by mail-ie0-f174.google.com with SMTP id 9so21822260iec.33
        for <git@vger.kernel.org>; Sat, 22 Jun 2013 09:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=+WNzMhjnAuGrJSx7+uZMr5dSO8nO7iGJIIMV0TW6+94=;
        b=VQiwgT8eY6MUU2tv1BaYSqzS5ixG3g8nhPk9+WDTaXfNwE4QAiSqV3JQZVysRP8QG+
         /+vkPZvPAtU9UvV9rYyA8JKFJSpHSqENXRGZyDyRtTrXs9R+u5ByHJSrmrCT+zkjEMDp
         oVQlRSn2kAF/vZaYlQZT1mqBGiirfh+hYcr12M21HNnn98REr9SpmMiTncJnNrw7CER3
         TQH7XO3Mk5JWGoffPU+850gKTLZBvyirisXlbItjU0VzHs7xTOBLpC2cGhnu8ilMvYn5
         0WXVyM8BnKX7XRAtKnVOTD3uEDM5YmCufcYjtfMMtmhdwfUwvU/PqnoqfeCmnbrV85f3
         aiEw==
X-Received: by 10.50.111.104 with SMTP id ih8mr1776345igb.28.1371918778336;
 Sat, 22 Jun 2013 09:32:58 -0700 (PDT)
Received: by 10.42.249.197 with HTTP; Sat, 22 Jun 2013 09:32:38 -0700 (PDT)
In-Reply-To: <20130622130604.GK20052@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228714>

2013/6/22 SZEDER G=E1bor <szeder@ira.uka.de>:
> On Thu, Jun 20, 2013 at 11:25:26PM -0300, Eduardo R. D'Avila wrote:
>> git-prompt.sh lacks tests for PROMPT_COMMAND mode.
>>
>> Add tests for:
>> * pcmode prompt without colors
>> * pcmode prompt with colors for bash
>> * pcmode prompt with colors for zsh
>>
>> Having these tests enables an upcoming refactor in
>> a safe way.
>>
>> Signed-off-by: Eduardo R. D'Avila <erdavila@gmail.com>
>
> I doubt the value of separate tests for zsh.  They might make sense a=
s
> long as there are different code paths for doing coloring for the two
> shells, but after your refactorization in 2/4 there is only one commo=
n
> block of if statements, which is already thoroughly excercised by you=
r
> tests for bash, making the separate tests for zsh redundant.

These tests where important to make sure that I wouldn't break anything=
 during
the refactorization. Having them pass before *and* after refactorizatio=
n
guarantees that nothing was broken (except for some subtle case that mi=
ght have
not be included in the tests).

However, I agree that they became redundant.

Would it make sense to include a patch that only removes the zsh
tests, after the
refactorization? I'm considering that *1* simple zsh test must be kept =
during
this removal, to make sure the code path for zsh is run.


Eduardo
