From: alex@bellandwhistle.net
Subject: Re: gitignore vs. exclude vs =?UTF-8?Q?assume-unchanged=3F?=
Date: Fri, 25 Apr 2014 16:09:47 -0700
Message-ID: <35592507346991e5c286144fcbd04097@bellandwhistle.net>
References: <b3f480af1c362c615ad9ce85296e2be2@bellandwhistle.net>
 <xmqqy4z5go1y.fsf@gitster.dls.corp.google.com>
 <dee7ee673c8c4d81fb5aaecea25e9709@bellandwhistle.net>
 <20140416234555.GA4309@google.com>
 <4dd8389939fbf3dc77b58adcca7b17c1@bellandwhistle.net>
 <CAH5451k+GGGdHXkwne2O-h2m2AyWg7K+5reNRG64+eF891pVUA@mail.gmail.com>
 <xmqqtx9l5jxn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 01:10:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdpG3-0005yp-W3
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 01:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753090AbaDYXKC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 19:10:02 -0400
Received: from selene.fortifiedserver.net ([98.158.151.224]:51301 "EHLO
	selene.fortifiedserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752486AbaDYXJ4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Apr 2014 19:09:56 -0400
Received: from localhost.uu.net ([127.0.0.1]:40714 helo=selene.fortifiedserver.net)
	by selene.fortifiedserver.net with esmtpa (Exim 4.82)
	(envelope-from <alex@bellandwhistle.net>)
	id 1WdpFc-0000vv-AZ; Fri, 25 Apr 2014 16:09:48 -0700
In-Reply-To: <xmqqtx9l5jxn.fsf@gitster.dls.corp.google.com>
X-Sender: alex@bellandwhistle.net
User-Agent: Roundcube Webmail/0.9.5
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - selene.fortifiedserver.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - bellandwhistle.net
X-Get-Message-Sender-Via: selene.fortifiedserver.net: authenticated_id: alex@bellandwhistle.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247129>

> Andrew Ardill <andrew.ardill@gmail.com> writes:
> 
> As a data point, I have seen people add ".gitignore" to their
> .gitignore file, as they don't want to share the file.

Right, I've seen that too. It confused the heck out of me. It only lends 
credence to my point about the docs. Those users want the functionality 
of a pattern in '$GIT_DIR/info/exclude', but haven't been able to figure 
it out easily enough. They've just heard about .gitignore, so they're 
using that. Yes, it's all there in the docs if you read it several 
times, and you already know what you're looking at, but not in a 
terribly accessible, best practices, "advice from a smart friend who's 
been through it all already" kind of way.

> ... The introduction does specifically mention 'gitignore'
> files, but that seems to be due to all the ignore files
> ($HOME/.config/git/ignore, $GIT_DIR/info/exclude, .gitignore) being
> classified as 'gitignore' files.

Yes, the 'gitignore' versus '.gitignore' distinction is hopelessly 
subtle. It is very easy for a newcomer to think these are exactly the 
same thing. I certainly did.

> Finally, it's a little confusing that one of the files is called 
> 'exclude'.
> 
> It would be great to rename it to 'ignore'; $GIT_DIR/info/exclude ->
> $GIT_DIR/info/ignore. Is there any reason this shouldn't be done?

Well, yes: semantics. Since they do slightly different things, they 
should have different names. It makes reference and teaching much 
easier. In fact, if a renaming were to occur, I would actually prefer 
even better semantics:

     .gitignore -> .shared-ignore

     $GIT_DIR/info/exclude -> $GIT_DIR/info/local-ignore

These suggested names could perhaps be improved on. But if anything, the 
names need to be more different, not less. Users should be able to 
instantly know what a speaker is talking about without having to 
doublecheck and ask if by "git-ignore", the speaker really meant "git 
ignore" or "dot-gitignore".

Thanks,
Alex
