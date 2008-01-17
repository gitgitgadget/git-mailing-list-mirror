From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git apply behaves differently from patch(1)
Date: Thu, 17 Jan 2008 09:11:44 +0100
Message-ID: <478F0DC0.9030107@viscovery.net>
References: <200801162358.48723.zander@kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Zander <zander@kde.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 09:12:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFPre-00009n-Ev
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 09:12:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753474AbYAQILu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 03:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753487AbYAQILu
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 03:11:50 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:63118 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588AbYAQILt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 03:11:49 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JFPqf-00013X-6C; Thu, 17 Jan 2008 09:11:41 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 334DB54D; Thu, 17 Jan 2008 09:11:44 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <200801162358.48723.zander@kde.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70838>

Thomas Zander schrieb:
> In the following usecase git apply (git version 1.5.4.rc3.15.g785f9) 
> doesn't do what I expect it should do. I expect it to do the same as 
> patch does in the same situation.
> 
> To reproduce;

[... hand-edit a patch without context ...]

> What I expect (and what I get if I replace git apply with a 'patch -R -p1 
> < mypatch') is that the diff shows line "2" is still missing.
> 
> What I get instead is that "2" is missing but also that "10" moved 2 lines 
> up.
> I conclude that git somehow doesn't like the patch to be removed, while 
> patch(1) has no problem with that.
> 
> I hope you agree its a bug and fix it in an upcoming version, it would be 
> great if I can avoid using patch(1) or worse.

It's not exactly a bug. The behavior of zero-context patches is simply not
well-defined. You have just been lucky that patch worked in the way that
you expected. Don't use zero-context patches.

That said git-apply can certainly be modified to behave like patch in this
case. I tried, but gave up - it's too much code that is new to me. :(

-- Hannes
