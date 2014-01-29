From: Armin Ronacher <armin.ronacher@active-4.com>
Subject: git clone on out-of-space device causes incorrect errors
Date: Wed, 29 Jan 2014 12:48:30 +0000
Message-ID: <52E8F89E.6090801@active-4.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 29 13:56:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8Ugo-0005Og-T5
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jan 2014 13:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbaA2M4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 07:56:18 -0500
Received: from ayreal.srv.pocoo.org ([78.46.64.175]:59199 "EHLO
	ayreal.srv.pocoo.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086AbaA2M4S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jan 2014 07:56:18 -0500
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Jan 2014 07:56:18 EST
Received: from minint-2aangor.splashdamage.local (unknown [194.74.244.130])
	by ayreal.srv.pocoo.org (Postfix) with ESMTPSA id 896C92A1C057
	for <git@vger.kernel.org>; Wed, 29 Jan 2014 12:48:30 +0000 (UTC)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241206>

Hi,

When cloning onto a device that is out of space to fulfill the whole clone 
operation, git will report that the remove repository does not exist:

$ git clone https://github.com/mozilla/flask
Cloning into 'flask'...
remote: Repository not found.
fatal: repository 'https://github.com/mozilla/flask/' not found

This error is misleading.  As an example here is what hg does for the same 
situation:

$ hg clone https://bitbucket.org/dholth/wheel
destination directory: wheel
requesting all changes
adding changesets
adding manifests
adding file changes
transaction abort!
failed to truncate 00changelog.i
rollback failed - please run hg recover
abort: No space left on device: /Volumes/Disk Image/wheel/.hg/store/.fncache-bt6dzr


Regards,
Armin
