From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: change the termination checks to avoid potential hang.
Date: Wed, 18 Aug 2010 23:48:17 +0100
Message-ID: <878w431qry.fsf@fox.patthoyts.tk>
References: <20100704203342.6064.32250.reportbug@balanced-tree>
	<20100704212125.GA1613@burratino> <20100704212439.GA1765@burratino>
	<87iq3bh1op.fsf_-_@fox.patthoyts.tk>
	<20100818042107.GC21185@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Anders Kaseorg <andersk@MIT.EDU>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 01:00:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlrcB-0007d6-VR
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 01:00:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236Ab0HRXAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 19:00:06 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:60515 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751006Ab0HRXAF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Aug 2010 19:00:05 -0400
Received: from [172.23.170.141] (helo=anti-virus02-08)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Olrc0-0002y5-Rw; Thu, 19 Aug 2010 00:00:00 +0100
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out4.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1OlrQg-000718-A4; Wed, 18 Aug 2010 23:48:18 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 9A35E208DA; Wed, 18 Aug 2010 23:48:17 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <20100818042107.GC21185@burratino> (Jonathan Nieder's message of
	"Tue, 17 Aug 2010 23:21:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153891>

Jonathan Nieder <jrnieder@gmail.com> writes:
>
>And consistently.
>
> $ wish
> % puts $tcl_version
> 8.5
> % puts $tk_version
> 8.5
> $ dpkg -l tcl8.5 tk8.5 | tail -2
> ii  tcl8.5         8.5.8-2       Tcl (the Tool Command Language) v8.5 - ru
> ii  tk8.5          8.5.8-1       Tk toolkit for Tcl and X11, v8.5 - run-ti
> $ ./git-gui--askpass
> <types passphrase>
>
>The window would stay open and hang.

OK I managed to confirm that using Tk 8.5. It seems 8.4 and 8.6 get away
with it. I've pushed the fix to git-gui master now. Thanks for testing.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
