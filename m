From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 27/40] Windows: Implement a custom spawnve().
Date: Thu, 28 Feb 2008 22:04:20 +0100
Message-ID: <200802282204.20168.johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-28-git-send-email-johannes.sixt@telecom.at> <alpine.LSU.1.00.0802281535210.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 22:05:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUpw5-0008CI-L2
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 22:05:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761854AbYB1VEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 16:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761659AbYB1VEX
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 16:04:23 -0500
Received: from smtp1.srv.eunet.at ([193.154.160.119]:51264 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755109AbYB1VEV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 16:04:21 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id B363933B49;
	Thu, 28 Feb 2008 22:04:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 5BD255B9E3;
	Thu, 28 Feb 2008 22:04:20 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LSU.1.00.0802281535210.22527@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75458>

On Thursday 28 February 2008 16:36, Johannes Schindelin wrote:
> On Wed, 27 Feb 2008, Johannes Sixt wrote:
> > -	cmd->pid = spawnvpe(_P_NOWAIT, cmd->argv[0], cmd->argv, (const 
char**)env); 
> > +	cmd->pid = mingw_spawnvpe(cmd->argv[0], cmd->argv, env);
>
> Should this not be "#define spawnvpe mingw_spanvpe" in git-compat-util.h
> instead?

No. We don't mimic the API of the original spawnvpe. Why obfuscate this fact?

-- Hannes
