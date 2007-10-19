From: "Dan McGee" <dan@archlinux.org>
Subject: Re: [PATCH] send-pack: respect '+' on wildcard refspecs
Date: Fri, 19 Oct 2007 09:11:00 -0500
Message-ID: <449c10960710190711p712e780dl5bb322d0804e4ecc@mail.gmail.com>
References: <20071019090400.GA8944@coredump.intra.peff.net>
	 <449c10960710190510y3af3ffa2ydb9ae4a01b5d480c@mail.gmail.com>
	 <20071019122755.GA17002@coredump.intra.peff.net>
	 <449c10960710190638j5823b19dl903ae369965e884e@mail.gmail.com>
	 <20071019134339.GA21852@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 16:11:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IisZV-0001UW-3s
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 16:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759531AbXJSOLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 10:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758833AbXJSOLF
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 10:11:05 -0400
Received: from nz-out-0506.google.com ([64.233.162.227]:32772 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760149AbXJSOLE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 10:11:04 -0400
Received: by nz-out-0506.google.com with SMTP id s18so58070nze
        for <git@vger.kernel.org>; Fri, 19 Oct 2007 07:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=PF0FNpZ31Pk/k2RPNrtdmSc6sE1+tKxd8gNywEwC7OE=;
        b=qFbfS2QFsLs2E7jYrpZYLO/Hj8W2S6yTTvMVRlYMOkXks/n1icS9/WUtQeHaE6srahdy5tVQV8m566+NMYzkn6RG5AKWts77ALMqOeTyquv6Jk74Ribq0fRL6umAPakAr0+cudc8buB3OZRiW5+6FsSCTwR3HXOzpzksgrB3UJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=ulodsEYpQiNWoZ1RvKCLEfj8CJUlKcJnuA+b3EQwKe9U0/UrsCh6VL09dqgRGR8FbRGXpNBf7zrIAC47foz6TRRisiMcUI92GQNnUJizL1vQKF4g9ouIaCqlZx8tggqNwAjycwAqJ9S+uvTv6h0kUHD1eezgkcJSk/TBIKbDj7Q=
Received: by 10.115.92.2 with SMTP id u2mr2086752wal.1192803060546;
        Fri, 19 Oct 2007 07:11:00 -0700 (PDT)
Received: by 10.114.67.15 with HTTP; Fri, 19 Oct 2007 07:11:00 -0700 (PDT)
In-Reply-To: <20071019134339.GA21852@coredump.intra.peff.net>
Content-Disposition: inline
X-Google-Sender-Auth: 14d32b01533f58f4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61712>

Ahh, shoot. Forgot to reply to all.

On 10/19/07, Jeff King <peff@peff.net> wrote:
> It is based on Shawn's next, 2fe5433b. Are you sure you're not doing
> something silly like executing an older version of git that is in your
> PATH?

Yeah, just tried that again, definitely using the right version of
git. Before I apply your patch, both my test script and your addition
to t5400 fail. After applying your patch, my test script fails but
your addition to t5400 succeeds. Could this be something where
git-push and git-send-pack are not interacting correctly?

-Dan
