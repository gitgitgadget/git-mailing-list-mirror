From: "Octavio Alvarez" <alvarezp@alvarezp.ods.org>
Subject: Re: What does git reset do?
Date: Tue, 02 Feb 2010 00:01:40 -0800
Message-ID: <op.u7hpv8nd4oyyg1@localhost.localdomain>
References: <ron1-A2A2DE.23475601022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 8bit
To: "Ron Garret" <ron1@flownet.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 09:02:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcDhv-0000Gi-Gy
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 09:01:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755715Ab0BBIBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 03:01:54 -0500
Received: from spider.alvarezp.com ([66.150.225.106]:44566 "EHLO
	spider.alvarezp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755392Ab0BBIBx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 03:01:53 -0500
Received: from localhost.localdomain (201.160.167.202.cable.dyn.cableonline.com.mx [201.160.167.202])
	(authenticated bits=0)
	by spider.alvarezp.com (8.13.8/8.13.8/Debian-3) with ESMTP id o1281jNf015878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 2 Feb 2010 00:01:47 -0800
In-Reply-To: <ron1-A2A2DE.23475601022010@news.gmane.org>
User-Agent: Opera Mail/10.10 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138693>

On Mon, 01 Feb 2010 23:47:56 -0800, Ron Garret <ron1@flownet.com> wrote:

> The docs say that git-reset:
>
> "Sets the current head to the specified commit..."

... without modifying your working copy if --soft, and modifying your  
working copy if --hard.

... and without switching branches (you want git checkout for that).

> So I tried this:
>
> [ron@mickey:~/devel/gittest]$ git branch
> * br1
>   master
> [ron@mickey:~/devel/gittest]$ git reset --soft master
>
>
> ...expecting HEAD to now point to master.  But it doesn't:

It actually does. HEAD (and br1) now point to [the commit pointed to by]  
master. Your working copy was left intact (because of --soft). Compare  
with "git checkout".

gitk --all is your friend to better understand this.

Your branch is still br1. It means, if you commit, br1 will advance, (not  
master). But, given your git reset, instead of committing over [the commit  
pointed to by previous] br1, you will commit over [the commit pointed to  
by] master.

Be careful though, you might lose commits with git reset.

> [ron@mickey:~/devel/gittest]$ git branch
> * br1
>   master
> [ron@mickey:~/devel/gittest]$ more .git/HEAD
> ref: refs/heads/br1
>
>
> So... what does git reset do?

Sets the current head (and branch, if not detached) to the specified  
commit...

-- 
--
Octavio.
