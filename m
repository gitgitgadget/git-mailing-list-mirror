From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10.1 7/7] bisect: allow any terms set by user
Date: Sat, 27 Jun 2015 23:15:49 -0700
Message-ID: <CAPc5daWmhkqDL0pNYne4-kRoxWK7ObcOKxtE5DsfHA2cnMM1pQ@mail.gmail.com>
References: <xmqqsi9etjwy.fsf@gitster.dls.corp.google.com> <1435351183-27100-1-git-send-email-Matthieu.Moy@imag.fr>
 <xmqqa8vmrtsh.fsf@gitster.dls.corp.google.com> <CAP8UFD1PyS_qM3EHW_Nzmo=3aeTDkZ0M3hnhRQANAO+ShF3H1Q@mail.gmail.com>
 <CAPc5daXSnovQPxR5kVoeRy4kApH7DiuTDvAz1ooQFp=5DZZg4Q@mail.gmail.com> <558F8B55.1070708@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git <git@vger.kernel.org>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jun 28 08:16:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z95tV-0003qg-Me
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 08:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbbF1GQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 02:16:11 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34862 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbbF1GQK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 02:16:10 -0400
Received: by oiax193 with SMTP id x193so99665635oia.2
        for <git@vger.kernel.org>; Sat, 27 Jun 2015 23:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=CQ/2j1Rv54C8OXa4gcfGlc9sS0RzAKiCa2eSQuOXX2c=;
        b=t7PGssdP7sR5gQ2fypAzvgv+rY9za4Y5fQ38U9kZ+3nGf2lBsyAM+bBaaG526P/EYc
         OHiISw5y6UhyFiDisRAjkUXFcg4Cq0M0wu9GkqvSjzm+3OnMElAHAFaYJd0DNfYR4VU3
         eM5zeCVc2crDJuAnTr9arelr4B3DphbmaKNi+g5tywsTbKRNF4zdwQTTEO/X8Lp+3NAg
         n8d8qAwwcl7zH4QyIGVB9ISNTwDV381jU/SXRBstb0wwPEYgPKo0JiO2+aiivP7uYSKp
         GtIUmvE+JCocpWM5SlaTRBte3ZuQAsJqXJKcIdttA/oW4jGnI+fZoEUQbo3ho6kcg1b+
         hvmA==
X-Received: by 10.60.52.212 with SMTP id v20mr8793194oeo.7.1435472169654; Sat,
 27 Jun 2015 23:16:09 -0700 (PDT)
Received: by 10.202.202.129 with HTTP; Sat, 27 Jun 2015 23:15:49 -0700 (PDT)
In-Reply-To: <558F8B55.1070708@alum.mit.edu>
X-Google-Sender-Auth: oDkU9pnZLfIX_ujwoqV4xU8aiLk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272868>

On Sat, Jun 27, 2015 at 10:51 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>
> I would like to remind everybody of my old claim that it would be
> possible to teach `git bisect` to infer by itself which term means
> "older" and which term means "newer":
>
>     http://article.gmane.org/gmane.comp.version-control.git/244036

But then one mistake at the beginning and the user will be on a wrong
track during the whole bisect session, no? Unless you make absolutely
clear when making the "intelligent" decision what Git inferred, that is.

For something complex like bisect, I highly suspect that a tool that is
more intelligent than the end users (more precisely, a tool that it thinks
it is more intelligent) would hurt them more than it helps them.

Of course, that is only my claim ;-)
