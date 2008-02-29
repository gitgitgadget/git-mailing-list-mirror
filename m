From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 04/40] Windows: Use the Windows style PATH separator ';'.
Date: Fri, 29 Feb 2008 08:57:34 +0100
Message-ID: <47C7BAEE.2020408@gnu.org>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-5-git-send-email-johannes.sixt@telecom.at> <47C67E1A.5030304@gnu.org> <200802282143.19322.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Johannes Sixt <johannes.sixt@telecom.at>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 29 08:58:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV08G-0000DR-Rv
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 08:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbYB2H5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 02:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbYB2H5j
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 02:57:39 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:65469 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbYB2H5i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 02:57:38 -0500
Received: by fg-out-1718.google.com with SMTP id e21so3134553fga.17
        for <git@vger.kernel.org>; Thu, 28 Feb 2008 23:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=NL0kRI0f4Nxp3a81SoIiXT4iWWAxcbc9NdbvuVJhTxw=;
        b=fXOF/uIyaCRHyhjbX0BXZc86NlaZhFb7TjNIk/9mxA5yIx43B8WG2CiyyeRdF1oGSl/2oy+/yo3qKKYLdf6III5KaURhMnIvAW9Vyi8GYbsC+ArijcGHMstNMQIKxoGLte7QS32xxjeoPO3oc16AB5p84zdMyOx3PHhX9GWxt3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=vpupLGpeiJitGuPLX4euuIE8sBNNOxL2MTJeMc9b4bSlrKd8qZK3QxHtANiE+hAvFcyccLx4f+osaGJ7Thfk+jNQkTLYOesdty0sF+lvIONh7v1YheE9OiyVB/Sy+3oyzN1f+MkjpSoy4gnTlTaj72jLDAx7GOCAP6A4w5B7qcY=
Received: by 10.86.68.20 with SMTP id q20mr9989804fga.59.1204271857255;
        Thu, 28 Feb 2008 23:57:37 -0800 (PST)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id e10sm5602086muf.10.2008.02.28.23.57.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Feb 2008 23:57:35 -0800 (PST)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <200802282143.19322.johannes.sixt@telecom.at>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75512>

Johannes Sixt wrote:
> On Thursday 28 February 2008 10:25, Paolo Bonzini wrote:
>>> +#ifdef __MINGW32__
>>> +		strbuf_addch(out, ';');
>>> +#else
>>>  		strbuf_addch(out, ':');
>>> +#endif
>> Why not adding a PATH_SEPARATOR #define?
> 
> Because IMO it is obfuscating:
> 
> 1. When you read through the code and see PATH_SEPARATOR, you still have
> to go look how it's defined. Why? Because you always will ask: Is this 
> about ':' vs. ';' or '/' vs. '\\'?

One is a DIR_SEPARATOR, the other is a PATH_SEPARATOR.  It's a matter of 
conventions.

Paolo
