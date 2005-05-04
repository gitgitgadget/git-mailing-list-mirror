From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: commit-id fails after cg-init
Date: Wed, 04 May 2005 08:45:36 -0700
Message-ID: <4278EE20.8080004@zytor.com>
References: <1115150585.28520.11.camel@dv> <20050503211301.GA15995@pasky.ji.cz> <4278E6D4.6060807@dwheeler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, Pavel Roskin <proski@gnu.org>,
	git <git@vger.kernel.org>, Joel.Becker@oracle.com
X-From: git-owner@vger.kernel.org Wed May 04 17:42:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTLym-0005yH-4Y
	for gcvg-git@gmane.org; Wed, 04 May 2005 17:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVEDPq1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 11:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbVEDPq0
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 11:46:26 -0400
Received: from terminus.zytor.com ([209.128.68.124]:4501 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261888AbVEDPqX
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 4 May 2005 11:46:23 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j44Fjgrb025713
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 4 May 2005 08:45:43 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: "David A. Wheeler" <dwheeler@dwheeler.com>
In-Reply-To: <4278E6D4.6060807@dwheeler.com>
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.0 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David A. Wheeler wrote:
> Joel Becker said:
> 
>> Well, cg-init in this case creates no objects.  I'd say,
>> instead, it should create an empty tree object (representing a project
>> with no files) and commit that.  That would be your initial commit, and
>> would put something valid in heads/master.
> 
> That would actually make sense; commits would go all the way
> back to the "empty tree" as the ultimate initial tree.
> 
> There's an interesting side-effect of this; I _think_ it's
> fine but it might be worth thinking through. If all
> new projects start with an empty tree, that creates a
> "common root" that all projects can appeal to.
> That means that in theory a merge between any two project root
> trees can eventually find a common ancestor: the empty tree.
> I _think_ that's okay... is it?
> 

In fact, I think that's a Very Good Thing... it eliminates an 
unnecessary corner case.  Same reason linked lists want head nodes and 
all that jazz.

	-hpa
