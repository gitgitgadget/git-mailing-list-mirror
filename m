From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Why does adding an existing repo as a submodule modify .git/config?
Date: Mon, 23 May 2011 20:43:30 +0200
Message-ID: <4DDAAAD2.1010708@web.de>
References: <irbq5a$h38$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: Christopher Wilson <cwilson@cdwilson.us>
X-From: git-owner@vger.kernel.org Mon May 23 20:43:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOa6S-0007Ss-2s
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 20:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756958Ab1EWSni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 14:43:38 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:40563 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756883Ab1EWSnh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 14:43:37 -0400
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate01.web.de (Postfix) with ESMTP id 48E0918F7520C;
	Mon, 23 May 2011 20:43:34 +0200 (CEST)
Received: from [93.246.58.98] (helo=[192.168.178.43])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QOa6I-0004lR-00; Mon, 23 May 2011 20:43:34 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <irbq5a$h38$1@dough.gmane.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX186FFUlMLvrp/1yJB+WRj+uaKyQAqTqKpGOLERp
	67IRYBmtnRtn+9hUSdlq2NY1nxObeVduJkhq7e4SnJxWjwS4UP
	uWHl3QL9HzDy1p1kI2kA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174260>

Am 22.05.2011 22:02, schrieb Christopher Wilson:
> (I posted this question below on
> http://stackoverflow.com/questions/6083357/why-does-adding-an-existing-repo-as-a-submodule-modify-git-config
> and was recommended to ask the mailing list)
> 
> If I add a submodule that does not currently exist, no submodule
> information is added to .git/config.
> 
> $ mkdir testing
> $ cd testing
> $ git init
> $ git submodule add git@git.server:submodule.git
> $ cat .git/config
> [core]
>     repositoryformatversion = 0
>     filemode = true
>     bare = false
>     logallrefupdates = true
>     ignorecase = true
> 
> However, if I add a repo that currently exists as a submodule, the url
> is added to .git/config:
> 
> $ mkdir testing
> $ cd testing
> $ git init
> $ git clone git@git.server:submodule.git
> $ git submodule add git@git.server:submodule.git
> $ cat .git/config
> [core]
>     repositoryformatversion = 0
>     filemode = true
>     bare = false
>     logallrefupdates = true
>     ignorecase = true
> [submodule "submodule"]
>     url = git@git.server:submodule.git
> 
> I would have assumed that in both cases, git submodule add would have
> only modified .gitmodules, and that git submodule init would have
> updated the project's .git/config.
> 
> I'm aware this is intentional behavior
> (https://github.com/git/git/commit/c2f939170c65173076bbd752bb3c764536b3b09b),
> but I don't understand why.
> 
> Why is .git/config modified in the second case but not the first? Can
> somebody explain the rational for this behavior?

Hmm, this looks like an inconsistency to me too. It would be great
to hear about the background, so I added Mark to the CC, maybe he
can shed some light.
