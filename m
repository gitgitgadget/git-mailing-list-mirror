From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Wed, 18 Apr 2007 08:24:29 +0200
Message-ID: <4625B99D.9090409@dawes.za.net>
References: <200704171041.46176.andyparkins@gmail.com> <"200704171803.58940.a n  dyparkins"@gmail.com> <200704172012.31280.andyparkins@gmail.com> <alpine.LFD.0.98.0704171530220.4504@xanadu.home> <Pine.LNX.4.63.0704171244450.1696@qynat.qvtvafvgr.pbz> <alpine.LFD.0.98.0704171624190.4504@xanadu.home> <Pine.LNX.4.63.0704171302200.1696@qynat.qvtvafvgr.pbz> <alpine.LFD.0.98.0704171708360.4504@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Lang <david.lang@digitalinsight.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 08:24:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He3ay-0004lK-C9
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 08:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbXDRGYn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 02:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbXDRGYn
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 02:24:43 -0400
Received: from sd-green-bigip-119.dreamhost.com ([208.97.132.119]:49730 "EHLO
	spunkymail-a11.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932493AbXDRGYm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Apr 2007 02:24:42 -0400
Received: from [192.168.201.100] (dsl-146-27-151.telkomadsl.co.za [165.146.27.151])
	by spunkymail-a11.g.dreamhost.com (Postfix) with ESMTP id A8232B6C24;
	Tue, 17 Apr 2007 23:24:36 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <alpine.LFD.0.98.0704171708360.4504@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44864>

Nicolas Pitre wrote:
> On Tue, 17 Apr 2007, David Lang wrote:
> 

>> I've
>> been told in the past that once .gitattributes is in place then the hooks for
>> the crlf stuff can be generalized to allow for calls out to custom code to do
>> this sort of thing.
> 
> And I agree that this is a perfectly sensible thing to do.  The facility 
> should be there for you to apply any kind of transformation with 
> external tools on data going in or out from Git.  There are good and bad 
> things you can do with such a facility, but at least it becomes your 
> responsibility to screw^H^H^H^Hfilter your data and not something that 
> is enforced by Git itself.
> 
> 
> Nicolas

One of the examples that has been given in the past has been taking a 
zipped OpenDocumentFormat file, unzipping it to its component parts, and 
then committing the individual files rather than the aggregate.

But I can't figure out how this might work.

One idea is to store the binary ODF file in the index (and in the packs, 
etc) as a directory with the individual text (and other) files as 
entries within that directory. Then, when various git operations want to 
use the directory, the operation is redirected via an attribute match to 
an external script that knows how to checkout an ODF "directory", or 
diff an ODF "directory", etc.

Or similarly, when checking an "ODF" file in, the attribute would lead 
to an appropriate script creating the "tree" of individual files.

Does this sound workable?

Rogan
