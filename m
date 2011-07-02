From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Gitweb 1.7.5 and Textconv Configuration
Date: Sat, 2 Jul 2011 23:22:23 +0200
Message-ID: <201107022322.24832.jnareb@gmail.com>
References: <CALWDD1x-_rEx+c9bpAgVk-hvnGz1bt0mbJoDkSjZkbe=gLscUg@mail.gmail.com> <m3aacw5t5x.fsf@localhost.localdomain> <20110702211027.GA16294@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Al Haraka <alharaka@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 02 23:22:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qd7eA-0006HF-PA
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 23:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535Ab1GBVWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jul 2011 17:22:33 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:41400 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030Ab1GBVWd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2011 17:22:33 -0400
Received: by fxd18 with SMTP id 18so4158768fxd.11
        for <git@vger.kernel.org>; Sat, 02 Jul 2011 14:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=du2aetRF5dfJPSx1O270NBGAajK7gpQKduYd5hhdu+o=;
        b=dtlx2hG95HYhdAsy9Ca5VhCPNyNSRId7M/M3tlEttPQWBrErLdjkRgT1aWn/kXyKnT
         TPTyG0YLM0zLDfU5HFsvqOTm/m05E2IzXoUCVl/4Ycgei2Vu8nvnFf6DNEKWSDkxrsmG
         batOMWokn+yL7MKdcUle91yOfmjVe3S0LBgls=
Received: by 10.223.85.155 with SMTP id o27mr6908640fal.109.1309641751779;
        Sat, 02 Jul 2011 14:22:31 -0700 (PDT)
Received: from [192.168.1.15] (abvp70.neoplus.adsl.tpnet.pl [83.8.213.70])
        by mx.google.com with ESMTPS id l9sm238502fal.43.2011.07.02.14.22.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 02 Jul 2011 14:22:30 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110702211027.GA16294@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176571>

On Sat, 2 Jul 2011, Jeff King wrote:
> On Sat, Jul 02, 2011 at 01:23:38PM -0700, Jakub Narebski wrote:
> 
> > > Ah, I see. That seems like a reasonable solution. Are you sure that the
> > > user running gitweb as a CGI is the same as the user you log in as? That
> > > is, are you sure that ~/.gitconfig is being parsed when it is called as
> > > a CGI, and it's not looking in ~www/.gitconfig or something?
> > > 
> > > It would depend how your hosting is set up.
> > 
> > Well, there is also system wide $(prefix)/etc/gitconfig file...
> 
> Good point. Though if he's on shared hosting, that might not be an
> option.

Though on the other hand if he is compiling git himself, $prefix can
be $HOME...

> > The question is if --textconv works with git-diff-tree, because that
> > is what gitweb uses.
> 
> It does. It just defaults to "--no-textconv", but you can enable it on
> the command-line.

Undocumented.

  $ git grep -e --textconv Documentation/
  Documentation/RelNotes/1.6.3.3.txt: * "git diff --textconv" leaked memory badly when the tex
  Documentation/git-cat-file.txt:'git cat-file' (-t | -s | -e | -p | <type> | --textconv ) <ob
  Documentation/git-cat-file.txt:object type, or '-s' is used to find the object size, or '--t
  Documentation/git-cat-file.txt:--textconv::

(on current 'master').

-- 
Jakub Narebski
Poland
