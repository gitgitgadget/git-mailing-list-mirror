From: "Yin Ping" <pkufranky@gmail.com>
Subject: Re: How to merge git://repo.or.cz/git-gui into git.git
Date: Mon, 29 Oct 2007 14:45:11 +0800
Message-ID: <46dff0320710282345r2922ac7dj9c7a4eb3e20fd011@mail.gmail.com>
References: <46dff0320710280357u23927960hd204760b3d664ce2@mail.gmail.com>
	 <46dff0320710280400v523e2130nd3286a88a4920a9c@mail.gmail.com>
	 <20071028111443.GA29183@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Peter Baumann" <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 29 07:45:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImONL-0004CL-D1
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 07:45:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbXJ2GpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 02:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbXJ2GpO
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 02:45:14 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:43292 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbXJ2GpM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 02:45:12 -0400
Received: by py-out-1112.google.com with SMTP id u77so2695429pyb
        for <git@vger.kernel.org>; Sun, 28 Oct 2007 23:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=atptOnM5xmxktU8iIlXLNV4bRIxDv2P+a3zPbmhgSpk=;
        b=GHiROzwgX5bPpBMBgfOys6EbQzZNhwJi6cfsmBAuaqvbD/bThVnqiT5f4dwBTh2Eq4k+DzUyZ5BTLAFMj+gVltYVLRY3XR1b1nkmzP+EcuCclMJbN3m1sLCT+Xe1bcWGpaVZNnW1rvOCI1ey0gimqm3Tt4ODi+O5yonEyIsq7kg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F1KU8R04nEz4mBAIxZV4YEOtMxEXNLas6Bjul8i5oq/QldRBvTQA7BEHpEoOO9KZ7LyvPslGLCaUBADoAmlKSQ1SbwX7ogaekeRhjLvOZGtrRTpLGdyna/gvExzPZ18MYgszRGa3UVmq3Cw9uvlyXvKKLRnWL1hUhunD8FED7aU=
Received: by 10.35.72.1 with SMTP id z1mr7092798pyk.1193640311915;
        Sun, 28 Oct 2007 23:45:11 -0700 (PDT)
Received: by 10.35.108.1 with HTTP; Sun, 28 Oct 2007 23:45:11 -0700 (PDT)
In-Reply-To: <20071028111443.GA29183@xp.machine.xx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62603>

On 10/28/07, Peter Baumann <waste.manager@gmx.de> wrote:
>
> Have a look at the subtree merge strategy [1] and at the following
> explanations how git-gui got initally merged.
>
> -Peter
>
> [1]: http://www.gelato.unsw.edu.au/archives/git/0702/40139.html
> [2]: http://www.gelato.unsw.edu.au/archives/git/0702/39661.html
>
>

When i merged git.git into git-gui with subtree strategy, I found all
histories of git.git merged into histories of git-gui (from 584
history entries to 11985). Is it possible that only histories related
to git-gui subdirectory in git.git(i.e. histories displayed by git-log
git-gui) are  merged into?

1. my configuration:
~/git-gui$ git-remote show git
* remote git
  URL: git://git.kernel.org/pub/scm/git/git.git
  Tracked remote branches
    master
~/git-gui$ git-remote show origin
* remote origin
  URL: git://repo.or.cz/git-gui
    Remote branch(es) merged with 'git pull' while on branch master
      master
    Tracked remote branches
      master
~/git-gui$ gtlg --pretty=oneline --topo-order --first-parent | wc -l
584

2. pull with subtree strategy
~/git-gui$  git-pull -s subtree git master:master

3. after pull, all logs of git comes into git-gui (584->11985)
~/git-gui$ gtlg --pretty=oneline --topo-order | wc -l
11985

4. histories of git can be hiden by --first-parent
gtlg --pretty=oneline --topo-order --first-parent | wc -l
585

-- 
franky
