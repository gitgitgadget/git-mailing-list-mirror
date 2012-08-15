From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [PATCH/RFC v3 07/16] Add a symlink 'git-remote-svn' in base dir.
Date: Wed, 15 Aug 2012 11:20:34 +0200
Message-ID: <2021296.QelIutNuid@flomedio>
References: <1344971598-8213-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <1344971598-8213-8-git-send-email-florian.achleitner.2.6.31@gmail.com> <7vvcgl8amk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 11:21:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1Zmd-0003lN-6G
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 11:20:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246Ab2HOJUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 05:20:46 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:63857 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662Ab2HOJUn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 05:20:43 -0400
Received: by bkwj10 with SMTP id j10so435958bkw.19
        for <git@vger.kernel.org>; Wed, 15 Aug 2012 02:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=9zo14oo8R6vK3RV4o3WqjwqS65WoK+fMPpobGBoNY2Q=;
        b=TGXlPEE+NmjYSu4SYLGdNib+/2LasluozlI7NZQf1uZngmVMExoUGncyqmNgm2F++z
         ja+TJRiSITJHV5E1twrWGvDq3rodWaq2rwX9XncK6uDzodc15lgBc6VvvEXNTkjIB3is
         uq7IrlQHoo2HHh/LbUUfIKP6F8bIyJXopm/0QrCd25gwrqDPz3zbTRAEGdVLhD9Rvw7a
         pkkgaIb9X3Lz2x+a4lb9Fzl4Pi36QRp5QaipnCmbcQ2PkkJJVhgAA55Bv4UaD9xqadTg
         KcptdlP8TrghxTarqRUABdJwHL2Ur3LAb4Rf46KzX5Uuwz9YWWkQAKT0F2SHA6j9cnLD
         kB3Q==
Received: by 10.204.8.65 with SMTP id g1mr7313514bkg.50.1345022442503;
        Wed, 15 Aug 2012 02:20:42 -0700 (PDT)
Received: from flomedio.localnet (089144206125.atnat0015.highway.a1.net. [89.144.206.125])
        by mx.google.com with ESMTPS id y20sm425212bkv.11.2012.08.15.02.20.38
        (version=SSLv3 cipher=OTHER);
        Wed, 15 Aug 2012 02:20:40 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.0.0-24-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <7vvcgl8amk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203466>

On Tuesday 14 August 2012 13:46:43 Junio C Hamano wrote:
> Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:
> > Allow execution of git-remote-svn even if the binary
> > currently is located in contrib/svn-fe/.
> > 
> > Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
> > ---
> > 
> >  git-remote-svn |    1 +
> >  1 file changed, 1 insertion(+)
> >  create mode 120000 git-remote-svn
> > 
> > diff --git a/git-remote-svn b/git-remote-svn
> > new file mode 120000
> > index 0000000..d3b1c07
> > --- /dev/null
> > +++ b/git-remote-svn
> > @@ -0,0 +1 @@
> > +contrib/svn-fe/remote-svn
> > \ No newline at end of file
> 
> Please scratch my previous comment.  I thought you were adding an
> entry to .gitignore or something.
> 
> I'd rather not to see such a symbolic link that points at a build
> product in the source tree.  Making a symlink from the toplevel
> Makefile _after_ we built it in contrib/svn-fe/ (and removing it
> upon "make clean") is OK, though.

As with the makefile in contrib/svn-fe, this is just a hack. The toplevel 
Makefile doesn't seem to build contrib/* at all. I always need to call make 
explicitly in these subdirs.
