From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t0005: work around strange $? in ksh when program
 terminated by a signal
Date: Fri, 9 Jul 2010 09:39:58 -0500
Message-ID: <20100709143958.GB1980@burratino>
References: <20100709030812.GA16877@dert.cs.uchicago.edu>
 <4C36CA2C.5050305@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jul 09 16:40:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXEkx-0007tU-2L
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 16:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755689Ab0GIOkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 10:40:41 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63135 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941Ab0GIOkl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 10:40:41 -0400
Received: by iwn7 with SMTP id 7so2256383iwn.19
        for <git@vger.kernel.org>; Fri, 09 Jul 2010 07:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=RZa9X7rMUgECR3xqyg4nwskSj/VukMxjLPS0JeWbpdk=;
        b=NqFIfHQLtarorffu055GG6t9v/I6sRvVkdEo/BZ9TyZot1u2MPoBwuMRTa5X4LdbHh
         1BPAct0uaWVS+3rLJIUbYItXii5MYwEL2yen8Y8kc8q78CKhvz0ldlnfU8dAvU5f6ugl
         sZfHywtb1nRBEUoXmywpE3BQNdU/uWaB+WWxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TtA3cGcw7ICAzOnF+SoKKalOyIbz7mu3Lq1Euu8FfS7Ua1CA5WylQKG6K4BqhEqzZ8
         c9FXrVXsDPHofEcHYcDk6ua3xHlUZuz64oQkOwCt8r8WN9w+yqohFGeD0l1IqnRibQbP
         dcPrjT0KTdldvc1RHHA2EFDho1m5LNYuvkmwQ=
Received: by 10.231.33.202 with SMTP id i10mr9791332ibd.50.1278686440585;
        Fri, 09 Jul 2010 07:40:40 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h8sm4449679ibk.9.2010.07.09.07.40.39
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Jul 2010 07:40:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C36CA2C.5050305@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150673>

Johannes Sixt wrote:

> ksh is known to report $? of programs that terminated by a signal as
> 256 + signal number instead of 128 + signal number like other POSIX
> compliant shells. (ksh's behavior is still POSIX compliant in this regard.)

This patch works for me.

 $ ksh t0005-signals.sh
 *   ok 1: sigchain works
 * passed all 1 test(s)

Thanks for the explanation.
