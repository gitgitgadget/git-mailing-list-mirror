From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: Tracking selected files from different repository
Date: Sun, 20 Jun 2010 10:22:17 +0200
Message-ID: <20100620082217.GA13060@vidovic>
References: <1276971140188-5199181.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: jhapk <pradeep.kumar.jha@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 20 10:22:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQFnR-0006Ve-0l
	for gcvg-git-2@lo.gmane.org; Sun, 20 Jun 2010 10:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755379Ab0FTIWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jun 2010 04:22:23 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58383 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755072Ab0FTIWV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jun 2010 04:22:21 -0400
Received: by wyb33 with SMTP id 33so1529302wyb.19
        for <git@vger.kernel.org>; Sun, 20 Jun 2010 01:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=vB4IMjRSN/iHY9hdJLIT/I4AXvzy2gBxLM/v0jSXSP4=;
        b=ITkKHcazeV/VWxyWN6rvtAnh0YnpZbhg2vm0jPEAZJngpJ4vu/SOS70w2k0urJB0r3
         hZI4tNvMAffrNPsuvEk2RCdh1GWzO52W02ssubgfhFuh/ONZK3EO8lVaAVa+EBlVcIv0
         4pimFGlPkr7vCI15O89LNc+NcPfsegfYw4BxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nBxEXQmN9Cz3p609NSp4+bg6cphlxcFL/CEEvtcgHQzTFbpcJ1ABgzmqW+I2dfDN3W
         TncYj+6HdcDphELoVdbVWd0rQBtHgEPbXH4VEMsfw/qxRL1Hdr9cIaEkIMty7It6pHRz
         J6ejIvU/F9Hyga1/EgVBYuIAohRfO+QHbMCao=
Received: by 10.227.144.79 with SMTP id y15mr3312436wbu.73.1277022140041;
        Sun, 20 Jun 2010 01:22:20 -0700 (PDT)
Received: from @ (88-121-116-223.rev.libertysurf.net [88.121.116.223])
        by mx.google.com with ESMTPS id u36sm17426562wbv.0.2010.06.20.01.22.18
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 20 Jun 2010 01:22:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1276971140188-5199181.post@n2.nabble.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149390>

The 19/06/10, jhapk wrote:

> I have a source code in a repository A. A has 1000s of files.  In A, I have
> added like 10 new files. For some reasons, I work on these 10 files in a
> different repository B. Is it somehow possible that I can make only these 10
> files pull and push easily from my repository B? There is nothing else
> common between A and B, so I am not sure if putting B as a remote and making
> a branch in A to track it is a feasible idea.

Having B as a remote looks like the most convenient choice if both
repositories have the same history as you can then play with the usual
git commands: diff, log, cherry-pick, etc.

Otherwise, you may either:
- make a new B as a Git fork of A so they share history (and fallback to
  my answer above) ;
or
- play with 'format-patch' and 'am' to export/import (maybe customised)
  commits.

-- 
Nicolas Sebrecht
