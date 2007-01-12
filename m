From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Fri, 12 Jan 2007 15:39:56 +0100
Organization: eudaptics software gmbh
Message-ID: <45A79DBC.1795F5C4@eudaptics.com>
References: <riddochc@gmail.com> <200701121409.l0CE9923015123@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Chris Riddoch <riddochc@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 12 15:40:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5NZp-0006G7-J1
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 15:40:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbXALOjj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 09:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbXALOjj
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 09:39:39 -0500
Received: from main.gmane.org ([80.91.229.2]:57830 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918AbXALOji (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 09:39:38 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H5NYy-0002ri-Up
	for git@vger.kernel.org; Fri, 12 Jan 2007 15:39:25 +0100
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Jan 2007 15:39:24 +0100
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Jan 2007 15:39:24 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36675>

"Horst H. von Brand" wrote:
> Hum... something like the following (completely untested!) should do the
> trick:
> 
>   cd /basedir
>   mkdir codebase; cd codebase; git init-db
>   for version in 1.0 1.1 1.1a 1.1b 2.0.0 ...; do
>      cd /basedir
>      tar xf tarball-$version.tar
>      mv codebase-$version/* codebase    # Take care to move everything!
>      cd codebase
>      git add .
>      git commit -a -m "Updated to $version"
>      rm -rf *                  # Delete everything except for git stuff
>   done

You can let GIT_DIR point somewhere outside the extracted directory.

If the dates of your tarballs are meaningful, you can use something like
this:

export GIT_AUTHOR_DATE="$(date --reference=foo-1.1.tar +%s) -07:00"

   
-- Hannes
