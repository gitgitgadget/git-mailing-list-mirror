From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] git-tag: Document that -m/-F create tag objects, too
Date: Mon, 9 Apr 2007 17:15:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704091641290.1420@beast.quantumfyre.co.uk>
References: <E1Hash0-0004rN-Mu@mid.deneb.enyo.de>
 <Pine.LNX.4.64.0704091554330.32490@beast.quantumfyre.co.uk>
 <87y7l11s5m.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Mon Apr 09 18:19:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HawX3-0000hB-3D
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 18:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966130AbXDIQPQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 12:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966135AbXDIQPQ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 12:15:16 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:39185 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966130AbXDIQPN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Apr 2007 12:15:13 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id E15B2C60EF
	for <git@vger.kernel.org>; Mon,  9 Apr 2007 17:15:11 +0100 (BST)
Received: (qmail 2115 invoked by uid 103); 9 Apr 2007 17:14:51 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90/3050. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.032785 secs); 09 Apr 2007 16:14:51 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 9 Apr 2007 17:14:51 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <87y7l11s5m.fsf@mid.deneb.enyo.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44055>

On Mon, 9 Apr 2007, Florian Weimer wrote:

> * Julian Phillips:
>
>> On Mon, 9 Apr 2007, Florian Weimer wrote:
>>
>>> And warn about the fact that lightweight tags are not normally
>>> transferred by clone/fetch.
>>
>> Um ... yes, they are (in v1.5.1 at least).
>
> Hmm.  This has to be a fairly recent change, see:
>
> <http://article.gmane.org/gmane.linux.kernel/513438>
>

It's not that recent a change.  I have been cloning and fetching my 
tag-references for some time (being too lazy to use full tags for my 
one-man projects).  Certainly since v1.4.4 days ...

Fetch doesn't care whether a tag is a full tag or merely a reference, it 
will automatically fetch them both in the same way (not sure about clone). 
It checks that the reference points at an object, but not that the object 
is a tag rather than a commit.  This behaviour hasn't changed since the 
auto tag-following code was added (AFAIK).  Any difference between the 
treatment of tags and tag-references is a subtle consequence of the former 
adding an object I expect.

In the case of the v2.6.21-rc6 tag-reference anyone who did a clone or 
fetch and may have got the tag-reference provided that they didn't already 
have the commit it referenced?  I'm not 100% sure of the behaviour here, I 
haven't quite got to tag following in my C rewrite (I should be doing it 
later today).

-- 
Julian

  ---
Never call a man a fool.  Borrow from him.
