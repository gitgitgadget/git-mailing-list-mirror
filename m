From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] test-lib: fix color reset in say_color()
Date: Fri, 10 Oct 2008 02:30:06 -0700 (PDT)
Message-ID: <m33aj4lrvs.fsf@localhost.localdomain>
References: <1223590030-7464-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Oct 10 11:31:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoELL-00046C-Hk
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 11:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756437AbYJJJaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 05:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756412AbYJJJaM
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 05:30:12 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:38797 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756171AbYJJJaK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 05:30:10 -0400
Received: by fg-out-1718.google.com with SMTP id 19so286014fgg.17
        for <git@vger.kernel.org>; Fri, 10 Oct 2008 02:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=g33QRctl34eUYSUGYiYXgeCC28itMVZiaayRBAnbFMU=;
        b=dPCppxyT7hXXLuvuVdAfqITeTLomWoIgxxNlHIQIQWuzxLBAfSSsFdfgnARU3EPHUA
         zzQjXJn12GX+wxEEK4oRdkXWibbtbHK6RkYVOlRVqDvmA2/5nytGywxErdCmgejBOdUz
         TvhWOY2NLOXwi+wg0ujBUQcZ9/XqTfY0eNWic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=HXhRDByXZ1GpRR8A9PWSk+kedzUUYyE5AWTheSHpbpSwrcnDl8O3pMJwNSos7WvKtV
         A9pCquqGj6LzxflXaS2fp+YgGV7IlRTa/el7fxiKNGWT5J5T4C9WUQ/b6PNSpcgYsyrt
         LNPZQw5p7730WcbURojPuquR3iIvEEyUiDu7M=
Received: by 10.181.60.13 with SMTP id n13mr1237214bkk.39.1223631007964;
        Fri, 10 Oct 2008 02:30:07 -0700 (PDT)
Received: from localhost.localdomain (abvi22.neoplus.adsl.tpnet.pl [83.8.206.22])
        by mx.google.com with ESMTPS id 23sm2127905eya.7.2008.10.10.02.30.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Oct 2008 02:30:06 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m9A9U2XB003864;
	Fri, 10 Oct 2008 11:30:02 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m9A9U0ss003858;
	Fri, 10 Oct 2008 11:30:00 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1223590030-7464-1-git-send-email-vmiklos@frugalware.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97919>

Miklos Vajna <vmiklos@frugalware.org> writes:

> When executing a single test with colors enabled, the cursor was not set
> back to the previous one, and you had to hit an extra enter to get it
> back.
> 
> Work around this problem by calling 'tput sgr0' before printing the
> final newline.
> 
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
> 
> Actually I'm not 100% sure about how many users are affected. I have a
> black background in konsole with white letters, and after the test I get
> a green cursor, and once I hit enter, I get the white one back.

I also had this very minor irritation that cursor retained color
of last line till enter (or IIRC any key which moved cursor). I use
ordinary xterm from X.Org 6.8.2(213).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
