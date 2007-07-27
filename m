From: Christian Stimming <stimming@tuhh.de>
Subject: Re: git-gui-i18n: Make "Revert changes in these $n files"
	translatable.
Date: Fri, 27 Jul 2007 13:49:23 +0200
Message-ID: <20070727134923.jahvcmejwgww0oow@webmail.tu-harburg.de>
References: <53264.26898.qm@web38901.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: Harri Ilari Tapio Liusvaara <hliusvaa@cc.hut.fi>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>
To: Brett Schwarz <brett_schwarz@yahoo.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 13:49:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEOK8-0002YH-Fj
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 13:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763562AbXG0Ltd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 07:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760180AbXG0Ltd
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 07:49:33 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:47573 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755433AbXG0Ltc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jul 2007 07:49:32 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6RBnNbZ014767
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Fri, 27 Jul 2007 13:49:23 +0200
Received: from webmail.tu-harburg.de (ocs3.rz.tu-harburg.de [134.28.202.66])
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6RBnNMe015954;
	Fri, 27 Jul 2007 13:49:23 +0200
Received: by webmail.tu-harburg.de (Postfix, from userid 1001)
	id 8CA10E50349; Fri, 27 Jul 2007 13:49:23 +0200 (CEST)
Received: from hansjoerg.sick.de (hansjoerg.sick.de [62.180.123.245]) by
	webmail.tu-harburg.de (Horde MIME library) with HTTP; Fri, 27 Jul 2007
	13:49:23 +0200
In-Reply-To: <53264.26898.qm@web38901.mail.mud.yahoo.com>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53920>

Quoting Brett Schwarz <brett_schwarz@yahoo.com>:
>> > - Buttons in hard reset confirmation (branch->revert or merge->abort,
>> >   and it is yes/no dialog).
>>
>> Maybe those need to be translated in the tcl/tk system libraries?
>
> These are indeed in the Tk libs. Unfortunately, there is no straight  
>  forward way to change the button text for tk_messageBox. I'll   
> probably submit a patch to Tcl core for this.

That would indeed be a very good solution here.

> In the mean time, if this is important, there are 2 ways around this:
>
> 1) override the button text in the msgcat. (...)
> So, somewhere in the git-gui, you would  have to do something like:
>     namespace eval ::Tk {
>       ::msgcat::mcset en_us &OK <new_term>
>       ::msgcat::mcset en_us &Cancel <new_term>
>       ::msgcat::mcset en_us &Yes <new_term>
>       ::msgcat::mcset en_us &No <new_term>
>       <continue for each language, if needed>
>     }

I think this wouldn't help much here. First of all, the original  
messages might be different between different Tcl versions. But  
secondly and more importantly, as Harri Ilari pointed out, we should  
prefer to provide button texts different from Yes/No but rather  
questions like "Revert"/"Cancel".

> 2) Re-write the tk_messageBox, to include an option to specify the   
> button text. This wouldn't be too hard actually, but this would live  
>  with git-gui.

This would indeed be the nicer solution and it would improve both the  
English button labels and their translations all in one.

> I don't think option #1 is robust enough, but would be the easiest   
> approach. Note also that this would only be for unix platforms,   
> since for windows and Mac, it calls the platform's equivalent.

By the way: I have been using git-gui on Windows with mingw-git(+msys)  
and ActiveTcl for several weeks by now. Works like a charm, and I'm  
looking forward to propose it as a fully localized, fully  
cross-platform, and simply the best SCM, to the co-workers in my  
company... :-)

Christian
