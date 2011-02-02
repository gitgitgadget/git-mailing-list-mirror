From: Pascal Obry <pascal@obry.net>
Subject: Re: git svn clone stops after r2 for svn://mlton.org/mlton/trunk
Date: Wed, 02 Feb 2011 21:19:11 +0100
Organization: Home - http://www.obry.net
Message-ID: <4D49BC3F.5080902@obry.net>
References: <87aaijso0j.fsf@mid.deneb.enyo.de>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Wed Feb 02 21:19:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkjAe-0002nM-A8
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 21:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393Ab1BBUTO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 15:19:14 -0500
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:50050 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679Ab1BBUTO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 15:19:14 -0500
Received: from [192.168.0.100] ([82.124.203.119])
	by mwinf5d09 with ME
	id 38KB1g0132b4kYJ038KBNk; Wed, 02 Feb 2011 21:19:12 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <87aaijso0j.fsf@mid.deneb.enyo.de>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165933>


Florian,

> There's something strange going on there:
> 
> $ git svn clone svn://mlton.org/mlton/trunk mlton 
> Initialized empty Git repository in /home/fw/src/mlton/.git/
> r2 = 61f0dd5ba401ece2ff4668bc7454b7742c60fa99 (refs/remotes/git-svn)
> Checked out HEAD:
>   svn://mlton.org/mlton/trunk r2

This is probably because the first revision in trunk is r2 and there is
no r0 nor a r1. This repository has been converted from CVS (see r2). In
such a case you can convert properly using:

   $ git svn clone -s -r3:7500 svn://mlton.org/mlton mlton

r3 is the first actual revision, all see can be seen using:

   $ svn://mlton.org/mlton/trunk mlton

Note that I have used -s as this repository is using a standard svn layout.

Hope this helps.

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
