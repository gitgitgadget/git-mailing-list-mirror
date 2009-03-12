From: david@lang.hm
Subject: Re: Google Summer of Code 2009: GIT
Date: Thu, 12 Mar 2009 11:03:47 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0903121100360.16753@asgard.lang.hm>
References: <49B74373.3090609@gmail.com>  <ab9fa62a0903110511u63e7d46dr3bb783ee891ca4ae@mail.gmail.com>  <alpine.DEB.1.00.0903111353340.10498@intel-tinevez-2-302>  <ab9fa62a0903110655y4a47ccfkde0984ecb46b3307@mail.gmail.com>  <alpine.DEB.1.00.0903111458340.10498@intel-tinevez-2-302>
  <alpine.DEB.1.10.0903110931070.13653@asgard.lang.hm>  <ab9fa62a0903111007w4772b234x8e6fd19cdc7fc595@mail.gmail.com>  <alpine.DEB.1.10.0903111223470.16753@asgard.lang.hm>  <ab9fa62a0903111302j46c46c2q96af497fa2ac513e@mail.gmail.com> 
 <alpine.DEB.1.10.0903111307050.16753@asgard.lang.hm> <ab9fa62a0903120542s45b1ceebwddab932891c47cf0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: saurabh gupta <saurabhgupta1403@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 19:06:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhpI5-0001QY-Sj
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 19:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756279AbZCLSD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 14:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755860AbZCLSDz
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 14:03:55 -0400
Received: from mail.lang.hm ([64.81.33.126]:33854 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753153AbZCLSDy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 14:03:54 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n2CI3l0v016925;
	Thu, 12 Mar 2009 10:03:47 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <ab9fa62a0903120542s45b1ceebwddab932891c47cf0@mail.gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113099>

On Thu, 12 Mar 2009, saurabh gupta wrote:

> hello,
>
> On Thu, Mar 12, 2009 at 1:51 AM,  <david@lang.hm> wrote:
>>
>>> Yes, but the thing is that the underlying codes and method will be
>>> different for GUI part and terminal part to make it readable and
>>> understandable. Like for OO Documents, if we aim to show the *diff*
>>> output in the Office tool, then we have to change the xml file
>>> accordingly. But the same xml file when used with terminal only, the
>>> *diff* output is not clear.
>>>
>>> As Johannes said in above post that for OO documents, while showing
>>> the *diff* result, no xml data should be shown.
>>
>> in part we are talking about different aspects of things, and we were all
>> wrong.
>>
>> see the e-mail a little bit ago by Junio
>>
>> there are two types of helpers that can be written
>>
>> 1. a low-level part that does the simple merges automaticaly and leaves
>> behind appropriate conflict markers when it can't
>>
>> there is no GUI involved with this.
>>
>> what 'appropriate conflict markers' are can vary from XML file to XML file
>>
>>
>> 2. after a conflict has taken place, a helper to work with the user to
>> resolve the conflict
>>
>> this can have a GUI and/or a text UI and is tied to the 'appropriate
>> conflict markers' as defined in #1, and can be _very_ tightly coupled to the
>> specific use of the XML file.
>>
>> I think it's very important to have a text UI tool that can be used for the
>> conflict resolution step as well as supporting GUI tools.
>
> All right. What I can understand from the current situation is that
> for merging and marking conflicts in xml (for example) files has
> following things to do.
>
> One, if the markers are put in the xml files like that of a text file,
> one can see the difference using a text editor or a terminal. But if
> the same xml file is to be opened in another editor which expects a
> valid xml (as clearly mentioned on the wiki ideas for GIT), then a
> merge helper is needed.
>
> But if the conflict markers are put in a way to make the xml file
> still valid which can be then opened in the appropriate editor, then
> the marking will be different. The merge driver has to produce the
> conflicted merged file in a manner which is still a valid xml file and
> user has the choice to open it in his own editor to resolve the
> conflicts.

exactly. and how you mark the conflict to have it be valid XML is going to 
depend on details of the type of file. there are probably a few basic 
methods that will work the vast majority of the time, but with some 
details needing to be configurable.

for example, if the XML document is a ODF document, it may be possible to 
add 'revision' tags around the conflict that are already understood by the 
editor.

David Lang
