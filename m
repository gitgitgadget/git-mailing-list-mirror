From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Are binary xdeltas only used if you use git-gc?
Date: Fri, 31 Oct 2008 13:42:05 +0100
Message-ID: <vpqy705rl5u.fsf@bauges.imag.fr>
References: <f1d2d9ca0810310243r669840bbj2c5ee7183e0caaed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Thanassis Tsiodras" <ttsiodras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 13:46:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvtO7-0003gn-Ls
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 13:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbYJaMoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 08:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbYJaMoe
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 08:44:34 -0400
Received: from imag.imag.fr ([129.88.30.1]:53445 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846AbYJaMoe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 08:44:34 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m9VCg73S012158
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 31 Oct 2008 13:42:07 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KvtKI-0007Q1-1A; Fri, 31 Oct 2008 13:42:06 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KvtKH-0002rq-VE; Fri, 31 Oct 2008 13:42:05 +0100
In-Reply-To: <f1d2d9ca0810310243r669840bbj2c5ee7183e0caaed@mail.gmail.com> (Thanassis Tsiodras's message of "Fri\, 31 Oct 2008 11\:43\:43 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 31 Oct 2008 13:42:07 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99585>

"Thanassis Tsiodras" <ttsiodras@gmail.com> writes:

> If that is the case, I will create an alias to always git-gc after commits...

If you have a decent version of git, it already does "git gc --auto"
regularly. With --auto, git gc will do nothing if you don't have too
many unpacked objects, and will try to do the right thing otherwise
(incremental packs, see man git gc). The idea is that "git gc" is a
costly operation, and git prefers to waste a bit of disk space to make
most "commit" really fast, and to take time to optimize the repository
only when it grew too much.

If you're worried about repository size and you have a permanently
running machine, a good idea is to run git gc in a cron job, so that
you work fast in daytime, and your computer optimizes hard at night
time ;-) (I have gic gc + git fsck in a cron job, so I'll also know if
a repository gets corrupted).

-- 
Matthieu
