From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Yet another base64 patch
Date: Wed, 13 Apr 2005 22:36:52 -0700
Message-ID: <425E0174.4080404@zytor.com>
References: <425DEF64.60108@zytor.com> <20050414022413.GB18655@64m.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 07:36:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLx1l-0001BZ-Tw
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 07:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVDNFju (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 01:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVDNFju
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 01:39:50 -0400
Received: from terminus.zytor.com ([209.128.68.124]:35043 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261429AbVDNFje
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 01:39:34 -0400
Received: from [172.27.0.18] (c-67-169-23-106.hsd1.ca.comcast.net [67.169.23.106])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3E5aq56029141
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 Apr 2005 22:36:54 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Christopher Li <git@chrisli.org>
In-Reply-To: <20050414022413.GB18655@64m.dyndns.org>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Christopher Li wrote:
> On Wed, Apr 13, 2005 at 09:19:48PM -0700, H. Peter Anvin wrote:
> 
>>Checking out the total kernel tree (time checkout-cache -a into an empty 
>>directory):
>>
>>	Cache cold	Cache hot
>>stock	3:46.95		19.95
>>base64	5:56.20		23.74
>>flat	2:44.13		15.68
> 
>>It seems that the flat format, at least on ext3 with dircache, is 
>>actually a major performance win, and that the second level loses quite 
>>a bit.
> 
> That is not surprising due to the directory index in ext3. Htree is pretty
> good at random access and the hashed file name distribute evenly, that is
> the best case for htree. 
> 

Right, so by not trying to do the filesystem's job for it we actually 
come out ahead.

	-hpa
