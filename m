From: David Aguilar <davvid@gmail.com>
Subject: Re: Git's inconsistent command line options
Date: Tue, 1 Sep 2015 02:28:34 -0700
Message-ID: <20150901092834.GA10706@gmail.com>
References: <mrh7ck$r0g$1@ger.gmane.org>
 <CAPc5daUdVQSAhrig046qGopVuxCDagZg3v9bwXOaC3SvC2MRnw@mail.gmail.com>
 <CA+P7+xrYugueYYrrJV0pduAHCg7CLknE_0QYcU8mO6idntz=VA@mail.gmail.com>
 <CAGZ79kZ6KK0qVtzrxmmsBQqmz-dgamC4f6W0zVTQLcuYi==0fw@mail.gmail.com>
 <xmqqa8tfvsr9.fsf@gitster.dls.corp.google.com>
 <CACsJy8D3J6RhtPPtSvtWfOb8BapaX2-52M5_fE36psQPB_oQsQ@mail.gmail.com>
 <20150831102558.1514e5f7@anarchist.wooz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Graeme Geldenhuys <graemeg@gmail.com>
To: Barry Warsaw <barry@python.org>
X-From: git-owner@vger.kernel.org Tue Sep 01 11:28:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWhrv-0006Sm-40
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 11:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755211AbbIAJ2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 05:28:39 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:38806 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754079AbbIAJ2i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 05:28:38 -0400
Received: by igbuu8 with SMTP id uu8so43901446igb.1
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 02:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=d2KBM7y7U8qF1B4B//EqS8caZoiH2SISx/H1I4nbG28=;
        b=M0DKHq/aYMFkwokyCIa/MkGZyEbTa1Kb0kD+jqJBuhRTuQpideGO7D3KOLt/4QG3Km
         eYF4h7/8cCXEKSj5atcQGNuaw/9vIGwqRRZM2tERcCElTU0GeZj6SnDL7ICc/8shVxeh
         QspgIxN5bXqdizAX5hLyAa9yhCYdVi5Rg1qTVChXAXCPKR4ztRYEIlVNMmQisopyyqrQ
         JSFpYmP8qIqYQYRHbHNSWdCO7iMIjqgQAPfINHaKBxr+PiNBqMtzSxZgqB3BnVEOMx6v
         OmdBpnh7YIUYQh4xsbx3NJueLHhXV6/nIwPxVnGyIWKh40NNswndguBWgXScDib52NzU
         zHwg==
X-Received: by 10.68.223.4 with SMTP id qq4mr45332515pbc.36.1441099717692;
        Tue, 01 Sep 2015 02:28:37 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id oq3sm17406423pdb.75.2015.09.01.02.28.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Sep 2015 02:28:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150831102558.1514e5f7@anarchist.wooz.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276974>

On Mon, Aug 31, 2015 at 10:25:58AM -0400, Barry Warsaw wrote:
> On Aug 31, 2015, at 05:10 PM, Duy Nguyen wrote:
> 
> >I'm probably shot down for this. But could we go with a clean plate
> >and create a new command prefix (something like git-next, git2, or
> >gt...)? We could then redesign the entire UI without worrying about
> >backward compatibility. At some point we can start to deprecate "git"
> >and encourage to use the new command prefix only. Of course somebody
> >has to go over all the commands and options to propose some consistent
> >UI, then more discussions and coding so it could likely follow the
> >path of pack v4..
> 
> `git` itself could also be a thin wrapper which consulted a configuration
> variable to see which version of the ui to expose.
> 
> "All problems in computer science can be solved by another level of
> indirection"

Except for poor performance, simplicity, and bad ideas.

The Git project does not break backwards compatibility.
Let's let Python3 serve as a good lesson on why not to do that! ;-p

While a script writer could write, "git -c core.cliversion=1 ...",
no one does that, no one wants to do that, and it just seems
like a bad idea that's best left unexplored.

The only idea in this thread that's user-friendly would be a new
Git that still supported the entirety of the existing,
perfectly-good CLI interface and *also* accepted some new
"consistent" user interface.

Otherwise, this entire thread seems like a big non-issue.
The existing CLI hasn't hurt adoption, and tossing a config
option at it only makes it worse.  The best config is no config.

There really are ony a few corner cases that would need to be
tweaked to support --named-subcommands style, and after that is
done, is Git really that much easier to use?

Maybe a little bit, but not enough that warrants breaking
existing scripts IMO.
---
David
