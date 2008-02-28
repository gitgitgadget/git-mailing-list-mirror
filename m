From: "Sebastian Schuberth" <sschuberth@gmail.com>
Subject: Re: git diff --name-status does not always list changed files
Date: Thu, 28 Feb 2008 23:19:35 +0100
Message-ID: <bdca99240802281419o3fcea2e8u277d8e5e48131b6d@mail.gmail.com>
References: <fq6hhi$cub$1@ger.gmane.org>
	 <7vablkkhac.fsf@gitster.siamese.dyndns.org>
	 <bdca99240802281323x1ec904ddq914ac2c484e7c468@mail.gmail.com>
	 <7vejawhi6a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 23:20:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUr6t-0004ri-Ff
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 23:20:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760539AbYB1WTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 17:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760000AbYB1WTi
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 17:19:38 -0500
Received: from wr-out-0506.google.com ([64.233.184.225]:5998 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759534AbYB1WTi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 17:19:38 -0500
Received: by wr-out-0506.google.com with SMTP id c48so5454237wra.23
        for <git@vger.kernel.org>; Thu, 28 Feb 2008 14:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ApFq53uGO7mGNRlVkB2EGWxrGwT1cC1iHJrmLlrl50w=;
        b=YRyOwik0qcDMVNTESGqt6H1PeAQMfDOVcMIBsF+RJviKK2U+pwCiJZ07DpBaRkZ6f27uyOeisuDeXisAN4p6jKrjTHtsNi8tuSxzRgbqbK8If91/Lqm7HFvnhjk+3UTEAILMthIhvV6u6yzfQppp1yDOfXDqCr+SGrnqi8fP23A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qx2+G6bg4UJ23i9yK0TFQ8ayUPgmE2ZlHT4BEUKHYEGnsZiJ7sQl6J4JbXNcRZOj0KSMblmYPsjh+m+y25KR14z+RYB8fFnZAKLmAUlk1cc3/T+tCg6S6fJPGG/UmSEoHdLZ+r3fxKjvwK0PirwJnaWIopxA0BPO4TR8COCigDA=
Received: by 10.140.126.10 with SMTP id y10mr5941350rvc.214.1204237175948;
        Thu, 28 Feb 2008 14:19:35 -0800 (PST)
Received: by 10.140.147.11 with HTTP; Thu, 28 Feb 2008 14:19:35 -0800 (PST)
In-Reply-To: <7vejawhi6a.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75469>

>  > Junio C Hamano wrote:
>  >
>  >> Doesn't reproduce for me.
>  >>
>  >>         $ rm -fr /var/tmp/j && mkdir -p /var/tmp/j && cd /var/tmp/j
>  >>         $ git init
>  >>         Initialized empty Git repository in .git/
>  >
>  > Can you reproduce it if you do
>  >
>  > $ git config core.pager "less -F"
>  >
>  > after "git init"? The "-F" seems to be important, but I'm not sure why
>  > using this switch causes no files to be displayed in this case.
>
>  Then isn't it what you are asking "less" to do?
>
>  Try "less -FX".  FYI, by default, we use "LESS=FRSX" exported
>  unless the user knows better than us and uses something of his
>  own.

Thanks, -FX works, though I do not understand why it did not with just
-F. From what I understood, -F just makes "less" quit immediately
(instead of waiting for the user to press "q") if the lines to display
fit completely on screen. In no case it should display nothing if
there actually is something to display.

-- 
Sebastian Schuberth
