From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: git-rebase -i prunes commits with empty commit-message
Date: Wed, 10 Mar 2010 14:13:19 +0100
Message-ID: <4B979AEF.5010201@alum.mit.edu>
References: <40aa078e1003081207u20046916yda5a62d44ce7a401@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 10 14:13:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpLjB-0001Ht-Li
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 14:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756026Ab0CJNNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 08:13:25 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:56641 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755626Ab0CJNNX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 08:13:23 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o2ADDK8d000626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 10 Mar 2010 14:13:20 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.23) Gecko/20090817 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
In-Reply-To: <40aa078e1003081207u20046916yda5a62d44ce7a401@mail.gmail.com>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141884>

Erik Faye-Lund wrote:
> I'm in the process of converting an SVN repo to Git, and in the
> process I found one quite disturbing feature of
> git-rebase--interactive.sh: It discards commits with empty commit
> messages!
> 
> Here's a recepie for reproducing the issue:
> --->8---
> git init
> git commit -m "dummy" --allow-empty
> git commit -m "dummy" --allow-empty
> git commit -m "dummy" --allow-empty
> git filter-branch -f --msg-filter 'sed -e "s/dummy//"'
> git rebase -i HEAD~2
> --->8---

Does git really claim to handle commits with empty commit messages?
That you have to use git-filter-branch to create the test case suggests
that the answer is "no", but I don't know.  (git-commit, for example,
refuses to create a commit with an empty message.)

If indeed git requires commit messages to be non-empty, then the fault
here seemingly lies with git-filter-branch for allowing commit messages
to be completely deleted.

Michael
