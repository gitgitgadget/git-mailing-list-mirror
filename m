From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 1/2] Handle core.symlinks=false case in merge-recursive.
Date: Sat, 3 Mar 2007 21:21:59 +0100
Message-ID: <200703032121.59468.johannes.sixt@telecom.at>
References: <200703032032.47158.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 21:24:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNamI-0007Xr-L9
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 21:24:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbXCCUYX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 15:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbXCCUYX
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 15:24:23 -0500
Received: from smtp5.srv.eunet.at ([193.154.160.227]:56650 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932229AbXCCUYX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 15:24:23 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id 77D2013C49F
	for <git@vger.kernel.org>; Sat,  3 Mar 2007 21:22:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id BA61A3B47A
	for <git@vger.kernel.org>; Sat,  3 Mar 2007 21:21:59 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <200703032032.47158.johannes.sixt@telecom.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41322>

On Saturday 03 March 2007 20:32, Johannes Sixt wrote:
> If the file system does not support symbolic links (core.symlinks=false),
> merge-recursive must write the merged symbolic link text into a regular
> file.

But how to resolve such a conflict if core.symlinks=false?

It turns out that git-add cannot honor the symlink property recorded in the 
index because read_cache.c:add_file_to_index() will find only entries at 
stage 0, but the conflicting entries are at stages 2 and 3. Can there be 
something done about that?

-- Hannes
