From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 0/2] RUNTIME_PREFIX enhancements
Date: Wed, 18 Feb 2009 23:52:19 +0100
Message-ID: <499C9123.2070104@kdbg.org>
References: <cover.1234969572u.git.johannes.schindelin@gmx.de> <499C63C2.3050405@kdbg.org> <alpine.DEB.1.00.0902182208070.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 18 23:54:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZvJh-0006ia-1D
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 23:54:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760936AbZBRWw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 17:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760929AbZBRWw1
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 17:52:27 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:29826 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759551AbZBRWw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 17:52:26 -0500
Received: from [77.117.243.175] (77.117.243.175.wireless.dyn.drei.com [77.117.243.175])
	by bsmtp.bon.at (Postfix) with ESMTP id 53D35CDF82;
	Wed, 18 Feb 2009 23:52:23 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <alpine.DEB.1.00.0902182208070.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110589>

Johannes Schindelin schrieb:
> On Wed, 18 Feb 2009, Johannes Sixt wrote:
>> This only silences the warning, but there is no guarantee that the 
>> resulting git suite works because your msysgit developer may not have 
>> installed stuff in C:\msysgit\libexec\git-core, yet.
> 
> The good thing: it still works.  Why?  Because Git actually does _not_ 
> search the Git binaries in libexec/git-core.  It adds that directory to 
> PATH and lets the PATH lookup handle the searching.  So it kind of works, 
> but in a different manner than you think it works.

I see why it works: Because we add argv0_path to PATH. I had forgotten 
about this fact. It comes after git_exec_path(), and so we pick up the 
binaries and shell scripts from the build directory if there is nothing 
in $prefix/libexec/git-core.

It's sad that your patch requires the source to live in a directory 
named 'git'. But I don't know how to do it better. :-(

-- Hannes
