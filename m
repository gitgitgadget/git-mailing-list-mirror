From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Propagating config to clones/pulls
Date: Tue, 7 Sep 2010 11:23:20 +0200
Message-ID: <201009071123.21011.trast@student.ethz.ch>
References: <A8F08AD5-6DB5-4A4D-9A8F-79DDBD93E666@getgosu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Douglas Tan <douglas@getgosu.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 11:23:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsuOo-0007yh-G1
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 11:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756126Ab0IGJXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 05:23:25 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:52308 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755997Ab0IGJXX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 05:23:23 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Tue, 7 Sep
 2010 11:23:22 +0200
Received: from thomas.site (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.0.702.0; Tue, 7 Sep
 2010 11:23:21 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <A8F08AD5-6DB5-4A4D-9A8F-79DDBD93E666@getgosu.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155691>

Douglas Tan wrote:
> 
> I have some config settings that I'll like to make default for
> anyone cloning/pulling from the central remote bare repository. I've
> tried to do this by editing the config file in the bare repository
> on the server but the change doesn't appear when cloning. How can I
> go about pushing default config settings to anyone cloing or pulling
> from the repository?

You can't, since that would open a whole range of security issues.

You can put some config defaults inside the repository itself, but it
is up to your users whether they apply them.  Perhaps it's best to
write them as a shellscript that adds to the configuration file(s) so
that it is easy to apply it later, e.g.,

  #!/bin/sh
  git config diff.jpg.textconv exiftool
  cat >> .gitattributes <<EOF
  *.jpg diff=jpg
  EOF

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
