From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Another way to compare tools: is it possible to transfer full
 history?
Date: Tue, 28 Sep 2010 16:53:29 +0200
Message-ID: <4CA20169.2040606@dbservice.com>
References: <loom.20100928T153519-936@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tuomo <tuo.tie@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 16:53:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0bZ0-0007Bq-6y
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 16:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756522Ab0I1Oxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 10:53:43 -0400
Received: from office.neopsis.com ([78.46.209.98]:58296 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756335Ab0I1Oxm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 10:53:42 -0400
X-Spam-Status: No, hits=0.0 required=5.0
	tests=BAYES_00: -1.665,TOTAL_SCORE: -1.665,autolearn=ham
X-Spam-Level: 
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Tue, 28 Sep 2010 16:53:31 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <loom.20100928T153519-936@post.gmane.org>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157430>

On 9/28/10 3:44 PM, Tuomo wrote:
> I have seen lots of comparisons between source control tools, 
> but have not found a comparison that would explain the fundamental differences 
> and similarities in a way that would really let me choose. 
> So I decided to try a new approach: if one tries to transfer the full history 
> of an application or a larger product/project, which features can I rely on 
> finding in any decently recent tool?
> 
> Let's start from Git vs. Mercurial: is it possible to move the whole history 
> of an application (with or without submodules) from Git to Mercurial? 
> From Mercurial to Git? 

fast-import/export (man git-fast-export/import) seems to be the future.
Git provides excellent support for it and other SCMs are adopting it as
well. And then there are custom written conversion tools, just take a
look at [1] to see which ones are available.

(shameless plug: just this weekend I started collecting the various fast
import/export tools and made a webpage about it:
http://caurea.org/fast-export-import/. It's far from complete though.
And if you know any tools that perform better than those I've listed,
I'd be glade to update the page).

> If it is not always possible, what is the feature that might completely 
> prevent the whole attempt? If partial transfer is possible, what information 
> might be missing in the result?

Not all SCMs have the same features. Subversion for example doesn't have
real branches, tags nor merges (in the same sense that Git does). And
even in distributed version control systems there can be differences.
Git history can't be mapped 1:1 to Mercurial (octopus merges come to
mind). Some of these things can be reasonably emulated, some can't and
you loose that information.

tom

[1]
https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools#Interaction_with_other_Revision_Control_Systems
