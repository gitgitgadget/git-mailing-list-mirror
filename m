From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] Cleaning up die() error messages
Date: Tue, 11 Oct 2005 13:50:24 -0700
Message-ID: <434C2590.3040107@zytor.com>
References: <20051010105008.GB30202@gentoo.org> <7vzmph42j2.fsf@assigned-by-dhcp.cox.net> <pan.2005.10.11.19.48.04.675482@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 11 22:54:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPR5Q-0001zj-GE
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 22:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbVJKUu5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 16:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbVJKUu5
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 16:50:57 -0400
Received: from terminus.zytor.com ([192.83.249.54]:14056 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750808AbVJKUu4
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2005 16:50:56 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9BKoQcO020050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Oct 2005 13:50:28 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.10.11.19.48.04.675482@smurf.noris.de>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9985>

Matthias Urlichs wrote:
> 
> IMHO, common library code should not be allowed to die.
> (Yes, that does imply replacing all the xmalloc() calls.)
> 

The sane way to do this is probably to call an overridable git_die() 
function, which can be specified by the user to use longjmp(), to use 
exceptions, or do something else appropriately.

However, a much bigger problem is cleanup.

	-hpa
