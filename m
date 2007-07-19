From: Brett Schwarz <brett_schwarz@yahoo.com>
Subject: Re: [PATCH] Internationalization of git-gui
Date: Thu, 19 Jul 2007 10:33:57 -0700 (PDT)
Message-ID: <622391.43998.qm@web38909.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ascii
Cc: Paul Mackerras <paulus@samba.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Christian Stimming <stimming@tuhh.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 19:41:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBZzo-0003cw-3e
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 19:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965119AbXGSRkm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 13:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965213AbXGSRkm
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 13:40:42 -0400
Received: from web38909.mail.mud.yahoo.com ([209.191.125.115]:34161 "HELO
	web38909.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965075AbXGSRki (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jul 2007 13:40:38 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Jul 2007 13:40:37 EDT
Received: (qmail 44177 invoked by uid 60001); 19 Jul 2007 17:33:57 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Message-ID;
  b=acssvUyTRHoKQiAtNIDQpxUflP5FYUU/SegnAS5LrlO69KoPLnWhNL/jXIDRGVIKbbX8yYB+v23GwQ9tfx9g2yKmM86FtxmCQX3HH0nfulsmrOBHXz8uc/Jo7PP4fxquLOexaqYhYEtxjM9guQBV1fSO5fmCqlvo5UPz6yHViyc=;
X-YMail-OSG: CrPXsvAVM1nPH_CfT7zP3CFeUuTaqCaENglH95WwRC7OXMZdlXSMBeSKi1As_JlphbNOFU6KrfOSKRoFauLAyhlEX6AvjTvCeIc.VJEhV9UaZoQa4L3wlEez4Q--
Received: from [128.251.88.108] by web38909.mail.mud.yahoo.com via HTTP; Thu, 19 Jul 2007 10:33:57 PDT
X-Mailer: YahooMailRC/651.41 YahooMailWebService/0.7.41.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53009>

This is a good idea. However, I assume the _ proc is just sugar. It might be better to follow a more "standard" way for this, and just import the msgcat namespace, and then you can just use [mc]. For example:

package require msgcat
namespace import ::msgcat::*
  .
  .
  .
.mbar add cascade -label [mc Repository] -menu .mbar.repository

Also, if the message catalogs are in a common location, then it might be worth looking into having gitk utilize these msg catalogs as well.

Thanks,
    --brett


p.s. the frink tool (http://wiki.tcl.tk/2611) is supposed to be able to convert -text and -label switches to use msgcat...it might be worth looking into, instead of manually editing git-gui/gitk


----- Original Message ----
From: Christian Stimming <stimming@tuhh.de>
To: git@vger.kernel.org
Sent: Thursday, July 19, 2007 3:56:57 AM
Subject: [PATCH] Internationalization of git-gui

This is an initial patch of how internationalization (i18n) in git  
could be done, starting with the git-gui application (because I need  
that one in German to convince my workplace of switching to git).

Does this implementation look okay? If yes, I'd happily i18n'ize the  
rest of git-gui and provide a full German translation as well.

Thanks,

Christian Stimming





       
____________________________________________________________________________________
Sick sense of humor? Visit Yahoo! TV's 
Comedy with an Edge to see what's on, when. 
http://tv.yahoo.com/collections/222
