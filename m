From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: configuring cherry-pick to always use -x?
Date: Tue, 15 Feb 2011 11:16:03 -0500
Message-ID: <AANLkTinMBBKwtkQKgyqaN+oH4-k1Ks_6SbnU7thzuuYs@mail.gmail.com>
References: <4D596435.9020605@gmail.com> <AANLkTimi=d0qbO3_-BEnPEJ+iy9B=_fksF7TiBE7HorC@mail.gmail.com>
 <4D59A39C.9090402@gmail.com> <4D5A401B.1050103@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Adam Monsen <haircut@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Feb 15 17:16:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpNZw-0004w9-Rj
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 17:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276Ab1BOQQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 11:16:35 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42191 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064Ab1BOQQe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 11:16:34 -0500
Received: by gxk9 with SMTP id 9so147371gxk.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 08:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=8/iXULGeqrgjUHShB+RJjpaAiRZvdJq5HEieJpTA0DA=;
        b=B5Nr9dJ8ibZg8ivs3N5d2mgDoSLdLnDqqaVUfZa5qVZuuknUDX641e02k/IhHihe1c
         ExGJx44qFyb8jm3w8KfE6pOsygJeon37yf9rD+vImGAVuSATemYrfjrIKOW9GyiVJHzi
         TrDYAcD9+rJX9yjsZC/Iiu2SVEl4Wv6ao5jY0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Sqrm4ZB6pyGYgCMWx3DOfPp3gKbPsOtN4lIQvO/lwHHywj99k5K4vEL/jgiiwCT3pv
         1/lREJO244QxTS4pQzmZGm+mDUdOZnKYQIcnuR75hpUgMwUjQiKpSzL1IuQIfefXYVgQ
         JyWMQyMmESvQdcAQOns/bX7B90cDsqRRd4ISE=
Received: by 10.42.218.66 with SMTP id hp2mr6970095icb.244.1297786593589; Tue,
 15 Feb 2011 08:16:33 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Tue, 15 Feb 2011 08:16:03 -0800 (PST)
In-Reply-To: <4D5A401B.1050103@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166856>

On Tue, Feb 15, 2011 at 3:58 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> - If you do want them on the same branch "f-release", you probably know
> beforehand which commits you don't want on master. You can fake-merge
> these ("merge -Xours") to master and merge the others, which is somewhat
> ugly but still better than cherry-picking everything. In some sense this
> is "manual rerere" whose results are shared (pushed) easily.(*)

I personally prefer cherry-pick, as the fake merge clutters mainline's
history with the superseded commits.

It would be interesting to have a history simplification that given a
merge M of parents A and B, ignored commits $(merge-base A B)..B where
M is TREESAME to A. Hmm, that's effectively "git rev-list ." isn't it?

j.
