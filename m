From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 3/3] clone: always fetch remote HEAD
Date: Fri, 3 Jun 2011 20:50:41 -0500
Message-ID: <BANLkTimuU6fxS+CoL=rpQbN4vfRyMNOMJQ@mail.gmail.com>
References: <20110603050901.GA883@sigill.intra.peff.net> <20110603051805.GC1008@sigill.intra.peff.net>
 <BANLkTim03_3DLdDkc3QgFrcUa0Fqhhqnbw@mail.gmail.com> <20110603181052.GA17538@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 04 03:52:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSg2L-0006Kf-VW
	for gcvg-git-2@lo.gmane.org; Sat, 04 Jun 2011 03:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980Ab1FDBvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 21:51:23 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:53432 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876Ab1FDBvW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 21:51:22 -0400
Received: by qwk3 with SMTP id 3so1041625qwk.19
        for <git@vger.kernel.org>; Fri, 03 Jun 2011 18:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=ok1o0DXvgBdwhw2s29hoR9C3MG/VziCQR0Jh336gd10=;
        b=tm1hHfpQdrCNlbwgqU+0kIKAIg4wzu8mF1vwK9Ny5NQLb+wk86J6GwA1hF/H1b0iMp
         9icx55Y7H2dlO+mYmeGvnzcy+Vy5js51hhCQG8oxX5DxV1mUQ6CUkhv35Xt7Meng+MUB
         fIc25iU7ENqJhbzT9AGOI7xk2XII7VzlUwGog=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=BdXKsW0vbNL3oem+9QO8dWVLjRRAbgFer2UxL0K6TUrXWPL2nBwE367I6ACHs4wSmU
         9d0QWj79fkmR85A4cBoXPsJ79kFYVQ4Z6tU5G6oaPXg3tvbhVp24h/CS0w/GFfcox/NG
         CWNxNjithnurc01DV9g9J9rSS5rRg9ZVDsmEQ=
Received: by 10.229.126.167 with SMTP id c39mr1913812qcs.119.1307152281277;
 Fri, 03 Jun 2011 18:51:21 -0700 (PDT)
Received: by 10.229.20.6 with HTTP; Fri, 3 Jun 2011 18:50:41 -0700 (PDT)
In-Reply-To: <20110603181052.GA17538@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175054>

Heya,

On Fri, Jun 3, 2011 at 13:10, Jeff King <peff@peff.net> wrote:
> Or is it the fault of testgit for calling exporter.export_repo twice? It
> seems to ignore the ref argument it gets to import, and just dumps the
> whole repo, albeit into an alternate namespace. Should we then be doing
> something per-ref with the result? Or since our particular import
> imports everything, should we simply ignore further imports after the
> first one?

I never tested testgit with multiple import arguments, as I wasn't
sure how it was supposed to work in the first place.

> Does that make sense? If so, then I think the right fix is for testgit
> ti ignore all imports after the first one (since the first one will have
> done all available refs). And the patch is:

We can do that yes, although it would be even better if we could make
testgit implement importing only a limited set of branches, as I
assume that will be common. Nonetheless, this will do for now I think.

-- 
Cheers,

Sverre Rabbelier
