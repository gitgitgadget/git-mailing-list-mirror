From: David Aguilar <davvid@gmail.com>
Subject: Re: [RFC] Interactive difftool
Date: Fri, 27 Mar 2009 07:51:22 -0700
Message-ID: <20090327145122.GA944@gmail.com>
References: <46dff0320903260829j34d8c613wf9b4fcc954c8519a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 15:52:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnDPv-0006cK-Ks
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 15:52:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429AbZC0Our (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 10:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbZC0Our
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 10:50:47 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:24941 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbZC0Ouq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 10:50:46 -0400
Received: by wa-out-1112.google.com with SMTP id j5so702877wah.21
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 07:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=hkk3tzFP2UMnlq8ost3MVBh1XSxpCgYQybieG0aaxM4=;
        b=WOt9VpeWuaRTTKyU17+iP/nKpW3nADrFKu2+LoYwDhdtGDngyKHNxYqMJPfsmtaOv0
         IrCkGAvSwaEXh+E5tk879dJHgpXNUDpOtCAdreUr9HHDdEfZyuQWs4WnEM8dgb18ogoO
         Vty6ZbKu/MEgq6IEsOXBRvlR5zSsMMjCEYQnU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Rd1CzuSonmspn3EAIh614brssdds0V6ftrUcC93S8Xfal8ODzxe1vSUo9jhJgrsBJF
         X6/LTBt9e50ZQCh8MdFVaWKMRj04NsDc8uEqdL6hdeczzJwhx0OFov6qt00f2XLRpp/2
         3y75BkKwM58MZkTsa2mxBeekyAOmXC9ZkG9Dc=
Received: by 10.114.137.16 with SMTP id k16mr1467058wad.189.1238165444644;
        Fri, 27 Mar 2009 07:50:44 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id k21sm1598228waf.57.2009.03.27.07.50.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Mar 2009 07:50:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <46dff0320903260829j34d8c613wf9b4fcc954c8519a@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114900>

On  0, Ping Yin <pkufranky@gmail.com> wrote:
> Before git-difftool goes to master, i want to propose a new feature to
> add to or replace the current behaviour of difftool. With current
> difftool, we can only see the diff one by one. However, sometimes what
> we want is to see the diff of selected files, or in a different order,
> just like what we can do in the gui. So here is what i propose
> 
> $ git difftool --interactive [options]
> [1] diff.c                   |   10 +++++++++-
> [2] t/t4020-diff-external.sh |    8 ++++++++
> Choose the file you want to see the diff of: 2
> 
> When the user types 2 and then <enter>, the external diff program is called
> 
> Further more, instead of just type a number, a letter can be prepended
> to the number to represent different ways of diff. For example
> 
> t2 (tool 2): see the diff for file 2 with the configured diff tool
> p2 (patch 2): see the diff for file 2 in the patch format
> 
> What do you think?
> 
> Ping Yin

That would be pretty cool.  I don't know about the
merge-to-master timing and whether we'd want to include new
features before the move.

I guess most of the work would have to be done in
git-difftool-helper.sh.  I had a co-worker that asked for this
exact feature just the other day (and ditto for mergetool).

Patches are welcome if you have an idea for how it could work.
Right now we get called indirectly by git-diff so I
don't know if there's an easy way to hook into it like that.
It might be a matter of changing git-difftool.perl so that it
does more of the dispatching itself.

-- 

	David
