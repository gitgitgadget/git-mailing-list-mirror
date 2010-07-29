From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: [PATCH] filter-branch tests/docs: avoid \t in sed regexes
Date: Thu, 29 Jul 2010 16:47:52 +0200
Message-ID: <4C519498.3000702@dbservice.com>
References: <AANLkTin5sv8NQ_8NZkQpW9HG4zYZDZHNF80EWK8Km4Mr@mail.gmail.com> <0bb511ca2d155ea7e37850a78375da1803032d6c.1280409717.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Adam Mercer <ramercer@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jul 29 16:48:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeUPB-0006BC-93
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 16:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757657Ab0G2OsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 10:48:12 -0400
Received: from office.neopsis.com ([78.46.209.98]:57836 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754303Ab0G2OsL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 10:48:11 -0400
X-Spam-Status: No, hits=0.0 required=5.0
	tests=AWL: 0.068,BAYES_00: -1.665,TOTAL_SCORE: -1.597,autolearn=ham
X-Spam-Level: 
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Thu, 29 Jul 2010 16:47:54 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.7) Gecko/20100713 Thunderbird/3.1.1
In-Reply-To: <0bb511ca2d155ea7e37850a78375da1803032d6c.1280409717.git.trast@student.ethz.ch>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152177>

On 7/29/10 3:24 PM, Thomas Rast wrote:
> Using \t to represent a tab character is not portable beyond GNU sed
> (see e.g. GNU sed's info pages).  Use printf to generate the tab
> instead.
> 
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
> 
>  Adam Mercer wrote:
>>> What OS is this?
>> This was on Mac OS X 10.6. Where sed is BSD sed.
> 
> That's very funny however, since it means that nobody should ever have
> had a successful test run on OS X with the preinstalled tools.  What
> gives?

v1.7.2-rc1 on 10.6:

fixed   3
success 6328
failed  0
broken  21
total   6355

*** t7003-filter-branch.sh ***
*   ok 1: setup
*   ok 2: rewrite identically
*   ok 3: result is really identical
*   ok 4: rewrite bare repository identically
*   ok 5: result is really identical
*   ok 6: correct GIT_DIR while using -d
*   ok 7: Fail if commit filter fails
*   ok 8: rewrite, renaming a specific file
*   ok 9: test that the file was renamed
*   ok 10: rewrite, renaming a specific directory
*   ok 11: test that the directory was renamed
*   ok 12: rewrite one branch, keeping a side branch
*   ok 13: common ancestor is still common (unchanged)
*   ok 14: filter subdirectory only
*   ok 15: subdirectory filter result looks okay
*   ok 16: more setup
*   ok 17: use index-filter to move into a subdirectory
*   ok 18: stops when msg filter fails
*   ok 19: author information is preserved
*   ok 20: remove a certain author's commits
*   ok 21: barf on invalid name
*   ok 22: "map" works in commit filter
*   ok 23: Name needing quotes
*   ok 24: Subdirectory filter with disappearing trees
*   ok 25: Tag name filtering retains tag message
*   ok 26: Tag name filtering strips gpg signature
*   ok 27: Tag name filtering allows slashes in tag names
*   ok 28: Prune empty commits
*   ok 29: --remap-to-ancestor with filename filters
*   ok 30: setup submodule
*   ok 31: rewrite submodule with another content
*   ok 32: replace submodule revision
