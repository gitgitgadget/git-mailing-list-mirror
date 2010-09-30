From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: wierd git show syntax
Date: Thu, 30 Sep 2010 10:46:53 +0200
Message-ID: <4CA44E7D.7090901@dbservice.com>
References: <AANLkTi=Zz-1dSC0imJ3NZXWcdvhXWXt-Kk94zwKe8+6Y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: geoffrey.russell@gmail.com
X-From: git-owner@vger.kernel.org Thu Sep 30 10:47:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1EnI-0005ft-5l
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 10:47:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188Ab0I3IrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 04:47:00 -0400
Received: from office.neopsis.com ([78.46.209.98]:41368 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802Ab0I3Iq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 04:46:59 -0400
X-Spam-Status: No, hits=0.0 required=5.0
	tests=AWL: -0.000,BAYES_00: -1.665,TOTAL_SCORE: -1.665,autolearn=ham
X-Spam-Level: 
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Thu, 30 Sep 2010 10:46:55 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <AANLkTi=Zz-1dSC0imJ3NZXWcdvhXWXt-Kk94zwKe8+6Y@mail.gmail.com>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157634>

On 9/30/10 7:02 AM, Geoff Russell wrote:
> Hi,
> 
> $ git show XXXX:data/path/object.c

Show me the contents of the file at data/path/object.c in revision XXXX.

> Gives me what I want, a cat of the objects contents. However
> for some files I get a message about ambiguous argument telling me to
> separate paths from revisions with '--'. Okay so I try that:
> 
> $ git show -- XXXX:data/path/object.c

Show me the commit HEAD but limit the diff to the path
XXXX:data/path/object.c.

There is an implicit HEAD before the double dash. You probably want the
double dash *after* the object, to force git to parse that string as an
object and not a path:

$ git show XXXX:data/path/object.c --

> But it gives me nothing
> 
> $ git show XXXX -- data/path/object.c

Show me the commit XXXX but limit the diff to the path data/path/object.c.

> Gives me a git diff output for the object.
> 
> 
> This is all with git 1.6.2.3
> 
> What's happening here? Why aren't all these equivalent?

no.

tom
