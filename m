From: linux@horizon.com
Subject: Re: [PATCH] git-blame: Make the output human readable
Date: 8 Mar 2006 13:04:22 -0500
Message-ID: <20060308180422.27978.qmail@science.horizon.com>
References: <20060308173249.1faed1d7.vsu@altlinux.ru>
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Mar 08 19:05:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FH31U-0000Qa-Un
	for gcvg-git@gmane.org; Wed, 08 Mar 2006 19:04:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWCHSEa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Mar 2006 13:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWCHSEa
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Mar 2006 13:04:30 -0500
Received: from science.horizon.com ([192.35.100.1]:40525 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932067AbWCHSE3
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Mar 2006 13:04:29 -0500
Received: (qmail 27979 invoked by uid 1000); 8 Mar 2006 13:04:22 -0500
To: linux@horizon.com, vsu@altlinux.ru
In-Reply-To: <20060308173249.1faed1d7.vsu@altlinux.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17378>

> And this won't work, unless you also add that wcwidth() implementation
> to git.

That was the general idea.  It is freely usable.

> The problem is that the wchar_t encoding is not specified anywhere -
> glibc uses Unicode for it, but other systems can use whatever they want
> (even locale-dependent).

Why is that a problem?  None of the code mentioned even uses wchar_t.
The code I wrote converts from UTF-8 to straight Unicode, and that's
what Markus Kuhn's wcwidth() expects as an argument.

At no time do we ask the compiler for its opinion on the subject.
