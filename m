From: Gioele Barabucci <gioele@svario.it>
Subject: Merge driver not called for locally modified files?
Date: Sat, 2 Apr 2016 16:14:21 +0200
Message-ID: <56FFD3BD.1060002@svario.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 02 16:21:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amMQM-00015X-SF
	for gcvg-git-2@plane.gmane.org; Sat, 02 Apr 2016 16:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbcDBOVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2016 10:21:07 -0400
Received: from camelia.svario.it ([164.138.26.129]:40885 "EHLO mail.svario.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767AbcDBOVG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2016 10:21:06 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Apr 2016 10:21:06 EDT
Received: from [192.168.14.101] (x4db63fad.dyn.telefonica.de [77.182.63.173])
	by mail.svario.it (Postfix) with ESMTPSA id 6782D22B30
	for <git@vger.kernel.org>; Sat,  2 Apr 2016 14:14:23 +0000 (UTC)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290590>

Hello,

it seems to me that merge drivers are not called while merging commits
that touch locally modified (but uncommited) files. Is this correct?

I made a (simple) merge driver for files in the `pw` format. [1] This
driver works correctly when a file is modified by multiple commits.
However, if a file has only been modified locally (and not committed),
then merging a commit that modifies the same file raises the following
error:

    $ git merge --ff-only 78d4f09
    Updating 5180202..78d4f09
    error: Your local changes to the following files would
    be overwritten by merge:
	.local/share/pw/passwords
    Please, commit your changes or stash them before you can merge.
    Aborting

>From my experiments, it looks like the merge driver is not called at all.

Is it possible to configure git so that the merge driver is called also
while merging locally modified files?

Regards,

[1] https://github.com/gioele/pw/blob/master/bin/git-pw-merge

-- 
Gioele Barabucci <gioele@svario.it>
