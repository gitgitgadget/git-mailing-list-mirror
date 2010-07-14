From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/9] Get svnrdump merged into git.git
Date: Wed, 14 Jul 2010 02:49:59 +0200
Message-ID: <20100714004959.GG12639@debian>
References: <1279064176-6645-1-git-send-email-artagnon@gmail.com>
 <20100713235825.GC12639@debian>
 <20100714001530.GB2308@burratino>
 <20100714002235.GF12639@debian>
 <20100714002843.GC2308@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, avarab@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Will Palmer <wpalmer@gmail.com>, Greg Stein <gstein@gmail.com>,
	Stefan Sperling <stsp@elego.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 02:48:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYq9L-0002Nv-71
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 02:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780Ab0GNAsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 20:48:18 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44454 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753641Ab0GNAsO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 20:48:14 -0400
Received: by ewy23 with SMTP id 23so1279831ewy.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 17:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=I7Q2mntGOsKnZGrT0xflndAkBm5PHlZYlP8dEpNSGNs=;
        b=tJfOEKzQgEu3MzvF8Dix1jtsmk4/NcwD9el8LD21PMi3rWtaIfu2KRbqCvzM499k9T
         uIDKjmJn+YalsX7UdZNKusVyOrmOwwjeZ/GzJPWyIyPRuyc9a6PbDoeINQHP5oPcSnjJ
         fEb9XLq8qZ/UlyyOgtbOkPB3deVpElZXgX0+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bjkHtFgxyVcNSUazEI0bivIOB7hzB5R3TJvDw6IsiJ3tCQLeUipAqPfmf7kexPzpRa
         sJUrssWHJ2McxGfsIbW+cgtzqRLh84LhyaYNaSeRV00/yijeWy5bDzIW0bAgcuNYFEGI
         w+74udmrq9Z9RD68PexDbWZHe3+jKuaHupZCo=
Received: by 10.213.7.2 with SMTP id b2mr3582973ebb.22.1279068492685;
        Tue, 13 Jul 2010 17:48:12 -0700 (PDT)
Received: from debian (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id x54sm51942589eeh.23.2010.07.13.17.48.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Jul 2010 17:48:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100714002843.GC2308@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150954>

Hi,

Jonathan Nieder writes:
> As long as the relevant licenses permit that.  svnrdump only links to
> libsvnclient, right?

I can see another problem coming: things are likely to move around
quite a bit after the code gets into the ASF. For instance, Stefan's
recent review points out that write_hash_to_stringbuf should probably
be in a reusable library. If these changes happen soon, svnrdump will
be tightly integrated into Subversion, and it'll be hard to separate
out an independent program. Then again, we don't know how soon this
will happen.

If you get this series merged into git.git, Git people will be able to
read and review it easily and it'll be guaranteed to compile against
SVN 1.6. In other words, it won't be a moving part. The downside being
that it's too painful to backport changes from the ASF version, so
it'll remain outdated atleast until the next Subversion release, and
we don't know how soon that'll happen and be widely available.

If the former option is preferred, I'll send one large patch to the
list for mirroring the version in ASF. Also, could the Subversion
people confirm that licensing isn't an issue?

-- Ram
