From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: Apology/Bug report: git-send-email sends everything on Ctrl+C
Date: Wed, 26 May 2010 09:05:12 +0100
Message-ID: <1274861112.2074.2.camel@wpalmer.simply-domain>
References: <4BFCB9D0.3010400@vilain.net>  <4BFCC4B5.6070408@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed May 26 10:05:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHBcD-0005wm-Fb
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 10:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789Ab0EZIFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 04:05:19 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49901 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170Ab0EZIFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 04:05:16 -0400
Received: by fxm5 with SMTP id 5so4075611fxm.19
        for <git@vger.kernel.org>; Wed, 26 May 2010 01:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=gLjSucytDlxxwK3PNnx2RTgHUZopuoanEns+G1zGwsw=;
        b=G+R9boL93Y8MiD+wFkF+eq9GI5zY7hPospL1x/Tn3csvSdtap1GZ9qWwDzfeJIzow/
         Q2/TKBpBYceHxGoQsU1qzHRfmK6WT1S60BPl/h+2Kh1Hab9TAEGzwXOY4I0YQIr/n0RA
         vNJrlTUmr6IxO0noWpZ0i7akb/+s4HbE1GrfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=IWVAhjRD0dZDvHusAloYcuG2H7cQYLgT2uuhjkac0agHDFsvOHxNNIYOqKfKmifYlI
         r61/nbmhkGDQi/0js25aDA1gGEQ4s13Ucm2/7HloQdxCrJ+0Z0CBBkQQpBPOx2EChj4Y
         opCjs4yFeh3Ie/KuGitTGKUdENIkMB6MwacjU=
Received: by 10.204.152.135 with SMTP id g7mr3368589bkw.146.1274861114835;
        Wed, 26 May 2010 01:05:14 -0700 (PDT)
Received: from [192.168.2.64] ([193.164.118.24])
        by mx.google.com with ESMTPS id h29sm4527642bkf.0.2010.05.26.01.05.13
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 26 May 2010 01:05:13 -0700 (PDT)
In-Reply-To: <4BFCC4B5.6070408@vilain.net>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147780>

On Wed, 2010-05-26 at 18:50 +1200, Sam Vilain wrote:
> Sam Vilain wrote:
> > Expect a mail storm shortly, sorry folks.
> >   
> 
> I just had a look at patching git-send-email.perl; but it looks like it
> is checking $? correctly at least since beece9da;
> 
>             system('sh', '-c', $editor.' "$@"', $editor, $_);
>             if (($? & 127) || ($? >> 8)) {
>                 die("the editor exited uncleanly, aborting everything");
>             }
> 
> I think I must have actually hit Ctrl-Z, not Ctrl-C.  So, it's all my
> fault and I apologize profusely.
> 
> Sam

I'd consider anything that can make "accidentally sending 100+ patches"
possible to be a bug. How does "it was Ctrl-Z, not Ctrl-C" make a
difference here?
