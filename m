From: Pascal Obry <pascal@obry.net>
Subject: Re: git-svn very slow on fetch (shared git-svn repo)
Date: Sun, 11 Oct 2009 11:00:15 +0200
Organization: Home - http://www.obry.net
Message-ID: <4AD19E9F.8010302@obry.net>
References: <4AD04F95.7050603@obry.net> <20091011070136.GB16264@dcvr.yhbt.net>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Oct 11 11:03:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwuLJ-0001JZ-8s
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 11:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754057AbZJKJAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 05:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753552AbZJKJAq
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 05:00:46 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:43442 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910AbZJKJAq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 05:00:46 -0400
Received: by ewy4 with SMTP id 4so1721205ewy.37
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 01:59:33 -0700 (PDT)
Received: by 10.211.132.22 with SMTP id j22mr2564319ebn.24.1255251573178;
        Sun, 11 Oct 2009 01:59:33 -0700 (PDT)
Received: from ?192.168.0.100? (AVelizy-154-1-79-118.w86-205.abo.wanadoo.fr [86.205.109.118])
        by mx.google.com with ESMTPS id 7sm1634594eyb.21.2009.10.11.01.59.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Oct 2009 01:59:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <20091011070136.GB16264@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129908>

Hi Eric,

> For globs (branches and tags) the $GIT_DIR/svn/.metadata
> config file, under the svn-remote.svn.{branches,tags}-maxRev keys.

Right. I found out that copying the .metadata solve this problem.

> For explicitly specified refs (e.g. "trunk"), then it's in the last
> record of the corresponding rev_map (e.g.
> $GIT_DIR/svn/trunk/.rev_map.$UUID) as a 4-byte revision number + 20
> bytes of zeroes.

Seems like we do not need to copy this one as it is reconstructed by a 
simple rebase on the trunk branch. This is quite fast as reconstructed 
from the embedded git-svn-id if I'm not mistaken.

So you confirm that copying the .metadata is the solution?

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
