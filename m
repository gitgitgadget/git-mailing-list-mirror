From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Updated base64 patches
Date: Wed, 13 Apr 2005 13:26:43 -0700
Message-ID: <425D8083.70105@zytor.com>
References: <20050413165310.GA22428@elte.hu> <425D4FB1.9040207@zytor.com> <20050413171052.GA22711@elte.hu> <Pine.LNX.4.58.0504131027210.4501@ppc970.osdl.org> <20050413182909.GA25221@elte.hu> <Pine.LNX.4.58.0504131144160.4501@ppc970.osdl.org> <20050413200237.GA26635@elte.hu> <425D7C0F.2050109@zytor.com> <20050413201523.GC27088@elte.hu> <20050413201836.GA27694@elte.hu> <20050413202102.GA27733@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 22:25:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLoOp-00082T-QA
	for gcvg-git@gmane.org; Wed, 13 Apr 2005 22:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVDMU1D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Apr 2005 16:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVDMU1D
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Apr 2005 16:27:03 -0400
Received: from terminus.zytor.com ([209.128.68.124]:59347 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261181AbVDMU1A
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2005 16:27:00 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3DKQn7i022231
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 Apr 2005 13:26:49 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050413202102.GA27733@elte.hu>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I have uploaded two new base64 patches, one which uses the flat 
repository and one which doesn't:

ftp://ftp.kernel.org/pub/linux/kernel/people/hpa/git-0.04-base64-3.diff
ftp://ftp.kernel.org/pub/linux/kernel/people/hpa/git-0.04-base64-flat-3.diff

... both are still against the git-0.04 tarball.

The only differences is changing "char" to "signed char" in places where 
it actually matters (since plain char is unsigned on some platforms), 
and, for the non-flat version, allowing the cache subdirectories to be 
lazily created (if ENOENT is returned, try mkdir before giving up.)

	-=hpa
