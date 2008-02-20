From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: Minor annoyance with git push
Date: Wed, 20 Feb 2008 10:20:01 -0500
Message-ID: <76718490802200720w4dd89dc1lf7b19d546d3bfd00@mail.gmail.com>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com>
	 <alpine.LSU.1.00.0802091307160.11591@racer.site>
	 <7v7ihd7ee1.fsf@gitster.siamese.dyndns.org>
	 <alpine.LSU.1.00.0802100213330.11591@racer.site>
	 <20080210101756.GB26568@coredump.intra.peff.net>
	 <alpine.LSU.1.00.0802101219280.11591@racer.site>
	 <20080210122321.GA31009@coredump.intra.peff.net>
	 <alpine.LSU.1.00.0802101303140.11591@racer.site>
	 <7vzltwavf9.fsf@gitster.siamese.dyndns.org>
	 <alpine.LSU.1.00.0802201305350.17164@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Steffen Prohaska" <prohaska@zib.de>,
	"Martin Langhoff" <martin.langhoff@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 20 16:21:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRql9-00006o-9x
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 16:21:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764601AbYBTPUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 10:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764569AbYBTPUR
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 10:20:17 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:3488 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764364AbYBTPUE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 10:20:04 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4066935wah.23
        for <git@vger.kernel.org>; Wed, 20 Feb 2008 07:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=IaAnW3OaJpAitYczvkuJIOIp1wUtLC/Uagb9rNy0iL0=;
        b=Od1oxPEuMg8gdsQQdWnICnuyRsvuafR3Ov3us/udnqij6zF7YyBFKgOKX+uZg/fFpxR01C7z61tVWVQcuf2jQx7s0l1rgcuoqwfVaoANciD7YR3OQl/wszXwSXuTK1nYIpOWscb7wD+PRfFWIPaxWyclHOGCTa3kdzSQGcqJ5Fg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ueSoU7T5k5fAFpPvsWqhre3Vv7738VNSBYGYE+C2xZ4Vt/e0McuMCXnLEwnyO8bHfpnF8XYoTIDDFKJcPwH1a5Lp3ZhkUJhYJE6zxXg8v0ERKOlnjduChG28ACNbS4nkdD2arpE3h7pMfFoGZcCkjXMFUAkD4el/iMEtbLsy0LQ=
Received: by 10.114.37.1 with SMTP id k1mr215228wak.6.1203520801433;
        Wed, 20 Feb 2008 07:20:01 -0800 (PST)
Received: by 10.114.145.13 with HTTP; Wed, 20 Feb 2008 07:20:01 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802201305350.17164@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74518>

On Feb 20, 2008 8:06 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 20 Feb 2008, Junio C Hamano wrote:
>
> > Putting this "push = HEAD" by default when "git clone" and "git remote
> > add" creates the [remote "$remote"] section is probably possible, and at
> > that stage we may even be able to do the "if the other end is shared,
> > then set this up automagically", as the result of the magic can be
> > inspected in the resulting config file.
>
> I think this is too magic, both of it.  Once people get used to "git push"
> being implicitly "git push origin HEAD", why should they not expect "git
> push <somewhere-else>" to push "HEAD" implicitly, too?

Well then, how about (don't cringe too much now...)

  push.conservative = true

If enabled and "git push" is run w/o arguments, it will first emit what
it plans to push and then prompt with "yes/no." I'm kinda opposed to
silly prompts -- folks just always go right past them -- so I dunno.

But it does make the operation a bit more safe I guess.

j.
