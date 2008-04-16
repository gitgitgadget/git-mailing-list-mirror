From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: crlf with git-svn driving me nuts...
Date: Thu, 17 Apr 2008 00:39:23 +0400
Message-ID: <20080416203923.GH3133@dpotapov.dyndns.org>
References: <320075ff0804161210m46f3e83bpf7bf9d1d5816d914@mail.gmail.com> <20080416200107.GG3133@dpotapov.dyndns.org> <32541b130804161320w42c68bc2p9d838dc127a57027@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nigel Magnay <nigel.magnay@gmail.com>, git <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 22:52:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmEQR-0003gK-H7
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 22:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130AbYDPUja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 16:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbYDPUja
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 16:39:30 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:14561 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbYDPUj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 16:39:29 -0400
Received: by fk-out-0910.google.com with SMTP id 19so2965931fkr.5
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 13:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=9C8a1TtNzfz4FfTbL9wb9Xr8V5g9rx9GJ1teekyFmwQ=;
        b=AiB6sdCt5eLj2sCa+FANw9BoyhgSMJyNAhWX1htj3BbZeO90LAUB7nyoOI7wLxqB3gXyqa0F0+pCLTgK6gezUHr4yKSFwuTGqApuGzV4R5keUBfo8vl8pPujgBy2opTVEr0axpM3j9Hv7odF/aUWRUNDQYJ+vN0cKV0dqEdnwLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=DCgiZ7pNgVrkSbgtvaWbVTdhAVRdeQlLuD0Mx1rT12S/NdtbVPYiPXPxqQPB5iVqku6JerKq97w1cSvqP2IA9x4+leuHcqkc2VO8F9ij5xC0QID28cs4ysYQ/aGGmm0wzwK0ZETVA8ToOF6Z803xsTL+EKgXZUUzah0L0qJT/qw=
Received: by 10.82.118.1 with SMTP id q1mr754695buc.4.1208378367595;
        Wed, 16 Apr 2008 13:39:27 -0700 (PDT)
Received: from localhost ( [85.141.188.158])
        by mx.google.com with ESMTPS id d25sm14252535nfh.33.2008.04.16.13.39.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Apr 2008 13:39:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <32541b130804161320w42c68bc2p9d838dc127a57027@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79747>

On Wed, Apr 16, 2008 at 04:20:27PM -0400, Avery Pennarun wrote:
> On 4/16/08, Dmitry Potapov <dpotapov@gmail.com> wrote:
> >  In this case, you already have a file with the wrong ending,
> >  so file.txt will be shown as changed now, because if you commit
> >  it again then it will be commited with <LF>, which should have
> >  been done in the first place.
> [...]
> > If you do not want problems, you should use core.autocrlf=true
> >  on Windows. Then all text files will be stored in the repository
> >  with <LF>, but they will have <CR><LF> in your work tree.
> >  Users on *nix should set core.autocrlf=input or false, so they
> >  will have <LF> in their work tree.
> 
> Alas, the subject of this thread involves git-svn, and the typical
> git-svn user is someone who has no way of rewriting the existing
> history in their svn repositories.  Thus, files *will* be in the
> repository that have the wrong line endings, and (as you noted) git
> just gets totally confused in that case.

Actually, what matters in what format files are in _Git_ repository.
Maybe, there is a problem with git-svn and how it imports SVN commits
to Git, but I have not encountered it.

> Nigel's example showed a few situations where git *thought* the file
> had changed when it hadn't, and yet is incapable of checking in the
> changes.

Incapable of checking in? I have not found a single example in
his mail where it was impossible. The only quirk with autocrlf
is that you need to re-checkout your work tree after changing
it. There is no other problems with it as far as I know.

Dmitry
