From: Rafael Kitover <rkitover@io.com>
Subject: Major git-svn fail
Date: Thu, 28 Jan 2010 20:50:16 -0500
Message-ID: <20100129015016.GD759@hlagh.dongs>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 29 03:34:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaghC-0007r5-T4
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 03:34:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755063Ab0A2Ceu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 21:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754934Ab0A2Ceu
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 21:34:50 -0500
Received: from caelum.cachemiss.com ([74.207.225.29]:58680 "EHLO
	caelum.cachemiss.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030Ab0A2Ceu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 21:34:50 -0500
X-Greylist: delayed 2664 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jan 2010 21:34:50 EST
Received: from c-76-98-235-160.hsd1.pa.comcast.net ([76.98.235.160] helo=hlagh.dongs)
	by caelum.cachemiss.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.69)
	(envelope-from <rkitover@io.com>)
	id 1Nag07-00083J-EC
	for git@vger.kernel.org; Fri, 29 Jan 2010 01:50:24 +0000
Received: by hlagh.dongs (sSMTP sendmail emulation); Thu, 28 Jan 2010 20:50:16 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138295>

Hello,

I'm trying to convert an SVK repo to git using the steps described here:
http://blog.woobling.org/2009/06/git-svn-abandon.html

I'm using the latest devel git from git as the svk reparenting stuff
seems to have gotten merged already.

When I used the old code from samv's github
(http://github.com/samv/git/tree/svn-merge-attrs) it ran through the
clone all the way, but I had a core file in the directory, so I don't
really trust the results.

This is the command I'm using and the results:
git svn clone --authors-file=sl-authors.txt
--branches='http://dev.catalyst.perl.org/repos/bast/branches/DBIx-Class-Schema-Loader/'
--tags='http://dev.catalyst.perl.org/repos/bast/DBIx-Class-Schema-Loader/tags/'
--trunk='http://dev.catalyst.perl.org/repos/bast/trunk/DBIx-Class-Schema-Loader'
'http://dev.catalyst.perl.org/repos/bast/trunk/DBIx-Class-Schema-Loader'
sl
Initialized empty Git repository in
/home/rkitover/src/git-conversion/sl/.git/
Using higher level of URL:
http://dev.catalyst.perl.org/repos/bast/trunk/DBIx-Class-Schema-Loader
=> http://dev.catalyst.perl.org/repos/bast
perl:
/tmp/buildd/subversion-1.6.9dfsg/subversion/libsvn_subr/path.c:115:
svn_path_join: Assertion `svn_path_is_canonical(component, pool)'
failed.
error: git-svn died of signal 6

The authors file I'm using is:
http://cachemiss.com/files/sl-authors.txt

These svn URLs are for a public repo, so hopefully you can reproduce my
results.

Any help much appreciated.
