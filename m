From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Suggestion: superceded tags
Date: Fri, 27 May 2005 09:10:10 -0700
Message-ID: <42974662.3040106@zytor.com>
References: <4296B051.10603@zytor.com> <1117193179.1957.28.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 18:11:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbhOR-0007Rw-D1
	for gcvg-git@gmane.org; Fri, 27 May 2005 18:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbVE0QKs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 12:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbVE0QKs
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 12:10:48 -0400
Received: from terminus.zytor.com ([209.128.68.124]:15775 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262488AbVE0QK2
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 12:10:28 -0400
Received: from [172.27.0.18] (c-67-169-23-106.hsd1.ca.comcast.net [67.169.23.106])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j4RGAAXD030772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 27 May 2005 09:10:11 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: "Stephen C. Tweedie" <sct@redhat.com>
In-Reply-To: <1117193179.1957.28.camel@sisko.sctweedie.blueyonder.co.uk>
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=0.3 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Stephen C. Tweedie wrote:
> Hi,
> 
> On Fri, 2005-05-27 at 06:29, H. Peter Anvin wrote:
> 
> 
>>When a tag is moved, a new tag object is created.  This tag object will 
>>have a "supercedes" header which references the old tag object.
> 
> Strictly speaking, don't you need to allow multiple "supercedes" lines
> to cover all the cases?  The pathological case is when you've got
> multiple trees all with different variants of the same tag name, and you
> try to merge them all at once with a multi-parent commit.  
> 
> Sure, tags refer to trees, not commits, so you don't necessarily have to
> do this tag resolution at commit time (indeed, since commits don't refer
> to tags, you *can't* do that resolution atomically on commit.)
> 
> But if you do pull tags into the local .git/refs/tags on merge, then you
> will want to either resolve the conflict or supercede those tags, and at
> that point you've got multiple equally valid tags in the histories that
> are being superceded.  Doing so is a porcelain issue, but the core will
> still need to understand tags with multiple supercedes: lines.
> 

Indeed, multiple supercedes lines are useful to conver the resolution of 
a tag conflict.

	-hpa
