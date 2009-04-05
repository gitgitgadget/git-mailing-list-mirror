From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: git-{diff,merge} refactor round 2
Date: Mon, 6 Apr 2009 00:15:16 +0200
Message-ID: <200904060015.17145.markus.heidelberg@web.de>
References: <1238590514-41893-1-git-send-email-davvid@gmail.com> <7vzlevv3fy.fsf@gitster.siamese.dyndns.org> <20090405211533.GA1393@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes.Schindelin@gmx.de, charles@hashpling.org, git@vger.kernel.org, msysgit@googlegroups.com
To: David Aguilar <davvid@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Apr 06 00:16:54 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f163.google.com ([209.85.221.163])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqadz-0007dg-3d
	for gcvm-msysgit@m.gmane.org; Mon, 06 Apr 2009 00:16:47 +0200
Received: by qyk35 with SMTP id 35so3427407qyk.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 05 Apr 2009 15:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:jabber-id:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:x-sender
         :x-provags-id:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=nzlS6fi1uoWhzJWael6LWOyJycxRCDO3hwwLP0QFVns=;
        b=NHwkS+2d7/qq0gisqfVpXy5u8ZZew1UHaOeNAPyJVQzWyBmcN/m6aRLF0kT6b+hd3h
         c2sMYU0pwrwhS9n50AQ99ezrOTL25wZUmPeTJpjilvdXpqED3fDWvLQn8EolLffVUG4n
         JyFe9J5mkMjJ0F4G4kmSKwVZvPGGlRW7GNf70=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :reply-to:to:subject:date:user-agent:cc:references:in-reply-to
         :jabber-id:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:x-provags-id:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=YfbYFTrpAoY0fIlbI6C9Te3CMoNDTUNczVDqMkXRM7zt/eS2Jf3NXeIp48JPg6tkNF
         ztCEp+ih7IX+6cIx5O9q4o1SCgTX7M2WCQLhqXwcrvDjEEM8o3lU65/z+YHKnPTayeyA
         1MEcEqL2f2orGs1AleFL+CzRnX1dzar+AKU4M=
Received: by 10.224.67.199 with SMTP id s7mr529903qai.12.1238969711070;
        Sun, 05 Apr 2009 15:15:11 -0700 (PDT)
Received: by 10.177.145.19 with SMTP id x19gr4662yqn.0;
	Sun, 05 Apr 2009 15:15:11 -0700 (PDT)
X-Sender: markus.heidelberg@web.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.27.20 with SMTP id a20mr1136305eba.14.1238969710166; Sun, 05 Apr 2009 15:15:10 -0700 (PDT)
Received: from fmmailgate03.web.de (fmmailgate03.web.de [217.72.192.234]) by gmr-mx.google.com with ESMTP id 14si608144ewy.1.2009.04.05.15.15.10; Sun, 05 Apr 2009 15:15:10 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of markus.heidelberg@web.de designates 217.72.192.234 as permitted sender) client-ip=217.72.192.234;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: best guess record for domain of markus.heidelberg@web.de designates 217.72.192.234 as permitted sender) smtp.mail=markus.heidelberg@web.de
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215]) by fmmailgate03.web.de (Postfix) with ESMTP id F0885FA020B6; Mon,  6 Apr 2009 00:15:09 +0200 (CEST)
Received: from [89.59.118.104] (helo=.) by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256) (WEB.DE 4.110 #277) id 1LqacP-0001r1-00; Mon, 06 Apr 2009 00:15:09 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20090405211533.GA1393@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19EXDx5giNHCNpo97X5mlv+Y6r370boCoLwF+w1 bRwEFfdCdWupuGr1xJGz3lw+c1B9jghuOg4Dvt56Dfk5L11FAa rwuFrxas+OmpovVUa58Q==
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115726>


David Aguilar, 05.04.2009:
> On  0, Junio C Hamano <gitster@pobox.com> wrote:
> > David Aguilar <davvid@gmail.com> writes:
> > 
> > I'll try to queue all the outstanding da/difftool patches tonight, but I
> > think the patches in the series are getting to the point of needing a
> > fresh redoing.  Patches like "oops, these non-user scripts should have
> > been named with double-dash" can and should disappear.
> > 
> > Currently they are:
> > 
> > $ git log --oneline next..da/difftool
> > [..]
> 
> It goes back even farther...
> 
> d3b8cec difftool: move 'git-difftool' out of contrib
> 
> d3db8cec is currently sitting in 'next' and is where the
> "oops, I should have used double-dash" lack of foresight
> began.

> 1. Base it on the current master, completely throwing away
> the existing da/difftool branch.  That would include throwing
> away the commit that's in next if we really want to be clean
> about the history.  In the process, move Markus' mergetool
> fixes for windows to the top so that they can be applied
> independently if necessary.  This series would then depend
> on them.

This is my favourite, too.

Additionally, what about basing these on master as well? They also are
unrelated to the refactoring:

def88c8 mergetool-lib: specialize opendiff options when in diff mode
2a83022 mergetool-lib: add diffuse as merge and diff tool
73c59d9 mergetool-lib: specialize xxdiff options when in diff mode
273e7a2 mergetool-lib: specialize kdiff3 options when in diff mode

And start refactoring on top of these?
Then these could go into master or next, since they are mostly bugfixes
and the refactoring can start in pu.

> This would probably mean a merge conflict with next at some
> point.

Revert "d3b8cec difftool: move 'git-difftool' out of contrib" from next?

> Regardless of which it's based on, it's obvious that there'll
> be some squashing going on.  Tentatively,
> 
> Will be squashed:
> 588954e difftool: use valid_tool from git-mergetool-lib
> 8af4556 mergetool: use valid_tool from git-mergetool-lib
> 
> Will be squashed:
> 72286b5 difftool: use get_mergetool_path from git-mergetool-lib
> d03b97f mergetool: use get_mergetool_path from git-mergetool-lib
> c6afc72 Add a mergetool-lib scriptlet for holding common merge tool functions
> 
> Will be squashed:
> 99511d8 mergetool: use run_mergetool from git-mergetool-lib
> 37c48c7 difftool: use run_mergetool from git-mergetool-lib
> 4e314b5 mergetool-lib: introduce run_mergetool
> 
> Will be squashed:
> def88c8 mergetool-lib: specialize opendiff options when in diff mode
> 73c59d9 mergetool-lib: specialize xxdiff options when in diff mode
> 273e7a2 mergetool-lib: specialize kdiff3 options when in diff mode

Yes, some squashing would be nice. Similar commit messages are confusing
when reading the history.

Markus
