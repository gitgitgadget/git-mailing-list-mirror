From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: [RFC] branch: list branches by single remote
Date: Tue, 16 Aug 2011 16:19:16 +0200
Message-ID: <4E4A7C64.2090607@elegosoft.com>
References: <4E383132.3040907@elegosoft.com> <20110804040646.GA5104@sigill.intra.peff.net> <4E4A729D.9030906@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Aug 16 16:19:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtKUY-0003uJ-6l
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 16:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629Ab1HPOTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 10:19:37 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:34866 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155Ab1HPOTh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 10:19:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 41C48DE80B;
	Tue, 16 Aug 2011 16:19:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TupLuTk2qgyf; Tue, 16 Aug 2011 16:19:30 +0200 (CEST)
Received: from [10.10.10.197] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id AF7C0DE809;
	Tue, 16 Aug 2011 16:19:30 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110628 Thunderbird/5.0
In-Reply-To: <4E4A729D.9030906@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179452>

On 08/16/2011 03:37 PM, Michael J Gruber wrote:
> Jeff King venit, vidit, dixit 04.08.2011 06:06:
>> On Tue, Aug 02, 2011 at 07:17:38PM +0200, Michael Schubert wrote:
>>
>>> @@ -297,6 +298,9 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
>>>  	if ((kind & ref_list->kinds) == 0)
>>>  		return 0;
>>>  
>>> +	if (cb->remote && strncmp(cb->remote, refname, strlen(cb->remote)))
>>> +		return 0;
>>> +
>>
>> This isn't right. You are assuming that a remote called "foo" will have
>> all of its branches in refs/remotes/foo. That's true under the default
>> configuration, but technically speaking, the remote tracking branches of
>> "foo" are defined by the right-hand side of foo's fetch refspecs.
> 
> You are 100% right here, but...
> 
>> So I think you want something more like this:
> 
> ...the op still might want to filter simply by the remote name.

There's an interesting discussion related to the subject:

http://thread.gmane.org/gmane.comp.version-control.git/178960
