From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git-core-arch: Missing dependency
Date: Fri, 11 Nov 2005 17:08:19 -0800
Message-ID: <43754083.4090501@zytor.com>
References: <200511111446.jABEk6QM023362@pincoya.inf.utfsm.cl>	<7vy83vnl7r.fsf@assigned-by-dhcp.cox.net> <4374E0EF.2020801@op5.se> <7vu0ejm30l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Chris Wright <chrisw@osdl.org>
X-From: git-owner@vger.kernel.org Sat Nov 12 02:09:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eajt6-0000a9-5I
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 02:09:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbVKLBIy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 20:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbVKLBIy
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 20:08:54 -0500
Received: from terminus.zytor.com ([192.83.249.54]:39370 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750839AbVKLBIy
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 20:08:54 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jAC18Up4026692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Nov 2005 17:08:30 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0ejm30l.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11655>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> 
>>Junio C Hamano wrote:
>>
>>>Horst von Brand <vonbrand@inf.utfsm.cl> writes:
>>>
>>>
>>>>The command git-archimport makes use of tla, but the relevant package(s) are
>>>>not on the requirements
>>>
>>>Thanks.  Should the fix be like this?
>>> Group:          Development/Tools
>>>-Requires:       git-core = %{version}-%{release}
>>>+Requires:       git-core = %{version}-%{release}, tla
>>
>>Just to be anal;
>>Requires doesn't usually include the %release,...
> 
> 
> Obviously both you and Chris (who did the part you are quoting
> for us) know RPM spec a lot better than I do, and I see two
> experts contradicting with each other.  It could have been just
> an oversight, or it might have done deliberately --- I cannot
> judge myself, so I punt here.  I'll remove "-%{release}" when I
> hear Chris says he agrees with you.
> 

You can do it either way.  It's a matter of the strictness of the 
binding.  If you put %{version} there, then it has to come from the same 
upstream release; for %{version}-%{release} it has to come from the same 
SRPM, i.e. usually from the same build.

In this case I think %{version}-%{release} is appropriate.

	-hpa
