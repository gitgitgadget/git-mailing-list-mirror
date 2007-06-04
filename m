From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Git Vs. Svn for a project which *must* distribute binaries too.
Date: Tue, 5 Jun 2007 10:29:56 +1200
Message-ID: <46a038f90706041529p224c5d44u32f7a1a358d058f1@mail.gmail.com>
References: <5971b1ba0706040448i6e166031od1212192a549c4a9@mail.gmail.com>
	 <alpine.LFD.0.98.0706040755560.23741@woody.linux-foundation.org>
	 <5971b1ba0706040838nc9ea7c7h54a57d4235d53bcf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Bryan Childs" <godeater@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 00:30:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvL3u-0002xF-Ba
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 00:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255AbXFDW36 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 18:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbXFDW35
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 18:29:57 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:55509 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbXFDW35 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 18:29:57 -0400
Received: by wx-out-0506.google.com with SMTP id t15so1321464wxc
        for <git@vger.kernel.org>; Mon, 04 Jun 2007 15:29:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ElHOHRbOQvj147nydVXDJ93uAWeZ4+aHNzonVbPIhiC6pCveJGpgW1ysHTGXZ76Fl1YpLywN1K/4pBmGHvH59igjjuL04Mwcz1JGl4Kl21Yi3q+sWzzf57FFubkNYW5Vf6FSiX2/EYfv3SX9yh/b4ON+nb6cblIKvEAEAwSD1Nw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EOha+K7GmKLvrxSNUcRvQLHTjOiPJC2jTdfuvelRxAM2KtqF1OPT+rW7+uowhV1wQo/hhRye2HkZCDG6sE2e5JevKZ1S9ojVw1aS4blPYCTKtAP5suwpi40HwCP+M3IJwBBLK8QKpGMesNvzKnBzylfbV0TgZQjTbnuXIMfULyE=
Received: by 10.90.78.9 with SMTP id a9mr4349489agb.1180996196483;
        Mon, 04 Jun 2007 15:29:56 -0700 (PDT)
Received: by 10.90.35.4 with HTTP; Mon, 4 Jun 2007 15:29:56 -0700 (PDT)
In-Reply-To: <5971b1ba0706040838nc9ea7c7h54a57d4235d53bcf@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49136>

On 6/5/07, Bryan Childs <godeater@gmail.com> wrote:
> Oh lord no - I never meant to imply that we'd be checking those
> binaries in, I just meant to hi-light that we need a central
> repository to build those binaries from - otherwise we'd end up with a

If your infrastructure to build the binaries is automated, you can
easily script the build for new incoming commits. The output of
git-describe is really useful for this if you are going to name your
builds `git describe`-<arch>.tar.gz.

OTOH, commit is different from push (vs SVN where both are one op),
and that means that when using git you can present a large change as a
better-explained patch-series. That's actually a good practice for new
development, and it might not make sense to have literally
one-build-per-commit.

Maybe I'd enable auto-builds for maintenance/bugfixes branches, and on
other (experimental/devel) branches only auto-build commits selected
explicitly (tagged?).

cheers,


martin
