From: Kevin <compufreak@gmail.com>
Subject: Re: Git commit error: fatal: Repository has been updated, but unable
 to write new_index file.
Date: Tue, 27 Mar 2012 10:36:25 +0200
Message-ID: <20120327083625.GA4159@ikke-laptop.buyways.nl>
References: <34E530A4-A792-42AC-8C19-5F7CB71FA46C@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 10:36:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCRtP-0004oW-SQ
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 10:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755400Ab2C0Igd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 04:36:33 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:52417 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754777Ab2C0Iga (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 04:36:30 -0400
Received: by eekc41 with SMTP id c41so1766724eek.19
        for <git@vger.kernel.org>; Tue, 27 Mar 2012 01:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8n1F0KOxnWqV522OxQ4fu6BclqBGI716bvG6Qzb68co=;
        b=yEYL+3KlK/N4ryfDP06AW8pTPxLzP5ivv+wITiwXvhsdulvohcTe5peTWVsOPGV/FW
         BlTTTSKPE3Fkc4+FcMj7GERvSLYDWMkN733IPCXNNDG07Ud84moeqpTNNM+fCQKkoIKz
         pUqCWCKgimmo1ePDTAGbCD/qQmhLP8lZ3UwvqKiBLZwFZlVHXwSQnFvrFzz/vPekmXw6
         ckuq8Zjqj8Z6aAOslNzU/Yw0JAMbP/D78Wi3DzaJlNiRhDfATHlU1fCsgsTkr81IbOoF
         Sw5PYVSt4RfeYeLGC0d5WJG8n6uuCu8xnHi3JsMtqGA05M06i6qlB+G4u6dtW+AM8GdG
         MDyg==
Received: by 10.14.185.143 with SMTP id u15mr3309179eem.94.1332837389758;
        Tue, 27 Mar 2012 01:36:29 -0700 (PDT)
Received: from localhost (D4B2749A.static.ziggozakelijk.nl. [212.178.116.154])
        by mx.google.com with ESMTPS id p57sm67071132eei.8.2012.03.27.01.36.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Mar 2012 01:36:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <34E530A4-A792-42AC-8C19-5F7CB71FA46C@jetbrains.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194032>

This might look like some kind of race condition where multiple commands
are executed at the same time, causing the lock file to be hold.

Could you check if something like that is happening somewhere?

On Tue, Mar 27, 2012 at 11:35:08AM +0400, Kirill Likhodedov wrote:
> 
> Reposting, since there were no replies - probably, the message was missed.
> I would appreciate help in understanding what the Git error could be cause by.
> Thanks!
> 
> -------
> 
> Hello,
> 
> I'm developing a Git integration with an IDE. Several users of the program report the following error which was returned by Git during commit:
> 
> fatal: Repository has been updated, but unable to write
> new_index file. Check that disk is not full or quota is
> not exceeded, and then "git reset HEAD" to recover.
> 
> Here is the command which IDE executes to make a commit: 
> 
> # git commit --only -F <message file> -- <several files chosen to commit>
> 
> The interesting thing is that commit was actually successful, i.e. all files are committed, git status reports correctly, no other mistakes were noticed by users.
> Here is the bugreport with some more details: http://youtrack.jetbrains.com/issue/IDEA-82108
> One of the users says, that the situation happens quite often.
> 
> Users say that the thing has never happened with them while they were using Tortoise Git, so I'm pretty sure, that it is my bug caused my some misusage of Git (although I asked users to perform more experiments).
> 
> Unfortunately, I didn't find any information about the possible cause of this error.
> 
> Could you please help me to figure out why it can happen? What situation can lead to this error?
> 
> Thanks a lot.
> 
> ----------------------------------
> Kirill Likhodedov
> JetBrains, Inc
> http://www.jetbrains.com
> "Develop with pleasure!"
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
