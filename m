From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Documentation: Fix build failure of docs.
Date: Tue, 28 Jul 2009 20:03:03 +0200
Message-ID: <4A6F3D57.2010602@drmicha.warpmail.net>
References: <4A6F29C5.6030608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Saikiran Madugula <hummerbliss@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 20:03:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVr1M-00011e-3F
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 20:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755294AbZG1SDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 14:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755291AbZG1SDU
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 14:03:20 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43491 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755038AbZG1SDT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jul 2009 14:03:19 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 8DBC33BD1F1;
	Tue, 28 Jul 2009 14:03:19 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 28 Jul 2009 14:03:19 -0400
X-Sasl-enc: NtKzRXt9DPWSZbXLOyZygwlTTDUci52YZfy10NiJjNQB 1248804199
Received: from localhost.localdomain (p5DCC1492.dip0.t-ipconnect.de [93.204.20.146])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7BE5CD3A1;
	Tue, 28 Jul 2009 14:03:18 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.2pre) Gecko/20090728 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <4A6F29C5.6030608@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124266>

Saikiran Madugula venit, vidit, dixit 28.07.2009 18:39:
> OOps, forgot to cc vger.kernel.org
> 
> Thomas Rast wrote:
>> NAK.  Presumably you are using an asciidoc 8.x?  Please check if
>> saying
>>
>>   make ASCIIDOC8=Yes man
>>
>> fixes the problem.  Read the comments in Documentation/Makefile for
>> advice on what precise combination of options you should use.  Also,
>> if you do not want to actually work on docs
>>
>>   make quick-install-man
>>
>> is a much less painful way to get manpages (in this case, from Junio's
>> 'man' branch that has preformatted manpages for 'master').
> 
> My asciidoc version is 8.4.1. Yes "make ASCIIDOC8=yes" seems to have built with
> out any problems. Thanks for quick-install-man tip, I should have read till the
> end of INSTALL document  :) .
>>
>> I put the +++ in there to stop the version I used at the time from
>> rendering the closing backtick as part of the URL and garbling the
>> entire paragraph in the process.  To be precise, with asciidoc 8.2.7
>> and without the +++ I get
>>
>>   Clone it with <tt>git clone <a href="file:///path/to/repo</tt">file:///path/to/repo</tt</a>>.
>>
>> in the HTML output.  Note the nested tags.  (With asciidoc 8.4.5 the
>> problem appears to be fixed.)
>>
> 
> People would start using latest versions of ascii doc which has no problems,
> wouldn't it be better if the default compile options suit them ? Also, it would
> be good if "make install man", would do "quick-install-man" as default to
> prevent users from the painful compilation of manpages everytime they try to
> install latest git.

"make install" does not build any documentation at all, so that should
be no source of pain.

The user decides which we to go: install-man or quick-install-man.

Having the defaults set up so that recent "mainstream" versions of the
tool chain work without extra options may sound like a good idea - but
that would mean changing options again and again. I think we should do
this for major milestones (say git 1.7).

Michael
