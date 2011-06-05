From: Paul Ebermann <Paul-Ebermann@gmx.de>
Subject: Re: Command-line interface thoughts
Date: Sun, 05 Jun 2011 23:34:46 +0200
Message-ID: <4DEBF676.5020608@gmx.de>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com> <BANLkTinTWG7YXGKZzmH0rqtt+Ob7X+2yMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: mike@nahas.com, Michael Nahas <mike.nahas@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 23:35:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTKyh-0007GV-O1
	for gcvg-git-2@lo.gmane.org; Sun, 05 Jun 2011 23:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756217Ab1FEVfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jun 2011 17:35:17 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:51017 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756129Ab1FEVfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2011 17:35:16 -0400
Received: (qmail invoked by alias); 05 Jun 2011 21:35:14 -0000
Received: from p5B3FB360.dip.t-dialin.net (EHLO [192.168.1.51]) [91.63.179.96]
  by mail.gmx.net (mp046) with SMTP; 05 Jun 2011 23:35:14 +0200
X-Authenticated: #2289940
X-Provags-ID: V01U2FsdGVkX182cUEYGbU2beg86+GhNyhvKrBRaGFsY1THO1sScV
	dv5ZBNUuT+k7x+
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110424 Thunderbird/3.1.10
In-Reply-To: <BANLkTinTWG7YXGKZzmH0rqtt+Ob7X+2yMQ@mail.gmail.com>
X-Enigmail-Version: 1.1.2
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175085>

Michael Nahas skribis:

> "commit"
>    HEAD = new(HEAD + (NEXT-HEAD))
>    NEXT = HEAD
> "commit --amend"
>    HEAD = new(HEAD^ + (NEXT-HEAD^))
>    NEXT = HEAD

A better notation for creating a new commit would be something that
takes both the contents and the parents as arguments.

"commit:"
  HEAD = new(NEXT, HEAD)
  NEXT = HEAD
"commit --amend"
  HEAD = new(NEXT, all-parents-of(HEAD))
  NEXT = HEAD

> "stash save"
>    STASH = new(new(HEAD+(NEXT-HEAD))+WTREE-NEXT)
>    NEXT = HEAD
>    WTREE = HEAD
>    push(STASH)

"stash save"
  STASH = new(WTREE, HEAD, new(NEXT, HEAD))
  NEXT = HEAD
  WTREE = HEAD
  push(STASH)

And similar.


Paul
