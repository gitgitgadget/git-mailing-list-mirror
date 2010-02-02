From: D Herring <dherring@tentpost.com>
Subject: working directory umask
Date: Tue, 02 Feb 2010 01:30:32 -0500
Message-ID: <hk8gq7$o76$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 07:31:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcCId-0002Mb-LU
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 07:31:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557Ab0BBGa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 01:30:57 -0500
Received: from lo.gmane.org ([80.91.229.12]:51471 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168Ab0BBGa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 01:30:56 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NcCHl-0001za-W3
	for git@vger.kernel.org; Tue, 02 Feb 2010 07:30:53 +0100
Received: from c-71-232-15-233.hsd1.ma.comcast.net ([71.232.15.233])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 07:30:53 +0100
Received: from dherring by c-71-232-15-233.hsd1.ma.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 07:30:53 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c-71-232-15-233.hsd1.ma.comcast.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100121 Thunderbird/3.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138685>

Hi all,

So for one project at work, we have a (slow) server with a common 
build area.  Standard practice has been to extract a tarball, 
configure, make, make install into a common area.  I have started 
using git to replace the tarballs -- keep version info, make doesn't 
have to rebuild everything, auto-tag install sources, etc.

One problem:  Even though the working directory is g+swx and git was 
initialized with --shared=group or --shared=0660, the checked out 
source files still don't have group write permissions...

Is there an option that I've overlooked?  I can't seem to find 
anything that overrides umask in the working directory, only in the repo.

Thanks,
Daniel
