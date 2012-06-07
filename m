From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 03/65] i18n: archive: mark parseopt strings for translation
Date: Thu, 7 Jun 2012 19:53:07 +0700
Message-ID: <CACsJy8D=SMmhiyp-+pL5FxfcUGdLp9X4D42eV0uAGX3_LAa0xA@mail.gmail.com>
References: <1336314232-21002-3-git-send-email-pclouds@gmail.com>
 <1338203657-26486-1-git-send-email-pclouds@gmail.com> <7vr4u23f0i.fsf@alter.siamese.dyndns.org>
 <20120529203759.GC22151@burratino> <CACsJy8AGKQHKx9XU+baUagcmi6Sc-=faNshpED=Q46JpV_31WA@mail.gmail.com>
 <20120602124440.GA28996@burratino> <CACsJy8A+FTjD3dzBWtL7X35YE9E3t0Gcx-DA6T_+Nt=X3Wp1jQ@mail.gmail.com>
 <20120607124155.GB12987@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 14:53:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SccDf-0002Tz-Rv
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 14:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756546Ab2FGMxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 08:53:40 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:44641 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755945Ab2FGMxj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 08:53:39 -0400
Received: by wibhm6 with SMTP id hm6so975545wib.1
        for <git@vger.kernel.org>; Thu, 07 Jun 2012 05:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1t2tnYM6HiaPKyM53dQ0pH1BpYZUV9vr80Gr1KW/RwQ=;
        b=bcAGB4OyTiIXAXd6Tefst9DI4PBdAWfDzOic/3cA8YudmMYQPpicFon3eAFtx60MwW
         o1tIsmnt9D1aLcOJ2jvvw/nu8yeb4Zna1zWqV0SO9IwZGBJ0UPKQ2YsZiW0nRfKn5JQr
         kbBz3S0cXUMSQmYZK3AQHWZftRHtn1LM4gG4epdmHqcyKkV0jTY1KAURxI6FmnD0Gf9P
         LC3xarKgqFzQGeze23ZA3Kasj5nJh50sv689D4svnvlfB7MzdX4FI//jVjUvbytTylxQ
         ZX3q0wDrCoDzTik96glsrUyaUWtQbI4c0xHzVygg127C+WDGrh1DWBNthOh0KXc5heJK
         m7RQ==
Received: by 10.216.213.79 with SMTP id z57mr811056weo.27.1339073618350; Thu,
 07 Jun 2012 05:53:38 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Thu, 7 Jun 2012 05:53:07 -0700 (PDT)
In-Reply-To: <20120607124155.GB12987@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199403>

On Thu, Jun 7, 2012 at 7:41 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Nguyen Thai Ngoc Duy wrote:
>
>> No changes to the series then. Junio, pu material perhaps? The
>> breaking gettext poison thing is different and I plan to kill gettext
>> poison soon (whether i succeed is another question of course).
>
> If you mean to kill it by replacing it with a facility to run tests in
> another locale, wouldn't all these testsuite bugs still be testsuite
> bugs?

They still are and should be fixed when the new facility comes, so
there's no point fixing them now. I played with the poison .po
generation a bit and started to use libgettext-po, which would give us
more control over reading/writing .po. We could even perform
git-specific checks on po files..

The said plan is to build .mo for $LANG in po/build/poison-locale
(po/build/locale remains good translation) and add a switch to make
the test suite use poison-locale instead. Long term I'd like to switch
to poison locale by default, unless LANG is C, maybe with an option to
run with real .mo files.
-- 
Duy
