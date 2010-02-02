From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 8/8 v6] gitweb: Add an option to force version match
Date: Tue, 2 Feb 2010 02:35:17 +0100
Message-ID: <201002020235.19943.jnareb@gmail.com>
References: <1264890645-28310-1-git-send-email-jnareb@gmail.com> <1264890645-28310-9-git-send-email-jnareb@gmail.com> <4B677971.2080100@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Tue Feb 02 02:35:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc7gJ-0007kM-MI
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 02:35:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409Ab0BBBf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 20:35:28 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:14317 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011Ab0BBBf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 20:35:27 -0500
Received: by fg-out-1718.google.com with SMTP id 16so81081fgg.1
        for <git@vger.kernel.org>; Mon, 01 Feb 2010 17:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=+fAYRxdIQFIzLNHuH38aOkEfPW+9mhzgfcUXG9dSkZ8=;
        b=kCJFfhKrBHitni6yn1qbHPfycAXuVnLdLi+VsZsEZhRDCWvruC8j3SLbAyCufAO88j
         TFItliQ4tuBHWltUlzF9esIRtDah6nCbmN9uKCNmYxjn5IgjCs/eePrl8yf5W0IXYKSV
         y6vVYwDbVT0bbTxmE3+Ou+HRO+Lc5TfY2x3Go=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=LgV9D2pNt3Zg8n6rgmKyrc27+iQtAOnf3Hos3S5baFcps+rZPCb++GmbBx1ROTJisB
         1UYt8C6WZAYeV+bVhiiI8k0sZ+avePodwjj5xOxp+CfQNgDj+mSWNhd5n4YYCZRlyQih
         bsT+cGhlQVYVD+vOjSbqb1vOjbkqOii98t9ic=
Received: by 10.87.36.4 with SMTP id o4mr8699443fgj.69.1265074525808;
        Mon, 01 Feb 2010 17:35:25 -0800 (PST)
Received: from ?192.168.1.13? (abvl217.neoplus.adsl.tpnet.pl [83.8.209.217])
        by mx.google.com with ESMTPS id d6sm10157679fga.29.2010.02.01.17.35.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Feb 2010 17:35:24 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4B677971.2080100@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138671>

On Mon, 1 Feb 2010, at 17:01:37 -0800, J.H. wrote:

> Starting to pop off the stack, and this came up first.  A quick reading
> of this, I'd sign-off and agree to patches 1-7 completely.
> 
> I'm still going to take issue that this being off by default is the
> wrong behavior and leaving this off by default more or less means that
> it will never get run and it becomes useless code.  If this isn't on by
> default, it shouldn't be committed, as I can't think of a legitimate use
> case where an admin is going to turn this on.

Well, I don't think that mismatched git and gitweb version should be
serious problem in practice, unless they are seriously out of sync.  
And in such situation (where either git is stale and gitweb updated,
or git updated and gitweb kept stale e.g. because it is heavily 
customized with not ported changes) gitweb admin should turn this
feature on.

> 
> I'd still argue this needs to be on by default to at least give admins
> the explicit warning that if they want to deviate they are taking their
> own risks, and that gitweb might not run as expected.  Once the warning
> is disabled in a configuration file it's not like it's going to be
> re-enabled.  People loading gitweb from their distro's package
> management will likely be in sync properly and will never see this.
> Those who are installing gitweb independent of their distro's package
> management will at least be warned of the risk, at least until better
> error reporting is done and in gitweb.

If you want to have it turned on by default (which is _incompatible_
change, and which was not announced enough, I think; it might mean
that gitweb can stop working after git or gitweb update), beside
changing commit message and gitweb/README (and of course definition of
$git_versions_must_match variable), you would have also update 
explanation in die_error for version mismatch.

Current version, as requested by Petr 'Pasky' Baudis, explains how
to turn feature off if it was enabled.  For this it needs to check
which config file is present, but we know at least that some config
file had to be used (beside possibility of hand-editing gitweb.cgi).
This is not the case if this feature is turned on by default: there
is possible that there is no gitweb config file, and all configuration
was done at build time.  How to explain then how to turn this feature
off?  What happens if both $GIWEB_CONFIG and $GITWEB_CONFIG_SYSTEM
are empty because of misconfiguration during build ($GITWEB_CONFIG
is set by default to gitweb_config.perl, and $GITWEB_CONFIG_SYSTEM
is set by default to /etc/gitweb.conf)?  Which one to recommend if both
variables are set, but neither file exists?

The difficulty of explanation how to turn this feature off if it is
on by default was one of main reasons to not have it turned on by
default.


Side-note: Perhaps error is too strong a measure, and it would be better
to just issue warning somewhere instead?

> 
> I've got a slightly modified version of this that re-enables it by
> default, it passes t9501 for me.

As it should, because gitweb-lib.sh was modified to explicitly turn off
this feature (see below), to allow testing gitweb without need to 
recompile whole git, and to allow testing _not installed_ (source)
version of gitweb.

> > diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
> > index 5a734b1..66a3e2d 100755
> > --- a/t/gitweb-lib.sh
> > +++ b/t/gitweb-lib.sh
> > @@ -26,6 +26,7 @@ our \$projects_list = '';
> >  our \$export_ok = '';
> >  our \$strict_export = '';
> >  our \$maxload = undef;
> > +our \$git_versions_must_match = 0;
> >  
> >  EOF
> >  

-- 
Jakub Narebski
Poland
