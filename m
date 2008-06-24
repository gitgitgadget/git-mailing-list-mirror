From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 12:08:31 -0700 (PDT)
Message-ID: <m31w2mlki4.fsf@localhost.localdomain>
References: <jeske@willow=01l5V7waFEDjChmh>
	<willow-jeske-01l5PFjPFEDjCfzf-01l5V7wbFEDjCX7V>
	<willow-jeske-01l5cKsCFEDjC=91MX> <48612ABE.6000104@panasas.com>
	<48612CB0.2070303@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Jeske <jeske@google.com>, git@vger.kernel.org
To: Boaz Harrosh <bharrosh@panasas.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 21:09:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBDtT-0003Ep-OT
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 21:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbYFXTIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 15:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751712AbYFXTIf
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 15:08:35 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:28665 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbYFXTIe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 15:08:34 -0400
Received: by ug-out-1314.google.com with SMTP id h2so8347ugf.16
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 12:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=muBqfc6ArL3awIt23qO4KbS8mgSEzWhAWp7tXRwguSM=;
        b=SdfAWA81EAWVCgHpmncWwJkkt76jsWsAHmoSTBWOtoNdspVMvdiu18rgRMxgupr84r
         u/WDqmlsSHVJJl2SO8S+YwDAGP9rEGQo2BsMulqVNzoFGcjCMLf5JWvXzR6uFZDtSnSh
         wxPj4VJc9khjsLiERf7yx0UFMWlBJP32JDrgU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=gOyCYEX+i+hxBQOx+9XErqmHCUdjw/Hb5lUVf1mS/z39TrzGSkxhpLx/CcWnlo1ch8
         bFJiPn7/NX/PeRSfgOnDU0K7CjwCeAwrfSNkEakYy04djTELU5qq1QakogQ9bhzKZQvP
         /VNjCrYk2273ptu6OBngWZgaNGJZL+/rbZKUw=
Received: by 10.67.116.19 with SMTP id t19mr26683ugm.56.1214334512849;
        Tue, 24 Jun 2008 12:08:32 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.223.44])
        by mx.google.com with ESMTPS id e23sm96426ugd.47.2008.06.24.12.08.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Jun 2008 12:08:31 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5OJ7r7Z010320;
	Tue, 24 Jun 2008 21:08:03 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5OJ7VGG010316;
	Tue, 24 Jun 2008 21:07:32 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <48612CB0.2070303@panasas.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86109>

Boaz Harrosh <bharrosh@panasas.com> writes:


> Sorry
> git-reset --clean -f/-n for removing local changes
> git reset --hard for moving HEAD on a clean tree only

Wouldn't "git reset <commit-ish>" be enough then?  It modifies where
current branch points to (as opposed to git-checkout modifying what is
the current branch), and it modifies index.  What it doesn't modify is
working directory, but it is clean already.

So the solution is: don't use `--hard'.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
