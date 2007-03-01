From: James Ketrenos <jketreno@linux.intel.com>
Subject: Re: bug report, error : Unable to find 000000000.....
Date: Thu, 01 Mar 2007 04:53:49 -0800
Message-ID: <45E6CCDD.2090502@linux.intel.com>
References: <BAY120-W200B9984A9E70409399666AE810@phx.gbl>	<slrneubrsd.2pm.siprbaum@xp.machine.xx> <7v8xei0xwk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>,
	git@vger.kernel.org, Jeremy Sw <kertejeremy@hotmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 01 19:39:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMqBF-0002Xl-PV
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 19:39:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965493AbXCASjE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 13:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965496AbXCASjE
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 13:39:04 -0500
Received: from mga06.intel.com ([134.134.136.21]:11484 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965493AbXCASjD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 13:39:03 -0500
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP; 01 Mar 2007 10:38:57 -0800
Received: from logicsbox.jf.intel.com (HELO [127.0.0.1]) ([10.23.61.118])
  by orsmga001.jf.intel.com with ESMTP; 01 Mar 2007 10:38:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: i="4.14,237,1170662400"; 
   d="scan'208"; a="202917937:sNHT18578686"
User-Agent: Thunderbird 1.5.0.7 (X11/20061205)
In-Reply-To: <7v8xei0xwk.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41114>

Junio C Hamano wrote:

> The repository is seriously broken.  If you try wget to see
> refs/tags/* files, you will find out that they are not even
> tags; they are symrefs and both point at the master branch.
> 
> I do not think the Porcelain-ish shipped with git creates symref
> in refs/tags/, so it was done by somebody playing with symbolic-ref
> by hand perhaps?
> 
> I'd suggest James to do delete these bogus refs/tags/* files and
> tag the correct commit with "git tag".

The above does explain the breakage.  The script that created snapshot 
tarballs for ipwraw was written was copying .git/HEAD to the tag name in 
.git/refs/tags... at some point .git/HEAD changed from being an actual 
symlink to master to being a normal file containing 'ref: refs/heads/master'

I believe I have fixed it now.

Thanks,
James
