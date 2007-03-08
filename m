From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Split sample update hook into post-receive hook
Date: Thu, 8 Mar 2007 09:26:25 +0100
Message-ID: <81b0412b0703080026v6f3990c3x2cefca661b64e00d@mail.gmail.com>
References: <20070308041618.GA29744@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Andy Parkins" <andyparkins@gmail.com>,
	"Bill Lear" <rael@zopyra.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 08 09:26:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPDxK-0004rK-Bf
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 09:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbXCHI01 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 03:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbXCHI01
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 03:26:27 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:4630 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030254AbXCHI00 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 03:26:26 -0500
Received: by nf-out-0910.google.com with SMTP id o25so548544nfa
        for <git@vger.kernel.org>; Thu, 08 Mar 2007 00:26:25 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jUf4wgmGX+viIO+6V53qEaTbo/Fdv0bLWmsZHYrh41CBLzrEQRHm5JOhdHLM6pNfTOkk/CbJ2TS3+DqTDaThGEIuCgODMtEiVJ/7+Brn5vzsNKETNDlWTlZrQNkLucgDW8Cl+1WEl2AWOfT/sMPf/NWWeIGp8PCvxN0j0X4RLpk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rDOnOBeYUmxD+4As2LwvA2GBJFsNgbzuzB32TCR/plYoFjjehyUOowghQKP0Acv39TH4LLtR8QkyNJEkH8mWXg6u5uAp0OJGst6Ela6zDL3vUxKARIOvxrpGON4sbz7swmPxLfWl/iQt/7gz0wPnZGHCH2VZHxv8QSiR1Hcef8I=
Received: by 10.78.203.13 with SMTP id a13mr13843hug.1173342385311;
        Thu, 08 Mar 2007 00:26:25 -0800 (PST)
Received: by 10.78.138.5 with HTTP; Thu, 8 Mar 2007 00:26:25 -0800 (PST)
In-Reply-To: <20070308041618.GA29744@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41717>

On 3/8/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> +# Called by git-receive-pack with arguments:
> +#    (refname sha1-old sha1-new)+
>  #

What do you do if this breaks because of too many refs passed?
