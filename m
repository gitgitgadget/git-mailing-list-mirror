From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] Gitweb: Source configuration from file separate from the CGI script
Date: Thu, 17 Mar 2011 03:21:48 -0700 (PDT)
Message-ID: <m3lj0e59ps.fsf@localhost.localdomain>
References: <1300285582.28805.25.camel@drew-northup.unet.maine.edu>
	<20110316143420.GA15371@elie>
	<1300286650.28805.29.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Thu Mar 17 11:21:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0AL7-00058s-Tx
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 11:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550Ab1CQKVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 06:21:53 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34360 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753370Ab1CQKVw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 06:21:52 -0400
Received: by bwz15 with SMTP id 15so2312029bwz.19
        for <git@vger.kernel.org>; Thu, 17 Mar 2011 03:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=Ohagx3S9qDaK6jlNCVZ1Q2kLi8wxDtxd4ljBCgsE6Ak=;
        b=kzGbIEuRNDaepKX0L7hL+bHAUWKBRm0cOcaD0dfXRqxA/1BYEtFTkXtHDYJs2MSp2O
         OaOhIc7XKUvr+Zrbmcg3P9KdF3MhcV/077uzeKf0G4kFjNFwBcMrsFkOMG6VUmh3eWf3
         H9lzBfGnfbe67ziEZR77N0t/DMPQxzUTftfcc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=hWhKusTgYkur2QEk4/d9N71nsRAuS7wFRaXBK02m7JQoSDzUS5twah2F/5C+ccmeu0
         C5tJodXVytSuNVS5e+hWMf30YpPFJFjkUfchqk1BM6lsPvMHLcmr+deOXEA9ZyrSEw/+
         YvzMIgRb2CVS0sUvAmP681ZRE4wqyQPs/NWDY=
Received: by 10.204.141.17 with SMTP id k17mr1006576bku.41.1300357310701;
        Thu, 17 Mar 2011 03:21:50 -0700 (PDT)
Received: from localhost.localdomain (abvc119.neoplus.adsl.tpnet.pl [83.8.200.119])
        by mx.google.com with ESMTPS id b7sm1245506bkb.18.2011.03.17.03.21.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Mar 2011 03:21:48 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p2HALEZa007972;
	Thu, 17 Mar 2011 11:21:19 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p2HAL3TE007968;
	Thu, 17 Mar 2011 11:21:03 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1300286650.28805.29.camel@drew-northup.unet.maine.edu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169231>

Drew Northup <drew.northup@maine.edu> writes:
> On Wed, 2011-03-16 at 09:34 -0500, Jonathan Nieder wrote:
> > Drew Northup wrote:
> > 
> > > I just upgraded my Gitweb package (I'm testing the EPEL RHEL5 latest;
> > > I'm not too happy with them tweaking the paths) and as I should have
> > > expected all of my Gitweb configuration is now gone.

We discourage configuring gitweb by editing generated gitweb.cgi file
for a long, long time, at least since v1.4.2-rc2-102-gc8d138a (gitweb:
optionally read config from GITWEB_CONFIG, 2006-08-02).  It is
described in gitweb/README since v1.4.3-rc1-7-g45a3b12 (gitweb:
Document features better, 2006-10-07).

> > 
> > In gitweb/README, I see:

Not only gitweb/README; in gitweb.cgi that you are, I suppose,
editing, you have $GITWEB_CONFIG mentioned 25 times as a place
to override default configuration.

> > 
> > | You can adjust gitweb behaviour using the file specified in `GITWEB_CONFIG`
> > | (defaults to 'gitweb_config.perl' in the same directory as the CGI), and
> > | as a fallback `GITWEB_CONFIG_SYSTEM` (defaults to /etc/gitweb.conf).
> 
> I apparently missed that. Alas, I didn't see it in the code when I was
> setting my values so I assumed that it wasn't available.

$GITWEB_CONFIG is mentioned 25 times in gitweb source; is it not enough?

> Perhaps we can make this a little more obvious?

How can we make it more obvious?  gitweb/INSTALL has "Build time
configuration" just below instruction on how to build it, and it
mentions "How to configure gitweb for your local system" section in
gitweb/README in very first line of this section.

> I'll go try that out and see if I can make it break--putting it in
> the same directory definitely wouldn't have helped this time.

First, as Jonathan cited, you can by default beside
'gitweb_config.perl' in the same directory as the CGI use '
/etc/gitweb.conf' file.

Second, you can configure where GITWEB_CONFIG and GITWEB_CONFIG_SYSTEM
are to be found dusing build time, e.g.

  $ make GITWEB_CONFIG_SYSTEM=/etc/gitweb/gitweb_config.perl \
         install-gitweb

Third, you can override where gitweb searches for its config files
using GITWEB_CONFIG and/or GITWEB_CONFIG_SYSTEM configuration
variables; quite useful for debugging gitweb, and for gitweb tests in
git.git repository.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
