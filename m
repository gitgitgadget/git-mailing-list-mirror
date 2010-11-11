From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH v2] rebase -X: do not clobber strategy
Date: Wed, 10 Nov 2010 20:11:04 -0500
Message-ID: <AANLkTiks87caBYo78Xh1hwnEfDF9yKwBn5q3wa87hBo3@mail.gmail.com>
References: <1289373266-32593-1-git-send-email-martin.von.zweigbergk@gmail.com>
	<AANLkTimEvp2mQu1QWhx-FDEx37NLi8jose_p+A1y1iHK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, gitster@pobox.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 02:11:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGLh1-0007lr-Uq
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 02:11:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121Ab0KKBLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 20:11:06 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:54291 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932099Ab0KKBLF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 20:11:05 -0500
Received: by qyk30 with SMTP id 30so53761qyk.19
        for <git@vger.kernel.org>; Wed, 10 Nov 2010 17:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=qnQ/tKEHkHMG7dS+NjuRBvPPxn7fYLqhzK+F3e95pvw=;
        b=etoyqayU2IPulZBIJVfhBArd37kK1HXYeJvK9B6yXugJFYdpumzub+ggULFX8hW/uJ
         vLm62sCQ17C8l0PIArm4wbwx2TcGuyGiQSKQiA6weygxjqeg3muTXyAkCnp6C3C3B1Yk
         iDSqAHwgFZdHAOxDh5oiBSRPdhpu0uIrqv/wE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=dXr9UQFz+bMdq6P+fhlmLmARobE2k+9GcyQeMCvQl8Gl9Z+lIxLnLspg/NZbjrbXg/
         VnLpn+cpM142Yf//T6pX74tUNRbtrF5U+4FqptiDiAHDbTLQomY19U7AEKqb5snx0sLj
         gNpcfucpguSUwlAC6LkGFtxrrekX76Ng9xRhI=
Received: by 10.224.135.227 with SMTP id o35mr256339qat.75.1289437864373; Wed,
 10 Nov 2010 17:11:04 -0800 (PST)
Received: by 10.224.138.5 with HTTP; Wed, 10 Nov 2010 17:11:04 -0800 (PST)
In-Reply-To: <AANLkTimEvp2mQu1QWhx-FDEx37NLi8jose_p+A1y1iHK@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161200>

On Wed, Nov 10, 2010 at 1:56 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Wed, Nov 10, 2010 at 08:14, Martin von Zweigbergk
> <martin.von.zweigbergk@gmail.com> wrote:
>> If any strategy options are passed to -X, the strategy will always be
>> set to 'recursive'. According to the documentation, it should default to
>> 'recursive' if it is not set, but it should be possible to set it to
>> other values.
>
> Repeat of other threat since this is a new patch: can we have a test for this?


I don't think there are any merge strategies other than recursive that
accept options, so what I could add a test case for is that e.g.
'-s ours -X foo' uses the 'ours' strategy, even though 'foo' will be
ignored. I have very little experience with merge strategies, but I will
give it a try. Hopefully there is some existing test case I can copy and
modify.

Btw, why is the default (if no strategy is specifed) for 'git rebase' to
use 'recursive', while for 'git merge' "a built-in list of strategies is
used instead (git merge-recursive when merging a single head, git
merge-octopus otherwise)"?
