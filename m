From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 1/1] Make git archive respect core.autocrlf when creating
 zip format archives
Date: Thu, 18 Sep 2008 22:21:05 +0200
Message-ID: <48D2B831.8080206@op5.se>
References: <1a7cc4db062b7df0dae0f27b29dba66c9d917e59.1221767629.git.charles@hashpling.org> <20080918200120.GB8631@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Thu Sep 18 22:23:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgQ1J-00036Q-NT
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 22:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756167AbYIRUVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 16:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756138AbYIRUVO
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 16:21:14 -0400
Received: from mail.op5.se ([193.201.96.20]:46660 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755655AbYIRUVN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 16:21:13 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 0A69E1B80049;
	Thu, 18 Sep 2008 22:11:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.816
X-Spam-Level: 
X-Spam-Status: No, score=-2.816 tagged_above=-10 required=6.6
	tests=[AWL=-0.317, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hW300SCgUiUl; Thu, 18 Sep 2008 22:11:08 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id 88BDF1B80046;
	Thu, 18 Sep 2008 22:11:07 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20080918200120.GB8631@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96241>

Charles Bailey wrote:
> There is currently no call to git_config at the start of cmd_archive.
> When creating tar archives the core config is read as a side-effect of
> reading the tar specific config, but this doesn't happen for zip
> archives.
> 
> The consequence is that in a configuration with core.autocrlf set,
> although files in a tar archive are created with crlf line endings,
> files in a zip archive retain unix line endings.
> 
> Signed-off-by: Charles Bailey <charles@hashpling.org>
> ---
> 
> It took me a while to find the cause of the difference in behaviour
> between tar and zip format archives when all the crlf fixing code
> seemed to be in code shared by both archiving processes. I'm 99% sure
> that creating zip archives from repositories with core.autocrlf set to
> true should create zip entries with crlf line endings but it would be
> good to have that confirmed.
> 

If it fixes the broken test while all the other tests still
pass, I can only assume it's doing something right.

The topic is a bit long though. Could you change it to
"git archive: respect core.autocrlf when creating zip archives"
so that it fits comfortably in one line when running "git log"
on 80 char wide terminals?

As a side-note, you needn't put "1/1" in the [PATCH] section.
That's usually done to make sure patches are applied in the
right order when sending a series, but since a series of 1
is kinda hard to jumble.. ;-)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
