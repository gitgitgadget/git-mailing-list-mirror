From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH 3/3] git-gui: new config to control staging of untracked files
Date: Mon, 17 Oct 2011 23:51:09 +0100
Message-ID: <87r52bgrky.fsf@fox.patthoyts.tk>
References: <0f862de296a94b06495e4418bc731b5d201d5767.1318620267.git.bert.wesarg@googlemail.com>
	<03727ea04f20c953e7de3f84ab1724a8360ca2c4.1318620267.git.bert.wesarg@googlemail.com>
	<20111017183430.GA2540@sandbox-rc>
	<CAKPyHN3pKUSLTs8_5QMo5i+=3w7KXAHJjDOfQ1XYG92ZbQ1SeA@mail.gmail.com>
	<20111017192706.GB3168@sandbox-rc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Oct 18 00:51:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFw1g-0007UH-Gs
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 00:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756129Ab1JQWvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 18:51:14 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:12599 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756099Ab1JQWvN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Oct 2011 18:51:13 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.4])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111017225110.RYK13501.mtaout01-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Mon, 17 Oct 2011 23:51:10 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1RFw1W-0000Fx-Pd; Mon, 17 Oct 2011 23:51:10 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 08A2A201AC; Mon, 17 Oct 2011 23:51:09 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <20111017192706.GB3168@sandbox-rc> (Heiko Voigt's message of
	"Mon, 17 Oct 2011 21:27:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=O9HYxzjLEG8A:10 a=OtpQyoxz0-8A:10 a=kj9zAlcOel0A:10 a=Y7828TS4AAAA:8 a=Rf460ibiAAAA:8 a=E6a1MfeHReUmRMKJy-sA:9 a=TRMQW9OnHJyVXuxz1agA:7 a=CjuIK1q_8ugA:10 a=IUdvcfx5MVUA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183839>

Heiko Voigt <hvoigt@hvoigt.net> writes:

>Hi,
>
>On Mon, Oct 17, 2011 at 08:47:50PM +0200, Bert Wesarg wrote:
>> On Mon, Oct 17, 2011 at 20:34, Heiko Voigt <hvoigt@hvoigt.net> wrote:
>> > Here I am wondering whether we have a similar mechanism in git gui like
>> > in core git that makes yes,true,1 equivalents (and similar with other
>> > values) ?
>> 
>> But it is not only yes,true,1 or no,false,0 its a tristate with the
>> third state 'ask'. For booleans, there is such functionality in git
>> gui. See is_config_true and is_config_false. Reusing these for this
>> tristate wouldn't work. The current check here is indeed very strict
>> and should be loosen by at least ignoring the case, surrounding
>> spaces, and allow also true/false. But also note, that this variable
>> can be set via the Options menu, so you can't mistype it.
>
>Well if using git config you can ;-). I just wanted to ask whether we
>may already have machinery which supports such tristate.
>If we do not I think the current "strict" configuration is fine. In most
>cases the user will use the gui itself to configure such behavior so
>thats no big deal.
>If someone needs that it can be added later on.
>
>Thanks, Heiko
>

This set of 3 patches looks fine. I was a bit dubious of the new
phrasing for the ask condition but it is growing on me. I wonder it it
might be worth including the number of untracked files to be staged too
eg: "Stage 15 untracked files?"

   set reply [ask_popup [mc "Stage %d untracked files?" \
                             [llength $untracked_paths]]]

Loosening the check we can do using
  switch -glob -- [get_config gui.stageuntracked] {
    [Nn]* { set reply 0}
    [Yy]* { set reply 1}
    default { ... }
  }

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
