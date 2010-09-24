From: Gustavo Narea <gnarea@tech.2degreesnetwork.com>
Subject: Multiple checkouts active for the same repository
Date: Fri, 24 Sep 2010 10:29:47 +0100
Organization: 2degrees Limited
Message-ID: <4C9C6F8B.3090806@tech.2degreesnetwork.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 24 11:30:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz4bQ-0003ZB-HN
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 11:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081Ab0IXJ3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 05:29:50 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64542 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932075Ab0IXJ3u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 05:29:50 -0400
Received: by wyb28 with SMTP id 28so1719847wyb.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 02:29:49 -0700 (PDT)
Received: by 10.227.153.15 with SMTP id i15mr2373936wbw.211.1285320588608;
        Fri, 24 Sep 2010 02:29:48 -0700 (PDT)
Received: from [192.168.0.69] (mail.2degreesnetwork.com [62.172.190.17])
        by mx.google.com with ESMTPS id g9sm1598741wbh.19.2010.09.24.02.29.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 02:29:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9pre) Gecko/20100217 Lightning/1.0b1 Shredder/3.0.3pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156965>

Hello.

We're currently migrating from another DVCS, which allows us to have
working copies of each branch in separate directories, so that their
code can be used simultaneously. However, I haven't found a way to do
this with Git, at least not an easy way. Can you please help me?

We are a team of Web developers and testers working on an application.
There are always a few development branches and a stable branch, and
testers need all the branches with the very latest code available at all
times.

The way we handle it at the moment is very simple because the server
hosting the remote repository is the same that hosts the deployed
instances of each branch, so when we push to the remote repository, the
code for each site is automatically updated.

We use the following structure:
/srv/repositories/project/branch1
/srv/repositories/project/branch2
/srv/repositories/project/branch3

Is there any simple way to do this with Git? I can only think of two
options that involve hooks:

    * Have a hook that exports each branch to a directory like
      /srv/repositories/project/branchN
    * Have one Git repository per branch, so that each repository have a
      different checkout active. Then the main remote repository will
      have post-receive hooks that trigger a pull on each individual

I'm not particularly happy with either way. Is there a better solution?

-- 
Gustavo Narea.
Software Developer.
2degrees, Ltd. <http://dev.2degreesnetwork.com/>.
