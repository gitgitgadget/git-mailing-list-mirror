From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH RFC 0/2] Mixing English and a local language
Date: Fri, 14 Sep 2012 18:35:20 +0700
Message-ID: <CACsJy8DKUdn-eY1P1d6vFz34SvEbUBm07ZR3xy5xLaKxE+Wnqg@mail.gmail.com>
References: <1345922816-20616-1-git-send-email-pclouds@gmail.com>
 <CACsJy8CG72PzvndV7C4a9hspxhprKn2tcb49HxeZ14pmEDycGQ@mail.gmail.com>
 <7vligfcdgh.fsf@alter.siamese.dyndns.org> <20120913132847.GD4287@sigill.intra.peff.net>
 <7v4nn1akz7.fsf@alter.siamese.dyndns.org> <20120913180056.GA1696@sigill.intra.peff.net>
 <505309EC.8040400@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 13:36:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCUBq-0002Ni-2k
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 13:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756077Ab2INLfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 07:35:53 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55766 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347Ab2INLfw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 07:35:52 -0400
Received: by iahk25 with SMTP id k25so2958999iah.19
        for <git@vger.kernel.org>; Fri, 14 Sep 2012 04:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=keqc63ZebcTuRsRvrSxTZnQ/buVb6JvJjxwicoLsw9M=;
        b=aminXbFHl/2hscAYOn5c+YJOp1qzu0yqUqrZcRaLI05eKSZdFhTj95u9vi1RM/1AUz
         6X/SfGROscq7HEXaQSsRYmSN5iy0K064FHagzOXc8VgFxneu1xlH4pYcAsgaRx2g5yJG
         QpJJ3qAjoUcKsTV49SHhnpr8+0sJVCTmhChibbr8rYykN81VsBkQOKULjgBiAkujXHBT
         PiE+dahd30zjBTh1TENIpfcbt8E3NaJkqrEpuSVQtyINxxm91OQFoNsG/r50lWFFFNmC
         5lkISZWp7C+rRNpmRgZpMjzmKYUhHg7YcRmKZmLpttatqibPY4mVf9p4t3p2bDAsBWqD
         napQ==
Received: by 10.42.60.139 with SMTP id q11mr2194541ich.53.1347622551351; Fri,
 14 Sep 2012 04:35:51 -0700 (PDT)
Received: by 10.64.64.72 with HTTP; Fri, 14 Sep 2012 04:35:20 -0700 (PDT)
In-Reply-To: <505309EC.8040400@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205481>

On Fri, Sep 14, 2012 at 5:41 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> For those proficient in 2 languages it's desirable to switch per project
> because it's likely they participate in projects with different $LANG
> preferences. Again, that means localizing everything(*). Additionally,
> setting core.i18n in global config is probably the better choice
> (compared to NO_GETTEXT=y) for those who are frustrated by git's
> translation in their usual $LANG.
>
> [git svn should pass that LANG to svn also etc.]

We should honor LINGUAS variable on installation. Only languages
listed in that variable are installed. Many if not most of projects do
that already. That's probably better than yet another switch.

> The question is whether we have people who prefer to work with git in
> their $LANG even though project interaction requires a different
> language. They would probably run log/gitk/commit... in their $LANG but
> need format-patch and the like in project-lang.
>
> I do think we have people in this category here on the list, so they
> should speak up ;) Could they alias their format-patch to use "-c
> core.i18n=C" or such? Or have <command>.i18n on top? per-command config
> again ;)

Probably not needed, but probably won't hurt repeating: I do :) And
things should just work, at least most of the time. When I set LANG, I
prefer to have everything in $LANG unless required otherwise (sending
to English speaking teams is one of them). But the exceptions should
be limited.

On Fri, Sep 14, 2012 at 12:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
> You seem to be saying that diagnostic does not have to be in project
> language, but I do not think it is the right thing to do.  The first
> response to "Frotz does not work" is often "What do you exactly
> mean?  How did you run Frotz?  What error message are you getting
> from it?", and you do not want to get back the diagnostics ints
> Klingon.

Whether you like it or not, all localized software has this problem.
Perhaps the only difference with commercial software is that they have
support line that also understands Klingon. I don't see any problems
with asking the reporter to translate error messages back to English,
assume that they report in English so they do know English. Given a
specific context, Klingon illiterates can even manually revert Klingon
text back to English because we have the all the translations. But
it's probably faster to just ask the reporter.
-- 
Duy
