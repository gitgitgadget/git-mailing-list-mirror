From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: error: packfile while git fsck
Date: Mon, 03 Nov 2008 17:18:53 +0100
Organization: atmel
Message-ID: <490F246D.1040307@atmel.com>
References: <48FF337F.3050505@atmel.com> <alpine.LFD.2.00.0810221049340.26244@xanadu.home> <48FF4521.5070303@atmel.com> <alpine.LFD.2.00.0810221323270.26244@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Nov 03 17:20:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx2A7-0008OZ-L8
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 17:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755314AbYKCQTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 11:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755041AbYKCQTE
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 11:19:04 -0500
Received: from mail.atmel.fr ([81.80.104.162]:63200 "EHLO atmel-es2.atmel.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754995AbYKCQTC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 11:19:02 -0500
Received: from fwat.rfo.atmel.com (gateway [192.168.1.1])
	by atmel-es2.atmel.fr (8.11.6+Sun/8.11.6) with SMTP id mA3GHYI28642;
	Mon, 3 Nov 2008 17:17:34 +0100 (MET)
Received: from meyreuil ([10.159.254.132]) by fwat; Mon, 03 Nov 2008 17:15:56 +0100 (MET)
Received: from [127.0.0.1] (pc245_112.atmel.fr [10.159.245.112])
	by meyreuil.atmel.fr (8.11.7p1+Sun/8.11.7) with ESMTP id mA3GIqL13387;
	Mon, 3 Nov 2008 17:18:52 +0100 (MET)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <alpine.LFD.2.00.0810221323270.26244@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99959>

Nicolas Pitre :
> On Wed, 22 Oct 2008, Nicolas Ferre wrote:
> 
>> Nicolas Pitre :
>>> On Wed, 22 Oct 2008, Nicolas Ferre wrote:
>>>
>>>> Hi all,
>>>> (please cc me on response)
>>>>
>>>> I am facing error during git status & git fsck on my tree.
>>>> This tree is cloned from various linux kernel trees.
>>>>
>>>> Here are a sample of the error I see :
>>>>
>>>> $ git fsck
>>>> error: packfile
>>>> .git/objects/pack/pack-2ab31ad1f8cb69d091a56fe936634e4796606d49.pack does
>>>> not
>>>> match index
>>>> error: packfile
>>>> .git/objects/pack/pack-2ab31ad1f8cb69d091a56fe936634e4796606d49.pack
>>>> cannot be
>>>> accessed
>>> [...]
>>>
>>> What git version?
>> $ git --version
>> git version 1.5.3.7
> 
> OK.  Since this is not bleeding edge, it is pretty unlikely that the 
> corruption is due to git itself.  Furthermore, the git packs are always 
> read only once they've been created, meaning that if they weren't 
> corrupted at some point then something outside of git caused the 
> corruption.  You really should consider the possible causes for that 
> (dying disk, pilot error, etc).
> 
> As to recovery... That really depends if you have personal work 
> committed to your repository.  If not then the easiest solution is 
> simply to recreate it by refetching from upstream.   If you have 
> personal work in there then you could try to fetch your work branch into 
> the newly created repository.  The latest git version could help with 
> the extraction of non-corrupted objects out of a bad pack, but if the 
> objects you are interested in are themselves corrupted then your only 
> hope is to have a copy of those objects somewhere else.

Nicolas,

Thanks for your help. I will consider migrating to a brand new git tree 
with my work imported in (it seems that my local work is not affected).

Just to know, as the object I try to access is not present, is there a 
way to rebuild the index to match this mater of fact ?

Regards,
-- 
Nicolas Ferre
