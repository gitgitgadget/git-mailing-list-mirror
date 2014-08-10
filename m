From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: Make git-gui lib dir configurable at runtime
Date: Sun, 10 Aug 2014 13:03:04 +0100
Message-ID: <87tx5k8scn.fsf@red.patthoyts.tk>
References: <1405966809-30882-1-git-send-email-dturner@twitter.com>
	<xmqqbnsiifq6.fsf@gitster.dls.corp.google.com>
	<1405979864.15933.4.camel@leckie>
Reply-To: patthoyts@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 14:03:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGRqI-0002WC-8Q
	for gcvg-git-2@plane.gmane.org; Sun, 10 Aug 2014 14:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbaHJMDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2014 08:03:09 -0400
Received: from know-smtprelay-omc-1.server.virginmedia.net ([80.0.253.65]:44017
	"EHLO know-smtprelay-omc-1.server.virginmedia.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751387AbaHJMDH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2014 08:03:07 -0400
Received: from red.patthoyts.tk ([82.45.42.101])
	by know-smtprelay-1-imp with bizsmtp
	id d0341o01s2AxhvW01034tl; Sun, 10 Aug 2014 13:03:05 +0100
X-Originating-IP: [82.45.42.101]
X-Spam: 0
X-Authority: v=2.1 cv=aLJ+qNNm c=1 sm=1 tr=0 a=FEdcR8KTC/yDun0iFnNZnw==:117
 a=FEdcR8KTC/yDun0iFnNZnw==:17 a=6gpmbu8EOFEA:10 a=aQbZP4Sc8hQA:10
 a=e6D5b-RAr9gA:10 a=CtgcEeagiGAA:10 a=xqWC_Br6kY4A:10 a=FP58Ms26AAAA:8
 a=6NG_XSeZAAAA:8 a=JqEG_dyiAAAA:8 a=Rf460ibiAAAA:8 a=NqB5FpGjT-UnosIcMZ8A:9
 a=U-3sENGST0oA:10 a=vngSGya56okA:10 a=AkUkIWUyXwcA:10 a=NWVoK91CQyQA:10
Received: from red.patthoyts.tk (red.patthoyts.tk [IPv6:2a01:348:2be::2])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by red.patthoyts.tk (Postfix) with ESMTPS id 5A0691960D2D;
	Sun, 10 Aug 2014 13:03:04 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
In-Reply-To: <1405979864.15933.4.camel@leckie> (David Turner's message of
	"Mon, 21 Jul 2014 17:57:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255090>

David Turner <dturner@twopensource.com> writes:

>On Mon, 2014-07-21 at 14:06 -0700, Junio C Hamano wrote:
>> David Turner <dturner@twopensource.com> writes:
>> 
>> > Introduce the GIT_GUI_LIB_DIR environment variable, to tell git-gui
>> > where to look for TCL libs.  This allows a git-gui which has been
>> > built with a prefix of /foo to be run out of directory /bar.  This is
>> > the equivalent of GIT_EXEC_PATH or GITPERLLIB but for git-gui's TCL
>> > libraries.
>> >
>> > Signed-off-by: David Turner <dturner@twitter.com>
>> > ---
>> >  git-gui/Makefile   | 3 ++-
>> >  git-gui/git-gui.sh | 6 +++++-
>> >  2 files changed, 7 insertions(+), 2 deletions(-)
>> 
>> Would a similar change to gitk necessary/beneficial to platforms
>> that would benefit from this change?
>
>Apparently not; it seems to work fine for me from an alternate location.
>Convenient!
>
>> git-gui directory in my tree comes from its upstream repository
>> git://repo.or.cz/git-gui.git/, and it is maintained by Pat Thoyts
>> (Cc'ed).
>
>> Note that these two upstream projects do not have leading
>> directories git-gui and gitk-git themselves (they are merged to my
>> tree while their paths being renamed).  A patch that is appliable to
>> them would touch paths without them (e.g. Makefile and git-gui.sh
>> for an equivalent of the patch I am responding to).
>
>Pat, do you want patches via the git mailing list, personal mail, or
>some other way?  
>

The standard method is both: personal to ensure I see it and mailing list to
allow everyone to comment.

I've applied this patch to git-gui master.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
