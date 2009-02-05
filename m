From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Comments on "Understanding Version Control" by Eric S. Raymond
Date: Thu, 5 Feb 2009 18:36:42 +0100
Message-ID: <200902051836.44973.jnareb@gmail.com>
References: <200902021948.54700.jnareb@gmail.com> <200902051223.38992.jnareb@gmail.com> <20090205131611.GJ8945@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 05 18:38:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV8B8-0008Bp-Di
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 18:38:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbZBERgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 12:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbZBERgw
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 12:36:52 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:60301 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061AbZBERgv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 12:36:51 -0500
Received: by ey-out-2122.google.com with SMTP id 25so99659eya.37
        for <git@vger.kernel.org>; Thu, 05 Feb 2009 09:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=VCBsKTP55ywqPIOk+0auBQ+AeY/aR7XKSS9kxOXbyTI=;
        b=JPL8p1Mn1yhJtLcbBFE4XUNzDYXhNb3/0wc+qS3yR8hrRqkLOo499nHe/YynxTTsuW
         jZvaXfVKuiM0tNbEpv8xM+FGHfEy7hPocb4hotbmGREfRD/zEFkbteOU/L1X1gdd+Hnb
         doijdWwl/a6F+NtfTg3gnVGWY7PWZtO1N7rQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ufGOQmuk+QE3aNUVzkINTXibWFKH+czSrLq2HdEA26oWhLumgvlf5w3u5c+gWuIZ3y
         tOzkbgEWL6ca+myrchwUfeoVYYEE/eE4HwXpDK/enTHuI1ND08CjryWusZavvynSiZdc
         bpVHbRfAtRz2y1cKjtNw+XDLy3uaqUKuYWXkA=
Received: by 10.86.92.7 with SMTP id p7mr463520fgb.24.1233855409135;
        Thu, 05 Feb 2009 09:36:49 -0800 (PST)
Received: from ?192.168.1.13? (abwq247.neoplus.adsl.tpnet.pl [83.8.240.247])
        by mx.google.com with ESMTPS id 12sm1852751fgg.53.2009.02.05.09.36.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Feb 2009 09:36:47 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20090205131611.GJ8945@mit.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108586>

On Thu, Feb 05, 2009, Theodore Tso wrote:
> On Thu, Feb 05, 2009 at 12:23:37PM +0100, Jakub Narebski wrote:
> > > 
> > > 2) And does the right thing happen if the situation is as described
> > >    above, but in, branch C, which is descended from branch B, a new
> > >    directory, src/plugin/innodb-experimental is created, such that
> > >    src/plugin/innodb and src/plugin/innodb-experimental both exist.
> > >    Now the same commit from branch A is pulled into branch C.  Will
> > >    the correct thing happen in that the correct files in
> > >    src/plugin/innodb are modified and created, even though there is a
> > >    new directory containing a completely unrelated plugin that happens
> > >    to have the name, "innodb-experimental"?
> > 
> > Errr... I think that you confused branch 'B' (with innodb-experimental)
> > with branch 'A' (with innodb only) here.
> > 
> 
> No, I didn't.   Let me try again.
> 
> At time T:	Project grows a plugin in directory src/plugins/foo-new
> 
> At time T+1:	Project releases a stable release, and branches off "maint"
> 
> At time T+2:	Project renames the plugin to be src/plugins/foo, using
> 		"scm mvdir src/plugins/foo-new src/plugins/foo" on the 
> 		devel branch:

And it is on branch 'A' that it happens.  But it doesn't matter...
The example is of 'independent add' in the same filename, different
contents case that I put in "Tests for...", but for directory not
for a filename.  Well, slightly more complicated than that...

What I wonder is how directory-id solution deals with situation
where (for example die to some reorganization) where once was single
directory (e.g. lib/) now there are two (include/ and src/); how it
would deal with the new file at old directory, hmmm...?

-- 
Jakub Narebski
Poland
