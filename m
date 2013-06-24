From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/6] Reroll of rr/triangular-push-fix
Date: Mon, 24 Jun 2013 12:51:24 +0530
Message-ID: <CALkWK0kDwMq-ADRPShOdCy2Vh+zj9J9A0A4CFv21aKZFeiMs+w@mail.gmail.com>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 09:22:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur16I-0006hA-2P
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 09:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873Ab3FXHWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 03:22:05 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:43350 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483Ab3FXHWE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 03:22:04 -0400
Received: by mail-ie0-f178.google.com with SMTP id u16so24622966iet.9
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 00:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gfcCq81RlWKe8rb3GTQ8QhOe6mgCFKeDeVy3+cVi3yc=;
        b=Is26vDSOJ9DAXeopFophaR/lNZ/Movewv+Jqd/D06GDGFl5hMBldO7RVT/u6VMGNue
         Q3Ch+NTtLKo/nbAqmsNO/EnREGAb1gE/bez7HWkVRMeiYJPPcfSD3M1vqbULBFowNdW/
         FFiSZdcmgHONm8qtT8u6BOGLe0lm9F7tdGEfViZeomlvRL2RvVjWiwtIOkQR0UzsJ6bB
         O0IM/dJtdPBK6XCQsXLh2QrYbCt+BlyVKNPrqEpv4lnu0pycCee8C0shZzCV9+udRd06
         s0CGPjYC83/kaOwRVIeN4CV9UG95orNusis6v+jKct3EPX1MICWeNr4cOBJMnoZI/QQG
         Cwag==
X-Received: by 10.50.47.105 with SMTP id c9mr4756695ign.50.1372058524396; Mon,
 24 Jun 2013 00:22:04 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Mon, 24 Jun 2013 00:21:24 -0700 (PDT)
In-Reply-To: <1372048388-16742-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228781>

Junio C Hamano wrote:
>   [PATCH 3/6] push: change `simple` to accommodate triangular workflows
>
>   Sqaushed in the fix to keep the semantics of "simple" when used in
>   the centralized workflow the same as before.

Yeah, I'm worried about this as I pointed out earlier.  I don't like
erroring out when no branch.$branch.merge is not explicitly set, when
the 95% usecase is not naming local branches differently from remote
branches (oh, and I already pointed out how difficult it is to set the
damn thing).  So, I'm working on a series to  make
branch.$branch.merge default to refs/heads/$branch.  Yes, I'm aware of
your "argument":

> We already have a sane default, which is to error out.  We do not
> need your broken default.

I hope (perhaps foolishly) to persuade you nevertheless. I fear that
if this series solidifies before I get there, we'll be stuck with this
stupid erroring-out behavior forever.
