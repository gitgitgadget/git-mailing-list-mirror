From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: rsync update appears broken now
Date: Thu, 20 Oct 2005 15:08:51 +0200
Message-ID: <81b0412b0510200608l61c00ed0yd4dbc00c313665fe@mail.gmail.com>
References: <86vezs9wy9.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 15:12:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESaAv-0001Z7-HO
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 15:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbVJTNIx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 09:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbVJTNIx
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 09:08:53 -0400
Received: from nproxy.gmail.com ([64.233.182.204]:43524 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932120AbVJTNIx convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 09:08:53 -0400
Received: by nproxy.gmail.com with SMTP id q29so19714nfc
        for <git@vger.kernel.org>; Thu, 20 Oct 2005 06:08:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZfX3tVQaQpPY+L6UI0Eac+9tK1VXas2p7vlYzisvMtP4mufp/dc+dx3jme/i3pPANGlhfdQqyoSUqAS+PWm7EwQbTgp0LrUvQKm46LYgGHSais4OBSm8M9J7ZzsGye0G2z75zNNxzPjPlYNRVXHZUUAAo33XqXnG+UdJr8Jl1i4=
Received: by 10.48.80.4 with SMTP id d4mr126207nfb;
        Thu, 20 Oct 2005 06:08:51 -0700 (PDT)
Received: by 10.48.49.13 with HTTP; Thu, 20 Oct 2005 06:08:51 -0700 (PDT)
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <86vezs9wy9.fsf@blue.stonehenge.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10359>

On 20 Oct 2005 05:47:42 -0700, Randal L. Schwartz <merlyn@stonehenge.com> wrote:
>
> Doing my daily git-pull now broke in this way (using yesterday's git version):
>
> sent 1196 bytes  received 155984 bytes  4555.94 bytes/sec
> total size is 4511741  speedup is 28.70
> * committish: 6e1c6c103c522d01829f3a63992a023ff031e851
>   branch 'master' of rsync://rsync.kernel.org/pub/scm/git/git
> * refs/heads/origin: does not fast forward to branch 'master' of rsync://rsync.kernel.org/pub/scm/git/git;
>   not updating.
> Trying really trivial in-index merge...
> fatal: Merge requires file-level merging
> Nope.
> Trying simple merge.
> Simple merge failed, trying Automatic merge.
> Auto-merging fetch-pack.c.
> merge: warning: conflicts during merge
> ERROR: Merge conflict in fetch-pack.c.
> fatal: merge program failed
> Automatic merge failed; fix up by hand

Absolutely normal pull into a changed repository. Just fix the
conflict (in fetch-pack.c, look for >>>), git-update-index the file
and commit. Doesn't look like a problem at all.
