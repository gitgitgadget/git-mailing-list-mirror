From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation: More on --pretty with git-diff-tree
Date: Mon, 28 Apr 2008 00:18:35 +0200
Message-ID: <200804280018.36470.jnareb@gmail.com>
References: <200804271940.44940.jnareb@gmail.com> <7vzlrfdmm4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 00:19:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqFDd-00043i-Gz
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 00:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482AbYD0WSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 18:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751936AbYD0WSk
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 18:18:40 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:36690 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108AbYD0WSj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 18:18:39 -0400
Received: by fg-out-1718.google.com with SMTP id l27so4666273fgb.17
        for <git@vger.kernel.org>; Sun, 27 Apr 2008 15:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=VXMiWziHaoylwoVHjYL/tj8sMTVfShpeMmAL9JlQWrk=;
        b=qttCN7hwGlRtfiqAa2LA1wOHaiL7cd7o1LJHBVX/9ARY5Rq8lhQZ9ac5lZcnL0nR3mP3s+BVSSz6+MKKOjc1iR4QFstUbb1RdwmPIncXSwoB6YM5hDexrgHS1vH/W3CeJfVqVD/Zmfe8UVcSsFeUREBb/EkawhWm3g+V+RHq+AI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=neO2sHaH/hSxumIyhEo6XDA5lgDvtyAuVDrilQ/lNs6ZJ4hAQaC8Ba4e2loOPtPItxNAYpDi563Tygh9HVNHrfWgTMOzaSG4sQDwdo7POy71HjCZDoamdYV+GDDq0BmwoBbYIqSztco/mLTSAtZFm/KJQXGQH9zmIFoZ/2vF/pY=
Received: by 10.86.92.7 with SMTP id p7mr6247441fgb.32.1209334717878;
        Sun, 27 Apr 2008 15:18:37 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.207.149])
        by mx.google.com with ESMTPS id j12sm8707108fkf.6.2008.04.27.15.18.35
        (version=SSLv3 cipher=OTHER);
        Sun, 27 Apr 2008 15:18:36 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vzlrfdmm4.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80490>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Mention that --pretty=<format> option is used by git-diff-tree only
>> if both --stdin and -v options are provided.

> There are two distinct uses for diff-tree, and by understanding it you
> would be freed from the confusion.
> 
>  * You can compare two arbitrary tree-ish, and because a commit is a
>    tree-ish, comparing two commits is a special case of this.  There is no
>    reason to expect commit logs to be shown in such a use, and formatting
>    options would naturally be ineffective.
> 
>  * You can give a commit and ask the command to give difference ``for the
>    commit'', in other words, the diff between its parent and the given
>    commit.  --stdin is a special case to drive this mechanism repeatedly,
>    one commit at a time.  This is showing the diff as one of the
>    characteristic of the commit, and allowing to show other attributes of
>    the commit such as its message and timestamp makes sense, so formatting
>    options take effect.

Sorry for the/my confusion.

It looks like gitweb's 'commitdiff' and 'commitdiff_plain' views
(actions), both of which can take _two_ commits, needs to be rethough.
Current output doesn't make much sense when the two commits in question
are not parent and child.  Also, simplifying 'commitdiff_plain' by using
git-diff-tree with --pretty=email cannot work with current gitweb's
commitdiff features.

By the way, can one choose one of parents to be shown in ''for the
commit'' mode, or it is only combined (-c, --cc) or all (-m)?
-- 
Jakub Narebski
Poland
