From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Improved error messages when temporary file creation
 fails
Date: Tue, 7 Dec 2010 18:12:36 -0600
Message-ID: <20101208001236.GA25527@burratino>
References: <20101207181633.GF25767@bzzt.net>
 <7v62v5paj2.fsf@alter.siamese.dyndns.org>
 <20101207212041.GG25767@bzzt.net>
 <idmhjl$n1j$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Arnout Engelen <arnouten@bzzt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 01:13:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ7eg-0000tF-WA
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 01:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754689Ab0LHAMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 19:12:50 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:50785 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013Ab0LHAMs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 19:12:48 -0500
Received: by vws16 with SMTP id 16so440572vws.19
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 16:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=GFlgNMApPF9iz8FLQZqBrsG+37dqecHjyE6rwUJ2QGQ=;
        b=VWzyG4oqNXmaTEEz3OErX3LLGmv2kHf9K6uaZ41ReA7HCvf/VnLgGMEW6K8Wc4kEax
         8Tm5YK/MmLd0jm5ZzPYXC4I9eHD0+GEZuti4Kl391hT1r/eZgVONvt4N+gSvXcn/FyaZ
         SCJErEYpdyY7PDHEuIbCY5nc8VHVVft8tAWec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=iE8NxsD3JWKZSwqVl3ebvyV2ioYURnQh/GPsuUJa4dmD+MH5q84Zm8dGCDloSW8wAE
         +mW2GPt4h31+z2f5Xw7z5kvIPf6rIUSWlsCW6FXhKF3EeRag5CLMoZkxJKR8iyEfOC9m
         Mq+MqOU9C0nhpUZN6ct5DTuLX/DJ9+XLPN+9g=
Received: by 10.229.84.81 with SMTP id i17mr6225396qcl.215.1291767167732;
        Tue, 07 Dec 2010 16:12:47 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id m7sm4811623qck.1.2010.12.07.16.12.45
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Dec 2010 16:12:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <idmhjl$n1j$1@dough.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163151>

Jakub Narebski wrote:
> Arnout Engelen wrote:
>> On Tue, Dec 07, 2010 at 12:56:17PM -0800, Junio C Hamano wrote:

>>>> +   char origtemplate[255];
>>>> +   strlcpy(origtemplate, template, 255);
>>> 
>>> Why "255"?
[...]
> Why not use PATH_MAX instead of 255?

The advantage I can see to 256 is a small speed-up in the "no errors"
code path.  Since the I/O would tend to be much more costly and PATH_MAX
is self explanatory, using PATH_MAX does seem cleaner.

I know you all are aware of this already; just thought I'd mention it
while forwarding the original message to Arnout. :)

Jonathan
