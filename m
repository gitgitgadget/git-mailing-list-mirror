From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: wierd git show syntax
Date: Thu, 30 Sep 2010 11:02:07 +0200
Message-ID: <4CA4520F.30809@dbservice.com>
References: <AANLkTi=Zz-1dSC0imJ3NZXWcdvhXWXt-Kk94zwKe8+6Y@mail.gmail.com> <4CA44E7D.7090901@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: geoffrey.russell@gmail.com
X-From: git-owner@vger.kernel.org Thu Sep 30 11:02:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1F1u-0001il-9a
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 11:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754941Ab0I3JCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 05:02:12 -0400
Received: from office.neopsis.com ([78.46.209.98]:39135 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565Ab0I3JCM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 05:02:12 -0400
X-Spam-Status: No, hits=0.0 required=5.0
	tests=BAYES_00: -1.665,TOTAL_SCORE: -1.665,autolearn=ham
X-Spam-Level: 
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Thu, 30 Sep 2010 11:02:08 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <4CA44E7D.7090901@dbservice.com>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157635>

On 9/30/10 10:46 AM, Tomas Carnecky wrote:
>> What's happening here? Why aren't all these equivalent?
> 
> no.

A 'no' does not really fit a 'why?' question. I should explain.

Someone (Linus?) long ago decided that the revision parsing work that
way. It's pretty powerful, even the smallest colon and double dash have
a meaning. But it can be complicated for someone new to git to
understand. See 'man gitrevisions' to understand how git parses
revisions. Sadly the effect of double bash is not described in the
git-show man page. But in most commands it's used to separate revisions
from paths. Example: if you have a file and branch both named master,
'git log master --' will show you the log of that branch while 'git log
-- master' will show you the log of HEAD but limit it to commits which
touched the file master. Again, there's an implicit HEAD before the
double dash.

tom
