From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH 1/2] diff --stat: use asymptotic scaling in graph
Date: Thu, 12 Oct 2006 15:48:05 -0700
Message-ID: <452EC625.7050301@gmail.com>
References: <d620685f0610121237k458665c5m7bbde2d565d7ef81@mail.gmail.com> <20061012201646.GC10922@admingilde.org> <d620685f0610121437m38eb454g7597b2a93010b023@mail.gmail.com> <452EBF99.5020108@gmail.com> <20061012222703.GA31152@admingilde.org>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: apodtele <apodtele@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 00:54:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY9Lh-0003R7-Hd
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 00:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWJLWsN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 18:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWJLWsM
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 18:48:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:28250 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751265AbWJLWsL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 18:48:11 -0400
Received: by nf-out-0910.google.com with SMTP id x30so725042nfb
        for <git@vger.kernel.org>; Thu, 12 Oct 2006 15:48:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=g+tZhdeaf8LN4XFr6WqTRr8cP45wg/9cUT0uaSO9R6CC/JnzRx9A9fCpsQzPjB20O10XqMc4Ha+107uwUUehovqQddlOTomGf1xEt84QV/Z1EQa/cndfP1cA0HqPMDEhGlDfP8ngdLgAYVZVPMPjET7AY/r8T29l2FDjOk9P2JY=
Received: by 10.78.128.15 with SMTP id a15mr2877621hud;
        Thu, 12 Oct 2006 15:48:09 -0700 (PDT)
Received: from ?10.0.0.6? ( [68.233.231.217])
        by mx.google.com with ESMTP id 37sm1156312hub.2006.10.12.15.48.07;
        Thu, 12 Oct 2006 15:48:08 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20061012222703.GA31152@admingilde.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28815>

Martin Waitz wrote:
> On Thu, Oct 12, 2006 at 03:20:09PM -0700, A Large Angry SCM wrote:
>>> +    if (it)
>>> +        return it * width / (it + width) + 1;
>>> +    else
>>> +        return 0;
>> No conditional needed:
>>
>> 	return it * width / (it + width - 1)
> 
> But then it would start scaling much earlier
> (for width 10: at 2 instead of 4).
> This is not bad per se, but different...
> 

OK:
	return (it * width + (it + width)/2)) / (it + width - 1)

Now it's back at 4. ;-)
