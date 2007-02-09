From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: restriction of pulls
Date: Fri, 09 Feb 2007 19:32:49 +0200
Message-ID: <45CCB041.1000500@dawes.za.net>
References: <200702091149.12462.duelli@melosgmbh.de> <200702091619.23058.andyparkins@gmail.com> <45CCA301.4060504@dawes.za.net> <200702091645.33384.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christoph Duelli <duelli@melosgmbh.de>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 09 18:33:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFZcL-0003gU-3c
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 18:33:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946619AbXBIRc5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 12:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946620AbXBIRc5
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 12:32:57 -0500
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:57143 "EHLO
	spunkymail-a9.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1946619AbXBIRc5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Feb 2007 12:32:57 -0500
Received: from [192.168.201.100] (dsl-146-24-208.telkomadsl.co.za [165.146.24.208])
	by spunkymail-a9.g.dreamhost.com (Postfix) with ESMTP id B406D20CF5;
	Fri,  9 Feb 2007 09:32:53 -0800 (PST)
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
In-Reply-To: <200702091645.33384.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39188>

Andy Parkins wrote:
> On Friday 2007 February 09 16:36, Rogan Dawes wrote:
> 
>> Please note that my suggestion does NOT imply allowing partial checkins
>> (or if it does, it was not my intention)
> 
> My apologies then; I did misunderstand.
> 
That'll teach me to be more clear ;-)

> 
>>> In every way that matters you can do a partial checkout - I can pull any
>>> version of any file out of the repository.  However, it should certainly
>>> not be the case that git records that fact.
>> Why not? If you only want to modify that file, does it not make sense
>> that you can just check out that file, modify it, and check it back in?
> 
> Sorry - what I meant was that it shouldn't record that you checked out 
> revision 74 of that file and retain a link from the current version to that 
> old version.

Well, the new commit would have the previous commit as its direct 
parent, even though it may not have all the blobs to support it.

Which implies that all the git merge semantics should still work, 
assuming that the person actually doing the merge has all the necessary 
objects to resolve any conflicts. (Which does not necessarily imply that 
he has ALL of the objects in the tree, just those that are implicated in 
any conflicts).

So, for example, the doc team may have a documentation maintainer who 
has the entire doc/ directory, who resolves any submissions from the doc 
team, and feeds that up into the master tree. And all of this could be 
done by means of pulls by the upstream maintainers.

Rogan
