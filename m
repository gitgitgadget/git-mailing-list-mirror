From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v1 1/2] Remove 'git archimport'
Date: Fri, 09 May 2014 10:15:34 -0500
Message-ID: <536cf11632a85_ce316372ec85@nysa.notmuch>
References: <1399599203-13991-1-git-send-email-felipe.contreras@gmail.com>
 <1399599203-13991-2-git-send-email-felipe.contreras@gmail.com>
 <20140509055024.GB30674@dcvr.yhbt.net>
 <536c7f9089b77_182dd0d31084@nysa.notmuch>
 <20140509081507.GA26494@dcvr.yhbt.net>
 <536c939781d8b_2bf0e952f08@nysa.notmuch>
 <20140509085937.GA29347@dcvr.yhbt.net>
 <536c9de8f07ae_39ea14ab310f9@nysa.notmuch>
 <20140509145453.GA18197@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin@laptop.org>
To: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 17:15:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WimWV-0005sc-Um
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 17:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756894AbaEIPPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 11:15:40 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:48258 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753587AbaEIPPj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 11:15:39 -0400
Received: by mail-yk0-f180.google.com with SMTP id q9so3531155ykb.11
        for <git@vger.kernel.org>; Fri, 09 May 2014 08:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=ptTXRX/cREh88vc8jymjeLITmbuMBk26SAodpZi8Acw=;
        b=LEo6Z+EjfpdJ/v/5u7etCNZFt5cjsP2cMtaSq8VB9zBpnLaVR3xGppIeFZFiTbjCs0
         hWkELE0DdINxFLSuqDSODQQ0yDqrO/jWTdTLfp496pNmKq/avTme7OeeW/WwdScr2Qad
         O818czS8DAGzcE9hFIn8EmeoEp//D/G88lO1QmKG/nrld0anptwUkAqWvYpkhA08HjFr
         RAf1ircbSKCKH3+tVrNnG/ToDamdq6/8nG41L/+sI0c0o5J4oEub33Pp+lB2akIf3OJb
         KmsacO9kDTGWqE57P5n0Hkwgk0PK+Agi02+xuEDomn+qm7zihLl7+o5ud3qJ0IDr4nRv
         1yeg==
X-Received: by 10.236.7.47 with SMTP id 35mr15769731yho.23.1399648538716;
        Fri, 09 May 2014 08:15:38 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id j76sm6538426yhi.33.2014.05.09.08.15.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 08:15:37 -0700 (PDT)
In-Reply-To: <20140509145453.GA18197@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248568>

Jeff King wrote:
> On Fri, May 09, 2014 at 04:20:40AM -0500, Felipe Contreras wrote:
> 
> > Eric Wong wrote:
> > > Felipe Contreras <felipe.contreras@gmail.com> wrote:
> > > > As a minimal token that anybody might possibly be using it, I would like
> > > > to see it work at least once. Since you said you have arch repos, can
> > > > you confirm that it does something?
> > > 
> > > Those repos are in offline/offsite storage and I do not have time to
> > > retrieve them.
> > 
> > Then we have no reason to believe they still work, and therefore, no
> > reason to believe anybody is using this.
> 
> Do you have any reason to believe they do NOT work? If not, and they are
> not causing any problems, then what is the benefit to getting rid of
> them?

Ask Junio. He is the one arguing that foreign tools should live in their
own repository out-of-tree.

> > > I've forgotten how to use tla to get a public repo, even.
> 
> I haven't used tla in quite a long time, but:
> 
>   tla register-archive http://www.atai.org/archarchives/atai@atai.org--public/
>   tla my-default-archive atai@atai.org--public
>   mkdir repo
>   cd repo
>   git archimport atai@atai.org--public
> 
> seemed to work (that archive is straight off the tla homepage's
> instructions). Looks like the commit messages could use some cleanup,
> but certainly it's better than nothing.

All right, I guess that' something, but I get:

  Use of each() on hash after insertion without resetting hash iterator
  results in undefined behavior, Perl interpreter: 0x1fec010 at
  /usr/lib/git-core/git-archimport line 129.

And a ton of:

  WARNING: no rule found for checking signatures from atai@atai.org--public

    Consider creating ~/.arch-params/signing/atai@atai.org--public.check
    or ~/.arch-params/signing/=default.check

I'll leave it running and see how it goes.

Still, if it's part of the core, it should have tests.

-- 
Felipe Contreras
