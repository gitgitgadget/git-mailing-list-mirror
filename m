From: Christopher Faylor <me@cgf.cx>
Subject: Re: [PATCH] Fixed Cygwin CR-munging problem in mailsplit
Date: Sun, 28 May 2006 12:39:49 -0400
Message-ID: <20060528163949.GB400@trixie.casa.cgf.cx>
References: <E124AAE027DA384D8B919F93E4D8C70801EFFB52@mssmsx402nb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 28 18:39:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkOIy-0008JH-Ua
	for gcvg-git@gmane.org; Sun, 28 May 2006 18:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWE1Qju (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 12:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWE1Qju
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 12:39:50 -0400
Received: from pool-71-248-179-19.bstnma.fios.verizon.net ([71.248.179.19]:49565
	"EHLO cgf.cx") by vger.kernel.org with ESMTP id S1750795AbWE1Qju
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 May 2006 12:39:50 -0400
Received: by cgf.cx (Postfix, from userid 201)
	id 8964113C020; Sun, 28 May 2006 12:39:49 -0400 (EDT)
To: "Zakirov, Salikh" <salikh.zakirov@intel.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <E124AAE027DA384D8B919F93E4D8C70801EFFB52@mssmsx402nb>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20881>

On Sun, May 28, 2006 at 12:57:35AM +0400, Zakirov, Salikh wrote:
>Junio C Hamano <junkio@cox.net> writes:
>> So even in this modern day, preserving CRLF is not
>> something that happens by default -- you would need to make sure
>> that everybody on your mailpath to the recipient is set up the
>> right way.
>
>> So now I am less in favor of the change than when I wrote that
>> response.
>
>I understand this reasoning, and I am not sure if the fix is correct
>from the "GIT world" point of view.
>
>However, I believe that the command sequence git-format-patch, git-am
>without any e-mail transfer in between and in the same repository
>should work perfectly regardless of the contents of the files, 
>no matter if they are binary, text, or "CRLF text" or even 
>"broken LF and CRLF text". This is a requirement from a nasty "real
>world".
>
>Junio, could you point at a right place to fix to get git-format-patch, 
>git-am sequence work flawlessly on Cygwin?
>
>By the way, the change affects only non-Unix users, as fopen(..., "rt")
>is equivalent to fopen(..., "rb") on all Unixes anyway.

But fopen(..., "r") is not equivalent to fopen(..., "rb") on Cygwin.

Wouldn't you want to add the "b" there to be assured of a binary open?

cgf
