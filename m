From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Tue, 19 Oct 2010 08:38:17 +0530
Message-ID: <20101019030813.GA14246@kytes>
References: <20101018073102.GA3979@burratino>
 <20101018163836.GI22376@kytes>
 <AANLkTik-OAZWBkKM1zNyeZpC6K4ZjvF8WfXOJrNkXayt@mail.gmail.com>
 <20101018165631.GA6718@burratino>
 <AANLkTimZU_q3KJYpq7zQU7o5H-M8=efDUDL9Zoy7LuZg@mail.gmail.com>
 <20101018172810.GA6877@burratino>
 <AANLkTinYpa61a=68ACSALtxuFnhGh5nGxmeD41J3e51i@mail.gmail.com>
 <20101018181336.GB6877@burratino>
 <AANLkTikHrCoZkJHN7Bnq4tgCTAHDfy7-92YOiV=s4VD8@mail.gmail.com>
 <20101018182530.GC6877@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Stephen Bash <bash@genarts.com>,
	Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	David Michael Barr <david.barr@cordelta.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 05:09:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P82ZW-0008Dh-Dc
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 05:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614Ab0JSDJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 23:09:01 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38019 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932297Ab0JSDJA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 23:09:00 -0400
Received: by ywi6 with SMTP id 6so883610ywi.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 20:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=1L3SHwkG30JIa692CMraV70VRpuMI0iZfEH3iSHa0Gs=;
        b=FVnof7gKIQ/2Ag9Wwreae/TxY77ivQtvK330c5OMBKAy6N/KgpDcbF6uMQBpuCOqQc
         XDcXMLRnV9FQ30iNLakxYE3f92pM0xlvH2QCWDt+foVwXOJm5gVB0+TCH1tNyxn3wi/D
         BPvG5GV/MDR8LisnzzWwKl7WfyBo3sxHzFkAw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=n9TXTmBc5i+dRyoPVCLJ8G2TXP/EjY6YPyrgL7skAfxKRRgW3bzRnd0crqhfWkQ6Lm
         p99UXj6uyYr1H7BAu/M9M0MBoKkwKsL5EPbW6T13YoKBQEEYDt1SwemBaJcEMOFrMyXg
         g+fwcQyShZ6z3t9OXu3DArLhZFsd2aYJXJwjw=
Received: by 10.100.232.20 with SMTP id e20mr3478020anh.266.1287457739486;
        Mon, 18 Oct 2010 20:08:59 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id 6sm22449092anx.12.2010.10.18.20.08.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 Oct 2010 20:08:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101018182530.GC6877@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159302>

Jonathan Nieder writes:
> Sverre Rabbelier wrote:
> 
> > Does the replay API somehow indicate that a revision changed since
> > last time you looked?
> 
> Good question.  Ram, I think there was some discussion of this
> recently in connection with svnrdump, right?  IIRC the suggested
> method was to use hooks or mine a commits@ mailing list. :(

Yep. There's really no way to determine if a revision changed. Atleast
we can be happy that it's just the revprops that change- replace refs
are a great solution when we can tell if something changed. Frankly, I
haven't thought about how to solve this yet -- I'll comment after
looking at the later emails in the thread.

-- Ram
