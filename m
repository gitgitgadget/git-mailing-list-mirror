From: Frank Li <lznuaa@gmail.com>
Subject: Re: possible code error at run_command.c
Date: Mon, 21 Dec 2009 16:18:26 +0800
Message-ID: <1976ea660912210018y15acfe32o78841d5e0968f793@mail.gmail.com>
References: <1976ea660912202246k45732bf2p111bbeb78047693e@mail.gmail.com>
	 <4B2F214D.2020905@viscovery.net>
	 <1976ea660912202329x42f6add3j9175867e8723a4bd@mail.gmail.com>
	 <4B2F2727.4060405@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Dec 21 09:18:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMdTN-0000At-LC
	for gcvg-git-2@lo.gmane.org; Mon, 21 Dec 2009 09:18:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662AbZLUIS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2009 03:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752260AbZLUIS2
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Dec 2009 03:18:28 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:42698 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbZLUIS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2009 03:18:28 -0500
Received: by yxe17 with SMTP id 17so4646397yxe.33
        for <git@vger.kernel.org>; Mon, 21 Dec 2009 00:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=Tba3cCWPGWqoaQKE4zvCuWC6cDpjlnUhhhwifB5JBtg=;
        b=gSQiP9ufVdZGUaglvRLzk0F+rPpZXmtPNVhc7+k0MBhh4NWauBDzo7Vz/rTncnvxKT
         pL+Y2bUHZg93+ePqu+k5SkqxWqXNyHCwbYC/qFXie6yc5CpJbl7gKeguHm099HlDun7N
         VShNBa84cGrrF4x+1I5BHgHYCqdZGLK6VtyAM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=aONewW+sMB8ezSzRCGXaOgwf1IziTSPQmt5faaedsX8vpa5TwIvWjsWN6Mnr4D9wb7
         39DGIPXVnoTzyqDyf7XMqhCOivGCUTzZXij2oOgixUnGEYj2XtskAlaGgXmIbl9wAK58
         8ZiZItcYNMMBlC7HlRiwhydhPC7mU+U8N7u+I=
Received: by 10.150.250.21 with SMTP id x21mr10692891ybh.181.1261383506623; 
	Mon, 21 Dec 2009 00:18:26 -0800 (PST)
In-Reply-To: <4B2F2727.4060405@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135547>

>
> Disable this check - it just takes away performance. :-)

Release version will disable this.
Debug version enable this by default is just for find out code error.

>
> (If you don't disable the check, then keep the required changes private.)
>
>> I prefer change it to
>> int failed_errno = errno;
>
> You don't need to initialize the variable at all because it is always
> initialized elsewhere before it is used. Perhaps MSVC is clever enough to
> see it?
>

Maybe some excute path miss initialized it. Otherwise compiler will
not report warning.
