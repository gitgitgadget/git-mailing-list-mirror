From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Another question about importing SVN with fast-import
Date: Mon, 6 Aug 2007 14:13:57 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708061408470.18641@reaper.quantumfyre.co.uk>
References: <Pine.LNX.4.64.0707162204480.14971@reaper.quantumfyre.co.uk>
 <20070717033840.GK32566@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 06 15:14:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1II2PV-0007Dq-N0
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 15:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763801AbXHFNOA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 09:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763455AbXHFNOA
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 09:14:00 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:40039 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763645AbXHFNN7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Aug 2007 09:13:59 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 3E358B8D7E
	for <git@vger.kernel.org>; Mon,  6 Aug 2007 14:13:58 +0100 (BST)
Received: (qmail 26031 invoked by uid 103); 6 Aug 2007 14:13:57 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3869. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.031803 secs); 06 Aug 2007 13:13:57 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 6 Aug 2007 14:13:57 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <20070717033840.GK32566@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55144>

On Mon, 16 Jul 2007, Shawn O. Pearce wrote:

> Julian Phillips <julian@quantumfyre.co.uk> wrote:
>> However, how do you copy a file from a
>> particular revision?
>
> and sometimes not so much.  You can't do that right now.  I've wanted
> to open up the data subcommand to allow another form that lets you
> specify data from a branch and file path (thus selecting a blob
> from another revision) but I haven't gotten around to it.  I also
> don't have time to do it during the earlier part of this week.
> Maybe I'll get to it later near the end of the week.

I was wondering if this was still a vague todo item, or if it was being 
worked on?  It really is the biggest thing blocking my import at the 
moment and I'm willing to have a bash at it myself, but I didn't want to 
start messing around inside the fast-import code if someone else was 
already there ...

>
> It shouldn't be too difficult now with the tree_content_get()
> function that I recently defined for the C/R commands.  The SHA-1
> comes back in the tree_entry leaf, but that codepath is only valid
> for the tip of a branch that fast-import knows about in memory.
> If it doesn't then you probably need to fallback into raw tree
> parsing.  Ugh.
>
> The way prior frontends have handled this is they assigned marks
> to every blob, and then had a translation table within the frontend
> of revision->mark, so that anytime it needed a given revision of a
> file it knew what mark to send to fast-import.  This does require
> that the frontend maintain basically everything...

Not sure how that would apply to trees ... and I would rather minimise the 
amount of state retained in the frontend.

-- 
Julian

  ---
Disco is to music what Etch-A-Sketch is to art.
