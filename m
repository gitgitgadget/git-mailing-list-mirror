X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Avoiding uninteresting merges in Cairo
Date: Fri, 15 Dec 2006 16:57:05 +0100
Message-ID: <200612151657.06909.jnareb@gmail.com>
References: <20061215020629.GK26202@spearce.org> <eluasq$v7q$3@sea.gmane.org> <20061215150130.GB17860@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 15 Dec 2006 15:54:53 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=R6SpF6ldyfrY6tIeq7KlY8w4ol2rZvtz+zcobwt45N5BGnCLOz7aHEiylvWeSy/RrryVwystj2/guqAjxJuaUE0eS7QZuiuGAKYTW9kMrq0Zh1g9C4MbnJgnejA2Yj+Kfm2UWac5pmq/UTiy4TbasvhtcnTSAte2raAORhZjId8=
User-Agent: KMail/1.9.3
In-Reply-To: <20061215150130.GB17860@spearce.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34524>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvFOY-0005Rx-QU for gcvg-git@gmane.org; Fri, 15 Dec
 2006 16:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752766AbWLOPyp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 10:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752769AbWLOPyp
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 10:54:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:37329 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1752766AbWLOPyo (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec
 2006 10:54:44 -0500
Received: by ug-out-1314.google.com with SMTP id 44so844428uga for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 07:54:43 -0800 (PST)
Received: by 10.67.121.15 with SMTP id y15mr162850ugm.1166198079207; Fri, 15
 Dec 2006 07:54:39 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id e1sm4459298ugf.2006.12.15.07.54.38; Fri, 15 Dec
 2006 07:54:39 -0800 (PST)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
>> Carl Worth wrote:
>> 
>>> On Thu, 14 Dec 2006 22:25:30 -0500, Shawn Pearce wrote:
>> 
>>>>  * gitweb made it appear as though a whole lot of Carl's recent
>>>>    work was somehow undone in the merge.
>>> 
>>> That looks like a simple gitweb bug. None of the other tools, (gitk,
>>> git log -p), consider a trivial merge commit like this as having
>>> anything interesting in it worth displaying.
>> 
>> It's not a bug, it is rather lack of feature (or misfeature).
> 
> Its a bug.
> 
> I'm not a gitweb user (meaning I almost never look at something
> in gitweb).  But I'm clearly also not a Git newbie.  ;-)
> 
> I could not fathom why that merge commit was being displayed that
> way in gitweb.  I had to clone the cairo project just so I could
> actually look at the commit with log/show/whatchanged/diff-tree,
> because I couldn't believe what I was seeing from gitweb.

Do you mean "commit" view or "commitdiff" view in gitweb for merges
is confusing?

If it is "commit" view, it is fairly easy to remove difftree/whatchanged
output below commit message for merges. However while git-show nor 
git-diff-tree doesn't show diff for merge messages, the diftree output
in "commit" view might be taken as 'damages'; git diff --summary always
takes summary of diff against first parent.

If it is "commitdiff" view... well, I plan on adding combined diff 
output to commitdiff, but I need raw (whatchanged) output with the
same files which would be shown in git-diff --cc for merges (compact
combined diff output). Otherwise I'd have to use combined (-c) output
in gitweb, rather than more terse --cc output.

-- 
Jakub Narebski
