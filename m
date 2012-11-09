From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: RFD: fast-import is picky with author names (and maybe it should
 - but how much so?)
Date: Fri, 9 Nov 2012 15:34:34 +0100
Message-ID: <CAMP44s3Lhxzcj93=e8TXwqAVvGJBKhZEVX33G8Q=n2+8+UfCww@mail.gmail.com>
References: <5093DC0C.5000603@drmicha.warpmail.net>
	<20121108200919.GP15560@sigill.intra.peff.net>
	<509CCCBC.8010102@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Nov 09 15:34:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWpfV-0000xq-HM
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 15:34:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753563Ab2KIOeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 09:34:36 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:38306 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877Ab2KIOef (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 09:34:35 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so4075546oag.19
        for <git@vger.kernel.org>; Fri, 09 Nov 2012 06:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BcuOZkCpfir086FoVCGGbD8ZoKA4H4TyKoqnVD+Vhr8=;
        b=ZnuWaDV2TnC2UffbdmeQgMXDFVj0sWwZrZQG/XU/sm09/Znyfbo+Ug4lnpZKsnu6/s
         28ryWiWPmU4+6mTMtjLt2gm4+Z0vsG6ffAZpuu03kx5YCgQ019Hnr2tVtXaw69aVXYEE
         5XQFyV13SNDNkMRufuLinRzzQUGwOTLmWdgXfHNav7RLnlhFFU04zaOK1yzn435IYrKs
         WkyxXGc1pOB+u2tDFWiJm1omNzHtXE6WJEoYR8tc5+kPTRFCLciq1W/kvmjWnYwbS0bm
         6485REgrqcITMDaYuNUJenbppx36pxeo25MgI0uy7s/2xaDLSWoh+823Ed5Hqepn3RZY
         a3yw==
Received: by 10.60.26.234 with SMTP id o10mr7798121oeg.85.1352471674832; Fri,
 09 Nov 2012 06:34:34 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Fri, 9 Nov 2012 06:34:34 -0800 (PST)
In-Reply-To: <509CCCBC.8010102@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209221>

On Fri, Nov 9, 2012 at 10:28 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:

> Hg seems to store just anything in the author field ("committer"). The
> various interfaces that are floating around do some behind-the-back
> conversion to git format. The more conversions they do, the better they
> seem to work (no erroring out) but I'm wondering whether it's really a
> good thing, or whether we should encourage a more diligent approach
> which requires a user to map non-conforming author names wilfully.

So you propose that when somebody does 'git clone hg::hg hg-git' the
thing should fail. I hope you don't think it's too unbecoming for me
to say that I disagree.

IMO it should be git fast-import the one that converts these bad
authors, not every single tool out there. Maybe throw a warning, but
that's all. Or maybe generate a list of bad authors ready to be filled
out. That way when a project is doing a real conversion, say, when
moving to git, they can run the conversion once and see which authors
are bad and not multiple times, each try taking longer than the next.

-- 
Felipe Contreras
