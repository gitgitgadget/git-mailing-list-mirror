From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Another question about importing SVN with fast-import
Date: Fri, 20 Jul 2007 06:50:31 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707200646400.18125@beast.quantumfyre.co.uk>
References: <Pine.LNX.4.64.0707162204480.14971@reaper.quantumfyre.co.uk>
 <7154c5c60707190009r6d460debs71158d4db9a028d4@mail.gmail.com>
 <20070720051142.GO32566@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: David Frech <david@nimblemachines.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 20 07:50:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBlNt-0007wO-On
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 07:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbXGTFue (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 01:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbXGTFue
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 01:50:34 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:33405 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750765AbXGTFud (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jul 2007 01:50:33 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id D838DD75E1
	for <git@vger.kernel.org>; Fri, 20 Jul 2007 06:50:31 +0100 (BST)
Received: (qmail 26400 invoked by uid 103); 20 Jul 2007 06:50:31 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3701. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.0325 secs); 20 Jul 2007 05:50:31 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 20 Jul 2007 06:50:31 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <20070720051142.GO32566@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53056>

On Fri, 20 Jul 2007, Shawn O. Pearce wrote:

> David Frech <david@nimblemachines.com> wrote:
>> On 7/16/07, Julian Phillips <julian@quantumfyre.co.uk> wrote:
>>> Now the question.  Shawn recently added C and R operations - almost as
>>> soon as they were asked for too.  However, how do you copy a file from a
>>> particular revision?
>>
>> I have to second Julian's question.
>
> I'm getting to it.  Maybe this weekend.  Right now I have git-gui
> work to finish, and that work is more important to me this week than
> fast-import is.  Not that fast-import isn't important to me either,
> its just the way things are this week.

No complaints from me - git-gui is one of the reasons I want to be able to 
use fast-import ;)

>> The comment/question is: how different is this, really, from being
>> able to  specify a "from" line in a commit? In both cases I'm asking
>> fast-import to reach into its memory (or the repo) and pull out a
>> tree, and to add (some or all of it) to my current branch. Isn't the
>> kind of generic C command that Julian and I are asking for the same
>> thing, only instead of taking the whole tree (from the specified
>> commit) it takes a single file or directory?
>
> It is possible.  I'm just not sure what the syntax for it should be.
> Suggestions?  I really want to stay backwards compatible with the
> current "C" command, so:
>
> 	'C' SP commit SP path SP path
>
> is out because its ambiguous with the current meaning where the
> second (destination) path can contain SP without being quoted by
> the frontend.

You could always make it part of the 'M' command?

'M' sp mode sp 'copy' sp path_str lf (ref_str | hexsha1 | sha1exp_str | 
idnum) SP path_str;

Or just make it a new command, O (for other) or E (for existing) maybe? :S

-- 
Julian

  ---
It is easier to change the specification to fit the program than vice versa.
