From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH] t6006-*.sh: Fix truncation tests
Date: Tue, 20 May 2014 18:34:01 +0400
Message-ID: <20140520143401.GA31750@ashu.dyn1.rarus.ru>
References: <537B5E8C.3070803@ramsay1.demon.co.uk>
 <20140520141936.GA30187@ashu.dyn1.rarus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue May 20 16:34:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wml7L-0001Bf-9H
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 16:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652AbaETOeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 10:34:06 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:45202 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522AbaETOeF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 10:34:05 -0400
Received: by mail-lb0-f169.google.com with SMTP id s7so479655lbd.28
        for <git@vger.kernel.org>; Tue, 20 May 2014 07:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=shyQQ9DmbzF1bISQaFMeEQPRocgeu9jkEHEaQMDOCI0=;
        b=q8pfcJj/v67nZ3CPON0+XclI84kNmolCtQhidZ7Yj0f6RdgpMJK9WsEF4ze1fv7bQY
         YH/8/cyrrJfSxamTP/p7z9w83mMif70SCckM4k2/VGf4/o1A53Lh5JkJ8qe8pap8X5GW
         SbCByzSEn4oK8xUGuTrLZnrWA7ywJRQzbNwGqUtEIGPimg1G4YMt7xYCWAdb9nFYveXV
         1UJKRFw4BRWYQakT/cBbNC/wacqNfVTd+ugOWZU0MEq7b64X4tMie48DYssSXAs3NoNW
         MYtfN8Qh89mAqbdx8mJfJnC7KNmXy72pTWlqC6o+cPBnRwGiSbVMNyKqimBqak2oCpLk
         nuvw==
X-Received: by 10.113.3.139 with SMTP id bw11mr2537773lbd.63.1400596443028;
        Tue, 20 May 2014 07:34:03 -0700 (PDT)
Received: from localhost ([193.9.244.4])
        by mx.google.com with ESMTPSA id go4sm20985595lbc.35.2014.05.20.07.34.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 May 2014 07:34:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140520141936.GA30187@ashu.dyn1.rarus.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249685>

On Tue, May 20, 2014 at 06:19:36PM +0400, Alexey Shumkin wrote:
> On Tue, May 20, 2014 at 02:54:20PM +0100, Ramsay Jones wrote:
> > 
> > Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> > ---
> > 
> > Hi Alexey,
> > 
> > If you need to re-roll your 'as/pretty-truncate' branch, could
> > you please squash the relevant parts of this patch into the
> > corresponding patches of your patch series. (ie this is a patch
> > against the head of the current pu branch ...).
> > 
> > Without this patch I get:
> > 
> >   $ ./t6006-rev-list-format.sh
> >   ok 1 - setup
> >   ok 2 - format percent
> >   ok 3 - format hash
> >   ok 4 - format tree
> >   ok 5 - format parents
> >   ok 6 - format author
> >   ok 7 - format committer
> >   ok 8 - format encoding
> >   ok 9 - format subject
> >   ./t6006-rev-list-format.sh: 152: ./t6006-rev-list-format.sh: Syntax error: "(" unexpected
> >   FATAL: Unexpected exit with code 2
> >   $ 
> Ooops, my fault.
> > 
> > (if you have bash as /bin/sh you get different but related errors).
> > The additional quoting suppresses the 'command redirection' errors, etc...
> It's strange but I do have Bash as /bin/sh and unfortunately I have no
> this error
> 
> AFAIU, Junio already applied my patches (existance of a branch
> as/pretty-truncate tells us that). So, we can only send other patches that
> fix errors brought with former patches.
> You can send, too.
> > 
> > Thanks.
> > 
> > ATB
> > Ramsay Jones
> > 
> >  t/t6006-rev-list-format.sh | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
> > index 9bc089b..e1dec3e 100755
> > --- a/t/t6006-rev-list-format.sh
> > +++ b/t/t6006-rev-list-format.sh
> > @@ -149,7 +149,7 @@ commit $head1
> >  $added
> >  EOF
> >  
> > -test_format subject-truncated %<($truncate_count,trunc)%s <<EOF
> > +test_format subject-truncated %\<\($truncate_count,trunc\)%s <<EOF
BTW, I would quoted that values rather than escaped
