From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] git-gui: make "Git GUI Here" Explorer extension
 more robust
Date: Mon, 30 Mar 2009 22:20:44 +0200
Message-ID: <200903302220.44564.markus.heidelberg@web.de>
References: <200903300030.03733.markus.heidelberg@web.de> <200903300851.43164.markus.heidelberg@web.de> <alpine.DEB.1.00.0903301001090.7534@intel-tinevez-2-302>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Mar 30 22:22:48 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f163.google.com ([209.85.221.163])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoO01-0002Yj-Tk
	for gcvm-msysgit@m.gmane.org; Mon, 30 Mar 2009 22:22:26 +0200
Received: by qyk35 with SMTP id 35so3466920qyk.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 30 Mar 2009 13:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:jabber-id:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:x-sender
         :x-provags-id:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=t6OBgY4KqygaEW54Gok5RpBTTSDybEEGuR6k0pNcly0=;
        b=bZaZj4WIaDBni8yo8HhCmh+z+zpqwWk+rT0JPP5wyre9QjjgRq8j/h3AZMPkLBytSA
         AimyHVOLk/UFvwnkO9j4XpbubXEF547pneUs/whObplLeYOddygDOep0yomxILK2BjUZ
         ihvl0DzlPh1l+Lv2yqAdSX+KGaENSsIs2lLWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :reply-to:to:subject:date:user-agent:cc:references:in-reply-to
         :jabber-id:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:x-provags-id:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=HpiF183tM5YFiDnBPUXNYTohZRZE3DxxsKFJxW76AFiPN3UGQsd7UePgZ3mHLpifgz
         fwqeJFhi9PHmJXg2ggOuLFmfue42fCHQRlG5QLjGTNhFaQgGOxTyZnj1rX3NoLy5i+gh
         wlZvotF5WXl0hn24bUJ9qHGDoY3Z6nttppkTI=
Received: by 10.224.19.147 with SMTP id a19mr756566qab.6.1238444445936;
        Mon, 30 Mar 2009 13:20:45 -0700 (PDT)
Received: by 10.176.203.19 with SMTP id a19gr4549yqg.0;
	Mon, 30 Mar 2009 13:20:45 -0700 (PDT)
X-Sender: markus.heidelberg@web.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.11.13 with SMTP id 13mr214931ebk.13.1238444445207; Mon, 30 Mar 2009 13:20:45 -0700 (PDT)
Received: from fmmailgate02.web.de (fmmailgate02.web.de [217.72.192.227]) by gmr-mx.google.com with ESMTP id 15si740167ewy.0.2009.03.30.13.20.45; Mon, 30 Mar 2009 13:20:45 -0700 (PDT)
Received-SPF: pass (google.com: domain of markus.heidelberg@web.de designates 217.72.192.227 as permitted sender) client-ip=217.72.192.227;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of markus.heidelberg@web.de designates 217.72.192.227 as permitted sender) smtp.mail=markus.heidelberg@web.de
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166]) by fmmailgate02.web.de (Postfix) with ESMTP id 14685FC43970; Mon, 30 Mar 2009 22:20:45 +0200 (CEST)
Received: from [89.59.73.72] (helo=.) by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256) (WEB.DE 4.110 #277) id 1LoNyO-0004wi-00; Mon, 30 Mar 2009 22:20:44 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0903301001090.7534@intel-tinevez-2-302>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19tHZ2LtMWh5+gOtuxVW3dWx01Ft5CFuJx44l6D lo7jOee2bQz5eqyeMJ2sdC4YDZeN0Cehx4H4N4sNUnpyhNinTM WkmBuP55cQan6QxLHy5A==
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115191>


Johannes Schindelin, 30.03.2009:
> Hi,
> 
> On Mon, 30 Mar 2009, Markus Heidelberg wrote:
> 
> > Johannes Schindelin, 30.03.2009:
> > 
> > > On Mon, 30 Mar 2009, Markus Heidelberg wrote:
> > > 
> > > > Starting git-gui via Windows Explorer shell extension caused 
> > > > problems when not started from the project directory, but from a 
> > > > directory within the project: starting the Explorer from the git-gui 
> > > > menu "Explore Working Copy" didn't work then.
> > > > 
> > > > Starting git-gui via Explorer shell extension from the .git 
> > > > directory didn't work at all.
> > > > 
> > > > To make these things possible, "cd .." until we see .git/
> > > 
> > > How does this interact with GIT_WORK_TREE?
> > 
> > Not sure. What's the use case for a globally set GIT_WORK_TREE, how is 
> > it used?
> 
> You can call git gui with a non-global GIT_WORK_TREE by something like 
> this, even on Windows (which your patch does not special case, anyway):
> 
> 	$ GIT_WORK_TREE=/bla/blub git gui

The patch only affected git-gui started via Explorer, i.e. invoked with
--working-dir. But it's right that core.worktree can be set in the
repository.
However, git-gui currently doesn't support the gitdir outside of the
working directory, but it may not be wise to build up on this!?

Hmm, more complicated than I initially thought.

Markus
