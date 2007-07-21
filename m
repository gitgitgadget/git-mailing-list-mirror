From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH 1/5] Internationalization of git-gui
Date: Sat, 21 Jul 2007 21:50:48 +0200
Message-ID: <200707212150.49351.stimming@tuhh.de>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com> <Pine.LNX.4.64.0707211427190.14781@racer.site> <7vejj1v92b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 21:50:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICKya-0004JX-Pg
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 21:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759092AbXGUTus (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 15:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757007AbXGUTus
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 15:50:48 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:35430 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324AbXGUTur (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 15:50:47 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6LJoaIW032241
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sat, 21 Jul 2007 21:50:36 +0200
Received: from [192.168.2.102] (p5490088F.dip0.t-ipconnect.de [84.144.8.143])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6LJoYZh027810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 21 Jul 2007 21:50:36 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <7vejj1v92b.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53183>

Am Samstag, 21. Juli 2007 21:41 schrieb Junio C Hamano:
> While I think keeping a reference for consistent translation
> (within one language's *.po file) is a useful practice,
> the po/glossary.csv file on 'master' seems a way suboptimal
> solution.  Currently it is:
>
>         $ file po/glossary.csv
>         po/glossary.csv: ISO-8859 text

Oops. I created it with utf8 locally. Must have turned into latin1 either in 
my mailer or during Johannes' mbox tweaking.

(Also, the de.po was created in utf8 here and must have been messed up during 
transmission. Johannes, for future reference: All i18n files should probably 
be submitted as utf8, and if they have a different encoding, the submitter 
better gave a clear sign this was intentional.)

>         $ head -n 1 po/glossary.csv
>         "English Term"  "de translation"
>
> which implies that other languages will be added at the end
> separated with <TAB>?
>
> There are two HUGE problems with that.
>
>  * Supporting many languages means looooong lines in that file.
>    Translators for languages later on the line would have hard
>    time updating or looking at that file.
>
>  * Mixed encodings.  What if next language wants its strings in
>    UTF-8?  How would you have that and ISO-8859 on a same line?
>
> I would suggest having one glossary file per language.

Agreed. I propose to throw away the "add glossary" patch and I'll resubmit, 
this time in a separate po/glossary/ directory, where each language will get 
a po file for the glossary. 

As I've written in another thread: In the glossary for the gnucash project [1] 
we've actually added an extra 
directory and encourage translators to add an extra po file for their 
glossary translations. However, the glossary of gnucash has more than 150 
terms and many of them require to be defined clearly as well, as translators 
would otherwise be unable to translate them concisely. In git-gui, the 
glossary is 25 terms so far and I think the git documentation already 
contains enough definitions of all of them. Nevertheless, maybe it would make 
a better structure if the translations of the glossary are kept in a separate 
po file for each language. 

Christian

[1] 
http://svn.gnucash.org/trac/browser/gnucash/trunk/po/glossary/gnc-glossary.txt
