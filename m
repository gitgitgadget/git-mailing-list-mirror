X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: Add "next" link to commitdiff view
Date: Sat, 28 Oct 2006 18:50:26 -0700 (PDT)
Message-ID: <196807.75961.qm@web31801.mail.mud.yahoo.com>
References: <200610281810.36892.jnareb@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sun, 29 Oct 2006 01:51:53 +0000 (UTC)
Cc: Junio Hamano <junkio@cox.net>, Petr Baudis <pasky@suse.cz>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=GR8U22aWfaT0hzsEEMOG/9nwiG+5xwxW3I9FqSYgNwP3XBgWqyqpgeUKMAHRpk063ow476ZV2DARTY2z7Mhaww9lt7FJOLjwk2cAbLCXmnsAeMo+OlXxMZtevo3WAxXkxOzFeLIYfR8PQkqmmuFDGvz2u31nZOYs0FyNW2B3eq8=  ;
X-YMail-OSG: mZSS8t4VM1lO.Jutnw.jpb2tqTgHDYVQmHZcyya.w_g_zJijTdSfG3cIEdkq4NUqnDwtYJnpo5dRvlSnosJa0cgo3V4nFgSyiyizhrVrhL17q8KHB2puZxFzPiLb.kDfL8B8xGK62ys-
In-Reply-To: <200610281810.36892.jnareb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30404>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdzpB-0005WO-Gi for gcvg-git@gmane.org; Sun, 29 Oct
 2006 02:50:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751459AbWJ2Bu1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 21:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWJ2Bu1
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 21:50:27 -0400
Received: from web31801.mail.mud.yahoo.com ([68.142.207.64]:63850 "HELO
 web31801.mail.mud.yahoo.com") by vger.kernel.org with SMTP id
 S1751459AbWJ2Bu0 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006
 21:50:26 -0400
Received: (qmail 76419 invoked by uid 60001); 29 Oct 2006 01:50:26 -0000
Received: from [71.80.233.118] by web31801.mail.mud.yahoo.com via HTTP; Sat,
 28 Oct 2006 18:50:26 PDT
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org

--- Jakub Narebski <jnareb@gmail.com> wrote:
> Jakub Narebski wrote:
> > Add a kind of "next" view in the bottom part of navigation bar for
> > "commitdiff" view.
> > 
> > For commitdiff between two commits:
> >   (from: _commit_)
> > For commitdiff for one single parent commit:
> >   (parent: _commit_)
> > For commitdiff for one merge commit
> >   (merge: _commit_ _commit_ ...)
> > For commitdiff for root (parentless) commit
> >   (initial)
> > where _link_ denotes hyperlink. SHA1 is shortened to 7 characters on
> > display, everything is perhaps unnecessary esc_html on display.
> > 
> > Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> > ---
> > 
> > Junio (and others), is it what you wanted? The idea was to change
> > "commitdiff" view only in minimal way, and preserve similarity
> > to "commit" format.
> 
> Any reasons not to accept this patch? I find it very useful.
> 
> The idea to use fixed string instead of shortened SHA-1 of commit
> was abandoned after some discussion in this thread.

I prefer using the commit-8 without any "..." postfixed.  Anyone who
knows squat about git knows very well what a commit-8 is when they
see one -- the first 8 hexadecimal digits of the full SHA-1.

I like using "next" only when there is a "prev" right next to it,
i.e. based on _context_, something like this:
   << prev next >>
where "<< prev" is hyperlinked, and "next >>" is also.

I looked at your patch (first email in this thread) and from
what I gathered that it does, I like it (haven't tried it yet).

What I like about it is the clear information it conveys:
it gives me both the commit-8 and what that commit-8 _is_.

I sometimes remember commit-8s and this helps me a lot when
I move the mouse pointer to an xterm and want to do
git-show <commit-8>, and it futhermore helps me _know_ the
relationship between that commit-8 and the rest of the
information in the window frame gitweb is showing, (parent, etc).

Acked-by: Luben Tuikov <ltuikov@yahoo.com>
(not that it matters in any way ;-) )

   Luben


