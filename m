From: Xavier Maillard <zedek@gnu.org>
Subject: Re: [PATCH 6/7] Small changes
Date: Mon, 5 Mar 2007 08:52:27 +0100
Organization: GNU's Not UNIX!
Message-ID: <200703050752.l257qRog007776@localhost.localdomain>
References: <15313.1172917217@localhost> <7vps7q7z44.fsf@assigned-by-dhcp.cox.net>
Reply-To: Xavier Maillard <zedek@gnu.org>
Cc: git@vger.kernel.org, julliard@winehq.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 05 08:55:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO82y-00050Q-1S
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 08:55:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbXCEHzs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 02:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbXCEHzs
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 02:55:48 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:46133 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932095AbXCEHzr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 02:55:47 -0500
Received: from localhost.localdomain (chn51-3-88-163-173-156.fbx.proxad.net [88.163.173.156])
	by smtp5-g19.free.fr (Postfix) with ESMTP id B37D17CFB;
	Mon,  5 Mar 2007 08:55:46 +0100 (CET)
Received: from localhost.localdomain (IDENT:1001@localhost [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l257qRYb007779;
	Mon, 5 Mar 2007 08:52:27 +0100
Received: (from zedek@localhost)
	by localhost.localdomain (8.13.8/8.13.8/Submit) id l257qRog007776;
	Mon, 5 Mar 2007 08:52:27 +0100
X-Authentication-Warning: localhost.localdomain: zedek set sender to zedek@gnu.org using -f
In-reply-to: <7vps7q7z44.fsf@assigned-by-dhcp.cox.net> (junkio@cox.net)
Jabber-ID: zedek@im.lolica.org
User-Agent: Rmail in GNU Emacs 23.0.51.1 on GNU/Linux
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41408>


   From: Junio C Hamano <junkio@cox.net>

   Xavier Maillard <zedek@gnu.org> writes:

   > * Makefile: add git-blame as a candidate to the
   >   byte-compilation. Change the function to call to byte-compile.

   Could we have a bit more detailed description on the latter
   change?

Sure.

byte-compile-file is an interactive function.
batch--byte-compile is a batch function.

First function would be (better) called when using emacs in its
"interactive" form -ie. M-x byte-compile-file RET.

batch-byte-compile is reserved for batching use (no interaction
with the user).

So in non interactive mode, this is prefered way to do things.

   Explaining why something needed a change is the point of a
   commit log message.  Summarizing what got changed and how is
   good but that is secondary, because anybody can see that you
   changed the handcrafted --eval to -f by running "git show", even
   if you did not have the above proposed log message.

Sorry Iam not "good" at commit log :/ 

   What is left unsaid is _why_ it is better to use single dash
   form of "-batch" and -f form instead of handcrafted --eval, and
   the proposed log message does not clarify the reason.

First reason is given by C-h f batch-byte-compile RET which
gives:

batch-byte-compile is an autoloaded Lisp function in `bytecomp'.
(batch-byte-compile &optional noforce)

Run `byte-compile-file' on the files remaining on the command line.
Use this from the command line, with `-batch';
it won't work in an interactive Emacs.
Each file is processed even if an error occurred previously.
For example, invoke "emacs -batch -f batch-byte-compile $emacs/ ~/*.el".
If noforce is non-nil, don't recompile a file that seems to be

Second reason is "by habit" :)


Hope Ihave been clear. If you want me to submit something again
from these patches, please tell how to do so (and modify what
Ihave changed).

-- 
Xavier
