From: "Bryan Donlan" <bdonlan@gmail.com>
Subject: Re: "make test" fails if /path/to/git.git contains spaces
Date: Mon, 31 Mar 2008 19:04:05 -0400
Message-ID: <3e8340490803311604v52ab9e03nd101ccadd4973760@mail.gmail.com>
References: <47F15CDB.60109@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Adam Roben" <aroben@apple.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 01:04:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgT3b-0005x7-45
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 01:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284AbYCaXEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 19:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752108AbYCaXEI
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 19:04:08 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:29022 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbYCaXEH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 19:04:07 -0400
Received: by py-out-1112.google.com with SMTP id u52so2642674pyb.10
        for <git@vger.kernel.org>; Mon, 31 Mar 2008 16:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=AKr76sMFS20Z2qle7X3heRGEQ1yoTjBX8kJAM1l+UOM=;
        b=A+7fr/JsKumoRHB7ef8qsYhoZw/RrxpRdruzUvG/HBzYbs7tWgmEUZZhxDSs6IrbTIGzgNEYIoe2PgJL6GKBn2jgTpXEjTuPycAUXLtdWRwnBUvKgke6w3tNvVeshYco90VJiHMdtil11AUyRRpLAUy3e2h7dnmQYEDF6N6vzlc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OAJ8+AGZ2M92cu0qc2U16vwVczBHEVsgZ/8sAAxtFH+ENCcExCw+HnRKI6rdfAw2Ef5ux0pG7e30/2Wr099rzFHo+ejAVaxRsmM0x2t/0oPdSERONTNrU3OE+6e/AnF/0NRMp87ctYEcJ8tgyU2oeS3sRBt70IRecRJ9w6gneo8=
Received: by 10.65.254.5 with SMTP id g5mr15002494qbs.62.1207004645162;
        Mon, 31 Mar 2008 16:04:05 -0700 (PDT)
Received: by 10.64.49.9 with HTTP; Mon, 31 Mar 2008 16:04:05 -0700 (PDT)
In-Reply-To: <47F15CDB.60109@apple.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78610>

On Mon, Mar 31, 2008 at 5:51 PM, Adam Roben <aroben@apple.com> wrote:
> I've noticed that "make test" fails if /path/to/git.git contains spaces,
>  with the following error:
>
>  > $ make test
>  > make -C t/ all
>  > make[1]: Entering directory `/home/Adam Roben/dev/git/t'
>  > *** t0000-basic.sh ***
>  > * error: cannot run git init -- have you built things yet?
>  > make[1]: *** [t0000-basic.sh] Error 1
>  > make[1]: Leaving directory `/home/Adam Roben/dev/git/t'
>  > make: *** [test] Error 2
>
>  This is a very common configuration on Cygwin, but clearly not a common
>  configuration for git developers, or else this error would have been
>  corrected already.
>
>  Do we want to support having spaces in your path? It doesn't seem hard
>  to fix, but it does seem like the kind of problem that will come up over
>  and over again if only a very small set of people have this configuration.

Turns out that while trying to fix the tests, I've found that
git-rebase doesn't like a $VISUAL having spaces, so perhaps this
should be tested more often :) Or should we just require $VISUAL have
no spaces?

I'll send a patch once I've got everything passing.

Thanks,

Bryan
