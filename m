From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Make git prune remove temporary packs that look like write
 failures
Date: Tue, 05 Feb 2008 14:02:26 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802051357420.2732@xanadu.home>
References: <Pine.GSO.4.63.0802051844220.15867@suma3>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: David Steven Tweed <d.s.tweed@reading.ac.uk>
X-From: git-owner@vger.kernel.org Tue Feb 05 20:04:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMT5E-0007nS-7c
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 20:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759672AbYBETCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 14:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760016AbYBETCa
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 14:02:30 -0500
Received: from relais.videotron.ca ([24.201.245.36]:34857 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759672AbYBETC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 14:02:28 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JVS003K54W2S3H0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 05 Feb 2008 14:02:27 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <Pine.GSO.4.63.0802051844220.15867@suma3>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72679>

On Tue, 5 Feb 2008, David Steven Tweed wrote:

> @@ -115,5 +139,6 @@ int cmd_prune(int argc, const char **argv, const char
> *prefix)
> 
>  	sync();
>  	prune_packed_objects(show_only);
> +	remove_temporary_files();

Maybe you could implement the "show_only" mode for 
remove_temporary_files() as well?  Otherwise the -n option would not be 
respected.

Also you should consider honoring the --expire option as well.


Nicolas
