From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: bug: build from tarball uses git-describe
Date: Tue, 13 Feb 2007 23:59:47 +0100
Message-ID: <eqtfso$7mo$1@sea.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 14 00:04:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH6gf-0001WI-Kk
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 00:03:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbXBMXDq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 18:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbXBMXDq
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 18:03:46 -0500
Received: from main.gmane.org ([80.91.229.2]:54449 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428AbXBMXDp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 18:03:45 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HH6fQ-0004u3-KJ
	for git@vger.kernel.org; Wed, 14 Feb 2007 00:02:34 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Feb 2007 00:02:32 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Feb 2007 00:02:32 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.9 (X11/20070130)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39598>



while building GIT from tarball inside a GUB checkout 
(GUB is a build environment , now using GIT for version
control):

sed -e '1s|#!.*/sh|#!/bin/sh|' \
            -e 's|@@PERL@@|/usr/bin/perl|g' \
            -e 's/@@GIT_VERSION@@/release_2.11.17.1_of_lilypond_release/2.11.16.1.g3abe43a66cf3655e5ec5486c3001ac2ac479433.3.gdb02-dirty/g' \
            -e 's/@@NO_CURL@@//g' \


apparently, the makefile blindly uses the output of 

  git describe 

without checking whether there is a .git directory.

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
