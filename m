From: Simon Josefsson <simon@josefsson.org>
Subject: Re: [PATCH] Add --pretty=changelog
Date: Sat, 03 Mar 2007 15:12:42 +0100
Message-ID: <877ityquud.fsf@latte.josefsson.org>
References: <Pine.LNX.4.63.0702271621120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<87y7mhrnrc.fsf@latte.josefsson.org>
	<Pine.LNX.4.63.0703011912090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<87hct4roqa.fsf@latte.josefsson.org>
	<Pine.LNX.4.63.0703021419520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 03 15:13:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNUz3-0006Pc-UJ
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 15:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbXCCONK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 09:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbXCCONK
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 09:13:10 -0500
Received: from 178.230.13.217.in-addr.dgcsystems.net ([217.13.230.178]:54867
	"EHLO yxa.extundo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030257AbXCCONJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 09:13:09 -0500
Received: from extundo.com (yxa.extundo.com [217.13.230.178])
	(authenticated bits=0)
	by yxa.extundo.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l23ECg2P007126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Mar 2007 15:12:42 +0100
OpenPGP: id=B565716F; url=http://josefsson.org/key.txt
X-Hashcash: 1:22:070303:johannes.schindelin@gmx.de::5lEJhPsTA1aje8j6:0lRT
X-Hashcash: 1:22:070303:junkio@cox.net::F/xtt48p9YbFOnOv:2XtX
X-Hashcash: 1:22:070303:git@vger.kernel.org::YGlIqGnucCEHdXaj:LPP+
In-Reply-To: <Pine.LNX.4.63.0703021419520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri\, 2 Mar 2007 15\:09\:49 +0100
	\(CET\)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.94 (gnu/linux)
X-Spam-Status: No, score=-1.0 required=4.0 tests=AWL,BAYES_20 autolearn=ham 
	version=3.1.1
X-Spam-Checker-Version: SpamAssassin 3.1.1 (2006-03-10) on yxa-iv
X-Virus-Scanned: ClamAV version 0.88.2, clamav-milter version 0.88.2 on yxa.extundo.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41298>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Fri, 2 Mar 2007, Simon Josefsson wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > I saw that in your mail already, and I find the style cvs2cl outputs 
>> > ugly.
>> 
>> Well, if you don't follow the GNU ChangeLog format, then please call it 
>> something else.  The format is well documented.
>
> Well, it is still ugly. I mean, really ugly. Like in "it's easier to 
> script, therefore I don't fix it" ugly.
>
> And yes, the format is well documented. For example, it includes the 
> function names in brackets, which both my patch and cvs2cl do not do. 
> These function names actually got me interested, and I would have tried to 
> generate them automatically, too.

Including the function names in brackets is optional, but the wrap
style is inherent in the format.

However, it sounds like a nice idea to automatically add function
names when there aren't too many of them.  Possibly one should be able
to use a regexp to restrict the set of function names (useful, e.g.,
for only having brackets for public API functions).  I recall that
"diff" has an option to print C function names in patches, maybe that
could be used.

>> > No charset problem. In Git commit messages, the first line is special. 
>> > It is the so called "oneline" description. If you wrap the oneline, 
>> > it's your fault, not Git's.
>> 
>> But I want more than the oneline comment in the ChangeLog?  There is no 
>> size limit on ChangeLog messages, and having as much information as 
>> possible available is better.
>
> With Git, it is encouraged that you write useful commit messages. There 
> are commits where the patch consists of just a line change, and the 
> message of a really long text. For a good example, look at commit 
> v1.4.0-rc1~50: the commit message has 49 lines of text, but the patch only 
> changes 5 lines.
>
> If you are serious about "having as much information", include the 
> _complete_ commit message.

Yes, I do want the complete commit message.  While 49 lines of
ChangeLog entry is a lot, it is not completely unheard of.  Although
the recommendation in the GNU ChangeLog specification to move such
lengthy discussions to manuals or source code comments is often good.

>> Anyway, for now I'll be settling with the (just announced) git2cl since 
>> it gives me the most flexibility.
>
> In hindsight I agree with Junio that a script is better for this purpose. 

Yup, I think it will be more flexible to keep it outside of git.  It
makes it easier to do some un-git-ish things (like handling those
"empty" CVS log messages).

/Simon
