From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Veillette?= 
	<jean_francois_veillette@yahoo.ca>
Subject: Re: gitk's copy pasteboard doesn't persist after it quits
Date: Thu, 22 Nov 2007 16:29:06 -0500
Message-ID: <2F4229F3-C4BE-4BC2-8F2D-90519D25944C@yahoo.ca>
References: <DFBFC631-01BF-4D2D-BCF3-3FC376479CB2@steelskies.com> <20071122210105.GY14735@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan del Strother <maillist@steelskies.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Nov 22 22:29:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvJc3-0001Av-OO
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 22:29:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408AbXKVV3N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Nov 2007 16:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752413AbXKVV3N
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 16:29:13 -0500
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:23056 "HELO
	smtp101.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752367AbXKVV3M convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 16:29:12 -0500
Received: (qmail 63066 invoked from network); 22 Nov 2007 21:29:08 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.ca;
  h=Received:X-YMail-OSG:In-Reply-To:References:Mime-Version:Content-Type:Message-Id:Cc:Content-Transfer-Encoding:From:Subject:Date:To:X-Mailer;
  b=SC84oB14+iz6yLuwviZuGXJXdXUeD1G3Kolj+dmAkHDdNPAFTl98WHnhxdCUQQCsNbOhhGWPJYxGy1+X/eUMP0/io8jP3+qE+VzmoLx8TkT6is15IXN2HIm1rheKOVPGN/+VJs0oAGhdcxgJv02xcit3O16DDv1mnRAdFxR+DqI=  ;
Received: from unknown (HELO ?192.168.3.32?) (jean_francois_veillette@207.96.147.134 with plain)
  by smtp101.mail.mud.yahoo.com with SMTP; 22 Nov 2007 21:29:08 -0000
X-YMail-OSG: VQ7agJwVM1nKY.5OwCmPHCVsKmCAVb5Hps2gF2F8k_QC7vKNeLDmogZA9J6F9VD2UuxN5LHWpA--
In-Reply-To: <20071122210105.GY14735@spearce.org>
X-Mailer: Apple Mail (2.752.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65849>


Le 07-11-22 =E0 16:01, Shawn O. Pearce a =E9crit :

> Jonathan del Strother <maillist@steelskies.com> wrote:
>> On OS X, if I load gitk, copy a sha1, then quit, the sha1 isn't put
>> into the system-wide pasteboard.  It's definitely copied - I can =20
>> paste
>> it back into the sha1 field - but it seems to be some sort of local
>> pasteboard that's specific to gitk

I don't know the specific of Tcl/Tk on OSX, but for Cocoa apps you =20
can choose how you want it pasteboard to  behave.  Imagine you copy a =20
1 gig video object, should you have another copy of it in the 'shared =20
space' ? no, that's why you can decide that you make it available on =20
demand only (if someone ask to paste it the system will ask your app =20
for the full content).  But if you (as an application) have put =20
something in the pasteboard 'on-demand-only', then when you quit, you =20
should store the real value in there, nut just a pointer to the =20
values.  I'm guessing the TclTk implementation doen't answer that =20
kind of notification from the system and quit without filling the =20
real pasteboard content.

- jfv
