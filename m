From: Deskin Miller <deskinm@umich.edu>
Subject: Re: [PATCH] git-svn: change dashed git-config to git config
Date: Fri, 24 Oct 2008 11:27:04 -0400
Message-ID: <20081024152704.GA983@euler>
References: <20081023192134.GB8320@euler> <20081024091544.GB27362@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Oct 24 17:28:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtOab-0007Az-Ax
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 17:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754919AbYJXP1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 11:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754641AbYJXP1Q
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 11:27:16 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:16320 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756959AbYJXP1P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 11:27:15 -0400
Received: by an-out-0708.google.com with SMTP id d40so102146and.103
        for <git@vger.kernel.org>; Fri, 24 Oct 2008 08:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:sender;
        bh=hPOBdxqYPSlrR7OTpssIfi+NkEMD/d/KtpP91uaP1jI=;
        b=fu48PfTXgfSUqx94JDPAlfsQfQKcN6oHfBfWUxfnHGgoaVG3RLRw5Rf+rI/Z0BT/Gf
         TgTNv06BnIB4skJC9FBNZn9Z2RKDgVNpUIZ9N8UV+0YbdAPKz3DbKSSUxJGRb8Y8r2lV
         8JrJr4um89uZzQL8F9nt3KD5HRRCd2hCCIwqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent:sender;
        b=duEotvWrBnm/BS/cGik+bSXlk3e0FN+t7dNkNiHLeP3A7oIyLj8gVW81U41GgWKbQD
         Sdwc4tA1PFu8MqdQIW7PnFee0fnoZjBCl9DZgJEbEXj+meSAdI0QNmCk1gpgbRbksdd3
         CrmR+/0C+ogbkMc87OusFh1MXO8w6N21bFc2c=
Received: by 10.100.109.13 with SMTP id h13mr2827452anc.21.1224862034130;
        Fri, 24 Oct 2008 08:27:14 -0700 (PDT)
Received: from euler ([68.40.49.130])
        by mx.google.com with ESMTPS id 3sm160783hsw.16.2008.10.24.08.27.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Oct 2008 08:27:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20081024091544.GB27362@untitled>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99042>

On Fri, Oct 24, 2008 at 02:15:44AM -0700, Eric Wong wrote:
> Deskin Miller <deskinm@umich.edu> wrote:
> > ---
> > When testing git-svn changes, I'll often use git-svn.perl directly on a
> > repository of mine, to see how things work.  Recently I had this happen:
> > 
> > $ git-svn.perl info
> > Use of uninitialized value in scalar chomp at ../git/git-svn.perl line 1202.
> > Use of uninitialized value in concatenation (.) or string at ../git/git-svn.perl line 1203.
> > 
> > but the expected output showed up correctly, giving the SVN-like info.
> > 
> > git svn info appeared to work just fine though, despite there being essentially
> > no difference between the two.  However, if I do the following, this is what I
> > see:
> > 
> > $ env /usr/libexec/git-core/git-svn info
> > Can't exec "git-config": No such file or directory at /usr/libexec/git-core/git-svn line 1202.
> > Use of uninitialized value in scalar chomp at /usr/libexec/git-core/git-svn line 1202.
> > 
> > Again, the SVN info would still appear.
> > 
> > Regardless, I think we want to change this call to use the non-dashed form.
> 
> Thanks Deskin,
> 
> Acked-by: Eric Wong <normalperson@yhbt.net>

Sorry, patch should have had a

Signed-off-by: Deskin Miller <deskinm@umich.edu>

Feel free to forge it. 

> > Deskin Miller
> >  
> >  git-svn.perl |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/git-svn.perl b/git-svn.perl
> > index 33e1b50..2e68c68 100755
> > --- a/git-svn.perl
> > +++ b/git-svn.perl
> > @@ -1126,7 +1126,7 @@ sub read_repo_config {
> >  		my $v = $opts->{$o};
> >  		my ($key) = ($o =~ /^([a-zA-Z\-]+)/);
> >  		$key =~ s/-//g;
> > -		my $arg = 'git-config';
> > +		my $arg = 'git config';
> >  		$arg .= ' --int' if ($o =~ /[:=]i$/);
> >  		$arg .= ' --bool' if ($o !~ /[:=][sfi]$/);
> >  		if (ref $v eq 'ARRAY') {
> > -- 
> > 1.6.0.2.554.g3041b
