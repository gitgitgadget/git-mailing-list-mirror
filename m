From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: [PATCH] Compile fix for MSVC: Move poll.h out of sys-folder
Date: Fri, 18 Nov 2011 15:42:07 +0100
Message-ID: <4EC66EBF.20007@lyx.org>
References: <1321624070-4246-1-git-send-email-vfr@lyx.org> <CABPQNSa+ZjAMSxpBTqGW7P=v-tJTW_jdx3MO=vCpzc-z_XdHTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, msysgit@googlegroups.com,
	j.sixt@viscovery.net
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Nov 18 15:42:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRPe0-0002xq-C7
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 15:42:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757956Ab1KROmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 09:42:15 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44680 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753599Ab1KROmP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 09:42:15 -0500
Received: by bke11 with SMTP id 11so3498955bke.19
        for <git@vger.kernel.org>; Fri, 18 Nov 2011 06:42:14 -0800 (PST)
Received: by 10.205.123.3 with SMTP id gi3mr3694472bkc.112.1321627333646;
        Fri, 18 Nov 2011 06:42:13 -0800 (PST)
Received: from [192.168.40.216] (221-44.206-83.static-ip.oleane.fr. [83.206.44.221])
        by mx.google.com with ESMTPS id o7sm852616bkw.16.2011.11.18.06.42.10
        (version=SSLv3 cipher=OTHER);
        Fri, 18 Nov 2011 06:42:11 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <CABPQNSa+ZjAMSxpBTqGW7P=v-tJTW_jdx3MO=vCpzc-z_XdHTg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185665>

> This looks strange to me. vcbuild/include/poll.h will only prevent the
> correct header from being included, while compiling an linking against
> compat/win32/poll.[co]... That seems dangerous to me, because the
> interface might be declared differently.
>
> Instead, I think compat/vcbuild/include/poll.h should be removed,

Yes, it should just be removed. Having poll.h in the sys directory was 
wrong and the patch I sent was needed to make 0f77dea compile.

Your patch is indeed necessary to compile later revisions as well.

> I still can't build Junio's master,
> due to sys/resource.h missing. This comes from ebae9ff ("compat: add
> missing #include<sys/resource.h>"), and is only guarded against
> MinGW, not MSVC...

The fix for this is already in 'next' now. So, with your patch, 'next' 
does compile.

Vincent
