From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Thu, 18 Feb 2010 15:14:06 -0500
Message-ID: <eaa105841002181214g380754fl9f7763ace4b2b457@mail.gmail.com>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
	 <20100214011812.GA2175@dpotapov.dyndns.org>
	 <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
	 <201002181114.19984.trast@student.ethz.ch>
	 <7vtytee7ff.fsf@alter.siamese.dyndns.org>
	 <alpine.LFD.2.00.1002181456230.1946@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Feb 18 21:22:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiCtC-0001e7-Ap
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 21:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758384Ab0BRUWR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Feb 2010 15:22:17 -0500
Received: from mail-pz0-f194.google.com ([209.85.222.194]:36777 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753007Ab0BRUWQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Feb 2010 15:22:16 -0500
X-Greylist: delayed 486 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Feb 2010 15:22:16 EST
Received: by pzk32 with SMTP id 32so494292pzk.4
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 12:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=+qr/9wH183jDEYCI12EfvicHUhQ8CH2yNJqQPUxZzxA=;
        b=dNRqoKCOpG9Gq4A+UPDA8v3YuWhrqsKC0VxaZ2uZXFqHplyUaj46nimkAtbxU+7im+
         439LoLqyQI7Fk5tbhcPb9ufDFhoh2t4bdWWgWbrV4PWBIB5uB42bakTp32B/q7UoAB1r
         8rbWV9lhcF90I/yuDLC6R1hliovlY+wrIboJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=PJ8R26RZ35aWd48ycQ8WKT7aq3OYEGsxywGfIRiHVYJzEFis0h8QPesXvn13T0WFYl
         Hs9CzI/r+gcwwe+YzL5DE2DBXp8oRknM/8zrUeOxxujGG91v9+bKwUD9R6lcZ9KSP1dM
         uAuXL45jLC040v3L978z0iHVmYNfED9QWH5lo=
Received: by 10.142.121.2 with SMTP id t2mr6827189wfc.100.1266524046885; Thu, 
	18 Feb 2010 12:14:06 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1002181456230.1946@xanadu.home>
X-Google-Sender-Auth: fd93f553910cb67b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140373>

On Thu, Feb 18, 2010 at 2:58 PM, Nicolas Pitre wrote:
>
> Can't we rely on the mtime of the source file? =A0Sample it before
> starting hashing it, then make sure it didn't change when done.

Some filesystems (eg FAT) have an abysmal mtime granularity (2
seconds). The same race exists on other filesystems, albeit with a
much narrower window of opportunity.

Peter Harris
