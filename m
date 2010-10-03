From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC] New type of remote helpers
Date: Sun, 3 Oct 2010 22:37:12 +0530
Message-ID: <20101003170711.GI328@kytes>
References: <4CA86A12.6080905@dbservice.com>
 <AANLkTikQyVLyH-O-OH2yZ0B3_UKDqzcnNgtqefSCN68t@mail.gmail.com>
 <20101003151304.GH17084@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 19:08:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2S2s-0002DS-KX
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 19:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187Ab0JCRIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 13:08:12 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:38558 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754100Ab0JCRIL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 13:08:11 -0400
Received: by pxi10 with SMTP id 10so1140639pxi.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 10:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=TeZA2st7pFxSQ7OO+mwM7Tn+uN0uDdVv+2ivSnYhYS0=;
        b=AnWze1isWbxuKFH3kzgtciyjSPVepF3JKBrMmjzG6/QSFY2pEbMJcQfr9hLENb/w2q
         EBkI8gxc7iy3FKvDAT3zImP4oXqtFnkpdPP0UfigZyhaVu84MuJgPwSNQjK9hRzk51z/
         BNc39WG1Z/GS4rjCskhrYkU7RgrMc2slJc9yk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xyVXNW4HB2nYbJmDpw65nzjWZGLLYIsZJaY9mqzKoodnZKVvEG6U4jlLjKwEnEjinK
         RTaVR1tLAtZMQcHL85BHbWlyBksK2+IFlGDDlPFy/+O/6h6bCB2rU7vodPqDfqF9Kpr+
         eFk3yMk/yvg/JhLPJecy6n4gN0SBkWqq78rzI=
Received: by 10.142.239.3 with SMTP id m3mr7520711wfh.64.1286125691435;
        Sun, 03 Oct 2010 10:08:11 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id y4sm1855756wfd.8.2010.10.03.10.08.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 10:08:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101003151304.GH17084@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157885>

Hi Tom and Jonathan,

Jonathan Nieder writes:
> Sverre Rabbelier wrote:
> > On Sun, Oct 3, 2010 at 13:33, Tomas Carnecky <tom@dbservice.com> wrote:
> 
> >> To test this
> >> approach I created a simple remote helper for svn.
> >
> > I guess it suffices as a POC, but I'd have preferred to see
> > collaboration with the people working on git-remote-svn instead
> > (cc-ed).
> 
> Just a quick note: if this approach gets a working remote helper
> in the hands of users faster, I'm all for it.

First off, great work on the fast-import and the remote-helper! I am
very impressed with the results.

> My only concern is the name: if it is not compatible the planned
> remote helper from the summer of code project, they should probably
> get different names.  Correct me if I'm wrong, but the main
> differences are:
> 
>  - this is scripted and uses local svn working copy operations; the
>    soc project is in C and uses remote access ("replay")

Yes, the name definitely needs to be changed. Maybe name it something
along the lines of "local-svn"?

>  - this uses the nice ls-remote output etc.  Ram, do you think this
>    would be easy to use for remote-svn?

This is quite awesome. Yeah, I suppose we can use it for remote-svn as
well.

> So, not many differences.  Maybe we can standardize the interface
> and consider them alternate implementations?

This helper can't be merged in until Tom's changes to fast-import are
ported to the current fast-import. I just hope that those changes to
fast-import don't conflict with the changes git-remote-svn will
need. Frankly, I'd rather we work towards a common goal.

-- Ram
