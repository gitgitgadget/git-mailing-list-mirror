From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] import-tars: be nice to wrong directory modes
Date: Sat, 28 Apr 2007 18:36:33 -0700
Message-ID: <86tzv07yhq.fsf@blue.stonehenge.com>
References: <Pine.LNX.4.64.0704290159230.29859@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Apr 29 03:36:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhyL8-0000Uq-Ib
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 03:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbXD2Bgf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 21:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753255AbXD2Bgf
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 21:36:35 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:11259 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbXD2Bge (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 21:36:34 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id A40A71DE5B7; Sat, 28 Apr 2007 18:36:33 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.4.16; tzolkin = 7 Cib; haab = 4 Uo
In-Reply-To: <Pine.LNX.4.64.0704290159230.29859@racer.site> (Johannes Schindelin's message of "Sun, 29 Apr 2007 01:59:47 +0200 (CEST)")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45807>

>>>>> "Johannes" == Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

Johannes> +		next if $name =~ '/$';

This is misleading.  That's a regex there.  And it also falsely matches a
string ending in "/\n", but I bet there are parts of git that break on those
filenames too. :)

Consider:

        next if $name =~ m{/\z};

which matches precisely when the filename ends in /.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
