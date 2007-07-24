From: Brett Schwarz <brett_schwarz@yahoo.com>
Subject: Re: [PATCH] Fix translation of strings in foreach lists.
Date: Tue, 24 Jul 2007 10:54:55 -0700 (PDT)
Message-ID: <59193.87306.qm@web38905.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ascii
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>
To: Christian Stimming <stimming@tuhh.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 24 19:55:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDOb6-0008RD-71
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 19:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753432AbXGXRy4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 13:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752785AbXGXRy4
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 13:54:56 -0400
Received: from web38905.mail.mud.yahoo.com ([209.191.125.111]:20596 "HELO
	web38905.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753296AbXGXRyz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jul 2007 13:54:55 -0400
Received: (qmail 87818 invoked by uid 60001); 24 Jul 2007 17:54:55 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Message-ID;
  b=g24ouYfCUh4MmS8++h4rW7TjcCCf1JCKZeU5wzjsZosawStfnNyCYZEZ11kinOLDDz7GSp0lwBvRYOP+M03eU1BGTZMPonR1aNamX/wOii35ZaC9Cy1MkfC2Nig+Q2m56YVG8bkfVvZpe/ESw99ymGXhAwYUi3YEu3f8+A41n1c=;
X-YMail-OSG: WzCMgBQVM1nJ5n8XOBEok8KFRq3iVo3Rk0ZJKHK.6vj5sQdinhUDwf.KmWVSYh8Hkb6y7K2SWYt.Pd0JU2BG7iyF8aNT58x_EsUT2896bOr7_kSXNuAorbgSsA--
Received: from [128.251.89.90] by web38905.mail.mud.yahoo.com via HTTP; Tue, 24 Jul 2007 10:54:55 PDT
X-Mailer: YahooMailRC/651.41 YahooMailWebService/0.7.41.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53621>



> ----- Original Message ----
> From: Christian Stimming <stimming@tuhh.de>
> To: Shawn O. Pearce <spearce@spearce.org>
> Cc: Brett Schwarz <brett_schwarz@yahoo.com>; git@vger.kernel.org; Paul Mackerras <paulus@samba.org>; Junio C Hamano <gitster@pobox.com>
> Sent: Tuesday, July 24, 2007 8:20:28 AM
> Subject: Re: [PATCH] Fix translation of strings in foreach lists.
> 
> Quoting "Shawn O. Pearce" <spearce@spearce.org>:
> >> >I not sure if it's worth changing, but you don't necessarily need
> >> >those [append]'s in there.
> >>
> >> Thanks for the info. It is basically up to Shawn to decide which style
> >> he likes more.
> >
> > "[mc Foo]\n\n$err"
> >
> > is much shorter.  So I'd prefer that over [append [mc Foo] "\n\n$err"].
> 
> Err, but the usual case is that the argument to [mc] is more than one  
> word, and (additionally) that argument has to be quoted by  
> double-quotes (as opposed to braces) because otherwise xgettext  
> doesn't extract the message correctly. Hence, the only possibility  
> here were
> 
>    "[mc "Some Text"]\n\n$err"
> 
> Is this valid Tcl? Being a newcomer to this language I have to says  
> the quotes here look rather strange :-)
> 

Yes, that's valid.

bschwarz@bschwarz-desktop:~/gittcl$ tclsh
% package require msgcat
1.3.4
% namespace import msgcat::mc
% set err "ERROR"
ERROR
% msgcat::mcset en "hello there" HOWDY
HOWDY
% puts "[mc "hello there"]\n\n$err"
HOWDY

ERROR
%


HTH,
    --brett




       
____________________________________________________________________________________
Looking for a deal? Find great prices on flights and hotels with Yahoo! FareChase.
http://farechase.yahoo.com/
