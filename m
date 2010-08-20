From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 4/4] fmt-merge-msg: Update fmt-merge-msg and
 merge-config documentation
Date: Fri, 20 Aug 2010 23:36:56 +0530
Message-ID: <20100820180654.GB6211@kytes>
References: <1282323292-11412-1-git-send-email-artagnon@gmail.com>
 <1282323292-11412-5-git-send-email-artagnon@gmail.com>
 <m31v9tp4pv.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 20:09:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmW1Z-0005nB-0z
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 20:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714Ab0HTSJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 14:09:00 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:63761 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304Ab0HTSI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 14:08:58 -0400
Received: by pvg2 with SMTP id 2so1303676pvg.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 11:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=V+NO3bR6kncqLneRWLoVm52GI11NWcbIkkY6Z7NSgXo=;
        b=swUToFkctSgodViaCyCOb00btbBnsBrXSk6hMHaSUGbtT25HLwr87tbcPJ+0AYIyYq
         vGcJPRLa44sL7Lyu++AZvRVOgHcgiBZRSAQUUpHjtg/8zAioOiaGjGFFpDckR2g0vr33
         R1YzGIPXIrLPCBhDY0YuXPQDKN1RjweQ5a9p0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EUs+TDN/bYnHEAkIhsEb3mXCnVTdZgjNFEnDxzakwNxNFgp49ItwnP8ZGmiHf0LJhf
         m6pEmouF5wGXNwaQFGlGbIeF0xva4n2BIT54t0ytmoHLq7PGgRsdtd3ximDPA2XxIJIO
         nVNFq+qM0QxqFZjboSDLPB5AOz1tEVMpNovAg=
Received: by 10.142.132.18 with SMTP id f18mr1297057wfd.196.1282327736474;
        Fri, 20 Aug 2010 11:08:56 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id g4sm5318754wae.2.2010.08.20.11.08.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 11:08:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m31v9tp4pv.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154064>

Hi Jakub,

Jakub Narebski writes:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
> 
> > Update the documentation of fmt-merge-msg and merge-config to reflect
> > the fact that `merge.log` can either be a boolean or integer option
> > now, instead of just a boolean.
> > 
> > Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> > ---
> >  Documentation/git-fmt-merge-msg.txt |   20 +++++++++-----------
> >  Documentation/merge-config.txt      |    8 ++++++--
> >  2 files changed, 15 insertions(+), 13 deletions(-)
> > 
> > diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
> > index 78c8a6d..720af64 100644
> > --- a/Documentation/git-fmt-merge-msg.txt
> > +++ b/Documentation/git-fmt-merge-msg.txt
> > @@ -9,8 +9,8 @@ git-fmt-merge-msg - Produce a merge commit message
> >  SYNOPSIS
> >  --------
> >  [verse]
> > -'git fmt-merge-msg' [-m <message>] [--log | --no-log] <$GIT_DIR/FETCH_HEAD
> > -'git fmt-merge-msg' [-m <message>] [--log | --no-log] -F <file>
> > +'git fmt-merge-msg' [-m <message>] [--log=<n> | --no-log] < $GIT_DIR/FETCH_HEAD
> > +'git fmt-merge-msg' [-m <message>] [--log=<n> | --no-log] -F <file>
> 
> Shouldn't it be
> 
>   +'git fmt-merge-msg' [-m <message>] [--log[=<n>] | --no-log] -F <file>
> 
> i.e. isn't <n> in '--log' optional?

Hm, I think I found a bug in the option parser. Currently writing a patch.

$ git fmt-merge-msg --log < .git/FETCH_HEAD
error: option `log' requires a value

$ git fmt-merge-msg --log= < .git/FETCH_HEAD
$ # Works

-- Ram
