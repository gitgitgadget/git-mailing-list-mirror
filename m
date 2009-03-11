From: david@lang.hm
Subject: Re: Google Summer of Code 2009: GIT
Date: Wed, 11 Mar 2009 13:21:05 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0903111307050.16753@asgard.lang.hm>
References: <49B74373.3090609@gmail.com>  <alpine.DEB.1.00.0903111255470.10279@pacific.mpi-cbg.de>  <ab9fa62a0903110511u63e7d46dr3bb783ee891ca4ae@mail.gmail.com>  <alpine.DEB.1.00.0903111353340.10498@intel-tinevez-2-302>  <ab9fa62a0903110655y4a47ccfkde0984ecb46b3307@mail.gmail.com>
  <alpine.DEB.1.00.0903111458340.10498@intel-tinevez-2-302>  <alpine.DEB.1.10.0903110931070.13653@asgard.lang.hm>  <ab9fa62a0903111007w4772b234x8e6fd19cdc7fc595@mail.gmail.com>  <alpine.DEB.1.10.0903111223470.16753@asgard.lang.hm>
 <ab9fa62a0903111302j46c46c2q96af497fa2ac513e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: saurabh gupta <saurabhgupta1403@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 21:25:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhUx0-0003gt-5N
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 21:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282AbZCKUVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 16:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751725AbZCKUVV
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 16:21:21 -0400
Received: from mail.lang.hm ([64.81.33.126]:40159 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897AbZCKUVU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 16:21:20 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n2BKL6kq009198;
	Wed, 11 Mar 2009 12:21:06 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <ab9fa62a0903111302j46c46c2q96af497fa2ac513e@mail.gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112974>

On Thu, 12 Mar 2009, saurabh gupta wrote:

> On Thu, Mar 12, 2009 at 12:59 AM,  <david@lang.hm> wrote:
>> On Wed, 11 Mar 2009, saurabh gupta wrote:
>>
>>> On Wed, Mar 11, 2009 at 10:02 PM,  <david@lang.hm> wrote:
>>>>
>>>> On Wed, 11 Mar 2009, Johannes Schindelin wrote:
>>>>
>>>>> Hi,
>>>>>
>>>>> On Wed, 11 Mar 2009, saurabh gupta wrote:
>>>>>
>>>
>>> In case of only a terminal, It would be very difficult to show an OO
>>> document to represent the *diff* output in both text as well in GUI.
>>> For example, to indicate the changes in an OO document, we will have
>>> to change the underlying XML file appropriately to show the markers
>>> signs and other things in the conflict file. Now, if this file is
>>> opened in terminal, it would not be at all comprehensible to see the
>>> differences.
>>>
>>> The main thing is that to create *diff* for different file formats, we
>>> will have to write the parser code accordingly.
>>
>> correct, and in the case of an XML file, the meaningful diff can be
>> substantially shorter than what a text diff of the two files would be
>> (whitespace changes that don't matter, even some tag ordering changes may
>> not matter)
>>
>> I'm just asking that you don't get so fixated on what can be done in a GUI
>> that you provide no benifit to people who don't have the GUI
>>
>> there are a _lot_ of XML based formats out there, having a diff/merge
>> capability to make dealing with them better than just treating them as text
>> files would be a _very_ useful thing.
>>
>> going beyond that and creating the ability to do the markup in
>> application-specific ways, and present it to the user in a nice GUI would
>> also be nice, but these are a step up after having the basic XML handling
>> that isn't specific to a particular application.
>
> Yes, but the thing is that the underlying codes and method will be
> different for GUI part and terminal part to make it readable and
> understandable. Like for OO Documents, if we aim to show the *diff*
> output in the Office tool, then we have to change the xml file
> accordingly. But the same xml file when used with terminal only, the
> *diff* output is not clear.
>
> As Johannes said in above post that for OO documents, while showing
> the *diff* result, no xml data should be shown.

in part we are talking about different aspects of things, and we were all 
wrong.

see the e-mail a little bit ago by Junio

there are two types of helpers that can be written

1. a low-level part that does the simple merges automaticaly and leaves 
behind appropriate conflict markers when it can't

there is no GUI involved with this.

what 'appropriate conflict markers' are can vary from XML file to XML file


2. after a conflict has taken place, a helper to work with the user to 
resolve the conflict

this can have a GUI and/or a text UI and is tied to the 'appropriate 
conflict markers' as defined in #1, and can be _very_ tightly coupled to 
the specific use of the XML file.

I think it's very important to have a text UI tool that can be used for 
the conflict resolution step as well as supporting GUI tools.


besides XML-based formats, a couple other formats that I think would be 
useful to be smarter about

unordered config files
   files where config options can appear in any order

   optionally: comments are similar to whitespace (they can be ignored)

'paragraph' based config files
   files where config options are orginized into 'paragraphs' where the 
paragraphs can be re-ordered

   the definition of what's a paragraph may differ, support having 
different defintions
     examples:
      the git config file has a high level tag that starts on the left margin with the sub-tags indented
      the apache config file can have single entries or 'XML like' sections

   optionally: comments are similar to whitespace (they can be ignored)


David Lang
