From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH 0/2] A new merge algorithm, take 3
Date: Thu, 08 Sep 2005 17:23:25 -0400
Message-ID: <4320ABCD.1060803@gmail.com>
References: <20050907164734.GA20198@c165.ib.student.liu.se>	<7v1x407min.fsf@assigned-by-dhcp.cox.net> <7v4q8vuvom.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 08 23:26:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDTs2-0002Pu-Uu
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 23:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbVIHVX3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 17:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbVIHVX3
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 17:23:29 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:24439 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964987AbVIHVX1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2005 17:23:27 -0400
Received: by wproxy.gmail.com with SMTP id 50so1120437wri
        for <git@vger.kernel.org>; Thu, 08 Sep 2005 14:23:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=flLKeqVedLh1WtqlIIzBj+EzUMn1z1ovpAjMKlCVCPUHR94XJb2OD7vROme2nzfzZp8M8DNKLfjcOpDy2Ge8bahltm0eNMf0VfK9wg5+3CtG9JH7UKm/U7ta5iJR+gpZbZ2NAKu702qtfiCUvGrqixlD35Dv7q4cekhDL6desdE=
Received: by 10.54.36.9 with SMTP id j9mr6325136wrj;
        Thu, 08 Sep 2005 14:23:26 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.97])
        by mx.gmail.com with ESMTP id 24sm5223079wrl.2005.09.08.14.23.26;
        Thu, 08 Sep 2005 14:23:26 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q8vuvom.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8219>

Junio C Hamano wrote:
[...]
> Subject: [PATCH] Multi-backend merge driver.
> 
> This is just an illustration of concept patch.
> 
> The new command 'git merge' takes the current head and one or more
> remote heads, with the commit log message for the automated case.
> 
> If the heads being merged are simple fast-forwards, it acts the
> same way as the current 'git resolve'.  Otherwise, it tries
> different merge strategies and takes the result from the one that
> succeeded auto-merging, if there is any.
> 
> If no merge strategy succeeds auto-merging, their results are
> evaluated for number of paths needed for hand resolving, and the
> one with the least number of such paths is left in the working
> tree.  The user is asked to resolve them by hand and make a
> commit manually.
[...]

This last paragraph concerns me because it limits us to a very simple 
metric, "number of paths needed for hand resolving". Some "hand 
resolving" situations can be more complex than others and it would nice 
to use that information if it was available.

Of course I have no idea what that information may be or how it can be 
computed.
