X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Add "next" link to commitdiff view
Date: Sun, 29 Oct 2006 03:58:31 +0200
Message-ID: <200610290258.31771.jnareb@gmail.com>
References: <196807.75961.qm@web31801.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 29 Oct 2006 01:58:52 +0000 (UTC)
Cc: Luben Tuikov <ltuikov@yahoo.com>, Junio Hamano <junkio@cox.net>,
	Petr Baudis <pasky@suse.cz>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ilIy4OZLdAnaf2Hgylgx3h/BxDJ0wGRJ2TUv9LKwHjNsEheKRVstJwJbgF0MNduAKnzkj2mTQOIubbGahtRwu+sPJZdQxIzCkJUH4N6SjbdoslUkXpdhm1uXHQrxr52L1AtySu4njwcBUbe41HLY8wX7CcEG41TeURzPEqK2YBI=
User-Agent: KMail/1.9.3
In-Reply-To: <196807.75961.qm@web31801.mail.mud.yahoo.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30405>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gdzwg-0008AF-7d for gcvg-git@gmane.org; Sun, 29 Oct
 2006 02:58:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751462AbWJ2B6g (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 21:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWJ2B6g
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 21:58:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:38444 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1751462AbWJ2B6f
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 21:58:35 -0400
Received: by ug-out-1314.google.com with SMTP id 32so933174ugm for
 <git@vger.kernel.org>; Sat, 28 Oct 2006 18:58:34 -0700 (PDT)
Received: by 10.66.244.10 with SMTP id r10mr1938286ugh; Sat, 28 Oct 2006
 18:58:34 -0700 (PDT)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id b23sm1366196ugd.2006.10.28.18.58.33; Sat, 28 Oct
 2006 18:58:33 -0700 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Luben Tuikov wrote:
> --- Jakub Narebski <jnareb@gmail.com> wrote:
>> Jakub Narebski wrote:
>>> Add a kind of "next" view in the bottom part of navigation bar for
>>> "commitdiff" view.
>>> 
>>> For commitdiff between two commits:
>>>   (from: _commit_)
>>> For commitdiff for one single parent commit:
>>>   (parent: _commit_)
>>> For commitdiff for one merge commit
>>>   (merge: _commit_ _commit_ ...)
>>> For commitdiff for root (parentless) commit
>>>   (initial)
>>> where _link_ denotes hyperlink. SHA1 is shortened to 7 characters on
>>> display, everything is perhaps unnecessary esc_html on display.
[...]
>> 
>> Any reasons not to accept this patch? I find it very useful.
>> 
>> The idea to use fixed string instead of shortened SHA-1 of commit
>> was abandoned after some discussion in this thread.
> 
> I prefer using the commit-8 without any "..." postfixed.  Anyone who
> knows squat about git knows very well what a commit-8 is when they
> see one -- the first 8 hexadecimal digits of the full SHA-1.
> 
> I like using "next" only when there is a "prev" right next to it,
> i.e. based on _context_, something like this:
>    << prev next>>
> where "<< prev" is hyperlinked, and "next>>" is also.

Unfortunately this is simply not possible in this case, as links in git
are only from commit to paren(a), in one direction only.

Besides as you can see we can have more than one "next>>" link: for merge
commit there are multiple parents. Well, for branch points there are
multiple commits which have given commit as (one of) its parent(s), so
there can be multiple "<<prev" links as well.

> I looked at your patch (first email in this thread) and from
> what I gathered that it does, I like it (haven't tried it yet).
> 
> What I like about it is the clear information it conveys:
> it gives me both the commit-8 and what that commit-8 _is_.

It is commit-7, but that can be easily changed.

> Acked-by: Luben Tuikov <ltuikov@yahoo.com>
> (not that it matters in any way ;-) )

IIRC Junio asked for ACKs.
-- 
Jakub Narebski
