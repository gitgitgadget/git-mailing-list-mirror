From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 18:14:46 +0200
Message-ID: <vpq7iyw2sg9.fsf@ecrins.imag.fr>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com>
	<45357CC3.4040507@utoronto.ca>
	<Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>
	<4536EC93.9050305@utoronto.ca>
	<845b6e870610190002u420118b8ud634bb9594572c48@mail.gmail.com>
	<46d6db660610190149x32442596we4112cdd044185a@mail.gmail.com>
	<45373E27.3050209@op5.se> <vpqwt6wsmb5.fsf@ecrins.imag.fr>
	<72877ab10610190757u3d2b4df0o204c6ffd73af69b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian MICHON <christian.michon@gmail.com>, Andreas Ericsson <ae@op5.se>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Thu Oct 19 18:16:05 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaaYt-0004Xx-30
	for gcvbg-bazaar-ng@m.gmane.org; Thu, 19 Oct 2006 18:16:03 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GaaYs-0001GH-6s; Thu, 19 Oct 2006 17:16:02 +0100
Received: from imag.imag.fr ([129.88.30.1])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <Matthieu.Moy@imag.fr>) id 1GaaYS-0001AG-RJ
	for bazaar-ng@lists.canonical.com; Thu, 19 Oct 2006 17:15:38 +0100
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.6/8.13.6) with ESMTP id k9JGEkQV006911
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 19 Oct 2006 18:14:47 +0200 (CEST)
Received: from ecrins.imag.fr ([129.88.43.124])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50) id 1GaaXe-0001WD-SM; Thu, 19 Oct 2006 18:14:46 +0200
Received: from moy by ecrins.imag.fr with local (Exim 4.50)
	id 1GaaXe-0001yj-P5; Thu, 19 Oct 2006 18:14:46 +0200
To: "Tim Webster" <tdwebste@gmail.com>
In-Reply-To: <72877ab10610190757u3d2b4df0o204c6ffd73af69b4@mail.gmail.com>
	(Tim Webster's message of "Thu\, 19 Oct 2006 22\:57\:24 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6
	(imag.imag.fr [129.88.30.1]);
	Thu, 19 Oct 2006 18:14:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29367>

"Tim Webster" <tdwebste@gmail.com> writes:

> First I want to say every SCM I know of sucks when it comes to tracking
> configurations, simply because they don't record or restore file metadata,
> like perms, ownership, and acl.

That's not a simple matter.

Tracking ownership hardly makes sense as soon as you have two
developers on the same project. What does it mean to checkout a file
belonging to user foo and group bar on a system not having such user
and group?

Just restoring the complete user/group/other rwx permission is already
a mess. In my experience (GNU Arch did this):

1) It sucks ;-). Me working with umask 022 so that my collegues can
   "cp -r" from me, working on a project with people having umask 077,
   I got some files not readable, some yes, well, a mess. *I* have set
   my umask, and *I* want my tools to obey.

2) It's a security hole. If you work with people having umask=002 (not
   indecent if your default group contains just you), you end-up with
   world-writable files in your ${HOME}.

That said, it can be interesting to have it, but disabled by default.

The 'x' bit, OTOH, is definitely useful.
