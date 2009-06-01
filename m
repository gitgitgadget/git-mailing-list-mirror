From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: "exclude" and ".gitignore" for everyone
Date: Mon, 1 Jun 2009 09:58:11 -0400
Message-ID: <E6F58E6B-4ECF-4A55-9249-9A8BBFBDBC24@silverinsanity.com>
References: <h00m32$gs0$2@ger.gmane.org>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nikos Chantziaras <realnc@arcor.de>
X-From: git-owner@vger.kernel.org Mon Jun 01 15:58:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MB81s-0006QZ-Jf
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 15:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbZFAN6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 09:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbZFAN6M
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 09:58:12 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:49184 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbZFAN6L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 09:58:11 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id B3F131FFC07C; Mon,  1 Jun 2009 13:58:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	SUBJECT_FUZZY_TION autolearn=no version=3.2.5
Received: from [192.168.5.44] (nmd.sbx07360.rocheny.wayport.net [98.98.50.102])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id CCFC61FFC07A;
	Mon,  1 Jun 2009 13:58:09 +0000 (UTC)
In-Reply-To: <h00m32$gs0$2@ger.gmane.org>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120470>


On Jun 1, 2009, at 9:46 AM, Nikos Chantziaras wrote:

> I'm a first-time Git user.  I found out how to ignore files with  
> Git. For example I've put "*.[oa]" and "*~" in ./git/info/exclude.   
> However, the rest of the persons doing commits in the public  
> repository might not have those entries.  Is everyone required to  
> put those entries in "exclude" themselves or does Git allow for  
> those to be automatically added next time they do a "git pull"?

If you commit a .gitignore, it will be used by everyone.  .git/info/ 
exclude is for your personal excludes.  Generally, I'd suggest putting  
build products in .gitignore and your editor's garbage in exclude.   
For example:

project/.gitignore:
-------------------
*.o
*.a
random.tmp

project/.git/info/exclude:
--------------------------
.*.swp
*~
/my-todo.txt

If you add and commit the .gitignore file it will be picked up by  
everyone, while whatever backups, temp files, notes, or whatever you  
use can be kept private in your exclude file.

~~ Brian
