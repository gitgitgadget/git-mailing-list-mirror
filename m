From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: Question about 'branch -d' safety
Date: Tue, 29 Dec 2009 23:31:23 +0100
Message-ID: <20091229223123.GA12965@vidovic>
References: <20091230065442.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 23:31:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPkbS-0000Jg-SC
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 23:31:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063AbZL2Wbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 17:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbZL2Wbc
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 17:31:32 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:60443 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240AbZL2Wbb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 17:31:31 -0500
Received: by ewy19 with SMTP id 19so3180730ewy.21
        for <git@vger.kernel.org>; Tue, 29 Dec 2009 14:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=rnuh6+uyln3xZMxIpJFVDONLkNWHfcBkGQdG8k1qHS8=;
        b=pbY0QwsX2hr6MTJWsCVd1vpaiIjX9Kfxp6C5W3C81EwzqED7KeDXKxjhrWp6ijTDvE
         myO/be7LIKajc1ut8vL6o5N9PWuYdh+neNMc2VmPcWH+C3iD3YtHMRSQsqq/MSA7TSS7
         qfHKNdoBAIeUTJarokEAa83TDa9yTSuaUHR98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EkmD/yfraxo0qxfivO+O0AVj2Gse3pxtFVNkxjswy9JqxT6B8D6zHBz9UOrYPwjruw
         MdqbSphrOE3AaOaymAaAxr86rZDR160IqwUOYNe8wUgSrXPZGVProjwqXlsnVU8ARvtU
         nIaKQSoK+tu4Q7wMjjl8HhCWWfR4fHLGgBWOQ=
Received: by 10.213.42.210 with SMTP id t18mr5641469ebe.49.1262125890056;
        Tue, 29 Dec 2009 14:31:30 -0800 (PST)
Received: from @ (83-154-173-109.rev.libertysurf.net [83.154.173.109])
        by mx.google.com with ESMTPS id 15sm9169004ewy.0.2009.12.29.14.31.25
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 29 Dec 2009 14:31:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091230065442.6117@nanako3.lavabit.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135841>

The 30/12/09, Nanako Shiraishi wrote:

> I think the safety feature should check if the branch to be deleted is merged to the remote tracking branch it was forked from, instead of checking the current branch.
> 
> What do you think?

I think we shouldn't. At first, every repository don't have a remote.
This may easily be passed by a "double check" with a logical OR between
the two statements.

But even with it, we would hit some foreign workflow. Think: Bob
directly push to Alice and Alice does the same to Bob. I don't use this
kind of workflow myself but I consider them to be sensible enough to
have our attention.

Now, I'm talking about what users may expect from the default behaviour.
I'm not against a new configuration variable. It would certainly give
more granularity to the expectation of "what is safe for me".


-- 
Nicolas Sebrecht
