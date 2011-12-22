From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: Warning from AV software about kill.exe
Date: Thu, 22 Dec 2011 18:19:29 +0000
Message-ID: <878vm4lb9q.fsf@fox.patthoyts.tk>
References: <4EF2E08C.3050502@icefield.yk.ca>
	<87mxalkn9q.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Blake <erik@icefield.yk.ca>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Dec 22 21:01:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rdops-0003Lf-CD
	for gcvg-git-2@lo.gmane.org; Thu, 22 Dec 2011 21:01:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755765Ab1LVUBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Dec 2011 15:01:48 -0500
Received: from queueout02-winn.ispmail.ntl.com ([81.103.221.56]:38576 "EHLO
	queueout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755680Ab1LVUBr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Dec 2011 15:01:47 -0500
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.2])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111222181930.SGUR19823.mtaout03-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Thu, 22 Dec 2011 18:19:30 +0000
Received: from [94.171.229.22] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1RdnEo-0008LV-OW; Thu, 22 Dec 2011 18:19:30 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 1922A2015A; Thu, 22 Dec 2011 18:19:30 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <87mxalkn9q.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
	"Thu, 22 Dec 2011 09:45:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=O9HYxzjLEG8A:10 a=uTYu3cP4YFoA:10 a=kj9zAlcOel0A:10 a=Rf460ibiAAAA:8 a=lbFHttIAw5w7gDJkSV0A:9 a=CjuIK1q_8ugA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187614>

Thomas Rast <trast@student.ethz.ch> writes:

>Erik Blake <erik@icefield.yk.ca> writes:
>
>> I'm running git under Win7 64. As I selected "Repository|Visualize all
>> branch history" in the git gui, my AV software (Trustport) trapped the
>> bin\kill.exe program for "trying to modify system global settings
>> (time, timezone, registry quota, etc.)"
>>
>> Does anyone know the details of this process and what it's function
>> is? First time I've seen it, though I'm a relatively new user.
>
>'kill' is a standard unix utility that sends signals to processes, in
>particular signals that cause the processes to exit or be killed
>forcibly by the kernel, hence the name.  (I don't know how the windows
>equivalent works under the hood, but presumably it's something similar.)
>
>git-gui and gitk use kill to terminate background worker processes that
>are no longer needed because you closed the window their output would
>have been displayed in, etc.

You might try replacing the command in the tcl scripts with 'exec
taskkill /f /pid $pid' and see if that avoids the error. taskkill is
present on XP and above as part of the OS distribution so shouldn't
suffer any AV complaints.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
