From: Rogan Dawes <discard@dawes.za.net>
Subject: Re: [PATCH] Show binary file size change in diff --stat
Date: Wed, 28 Feb 2007 20:58:31 +0200
Message-ID: <45E5D0D7.5070305@dawes.za.net>
References: <200702281303.11951.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 19:59:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMU1n-00008w-8F
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 19:59:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbXB1S7t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 13:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbXB1S7s
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 13:59:48 -0500
Received: from sumo.dreamhost.com ([66.33.216.29]:53293 "EHLO
	sumo.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932326AbXB1S7s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 13:59:48 -0500
Received: from spunkymail-a15.dreamhost.com (sd-green-bigip-74.dreamhost.com [208.97.132.74])
	by sumo.dreamhost.com (Postfix) with ESMTP id 347D818642B
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 10:59:47 -0800 (PST)
Received: from [192.168.201.100] (dsl-146-24-85.telkomadsl.co.za [165.146.24.85])
	by spunkymail-a15.dreamhost.com (Postfix) with ESMTP id F1D487F085
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 10:58:34 -0800 (PST)
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
In-Reply-To: <200702281303.11951.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40989>

Andy Parkins wrote:
> Previously, a binary file in the diffstat would show as:
> 
>  some-binary-file.bin       |  Bin
> 
> The space after the "Bin" was never used.  This patch changes binary
> lines in the diffstat to be:
> 
>  some-binary-file.bin       |  Bin +123456B -12345B
> 
> The "+" item is the size of the new version, the "-" item is the size of
> the old version.  If a size is 0 it's not shown (although it would
> probably be better to treat no-file differently from zero-byte-file).
> 
> The "B" (for bytes) is shown to highlight the fact that these numbers
> are not "number of lines", but actual bytes.
> 
> The user can see what changed in the binary file, and how big the new
> file is.  This is in keeping with the information in the rest of the
> diffstat.
> 
> The diffstat_t members "added" and "deleted" were unused when the file
> was binary, so this patch loads them with the file sizes in
> builtin_diffstat().  These figures are then read in show_stats() when
> the file is marked binary.

How about showing the size of the changes between the 2 files via the 
libxdiff binary patch function?

It would probably not be that difficult to generate a binary patch, and 
then derive some stats from it.

Rogan
