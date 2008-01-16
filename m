From: Petko Manolov <petkan@nucleusys.com>
Subject: Re: git and binary files
Date: Wed, 16 Jan 2008 18:06:10 +0200 (EET)
Message-ID: <alpine.DEB.1.00.0801161802370.5260@bender.nucleusys.com>
References: <alpine.DEB.1.00.0801161222150.3889@bender.nucleusys.com> <m37ii9nagt.fsf@roke.D-201> <alpine.DEB.1.00.0801161600030.5260@bender.nucleusys.com> <200801161520.44668.jnareb@gmail.com> <alpine.DEB.1.00.0801161640010.5260@bender.nucleusys.com>
 <alpine.LFD.1.00.0801160958170.25841@xanadu.home> <alpine.DEB.1.00.0801161715570.5260@bender.nucleusys.com> <alpine.LFD.1.00.0801161056500.25841@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 17:08:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFAo9-0008KO-K4
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 17:08:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbYAPQHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 11:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbYAPQHh
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 11:07:37 -0500
Received: from n152-u15.cabletel.bg ([89.253.152.15]:57470 "EHLO
	zztop.nucleusys.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751243AbYAPQHg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 11:07:36 -0500
Received: from bender.nucleusys.com ([192.168.234.2])
	by zztop.nucleusys.com with esmtp (Exim 4.63)
	(envelope-from <petkan@nucleusys.com>)
	id 1JFAnQ-0007aD-Og; Wed, 16 Jan 2008 18:07:20 +0200
In-Reply-To: <alpine.LFD.1.00.0801161056500.25841@xanadu.home>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70695>

On Wed, 16 Jan 2008, Nicolas Pitre wrote:

> On Wed, 16 Jan 2008, Petko Manolov wrote:
>
>> On Wed, 16 Jan 2008, Nicolas Pitre wrote:
>>
>>> On Wed, 16 Jan 2008, Petko Manolov wrote:
>>>
>>>> On Wed, 16 Jan 2008, Jakub Narebski wrote:
>>>>
>>>>> Petko Manolov wrote:
>>>>>>
>>>>>> Unfortunately this is not the case.  These binary blobs are already
>>>>>> compressed and/or encrypted and adding even a few bytes ends up
>>>>>> storing
>>>>>> new version in full size.
>>>>>
>>>>> Can't you store them uncompressed?
>>>>
>>>> Not really, but i can convert them into ascii format and store only the
>>>> delta.
>>>
>>> If you don't have the original uncompressed unencrypted file, what will
>>> converting them to ascii actually give you?
>>
>> I hope that in the case of incremental changes (0 to 5MB file is the same,
>> last 64KB are actually new) the delta will be small and should be able to
>> compress well.
>>
>> This won't work for random changes along the length of the whole file.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> But my question remains.
>
> If you cannot create good deltas out of your binary files, converting
> those binaries into ascii will do nothing to compression performance.

I did agree with you above.  Binary or ascii it doesn't matter.

The experiments so far shows that git is doing a good job finding deltas 
in binary files.  This may be a solution for certain part of my files...


 		Petko
