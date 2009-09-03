From: Nasser Grainawi <nasser@codeaurora.org>
Subject: Re: [JGIT] Request for help
Date: Thu, 03 Sep 2009 13:46:16 -0600
Organization: Code Aurora Forum
Message-ID: <4AA01D08.3060400@codeaurora.org>
References: <4A9EFFB1.9090501@codeaurora.org> <20090903012315.GG1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 03 21:46:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjIGH-0001Zo-0I
	for gcvg-git-2@lo.gmane.org; Thu, 03 Sep 2009 21:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756090AbZICTqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 15:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756063AbZICTqO
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 15:46:14 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:31135 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756035AbZICTqO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 15:46:14 -0400
X-IronPort-AV: E=McAfee;i="5300,2777,5730"; a="23055521"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine01.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 03 Sep 2009 12:46:16 -0700
Received: from [129.46.10.111] (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id E5E5310004C9;
	Thu,  3 Sep 2009 12:48:27 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
In-Reply-To: <20090903012315.GG1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127664>

Shawn O. Pearce wrote:
> Nasser Grainawi <nasser@codeaurora.org> wrote:
>> Should PatchId be a class on its own, or just a method within the Patch  
>> class?
> 
> Hmm, maybe a method on Patch is reasonable.
> 

Going down this route, I'd add a few things to Patch.
patchId would be a private field (of type ObjectId?)
getPatchId would be a public method that returns patchId
and then likely a private method (computePatchId?) that actually 
generates the patchId

This way any method in Patch that would potentially change a Patch 
object's patch-id would call computePatchId before it returns.

Thoughts?
