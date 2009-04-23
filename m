From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] tests: remove xargs in favor of --stdin where possible
Date: Thu, 23 Apr 2009 11:22:20 +0200
Message-ID: <49F0334C.6000004@viscovery.net>
References: <1240468281-23815-1-git-send-email-pclouds@gmail.com> <7vfxfzwytx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 11:24:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwvA1-0004Lr-2m
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 11:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358AbZDWJW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 05:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752284AbZDWJW1
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 05:22:27 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:61166 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbZDWJW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 05:22:27 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Lwv8O-0004kg-Ud; Thu, 23 Apr 2009 11:22:21 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 74FFC4E9; Thu, 23 Apr 2009 11:22:20 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <7vfxfzwytx.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117314>

Junio C Hamano schrieb:
> The tests may not break with your change because none of them may use
> problematic characters (especially "\n" and '"'), but update-index --stdin
> without -z is not suitable for reading from output from "find" without -0
> option

Why should this be so? I thought I need -0/-z only if there are "\n" in
file names (and I specifially talk about a find | update-index pipeline).

> (on the other hand, "update-index -z --stdin" is good for reading
> output from "find -0"; but for portability we avoid GNUism "find -0").

Sure, -0/-z is safer and to be used in scripts. But for an ad-hoc command
that I type on the command line, why should I use -0/-z if I know that I
don't have any "\n" in my file names?

-- Hannes
