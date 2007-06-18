From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: Re: GIT_DIR question
Date: Mon, 18 Jun 2007 22:43:57 +0300
Message-ID: <f36b08ee0706181243x64241585rfb64ca48323dea1e@mail.gmail.com>
References: <f36b08ee0706170829w59979d86i7bf09bc35ff28fca@mail.gmail.com>
	 <f36b08ee0706170834m464ce57dl3fd5b549b23abb16@mail.gmail.com>
	 <20070617215235.GA27753@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Matthias Lederhofer" <matled@gmx.net>
X-From: git-owner@vger.kernel.org Mon Jun 18 21:44:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0N8r-0007nj-B4
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 21:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761982AbXFRTn7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 15:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761905AbXFRTn6
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 15:43:58 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:48722 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761528AbXFRTn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 15:43:58 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1115364wra
        for <git@vger.kernel.org>; Mon, 18 Jun 2007 12:43:57 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mUxdywCGHEVV73r07j+ZuGTanfJOdiJJMSPpHLMTOXNHv/6O7XgdHoU99E9HjaRfAHiOXj/Sq7L/0fExzreyxnq2qqTZ+2QluaTXnXyoZIfuF2m1ZyiT+4CPtONf5Wmz+SO6GCsMgUy3dixc+XS707e0voaX06Rsjpat23AoCIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mKxhena18kSWLQQcHAsUn8Gl+oYOrl9y5KoUneoIQ2ndi6VmTJdsPE7tBdlgcOa4y/NSQx3HGMG2+QRLv5B8LiQ8qw5/4DzhvkEOY1WEcdLCbsBz3IkFEeuhHOeSv8cWRHeU9Y3LvlbmMRTqaBKUAC2XaG8j++MSqlesXN2B+qA=
Received: by 10.142.76.4 with SMTP id y4mr315689wfa.1182195837050;
        Mon, 18 Jun 2007 12:43:57 -0700 (PDT)
Received: by 10.142.116.4 with HTTP; Mon, 18 Jun 2007 12:43:57 -0700 (PDT)
In-Reply-To: <20070617215235.GA27753@moooo.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50404>

On 6/18/07, Matthias Lederhofer <matled@gmx.net> wrote:
> Yakov Lerner <iler.ml@gmail.com> wrote:
> > I wanted to create cloned repo, but with metaninfo separately from data.
> > I cloned the repo ( git-clone ~/repo ~/x) ,
> > then I moved ~/x/.git to different place (mv ~/x/.git ~/git);
> > then exported GIT_DIR=~/git; then
> > cd ~/x;
> > But now 'git status' says 'fatal: runstatus must be run in a work tree' .
> > Why ?
> >
> > 'ls $GIT_DIR'  shows
> >  FETCH_HEAD  HEAD  ORIG_HEAD  branches  config
> >  description  hooks  index  info  logs  objects  refs
> > This is ok, no ?
>
> With current git you have to name the repository directory '.git' to
> use it with a working tree.  Some commands work even though the
> repository is named differently, others don't.
>
> In pu is a patch series by me which changes this.  First of all the
> core.bare option is used all the time, the directory name of the
> repository does not matter if core.bare is specified.  Additionally
> you can specify the working tree through the config option
> core.worktree or the environment variable GIT_WORK_TREE.  With this
> you can even work in a subdirectory of the working tree.  But this is
> only in pu and it is not decided yet if this will make it into master,
> even though I hope it will.  Perhaps more people asking for this helps :)
>


Does your patch allow to use absolute filenames and being cwd
 outside of working dir ? I like to use absolute filenames (sometimes.
 Most modern VSCes allow absolute pathnames).

 Thanks
 Yakov
