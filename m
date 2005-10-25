From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] GIT paths
Date: Tue, 25 Oct 2005 09:53:06 -0700
Message-ID: <435E62F2.6050400@zytor.com>
References: <7vhdb7qown.fsf@assigned-by-dhcp.cox.net> <435E259D.3040701@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 18:55:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUS39-0001Mv-9f
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 18:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbVJYQxU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 12:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbVJYQxU
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 12:53:20 -0400
Received: from terminus.zytor.com ([192.83.249.54]:38084 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932207AbVJYQxU
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 12:53:20 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9PGrBWl009684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 25 Oct 2005 09:53:11 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <435E259D.3040701@op5.se>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10597>

Andreas Ericsson wrote:
>>
>>  - Over a git-daemon connection, supporting ~user expansion
>>    makes sense.  E.g git://host.xz/~junio/ refers to my home
>>    directory on that machine.  It would make it impossible to
>>    have a directory literally named '~junio' directly underneath
>>    the root directory, but that is a good limitation anyway.
>>
> 
> I like this idea, although I'd extend it with a Userdir-like config 
> option in git-daemon (like ~/public_html for apache). This makes it a 
> bit easier to see what's published and what isn't.
> 

I've found that whenever one does a network daemon which exports paths, 
sooner or later one wants namespace management.  In Linux, of course, 
there are a lot more tricks one can play to actually create the 
namespace one wants in the filesystem (although it's complicated by 
needing to have an exec-worthy environment.)

It might be worth to consider creating a library to do this.

	-hpa
