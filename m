From: Andrew Neil <andrew.jr.neil@googlemail.com>
Subject: Re: Problem with submodules
Date: Fri, 29 May 2009 14:38:32 +0100
Message-ID: <7FD6E590-8C6F-4DC6-8F64-A52FFCA92515@googlemail.com>
References: <77493F66-6FBF-46E8-AD5B-702DC245AA43@googlemail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 29 15:38:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA2IL-0003uT-9G
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 15:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758291AbZE2Nil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 09:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757730AbZE2Nik
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 09:38:40 -0400
Received: from wmsmtp.opaltelecom.net ([62.24.128.253]:51282 "EHLO
	otmx.cpwnetworks.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756948AbZE2Nij (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 09:38:39 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AiwCAMuCH0pUDXCl/2dsb2JhbAAI0E2EDAU
Received: from host-84-13-112-165.opaltelecom.net (HELO [192.168.2.3]) ([84.13.112.165])
  by ttsmtp.cpwnetworks.com with ESMTP; 29 May 2009 14:38:33 +0100
In-Reply-To: <77493F66-6FBF-46E8-AD5B-702DC245AA43@googlemail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120277>

I found a solution to this here:

	http://www.websideattractions.com/2008/10/21/no-color-for-git/

Turns out that the following line in my .profile was messing things up:

	GREP_OPTIONS="--color=always"; export GREP_OPTIONS

I changed --color=always to auto, and everything works fine now.

Cheers,
Drew


On 29 May 2009, at 12:44, Andrew Neil wrote:

> I am having trouble with submodules on one of my machines. When I run
> `git submodule init`, then `git submodule update`, it looks as though
> everything is going fine, then it crashes out with an error:
> "pathspec '665a3c' did not match any file known to git.".
> (The full output is pasted below).
>
> According to this article: http://book.git-scm.com/5_submodules.html
> under the heading "Pitfalls with submodules", this error is expected
> to occur if you don't publish changes to a submodule. This doesn't
> seem to be the problem in my case. I have tried installing the same
> git repository on 2 other machines, and the submodule init/update
> commands worked fine on both of them. So it looks as though there is
> something on one of my machines that is interfering with this process.
>
> I discovered that if I run the `git submodule update` command as sudo,
> the problem goes away. However, this has the side-effect that the
> submodule directories are created with root as the owner.
>
> Can anyone help with this problem?
>
> Much appreciated,
> Drew
>
>
> Here is the full output of the init/update commands, with my faulty
> machine:
>
> $ git submodule init
> Submodule 'vendor/plugins/dataset' (git://github.com/jgarber/ 
> dataset.git) registered for path 'vendor/plugins/dataset'
> Submodule 'vendor/plugins/simply_versioned' (git://github.com/mmower/ 
> simply_versioned.git) registered for path 'vendor/plugins/ 
> simply_versioned'
> $ git submodule update
> Initialized empty Git repository in /Users/drew/web/extensions/ 
> chronicle/vendor/plugins/dataset/.git/
> remote: Counting objects: 899, done.
> remote: Compressing objects: 100% (692/692), done.
> remote: Total 899 (delta 539), reused 250 (delta 158)
> Receiving objects: 100% (899/899), 141.93 KiB | 42 KiB/s, done.
> Resolving deltas: 100% (539/539), done.
> error: pathspec '665a3c03f6a65a586839b8de437c60f98177dd78' did not  
> match any file(s) known to git.
> Unable to checkout '665a3c03f6a65a586839b8de437c60f98177dd78' in  
> submodule path 'vendor/plugins/dataset'
>
