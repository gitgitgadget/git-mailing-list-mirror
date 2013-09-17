From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: 1.8.4 rebase regression?
Date: Tue, 17 Sep 2013 12:59:26 +0200
Message-ID: <vpq1u4n67e9.fsf@anie.imag.fr>
References: <20130915235739.GA712@quark> <vpqioy1815z.fsf@anie.imag.fr>
	<20130917091333.GB289@quark> <vpq8uyv6btk.fsf@anie.imag.fr>
	<20130917100726.GF289@quark>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Patrick Welche <prlw1@cam.ac.uk>
X-From: git-owner@vger.kernel.org Tue Sep 17 12:59:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLt0L-0000ST-5k
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 12:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481Ab3IQK7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 06:59:33 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50314 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752412Ab3IQK7d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 06:59:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r8HAxPBW016543
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 17 Sep 2013 12:59:25 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VLt0A-00057I-OA; Tue, 17 Sep 2013 12:59:26 +0200
In-Reply-To: <20130917100726.GF289@quark> (Patrick Welche's message of "Tue,
	17 Sep 2013 11:07:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 17 Sep 2013 12:59:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8HAxPBW016543
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1380020367.49267@osRCS82uuFVy+ymv1PgZuA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234870>

Patrick Welche <prlw1@cam.ac.uk> writes:

> On Tue, Sep 17, 2013 at 11:23:51AM +0200, Matthieu Moy wrote:
>> Patrick Welche <prlw1@cam.ac.uk> writes:
>> 
>> > Got it: the change between 1.8.3.4 and 1.8.4 is that colour is on by
>> > default. If I take 1.8.3.4 and git -c color.ui=always log, I see
>> > the same ESC codes => not a regression! I'll just have to sort my
>> > box out if I want colour. (The only oddity is that git status is
>> > correctly colourful.)
>> 
>> Maybe you disabled the pager for "git status"?
>
> Interesting: I didn't disable it on purpose, but indeed, it is not
> used for status.

Ah, my bad. Whether the pager should be enabled by default for status
led to a lot of debates here, and I thought the conclusion was yes. But
I'm the one having it enabled by default:

[pager]
        status = true

> Can't believe this:
>
> $ echo $PAGER
> more
>
> unset PAGER, and git diff is fine...

less will be a much better pager than more, indeed. The default behavior
of less is sometimes anoying (open full-page, and 'q' restores the
terminal, which is very inconvenient for short output), but if you
didn't set $LESS, then Git will set it for you to something appropriate
for git pager.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
