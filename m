From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v6 4/4] config: add '--show-origin' option to print the
 origin of a config value
Date: Thu, 3 Mar 2016 19:36:31 +0100
Message-ID: <56D8842F.50602@kdbg.org>
References: <1455873362-66998-1-git-send-email-larsxschneider@gmail.com>
 <1455873362-66998-5-git-send-email-larsxschneider@gmail.com>
 <56D723F0.7020106@kdbg.org> <07435444-0C35-4615-A403-9E124AFC9427@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes.Schindelin@gmx.de, Duy Nguyen <pclouds@gmail.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 19:36:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abY75-0006Wq-Li
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 19:36:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754373AbcCCSgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 13:36:35 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:16990 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753213AbcCCSge (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 13:36:34 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3qGLWN390Fz5tlX;
	Thu,  3 Mar 2016 19:36:32 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 9D1AB5221;
	Thu,  3 Mar 2016 19:36:31 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <07435444-0C35-4615-A403-9E124AFC9427@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288203>

Am 03.03.2016 um 08:38 schrieb Lars Schneider:
> (1) If I have a Git core branch with a some changes that builds and
> tests clean on Linux and OSX. How do I apply all the necessary Git for
> Windows specific changes to this branch?

How do you do it when you make a patch on Linux and want to test it on 
OSX, or the other way around? It's the same with Windows, I would guess.

*I* would export the Linux directory for Windows using Samba and then 
fetch and push from the Windows side. I would *not* develop on Windows 
in the exported Samba directory directly. If Samba is too hairy, 
exchange git bundles on a USB stick.

> (2) During my testing with Windows I noticed that the git config
> paths look funny by adding ("\\" and "/"). I mentioned the problem in
> the Gitfor Windows forum:
> https://groups.google.com/forum/#!topic/git-for-windows/zTv60HhfnYk
> Duy suggested a solution in that thread. Is this the default way
> todeal with the paths? Would the list accept this solution?

IMHO, the solution is misguided. Either --show-origin is plumbing, then 
we need the quoting. Or it is porcelain, then the quoting can be removed 
(and it is not necessary to "prettify" the file names on Windows). I 
tend to categorize --show-origin as procelain.

> (3) The tests on Windows seemed very slow to me. Are there tricks to
> speed them up? Did you try a RAM disk? If yes, how do you do it?

Run on SSD (and be prepared to swap it out for a new one within a year 
or two) ;-)

Really, there doesn't seem to be much you can do. Run the tests 
--with-dashes to save a shell wrapper around git.exe.

Unfortunately, Windows does not have RAM disks built in. I would 
appreciate any hints in this direction as well.

-- Hannes
