From: david@lang.hm
Subject: Re: large(25G) repository in git
Date: Tue, 24 Mar 2009 11:33:07 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0903241130240.16753@asgard.lang.hm>
References: <49C7FAB3.7080301@brainfood.com> <alpine.LFD.2.00.0903232056520.26337@xanadu.home> <49C91F87.3050105@brainfood.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Adam Heath <doogie@brainfood.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 19:35:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmBT0-0007qO-1G
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 19:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318AbZCXSdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 14:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752304AbZCXSdq
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 14:33:46 -0400
Received: from mail.lang.hm ([64.81.33.126]:58969 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751897AbZCXSdq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 14:33:46 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n2OIX7fQ021647;
	Tue, 24 Mar 2009 10:33:07 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <49C91F87.3050105@brainfood.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114477>

On Tue, 24 Mar 2009, Adam Heath wrote:

> Nicolas Pitre wrote:
>
>> Strange.  You could instruct ssh to keep the connection up with the
>> ServerAliveInterval option (see the ssh_config man page).
>
> Sure, could do that.  Already have a separate ssh config entry for
> this host.  But why should a connection be kept open for that long?
> Why not close and re-open?

what if the server you are connecting to is behind a load balancer? how do 
you know that your new connection will go to the same server? if the 
client never reconnects, how long should the server keep it's resources 
tied up 'just in case'. if something connects to the server, how does it 
know if it's something reconnecting or connecting for the first time? (or 
someone connecting with the intent of messing up someone else's fetch)

having the client reconnect to finish a single transaction starts getting 
_really_ ugly.

David Lang
