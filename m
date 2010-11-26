From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 03/18] usage: implement error_errno() the same way as
 die_errno()
Date: Fri, 26 Nov 2010 00:07:47 -0600
Message-ID: <20101126060747.GD18751@burratino>
References: <20101125210138.5188.13115.chriscool@tuxfamily.org>
 <20101125212050.5188.56613.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Nov 26 07:07:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLrTT-0002IK-BR
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 07:07:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684Ab0KZGHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 01:07:53 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40856 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860Ab0KZGHx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 01:07:53 -0500
Received: by yxt3 with SMTP id 3so281394yxt.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 22:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=xh+xjHMi+1ULSLeaqhCPCIZmjj9VRqX204QT4HOsy0I=;
        b=ItEAotbzAbpE/kjZ+WKeaTrd+2qQXsTviqbEL9T094DTKMJDlFAvGlW4IzmwJvAQex
         3g9uPICthjtUyJkZd2cfF2g65OD1+9O0Y6M0OaoFVAef/81e7dks2DIn6K5em4n8SR1l
         Cbqz9VZFiNJP4HyCaqvR+7vgGdymxjTMKhZGY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hEfnew57Uk0cCVqJIjtKEOdZdmPKFAK81A8rrVoTMcNzKww3HcTnxoKINJqRxgBBAC
         uPPTeR2IMTWmVKYeYfHH44AvQoDr1heY4GNbcpxwIpAD5u3DmcpmkmHU1rsuygiDo2Te
         RL+Ll96zWL8wG5XbXCL02+1Xuxez5k9nBMjZU=
Received: by 10.91.44.23 with SMTP id w23mr3810939agj.184.1290751672455;
        Thu, 25 Nov 2010 22:07:52 -0800 (PST)
Received: from burratino (adsl-68-255-101-216.dsl.chcgil.ameritech.net [68.255.101.216])
        by mx.google.com with ESMTPS id k52sm1029476yhg.39.2010.11.25.22.07.50
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 22:07:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101125212050.5188.56613.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162204>

Christian Couder wrote:

> die_errno() is very useful, but sometimes we don't want to
> die after printing an error message and the error message
> from errno.

Yes, please!  I have often wished for this helper.
