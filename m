From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: question concerning branches
Date: Wed, 19 Aug 2009 22:01:35 +0200
Message-ID: <200908192201.36383.jnareb@gmail.com>
References: <4a8c51f5@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>
To: Ingo Brueckl <ib@wupperonline.de>
X-From: git-owner@vger.kernel.org Wed Aug 19 22:01:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdrLt-0001e1-U9
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 22:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbZHSUBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 16:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbZHSUBg
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 16:01:36 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:40618 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbZHSUBf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 16:01:35 -0400
Received: by fg-out-1718.google.com with SMTP id e12so858378fga.17
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 13:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=B959K/g8rI2r2mteAd9Ct99SHGRPnN4VS/NOrethNSM=;
        b=lUnqJIZUY8YdVKKUcIMiwYuB0QZj3B+1PZm7BGm6f+hJ/RWDz5fbG7goKUw/20NlZr
         TB94qPv5c/7jYFIVtUGMO3pjWJ/zsJg7LBiei1IIccuqJcnybEFpq+UE5HiOxUkuiHso
         urk0GU4sSD9uR75AUgmo8ZvLZ+9qNhg1MV+Q8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=GQBl2LxYX6hHP89KbjJYQSNmZWLNXOqWsxXMAxoHDTiWedZVtUfmQdUpLd6WBiGoUB
         giKEElk6e07+vUHNVXUziuoa3JfyaQeuYfcztfzJx519NQguDETnQWE7DD8Syp9wnTTi
         QZ59SNXP6xyjlWgMz5c36uOwjjHwKe4mUTrcE=
Received: by 10.86.231.5 with SMTP id d5mr4460831fgh.53.1250712096399;
        Wed, 19 Aug 2009 13:01:36 -0700 (PDT)
Received: from ?192.168.1.13? (abvn197.neoplus.adsl.tpnet.pl [83.8.211.197])
        by mx.google.com with ESMTPS id 4sm885580fgg.4.2009.08.19.13.01.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Aug 2009 13:01:35 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4a8c51f5@wupperonline.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126580>

On Wed, 19 Aug 2009, Ingo Brueckl wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > You finish old work (or stash it away), _then_ you begin new work.
> 
> Ok, this helps me a little bit to understand.
> 
> The branches aren't designed to split my work, but rather something to
> collect the different parts of my work.

Well, git is flexible enough that it can support also the workflow you 
tried to use.  

Namely you can have many working directories tied to single repository 
(each of those checkouts should be of different branch).  You can use 
git-new-workdir script from contrib/worktree for that.  Then to switch 
branches you would just cd to appropriate directory (and keep unsaved 
changes and untracked files).  That said it is [much] less used 
workflow.
 
> But as software development often is something where you are coding on
> several issues at the same time which can't be committed immediately,
> it sounds that 'stash' is the developer's best friend.

Well, you can also commit and then clean up history with interactive 
rebase (or patch management interface such as StGit or Guilt).  In 
distributed version control systems like Git the act of publishing 
changes is separate from the act of committing them (you should not 
rewrite published history, though).

-- 
Jakub Narebski
Poland
