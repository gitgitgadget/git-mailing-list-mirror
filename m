From: Reilly Grant <reillyeon@qotw.net>
Subject: Re: [PATCH] git-p4: Avoid modules deprecated in Python 2.6.
Date: Wed, 26 Aug 2009 11:39:58 -0700
Message-ID: <4A95817E.4020109@qotw.net>
References: <1251305536-25887-1-git-send-email-reillyeon@qotw.net> <7vhbvucuj5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 20:48:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgNXn-0006Hc-El
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 20:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792AbZHZSsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 14:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752786AbZHZSsS
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 14:48:18 -0400
Received: from jane.qotw.net ([72.14.183.39]:52486 "EHLO jane.qotw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752658AbZHZSsR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 14:48:17 -0400
X-Greylist: delayed 493 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Aug 2009 14:48:17 EDT
Received: from [192.168.17.110] (unknown [64.125.181.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: reillyeon)
	by jane.qotw.net (Postfix) with ESMTPSA id B213553846;
	Wed, 26 Aug 2009 14:40:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=qotw.net; s=jane;
	t=1251312005; bh=FMkAwqovVO7RVGkE8mxHZ8V+xO8cu7Bl0ngsmaaZAtE=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=Hih/iGFxNqGuhZ3lpwZKpZ+DIILf7m7Z0XM2vzm+MUjwJQJF/z1UUdx5513yoqKuj
	 Eyv8E7d1ZOmuf5Ddt0TA6Me7opa+YK0iS5vL4ZudW59cCQ3bKdv9c+Ihpa1viELFnB
	 7iY2HohWnAaxcBk5NTE4PIJFRlrTgqonhZLisshI=
User-Agent: Thunderbird 2.0.0.22 (X11/20090710)
In-Reply-To: <7vhbvucuj5.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127112>

Junio C Hamano wrote:
> Reilly Grant <reillyeon@qotw.net> writes:
>
>   
>> The popen2, sha and sets modules are deprecated in Python 2.6 (sha in
>> Python 2.5).  Both popen2 and sha are not actually used in git-p4.
>> Replace usage of sets.Set with the builtin set object.
>>     
>
> Does the code already rely on a feature not found in Python older than 2.4
> before your patch?  Otherwise I would have liked to see the last sentence
> like this:
>
>     Replace usage of sets.Set with the builtin set object, which has
>     been available since Python 2.4.
>
>     This change makes the script unusable with Python older than 2.4,
>     which was released in 2004. Hopefully nobody uses ancient 2.3.
>
> So that I did not have to check myself to get a feel of how safe this
> change is.
>   
Thank you for the advice, this is my first patch.  The existing code
uses the built-in set module in other places so the 2.4 requirement
already exists.  I should have mentioned this in the original description.

-- 
Reilly Grant
reillyeon@qotw.net                     http://www.qotw.net/~reillyeon
GPG Key Signature: 2A41 A3E5 F3CA D3A0 F5CF  02DF B1EB CDEC 7850 E278
