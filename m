From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git doc build failure on OS X 10.5.6 (Leopard) during xmlto 
  phase
Date: Fri, 13 Mar 2009 11:29:01 +0100
Message-ID: <49BA356D.8050007@drmicha.warpmail.net>
References: <5e68abd90903110721o414283a4te188b58e0e4df8ad@mail.gmail.com> <76718490903110812t5e1723ebi28a84da680422d8a@mail.gmail.com> <76718490903110839m17041c7bxd7912eb09496c81a@mail.gmail.com> <76718490903110849x2ef48a89j3f17706390991eda@mail.gmail.com> <49B7E670.7060606@drmicha.warpmail.net> <gp95vf$gp1$1@ger.gmane.org> <49B8EF3E.2070208@drmicha.warpmail.net> <20090312170931.GB19175@inocybe.teonanacatl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Alejandro Riveira <ariveira@gmail.com>, git@vger.kernel.org,
	Jay Soffian <jaysoffian@gmail.com>,
	Tom Holaday <tlholaday@gmail.com>
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 11:30:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li4fD-0001c8-2D
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 11:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753877AbZCMK3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 06:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753066AbZCMK3S
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 06:29:18 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:42315 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753526AbZCMK3S (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2009 06:29:18 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 487D32EE565;
	Fri, 13 Mar 2009 06:29:14 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 13 Mar 2009 06:29:15 -0400
X-Sasl-enc: fh4QZBXIbu5F18wEPCXpths5q0v1JZ9lwE1JcAyAYWf0 1236940153
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5CD6310B29;
	Fri, 13 Mar 2009 06:29:13 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090313 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <20090312170931.GB19175@inocybe.teonanacatl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113165>

Todd Zullinger venit, vidit, dixit 12.03.2009 18:09:
> Michael J Gruber wrote:
>> Following up on this:
>> On Fedora 10, I have asciidoc 8.2.5 and docbook 1.7.4 xsl's. For
>> proper man and html doc, I have to set DOCBOOK_XSL_172=Yes but leave
>> ASCIIDOC8 unset! I always forget, though (just like the packagers).
> 
> Check the fedora git packages in rawhide, we don't set ASCIIDOC8. :)

I was unclear, but I meant forgetting to set DOCB... But:

> I experimented with that and found it did not improve things.  We are
> only setting DOCBOOK_XSL_172.  Without that, we get the '.ft C'
> droppings.  With it, we get non-ascii characters in various places
> (where bold should be used to make the (1) notations stand out, for
> example).  This was filed as:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=485161

I hadn't noticed that yet (neither the effect nor the report). So, you
kept it unset intentionally and for a good reason. Please accept my apology!

> 
> I didn't add DOCBOOK_XSL_172 to the F-10 packages yet, because I know
> that it fixes one problem and causes another.  Either way, we'd be
> shipping packages with known brokeness.  I chose to stick with keeping
> the currently broken '.ft C' behavior.  Pick your poison. ;)
> 
> One of the fedora/red hat folks that works on the xmlto and docbook
> packages was going to take a look, as I very much don't understand the
> documentation stack.  :/
> 
> Anyone who does is very welcome to help find the culprit(s) and help
> get fixes to the proper places.

So the easy solution is out again, quite a pitty. The problem occurs on
F10 as well as F11/rawhide, right?

On a related issue: Does anybody know which asciidoc versions need
asciidoc7compatible to be set? 8.2.5 and above certainly don't, so we
should not advise using it. asciidoc's hg repo doesn't go back much more
(the initial revision does not need it either), and I haven't dug for
their earlier history yet.

Michael J Gruber
