From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] t0003: properly quote $HOME
Date: Mon, 18 Oct 2010 05:02:37 -0500
Message-ID: <20101018100237.GB5641@burratino>
References: <201010172134.43983.trast@student.ethz.ch>
 <b280c19ddc25f2f3a76d1871ed79906663daa802.1287392872.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Petr Onderka <gsvick@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Oct 18 12:06:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7mbl-0002QV-S7
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 12:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061Ab0JRKGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 06:06:15 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:44750 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970Ab0JRKGO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 06:06:14 -0400
Received: by gwaa18 with SMTP id a18so243076gwa.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 03:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Z3nYZBoH7G07O11TisFJ3RVJtuVvGe1FbaxI0usBJGs=;
        b=vsI41xp9ZjwUq2HvANb4zB0fxWDQfFC7JoWoPX4tj5ayqMtErWJS8TuIqwYJsH92AR
         gKSa7O5Gi4+MSxUPk5UEQ/2PZa7y6hFyz/T2hGbiGY8bEJG0wHzwjIe6wxhYS5/J4ew/
         3/cG1BBnabNsIodZK0koOESVQhlXy6oeK6Tsg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hGDkDuuDT81WTqzqwokFuN5UCAJInefG31bBdDDT8u2FGvr9yKLO3Yz9H7KPcLPwR1
         j1lrka5zXTk1zPPwKbit6YREhLR/ta2BThvBr+0ZGm1W62UQ5vROjUUv9MBTgPkoUz9u
         5454vQxfr4xxDYqSzYGtJisvJKSvz1th4GyAo=
Received: by 10.150.140.16 with SMTP id n16mr6682027ybd.153.1287396373768;
        Mon, 18 Oct 2010 03:06:13 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id k2sm1104022ybj.20.2010.10.18.03.06.11
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 18 Oct 2010 03:06:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <b280c19ddc25f2f3a76d1871ed79906663daa802.1287392872.git.trast@student.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159248>

Thomas Rast wrote:

>                                               This would be valid
> according to POSIX, but bash 4 helpfully declines to execute the
> command in question with an "ambiguous redirection" error.

For the benefit of those wondering why they never saw this problem,
even after using bash for a while: bash in POSIX mode (e.g. when
running as "sh") does not have the same problem.

Presumably that's why this problem was not noticed until on a platform
without bash as /bin/sh, in v1.7.0-rc1~30 (work around an obnoxious
bash "safety feature" on OpenBSD, 2010-01-26).

I still like the patch. :)
