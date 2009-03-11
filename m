From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: Google Summer of Code 2009: GIT
Date: Wed, 11 Mar 2009 17:27:07 +0200
Message-ID: <49B7D84B.6080501@dawes.za.net>
References: <49B74373.3090609@gmail.com>	 <alpine.DEB.1.00.0903111255470.10279@pacific.mpi-cbg.de>	 <ab9fa62a0903110511u63e7d46dr3bb783ee891ca4ae@mail.gmail.com>	 <alpine.DEB.1.00.0903111353340.10498@intel-tinevez-2-302>	 <ab9fa62a0903110655y4a47ccfkde0984ecb46b3307@mail.gmail.com>	 <alpine.DEB.1.00.0903111458340.10498@intel-tinevez-2-302> <ab9fa62a0903110713k2a21cefbj1e7cd3c126aca8f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: saurabh gupta <saurabhgupta1403@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 16:29:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhQMy-0006p9-IU
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 16:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868AbZCKP11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 11:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752306AbZCKP1Z
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 11:27:25 -0400
Received: from caiajhbdcbhh.dreamhost.com ([208.97.132.177]:49103 "EHLO
	spunkymail-a16.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753530AbZCKP1Z (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2009 11:27:25 -0400
Received: from [192.168.201.113] (unknown [41.246.10.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by spunkymail-a16.g.dreamhost.com (Postfix) with ESMTP id 162E77B32B;
	Wed, 11 Mar 2009 08:27:20 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.19 (Macintosh/20081209)
In-Reply-To: <ab9fa62a0903110713k2a21cefbj1e7cd3c126aca8f9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112941>

saurabh gupta wrote:
>>> However, I think in merging and notifying about the conflicts in the xml
>>> files, other things can also be put forward. Like the GUI will show the
>>> number of tags differing and what are the new tags added and even if any
>>> tag is renamed with the content unchanged. If possible, how about
>>> showing a tree like structure (just like DOM model) to compare (or diff)
>>> the two xml files.
>>
>> This is a little bit too low-level for my liking.  Taking the OpenOffice
>> example again, the GUI should not expose XML at all...
> 
> hmmmm.....I think I get your point somewhat. Let me do some research
> over the formats and the background formats in which tools like
> OpenOffice store the data in xml files. May be for docbooks by
> OpenOffice, the best thing would be to give the *diff* output in terms
> of lines.
> I would also appreciate to know what you think and would like to see
> the output in such case.

I think that the implementation may make use of features inherent in the
file format where possible. e.g. I suspect that OpenOffice has the
ability to show "Tracked changes", and then allow the user to view the
changes using the actual OpenOffice implementation.

I suspect that that will get a lot more difficult with e.g. conflicts
and merges, because I doubt that OOo has the ability to show changes
from multiple versions.

But I have to agree with Dscho, that the output would have to depend on
the file type (OOo document), not just the data structure (e.g. XML)
inside the file.

A regular XML file diff could choose to ignore/collapse whitespace
(pretty printing) when doing the comparison, to show things like moving
a branch further down the tree.

e.g.

<i>text</i>

vs

<b><i>text</i></b>

vs

<b>
  <i>text</i>
</b>

For plain XML, a textual diff might choose to show it with each element
un-indented, and a standard text diff output:

+ <b>
  <i>
  text
  </i>
+ </b>

while a GUI diff might show the new element highlighted in a tree:

#green#<b>#/green#
  <i>
   text

I think that where reasonable that you should aim to have a text-only
version that could be wrapped by a GUI. Obviously, this would be
meaningless when diffing a JPG, for instance.

Ok, that was a bit rambling. I hope it helped more than it confused.

Rogan
