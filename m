From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] git help -w should not create nohup.out
Date: Fri, 8 Feb 2008 14:25:43 +0300
Message-ID: <20080208112543.GV30368@dpotapov.dyndns.org>
References: <1202434421-8066-1-git-send-email-dpotapov@gmail.com> <alpine.LSU.1.00.0802080153570.11591@racer.site> <7vhcgkm7yy.fsf@gitster.siamese.dyndns.org> <200802080637.04015.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Feb 08 12:26:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNRN8-00067B-VF
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 12:26:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbYBHLZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 06:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760264AbYBHLZu
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 06:25:50 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:55258 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760165AbYBHLZt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 06:25:49 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2880726fga.17
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 03:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=HfE9LQUaRmSPc3c3e9z5RUbcP3/E994tKJj3CajmdY8=;
        b=LZVYWVbd0pKqZLXIvH3kHL+rHg4Nr2Yo+wxl3C0IzE0shUN5OOxTLIKXv+P87wYi04DY7Pj/fMNtRcEq6ITRhwj39pjhnhbpPghCdijpPAwS0Rwxp2mUtZIkmVcKQUJEXWT1wcHIiXXC3EDCtemoKRhM9LMhDHy6hU7hmAwDLdY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=p92XOKHjSXg4AKGEXx/IgcoLqINquUseCN7YxqpVl6C4bqR7/q6dOxxHLHTtc8bk45hJUyQFTA5cPw5P/uMfKPWxi+9eLCfivIm0lcXLetS92rCHckgvB1n7133c1nkhD+tQS4ov6TDjiDUNBpkqu+SsegJcbKI892AdinErXx0=
Received: by 10.86.73.17 with SMTP id v17mr11575026fga.40.1202469947499;
        Fri, 08 Feb 2008 03:25:47 -0800 (PST)
Received: from localhost ( [85.141.191.38])
        by mx.google.com with ESMTPS id 3sm13250635fge.7.2008.02.08.03.25.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Feb 2008 03:25:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200802080637.04015.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73074>

On Fri, Feb 08, 2008 at 06:37:03AM +0100, Christian Couder wrote:
> 
> I think I was worried about something like this:
> 
> 1) ssh -Y other_machine
> 2) git help -w, it opens my browser
> 3) open many other tabs in the browser
> 4) exit other_machine, oops my browser with all my tabs is gone

It seems to me that the browser will be killed anyway if ssh connection
is closed. At least, that what happened when I used ssh -Y localhost. In
fact, "nohup" made only easier to kill the browser in this way:
ssh -Y localhost
git help -w
exit
CTRL-C

Without "nohup" CTRL-C had no effect, but when I started the browser
with nohup then the connection would be closed and the browser killed.


Dmitry
