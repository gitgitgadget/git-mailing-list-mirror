From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH] Internationalization of git-gui
Date: Fri, 20 Jul 2007 10:56:02 +0200
Message-ID: <20070720105602.7dcm241ts0k0ww88@webmail.tu-harburg.de>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com>
	<20070720050455.GN32566@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 20 12:59:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBqCw-0007Hm-OK
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 12:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754007AbXGTK7e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 06:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753983AbXGTK7e
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 06:59:34 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:46185 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753982AbXGTK7d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jul 2007 06:59:33 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6K8u2IK008974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Fri, 20 Jul 2007 10:56:02 +0200
Received: from webmail.tu-harburg.de (ocs3.rz.tu-harburg.de [134.28.202.66])
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6K8u27R012255;
	Fri, 20 Jul 2007 10:56:02 +0200
Received: by webmail.tu-harburg.de (Postfix, from userid 1001)
	id 8D264E50349; Fri, 20 Jul 2007 10:56:02 +0200 (CEST)
Received: from hansjoerg.sick.de (hansjoerg.sick.de [62.180.123.245]) by
	webmail.tu-harburg.de (Horde MIME library) with HTTP; Fri, 20 Jul 2007
	10:56:02 +0200
In-Reply-To: <20070720050455.GN32566@spearce.org>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53084>

Quoting "Shawn O. Pearce" <spearce@spearce.org>:
> Brett Schwarz <brett_schwarz@yahoo.com> wrote:
>> This is a good idea. However, I assume the _ proc is just sugar. It
>> might be better to follow a more "standard" way for this, and just
>> import the msgcat namespace, and then you can just use [mc].
>>
>> package require msgcat
>> namespace import ::msgcat::*
>>   .
>>   .
>> .mbar add cascade -label [mc Repository] -menu .mbar.repository
>
> Not just better, I'd prefer it.  The proc name "_" is cute but
> is just too darn short.  I would much prefer to use "mc" and just
> say that "mc" in all of git-gui's namespaces is reserved for the
> message catalog

I used (and prefer) "_" because that's the standard function name for  
i18n'd strings when using gettext (talking about a "standard" way). In  
that case the convention from C simply carries over to tcl/tk, and  
programmers who have worked with gettext in C before, which uses  
_("some message"), directly apply what they already know. [mc ..], on  
the other hand, would be a tcl-only function name which doesn't give  
too much of a hint of what this function does, except for those  
programmers who happen to know that tcl's translation is done by a  
package called msgcat. One might rather consider something like [tr  
...], for "translate", or even [i18n ...].

That being said, I'm rather agnostic on which proc name you really  
prefer. Just pick one.

Being a newcomer on this list, could you please explain to me how to  
proceed with the i18n patches so far? Do you want to have patches  
submitted after some further changes (which ones?) and/or in different  
formats? Do you prefer to have all changes in a smaller number of  
commit rather than split the way I did before? Should I wait for some  
more days/weeks/whatever until you or particular other developers have  
reviewed the patches? Thanks.

Christian
