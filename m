From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH] Internationalization of git-gui
Date: Fri, 20 Jul 2007 11:03:54 +0200
Message-ID: <20070720110354.so2v2d5ysc040sss@webmail.tu-harburg.de>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Brett Schwarz <brett_schwarz@yahoo.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 12:59:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBqCn-0007Dt-2p
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 12:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445AbXGTK70 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 06:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752447AbXGTK70
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 06:59:26 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:46185 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233AbXGTK7Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jul 2007 06:59:25 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6K93tEd010150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Fri, 20 Jul 2007 11:03:55 +0200
Received: from webmail.tu-harburg.de (ocs3.rz.tu-harburg.de [134.28.202.66])
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6K93t57015605;
	Fri, 20 Jul 2007 11:03:55 +0200
Received: by webmail.tu-harburg.de (Postfix, from userid 1001)
	id 00D94E50349; Fri, 20 Jul 2007 11:03:54 +0200 (CEST)
Received: from hansjoerg.sick.de (hansjoerg.sick.de [62.180.123.245]) by
	webmail.tu-harburg.de (Horde MIME library) with HTTP; Fri, 20 Jul 2007
	11:03:54 +0200
In-Reply-To: <622391.43998.qm@web38909.mail.mud.yahoo.com>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53083>

Quoting Brett Schwarz <brett_schwarz@yahoo.com>:
> Also, if the message catalogs are in a common location, then it   
> might be worth looking into having gitk utilize these msg catalogs   
> as well.

You mean you suggest to re-use existing msg catalogs in addition to  
ones that are created on our own? Well, from the i18n coordination  
work in another project (gnucash) I wouldn't expect any noticable  
benefit from doing so. The re-usable parts of translations are rather  
limited, basically limited to the standard menu entries and some more  
single-word strings (Yes/No/Cancel...). But even then re-using other  
translations might already decrease the quality of your own  
translation, because other translators of packages might already have  
chosen a different translation for e.g. "Cancel". For that reason I  
strongly suggest using one single msg catalog for one single project,  
so that the translator is even able to make sure each word is  
translated into the same translation throughout the project.

(I also strongly suggest creating and translating a glossary of the  
important terms before starting to translate the msg catalog itself,  
but that's a different issue.)

> p.s. the frink tool (http://wiki.tcl.tk/2611) is supposed to be able  
>  to convert -text and -label switches to use msgcat...it might be   
> worth looking into, instead of manually editing git-gui/gitk

Thanks for the pointer. However, the -text and -label switches can be  
found and edited rather easily by keyboard macros and such. More  
important than this are some changes that are necessary in order to  
obtain strings that are actually translatable, such as

-	.mbar.apple add command -label "About [appname]" \
+	.mbar.apple add command -label [format [_ "About %s"] [appname]] \

and you will agree those can only be done manually anyway.

Christian
