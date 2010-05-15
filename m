From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH GSoC] gitweb: Add global installation target for gitweb
Date: Sat, 15 May 2010 14:49:26 +0200
Message-ID: <201005151449.31609.jnareb@gmail.com>
References: <AANLkTimzoa_B2UV-4J7DvndiLNp5bYhAeT9VU0PqzUWE@mail.gmail.com> <201005141707.26416.jnareb@gmail.com> <AANLkTikDA1z9WiRa0Jt3vN0h1Zyq74uupqy14iVW3I7C@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	Eric Wong <normalperson@yhbt.net>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 15 14:50:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODGot-0007Dh-7r
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 14:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490Ab0EOMtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 May 2010 08:49:43 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48247 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271Ab0EOMtn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 May 2010 08:49:43 -0400
Received: by fxm6 with SMTP id 6so2324479fxm.19
        for <git@vger.kernel.org>; Sat, 15 May 2010 05:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=pN/98DAl+LYsWfhHYfUMyya2phhQjVOv9TztcanfB6E=;
        b=mQzAiMQOSAQwrGMswsVOoeRy64x1c68Tfkjusu1JMWQsMShaaEddJEVIoXOzbGlyV+
         84eox74ignVK9raWbfv3Nb4t6PHw+axmkN+hgL9Y0zJWIaGTOd7LOAG1U9m4kqycQPTn
         Xh/P66wnPyVKuSsA+ueFI/wYxdbrZu/7GU2fI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=UYamD01yKZA8kvaz/nsvaZh0pSNJOKiKNlh0q5Msz8E0EoDiTI4qXFQfXnOd2kJ4JR
         FFcbQ68jF+l0Kw8NBWBjDUHBPL2BX+UZIjf/GNTJWuFnV/gk6nbYlhc4Po6JRT3/RumH
         H7vwaKt3ftZaqtnCFgRUINHwNsRa3LFap9dVM=
Received: by 10.223.26.130 with SMTP id e2mr3100550fac.101.1273927781497;
        Sat, 15 May 2010 05:49:41 -0700 (PDT)
Received: from [192.168.1.13] (abvn155.neoplus.adsl.tpnet.pl [83.8.211.155])
        by mx.google.com with ESMTPS id z12sm15767492fah.9.2010.05.15.05.49.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 05:49:39 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTikDA1z9WiRa0Jt3vN0h1Zyq74uupqy14iVW3I7C@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147149>

On Fri, 14 May 2010, Pavan Kumar Sunkara wrote:
> On Fri, May 14, 2010 at 8:37 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> >
> > In short: I think that this patch should be split into two patches, one
> > which sets default value of 'gitwebdir' (in Makefile or gitweb/Makefile;
> > please explain why you chosen one or the other), and second that "fixes"
> > git-instaweb (and might include installing gitweb, in $(gitwebdir) or in
> > $(sharedir)/gitweb).
> 
> Yes, I agree. This is the first patch.
>
> The second patch which fixes git-instaweb is in discussion with my
> mentors. after that I will be sending it to the git mailing list.

As I said, I agree with the reasoning and the fact that patch is split
into two. What I disagree with is the splitting itself.

Making 'install-gitweb' prerequisite to 'install' target, or in other
words adding installing gitweb *somewhere*, should in my opinion by in
this second patch.
 
> I choose Makefile rather than choosing gitweb/Makefile becuase
> git-instaweb is a package of git not a package of gitweb. So, I choose
> Makefile rather than choosing gitweb/Makefile.

This is important fact; the description that 'gitwebdir' has default
value set (also) in Makefile because of the future change to the way
git-instaweb is build / installed should be in commit message of a new
first patch.


BTW. if 'gitwebdir' would be set to some default value both in Makefile
and in gitweb/Makefile, then in gitweb/Makefile the "?=" operator must
be used (set if undefined).

Note that default value in Makefile can be "$(sharedir)/gitweb", and in
gitweb/Makefile can be '/var/www/cgi-bin'.

[...]
> > Two things.
> >
> > First, I think providing default value for 'gitwebdir' could be I good
> > idea.  I think that all other build variables containing installation
> > directories have default values.  But I do wonder whether the
> > "$(sharedir)/gitweb" is a good default value for 'gitwebdir' (see also
> > comment about git-instaweb below).
> 
> I chose it because the lib files of gitk and git-gui are being
> installed in sharedir.

O.K., I can agree with this. You might want to put this substantiation
in the commit message, though.

> > Second, the issue with git-instaweb in its current form, and splitting
> > gitweb is very important.  I am not sure though if this is correct
> > solution for this problem.  It is NOT A FULL SOLUTION, that is sure.
> 
> Yes, It is not a full solution. There is another patch that is
> currently in discussion with my mentors.
>
> Petr and Christian told me to make sure that I send patches as small
> as possibl so that they will be merged into the mainstream. That is my
> GSoC aim too.
> 
> So, I sent this small patch which just installs gitweb with git's
> "make install" without breaking the git-instaweb.sh script.
> The patch for modifying git-instaweb will be sent soon to his mailing list.

That is a good practice, and a good idea.

My complaints are about putting too much in this first patch (I think
that making 'install' target install gitweb should be put in the commit
that changes git-instaweb, as those two changes have to be
synchronized), and about that commit message seems to claim that this
commit does more than it really does.

-- 
Jakub Narebski
Poland
