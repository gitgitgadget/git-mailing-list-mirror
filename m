From: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: Barebone Porcelain.  Where to stop?
Date: Mon, 18 Jul 2005 14:57:41 -0600
Message-ID: <42DC17C5.80000@tuxrocks.com>
References: <7vek9yirdi.fsf@assigned-by-dhcp.cox.net>	<42DB32F1.5020900@gmail.com> <tnx3bqcxvkm.fsf@arm.com> <7v8y04q6sj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 22:59:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ducgq-0006mO-J3
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 22:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbVGRU6J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jul 2005 16:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVGRU6J
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jul 2005 16:58:09 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:37389 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S261893AbVGRU6I (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jul 2005 16:58:08 -0400
Received: from [128.187.171.102] (obelix.cs.byu.edu [128.187.171.102])
	(authenticated bits=0)
	by tuxrocks.com (8.13.1/8.13.1) with ESMTP id j6IKvfR7024296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 18 Jul 2005 14:57:44 -0600
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8y04q6sj.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Junio C Hamano wrote:
> Catalin Marinas <catalin.marinas@gmail.com> writes:
> 
>>I don't see git going towards stgit at all. Indeed, it gets closer to
>>cogito but I still like cogito over plain git since it's easier to use
>>(my goal, though, is to add pull/clone commands to stgit so that one
>>doesn't need to rely on directly using other tools).
> 
> All good to hear.  I do not speak for Linus, but I think core
> should not be competing with Porcelain.  To me, there are four
> purposes for the barebone Porcelain layer:
> 
>  (1) provide the end user a minimum UI to do essential things.
> 
>  (2) codify the BCP/convention to use the core by higher level
>      SCMs to help them stay compatible with each other where
>      possible (e.g. "what .git/HEAD means, when it gets updated,
>      and to what" was discussed recently).
> 
>  (3) serve as an example for people interested in learning the
>      core GIT (i.e. they may be starting their own Porcelain).
> 
>  (4) implement operations that are heavy on logic/convention but
>      does not have much UI need so that higher level SCMs can
>      implement their own UI by just being a thin wrapper around
>      them (e.g. clone/fetch and push).

These all sound good.  Along the lines of #4, one potential purpose I've
been curious about is the possibility of pulling these core operations
out into a library that Porcelain could use directly.  This way,
Porcelain, including the minimum git UI (your #1), could directly link
in and call the needed functions, and rather than stringing sequences of
git-whatever commands together in a shell script.

This would allow Porcelain to take advantage of the core git more
directly, and would improve the speed of Porcelain.  The minimum UI (#1)
would be a much simpler example (#3), since it would only be the
front-end, rather than the front-end/back-end combination it is now.

Is this something we want to consider, or am I out in left field? :)

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC3BfFaI0dwg4A47wRApyQAKD3yXqYfcm7TgJ5GnIZsw5ZcB+P/wCgpM75
cjPHXi8jd0VthQjKNFITFxU=
=Jxx/
-----END PGP SIGNATURE-----
