From: Simon Josefsson <simon@josefsson.org>
Subject: Re: [PATCH] Add --pretty=changelog
Date: Fri, 02 Mar 2007 11:15:03 +0100
Message-ID: <87abywrly0.fsf@latte.josefsson.org>
References: <Pine.LNX.4.63.0702271621120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<87y7mhrnrc.fsf@latte.josefsson.org>
	<Pine.LNX.4.63.0703011912090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<87hct4roqa.fsf@latte.josefsson.org>
	<7vejo8ezde.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 02 11:15:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN4nO-0001ug-S4
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 11:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933303AbXCBKPV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 05:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423003AbXCBKPV
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 05:15:21 -0500
Received: from 178.230.13.217.in-addr.dgcsystems.net ([217.13.230.178]:46594
	"EHLO yxa.extundo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423002AbXCBKPT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 05:15:19 -0500
Received: from extundo.com (yxa.extundo.com [217.13.230.178])
	(authenticated bits=0)
	by yxa.extundo.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l22AF3mT000613
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 Mar 2007 11:15:06 +0100
OpenPGP: id=B565716F; url=http://josefsson.org/key.txt
X-Hashcash: 1:22:070302:junkio@cox.net::JyW7TFFdIFwNcRP7:0r8h
X-Hashcash: 1:22:070302:git@vger.kernel.org::urwXVqxL0Snw3mtV:tOb
X-Hashcash: 1:22:070302:johannes.schindelin@gmx.de::XYs968dqDmC9dRGw:ZxLn
In-Reply-To: <7vejo8ezde.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri\, 02 Mar 2007 02\:03\:25 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.94 (gnu/linux)
X-Spam-Status: No, score=-0.7 required=4.0 tests=AWL,BAYES_50 autolearn=ham 
	version=3.1.1
X-Spam-Checker-Version: SpamAssassin 3.1.1 (2006-03-10) on yxa-iv
X-Virus-Scanned: ClamAV version 0.88.2, clamav-milter version 0.88.2 on yxa.extundo.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41180>

Junio C Hamano <junkio@cox.net> writes:

> Simon Josefsson <simon@josefsson.org> writes:
>
>> The problem here is that CVS insert '*** empty log message ***' when
>> you didn't supply a log message, and doing something intelligent with
>> such logs would be useful.
>
> If that is indeed the case then I suspect that cvs-to-git
> conversion should know about it and strip the artificial
> string.

Yes, actually, that seems like a better solution.

Btw, there is a custom to work around cvs translating empty log
messages into '*** empty log message ***' strings, and that is to
commit a log consisting of '.'.  Translating both of those cvs log
messages into a '' git log message, during cvs-import, seems like a
useful change.

>> But I want more than the oneline comment in the ChangeLog?  There is
>> no size limit on ChangeLog messages, and having as much information as
>> possible available is better.
>
> I think this was purely underspecification when your request was
> passed to Johannes.
>
> I've merged Johannes's gnucl series to 'next' but haven't pushed
> out, so I'll revert it.

Sorry for the trouble!

Also thanks, Johannes, for working so quickly on this.  Seeing the
first version of the ChangeLog output from your patched git allowed me
to realize that the imported cvs history seemed ok.  After replacing
'cvs2cl' and 'cvsco' I couldn't find any other more cvs-specific
features in the project.  I have just released the first version of
libtasn1 from git instead of cvs.  More projects will follow...

/Simon
