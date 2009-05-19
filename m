From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: committing to a checked out branch
Date: Mon, 18 May 2009 22:17:57 -0400
Message-ID: <76718490905181917u1f41e06dq9cf527a1dac9bea5@mail.gmail.com>
References: <bbd12f0f0905181733h6a9537d2hf4e6b7a1384fa32d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff Brown <jeff@jeffandbetsy.net>
X-From: git-owner@vger.kernel.org Tue May 19 04:18:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6Eu5-0004kS-9C
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 04:18:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752925AbZESCR7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 May 2009 22:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752863AbZESCR6
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 22:17:58 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:3226 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714AbZESCR4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 May 2009 22:17:56 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2230696ywb.1
        for <git@vger.kernel.org>; Mon, 18 May 2009 19:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=N71fKvnVujHMzRMB71VqkhBqBozvQ+qWPf/Fnt+CUVo=;
        b=bDUxdsTjpp5nMX2snbj9k1T/r6XVSGpnHISxdlhpNkXda/JgYwIN6bDCMGd/EBDdIk
         nHGpjJFU9VqYaGhZMhiv2zOUqHpn/aPcox27EeN9feEtkPWQBNZ+hvblxgSOZtT04wOG
         pYIL9op5xSte8V0RR82YeaDxPYD6HSQGfB0hM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rGEFCtXhu3gtPJ2OTta/c13tCCCD+c55kOsflTIrXGwO9+uf3BU8kCNtwH0z4DqqEb
         r3Yyuy+juYjYOHAOXvvDg3g7Z8AAX2tXDv+90Wt6mFKfROu1PSOx9WCImtaAg+4vqVo2
         9HYA3cBbUckHfqkDATF+n9r0e+US3W4vcku5M=
Received: by 10.151.123.1 with SMTP id a1mr13956046ybn.38.1242699477845; Mon, 
	18 May 2009 19:17:57 -0700 (PDT)
In-Reply-To: <bbd12f0f0905181733h6a9537d2hf4e6b7a1384fa32d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119485>

On Mon, May 18, 2009 at 8:33 PM, Jeff Brown <jeff@jeffandbetsy.net> wro=
te:
> The workspace on my server is currently "checked out" so I get the bi=
g
> warning message every time I push to there. =C2=A0What is the best wa=
y to
> cleanup that working area so I can push to it without the large
> warning every time I commit. =C2=A0I know I can set a config variable=
 to
> squelch the message but that isn't what I want to do. =C2=A0I want to=
 make
> the workspace on the server _not_ be checked out.
>
> Thanks for the help.

If you never want to checkout any branches in that repo on your
server, then what you want is a bare repository. The easiest way to
create it is as follows:

$ git clone --bare /path/to/repo /path/to/repo.git

Then you can remove /path/to/repo after verifying everything is sane.
Note the ".git" extension is a convention denoting the repository is
bare (vs "repo/.git", which implies a repository with a working copy).

j.
