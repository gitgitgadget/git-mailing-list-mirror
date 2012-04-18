From: Per Cederqvist <cederp@opera.com>
Subject: Re: git clone fails intermittently if source repo is updated
Date: Wed, 18 Apr 2012 10:37:04 +0200
Message-ID: <4F8E7D30.2010906@opera.com>
References: <87vckyldrj.fsf@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: ceder@lysator.liu.se
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 18 10:37:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKQOD-0004AW-Ce
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 10:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287Ab2DRIhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 04:37:13 -0400
Received: from smtp.opera.com ([213.236.208.81]:49111 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752226Ab2DRIhK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 04:37:10 -0400
Received: from [10.30.1.61] (oslo.jvpn.opera.com [213.236.208.46])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id q3I8b54p011683
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 18 Apr 2012 08:37:07 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <87vckyldrj.fsf@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195846>

On 04/17/2012 02:54 PM, Per Cederqvist wrote:

> Running "git clone master.git copy" sometimes fails if changes are being
> pushed to master.git.  Likewise, running "git clone mirror.git copy"
> sometimes fails if the mirror is currently fetching changes from
> master.git.
>
> In git 1.7.9 I sometimes get one of two fatal error messages.  In one of
> the cases, git still exits with exit code 0, but the working directory
> of "copy" is not updated with the proper files.  (See below for the
> exact error messages.)
>
> In git 1.7.10 the mirror sometimes ends up in "detached HEAD" state.
> Sometimes it prints a warning message.  (See below for the messages.)
>
> The following shell scripts can reproduce the problem.  I've been using
> a 4-core CPU on Ubuntu 11.04.  I've compiled Git from source.
>
> The first script, test-git-setup.sh, creates the directory "test-git"
> and three git repositories in it: master.git, mirror.git, and committer:
>
 > [...four shellscripts omitted...]

For your convenience, I have now set up a Git repository where you can
get slightly updated versions of the above scripts.  The Gitorious web
page is here:

http://git.lysator.liu.se/ceder/git-clone-fail-demo

You can clone it like this:

git clone git://git.lysator.liu.se/ceder/git-clone-fail-demo.git

I have been able to reproduce the problem on Git 1.6.0 as well, so
this is apparently not a recent regression.

The problem can also be reproduces when you clone, push and fetch via
ssh, but it happens a lot less frequently then.  See the README file in
the git-clone-fail-demo repository for info on how to reproduce it.

> [...]
>
>      /ceder

     /ceder
