From: Brian Gerst <bgerst@didntduck.org>
Subject: Re: [PATCH Cogito] cg-init breaks if . contains sub-dir
Date: Tue, 10 May 2005 01:17:31 -0400
Message-ID: <428043EB.7010004@didntduck.org>
References: <20050509233904.GB878@osuosl.org> <pan.2005.05.10.03.41.15.683163@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 07:10:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVN0I-0003N0-F5
	for gcvg-git@gmane.org; Tue, 10 May 2005 07:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVEJFQ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 01:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbVEJFQ5
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 01:16:57 -0400
Received: from quark.didntduck.org ([69.55.226.66]:63399 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261546AbVEJFQx
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 01:16:53 -0400
Received: from [192.168.1.2] (24-236-201-214.dhcp.aldl.mi.charter.com [24.236.201.214])
	(authenticated)
	by quark.didntduck.org (8.11.6/8.11.6) with ESMTP id j4A5GeC27718;
	Tue, 10 May 2005 01:16:40 -0400
User-Agent: Mozilla Thunderbird 1.0.2-1 (X11/20050323)
X-Accept-Language: en-us, en
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.05.10.03.41.15.683163@smurf.noris.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Matthias Urlichs wrote:
> Hi, Brandon Philips wrote:
> 
> 
>>-	find * | xargs cg-add
>>+	find * ! -type d | xargs cg-add
> 
> 
> Actually, (almost) every use of "find | xargs" which is not a subset of
> "find -print0 | xargs -0r" is a bug.
> 
> So please don't do that. Special files aren't liked by git either, thus:
> 
>         find * -type f -print0 | xargs -0r cg-add
> 

But it can handle symlinks:

	find * -type f -o -type l -print0 | xargs -0r cg-add

--
				Brian Gerst
