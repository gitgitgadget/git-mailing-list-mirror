From: "Dan McGee" <dan@archlinux.org>
Subject: Re: [PATCH] send-pack: respect '+' on wildcard refspecs
Date: Fri, 19 Oct 2007 08:38:06 -0500
Message-ID: <449c10960710190638j5823b19dl903ae369965e884e@mail.gmail.com>
References: <20071019090400.GA8944@coredump.intra.peff.net>
	 <449c10960710190510y3af3ffa2ydb9ae4a01b5d480c@mail.gmail.com>
	 <20071019122755.GA17002@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 15:38:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iis3T-0001Dz-Mw
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 15:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757316AbXJSNiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 09:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756507AbXJSNiJ
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 09:38:09 -0400
Received: from nz-out-0506.google.com ([64.233.162.232]:10303 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754272AbXJSNiI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 09:38:08 -0400
Received: by nz-out-0506.google.com with SMTP id s18so48785nze
        for <git@vger.kernel.org>; Fri, 19 Oct 2007 06:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=EVNutxgDdMQu4Z1khwhK+/WGchklBLu7HtIfd6z/dBk=;
        b=f5YF8zkgukD6PrGZbKB8jn7F5JtA5srKxtMC/IAkI2iJR0byZyC7SLf6LbfuQ3r4jVKlWPhdQKBd1uC03HDeAhsmPcrmXQUjdTA4/+KA1CSfdf2ejbFchJAWTiBy6CZGyNLXakvM08tfZ8w6x0/gbPK2XzuJlNSQsQ8zqT2g5FE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=oehUFtVeuL/rCRgmPTA5ffLh4EFucAVu5lnAu4qxk806L6GNBSavunqZVw/GbyOHBMxs7l8Z8yGwRunB4PnLAjYEYGDMvETKx8+R2YykZDlu7g/M4t++SLORHaUyHBShM4hg5tWcEs4/ysk3EMZf6PMzoYKYjSjV4ufF66+DXvY=
Received: by 10.115.76.1 with SMTP id d1mr2065077wal.1192801086893;
        Fri, 19 Oct 2007 06:38:06 -0700 (PDT)
Received: by 10.114.67.15 with HTTP; Fri, 19 Oct 2007 06:38:06 -0700 (PDT)
In-Reply-To: <20071019122755.GA17002@coredump.intra.peff.net>
Content-Disposition: inline
X-Google-Sender-Auth: 132abbf652bcf68c
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61707>

On 10/19/07, Jeff King <peff@peff.net> wrote:
> On Fri, Oct 19, 2007 at 07:10:42AM -0500, Dan McGee wrote:
>
> > Hmm. For some reason this passes with your test case, but not with my
> > original bash test script[1]. Did you try it with this?
> >
> > [1] http://www.toofishes.net/uploads/
>
> I didn't try it until you sent your message, but your test seems to work
> fine for me. My patch is on top of 'next', which is what I usually run.
> I haven't looked into 'master' (I assumed since the bug was reproducible
> in both, it would be the same in both, but that is perhaps not the
> case).

Still getting this error:
error: remote 'refs/heads/working' is not a strict subset of local ref
'refs/heads/working'. maybe you are not up-to-date and need to pull
first?
error: failed to push to '/tmp/testpush'

I've tried applying the patch on the following commits, and maybe I'm
smoking something but I can't get it to pass my test script.

origin(junio)/master: 58ba4f6
origin(junio)/next: fe96ee67ec5840
spearce/master: 7840ce6cb24a9d
spearce/next: 2fe5433b416f0df

Can you let me know what commit you based the patch off of? I'm at
work for the next 8 hours or so, so I can't look in to this a whole
lot until tonight.

-Dan
