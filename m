From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH] gitweb: Use GITWEB_CONFIG_SYSTEM even if GITWEB_CONFIG
	does exist
Date: Mon, 16 May 2011 08:10:38 -0400
Message-ID: <1305547838.3396.4.camel@drew-northup.unet.maine.edu>
References: <201105142137.16541.jnareb@gmail.com>
	 <20110514210603.GA11502@elie>  <201105151153.08826.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 14:11:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLwe6-0004Uq-OK
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 14:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649Ab1EPMLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 08:11:30 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:54217 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab1EPML3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 08:11:29 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p4GCAfvl007766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 16 May 2011 08:10:46 -0400
In-Reply-To: <201105151153.08826.jnareb@gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=5
	Fuz1=5 Fuz2=5
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p4GCAfvl007766
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1306152658.70273@sfNMzhuaSxERQwPX8YpHpQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173729>


On Sun, 2011-05-15 at 11:53 +0200, Jakub Narebski wrote:
> On Sat, 14 May 2011, Jonathan Nieder wrote:
> > Jakub Narebski wrote:
> > 
> > > If per-instance configuration file exists, then system-wide
> > > configuration was _not used at all_.  This is quite untypical and
> > > suprising behavior.
> > 
> > I agree.  How to avoid breaking existing installations, though?  (I'm
> > especially worried because distro packages tend to ship their own
> > /etc/gitweb.conf, so the admin might not even know about what's
> > there.)  For example, depending on the content of /etc/gitweb.conf,
> > this has the potential to break "git instaweb".
> 
> I don't think that this change has potential to break "git instaweb",
> because "git instaweb" creates its own gitweb_conf.perl - settings
> there would override distro's /etc/gitweb.conf.  But I have not checked
> if it doesn't rely on some values being default; it shouldn't though.
> 
> It is a PITA to have to retain backward compatibility with our bugs
> and mistakes.  Perhaps this change is for 1.8.0 version boundary, then?

I'm comfortable putting this at the 1.8.0 boundary. Frankly, I think
that the default /etc/gitweb.conf should be a file full of commented-out
examples anyway. I do believe that at least one distro is doing that
already. Doing so decreases the potential pain for those still expecting
the old behavior.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
