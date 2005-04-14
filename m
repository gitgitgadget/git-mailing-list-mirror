From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Yet another base64 patch
Date: Wed, 13 Apr 2005 23:27:46 -0700
Message-ID: <425E0D62.9000401@zytor.com>
References: <425DEF64.60108@zytor.com> <20050414022413.GB18655@64m.dyndns.org> <425E0174.4080404@zytor.com> <20050414024228.GC18655@64m.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 08:25:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLxmE-00066I-3G
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 08:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVDNG1w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 02:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVDNG1w
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 02:27:52 -0400
Received: from terminus.zytor.com ([209.128.68.124]:44516 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261399AbVDNG1u
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 02:27:50 -0400
Received: from [172.27.0.18] (c-67-169-23-106.hsd1.ca.comcast.net [67.169.23.106])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3E6RkGP029840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 Apr 2005 23:27:48 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Christopher Li <git@chrisli.org>
In-Reply-To: <20050414024228.GC18655@64m.dyndns.org>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Christopher Li wrote:
> 
> But if you write a large number of random files, when htree has three
> levels index. htree will suffer on the effect that it dirty random block
> very quickly, most block get dirty only contain one or two new entries.
> Ext3 will choke on it due to the limited journal size.
> 
> While non-index directory, new entry are very compact on the blocks.
> So it end up dirty a lot less blocks, of course, lookup will suffer.
> 
> Depend on you want check out fast or write a big tree fast, you can't
> win it all.
> 

Actually, the subdirectory hack has the same effect, so you lose 
regardless.  Doesn't mean that you can't construct cases where the 
subdirectory hack doesn't win, but I maintain that those are likely to 
be artificial.

It's probably worth noting that you have to assume htree is on, since 
that's the typical default for a Linux installation, even if you use the 
subdirectory hack.

	-hpa
