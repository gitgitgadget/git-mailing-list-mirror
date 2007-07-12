From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: mtimes of working files
Date: Thu, 12 Jul 2007 06:05:53 -0700
Message-ID: <86myy122mm.fsf@blue.stonehenge.com>
References: <f36b08ee0707110808h56ecbc7at9c92727c01cca508@mail.gmail.com>
	<Pine.LNX.4.64.0707111902040.4516@racer.site>
	<f36b08ee0707111136t198cf559vc85c561decf9707f@mail.gmail.com>
	<Pine.LNX.4.64.0707111940080.4516@racer.site>
	<20070712062605.GD29676@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jul 12 15:06:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8yMn-0007cn-DW
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 15:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762330AbXGLNFy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 09:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763394AbXGLNFy
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 09:05:54 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:5091 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761845AbXGLNFx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 09:05:53 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 8FC991DE629; Thu, 12 Jul 2007 06:05:53 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.8.11; tzolkin = 4 Chuen; haab = 19 Tzec
In-Reply-To: <20070712062605.GD29676@muzzle> (Eric Wong's message of "Wed, 11 Jul 2007 23:26:05 -0700")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52281>

>>>>> "Eric" == Eric Wong <normalperson@yhbt.net> writes:

Eric> open FH, "git log -r --name-only --no-color --pretty=raw -z @ARGV |" or die $!;

This breaks needlessly on @ARGV names that contain spaces.  You want:

  open FH, "-|", qw(git log -r --name-only --no-color --pretty=raw -z), @ARGV or die $!;

But that sounds familiar.... I think there's a function somewhere included in
the git distro that does this.  I'm old and senile though. :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
