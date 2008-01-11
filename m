From: Charles Bailey <charles@hashpling.org>
Subject: Re: git-commit fatal: Out of memory? mmap failed: Bad file descriptor
Date: Fri, 11 Jan 2008 22:18:32 +0000
Message-ID: <4787EB38.7010600@hashpling.org>
References: <4787E981.7010200@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, drafnel@gmail.com
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Jan 11 23:19:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDSDW-0000Fh-Fa
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 23:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761753AbYAKWSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 17:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755757AbYAKWSm
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 17:18:42 -0500
Received: from pih-relay05.plus.net ([212.159.14.132]:34431 "EHLO
	pih-relay05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761566AbYAKWSm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 17:18:42 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay05.plus.net with esmtp (Exim) id 1JDSD0-00055s-3N; Fri, 11 Jan 2008 22:18:38 +0000
Received: from [192.168.1.29] (heisenberg2.hashpling.org [192.168.1.29])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m0BMIWgs030293;
	Fri, 11 Jan 2008 22:18:32 GMT
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <4787E981.7010200@nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70215>

Brandon Casey wrote:
> I got this message from git-commit:
> 
> $ git commit -a
> <edit message, :wq>
> fatal: Out of memory? mmap failed: Bad file descriptor
> Create commit <my_prompt_string>
> 
> The exit status was 128.
> Looks like the commit was successful though.
> The partial message 'Create commit ' comes from print_summary()
> in builtin-commit.c which is _after_ the actual commit.
> 
> $ git --version
> git version 1.5.4.rc2.84.gf85fd-dirty
> 
> It was compiled with NO_CURL=1. The dirtiness comes from the
> patches I submitted for relink earlier today.
> 
> The other possible clue is that this repo is on NFS.
> 
> -brandon

I have seen this exact type of failure (commit reports possible 
oom, but commit appears to have succeeded) with most recent gits.

I had assumed that it was because I was using a very large 
repository (experimenting with using git for general backup 
purposes) on a machine with not too much memory.

Perhaps there's a real bug in here somewhere after all.

Charles.
