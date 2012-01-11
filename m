From: "Andreas T.Auer" <andreas.t.auer_gtml_37453@ursus.ath.cx>
Subject: Re: rsync a *bunch* of git repos
Date: Wed, 11 Jan 2012 09:01:39 +0100
Message-ID: <4F0D41E3.5020908@ursus.ath.cx>
References: <20120110211548.GD10255@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jason <git@lakedaemon.net>
X-From: git-owner@vger.kernel.org Wed Jan 11 09:09:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RktFe-0002JL-Kf
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 09:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756657Ab2AKIJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 03:09:37 -0500
Received: from brln-4dba5aac.pool.mediaWays.net ([77.186.90.172]:11816 "EHLO
	here" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756117Ab2AKIJg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 03:09:36 -0500
X-Greylist: delayed 478 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Jan 2012 03:09:36 EST
Received: from [192.168.0.14] (unknown [192.168.0.14])
	by here (Postfix) with ESMTP id 006561B05FA;
	Wed, 11 Jan 2012 09:01:36 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20111110 Icedove/3.0.11
In-Reply-To: <20120110211548.GD10255@titan.lakedaemon.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188341>

On 10.01.2012 22:15 Jason wrote:
> The nuts and bolts of this aren't difficult, the problem is I don't have
> a complete understanding of how git stores data.  I've heard in the
> past that it uses a lot of hardlinks and softlinks.  I need to make
> sure, that once I transfer the data, and reboot the machine with the new
> partition mounted under /home, that all my git repos will be okay.
>
>    
As far as I know git uses hardlinks to save diskspace, but it doesn't 
rely on hardlinks to work. It also works with filesystems that don't 
support hardlinks.
But without hardlinks you will probably waste disk space so I recommend 
the -H parameter to rsync, which preserve hardlinks, if possible. If you 
have hundreds of git repos that are cloned from each other, than this 
should make a difference.
