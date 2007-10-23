From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] execv_git_cmd(): also try PATH if everything else fails.
Date: Tue, 23 Oct 2007 17:29:49 +0200
Message-ID: <471E136D.4010905@viscovery.net>
References: <1192867937.v2.fusewebmail-240137@f> <20071020205721.GA16291@srparish.net> <Pine.LNX.4.64.0710202258440.25221@racer.site> <20071021023614.GB14735@spearce.org> <Pine.LNX.4.64.0710212256270.25221@racer.site> <20071022143637.GP16291@srparish.net> <471CBF88.6020300@op5.se> <471CC380.5030603@viscovery.net> <471DD703.70608@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Scott Parish <sRp@srparish.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Oct 23 17:30:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkLhl-0003Pr-7G
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 17:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbXJWP3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 11:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751916AbXJWP3y
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 11:29:54 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:64650 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758AbXJWP3x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 11:29:53 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IkLhE-00015C-VP; Tue, 23 Oct 2007 17:29:33 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 4217E6C4; Tue, 23 Oct 2007 17:29:49 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <471DD703.70608@op5.se>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62130>

Andreas Ericsson schrieb:
> Johannes Sixt wrote:
>> But I can't think of any negative side effect if *all* exec-path 
>> candidates are in $PATH. It's important, though, that all paths are 
>> absolute because the tools chdir every now and then.
>>
> 
> So long as they're added in "success:failed:failed" order, I don't see
> any issues either. Assuming we stop prepending once we find something
> that works, that should be a non-issue.

No, the point is exactly to let execvp() do all the work and we don't care 
which of the paths is the "success". And I don't think that this has any 
negative side effects.

-- Hannes
