From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: Tracking remote branches
Date: Mon, 14 Sep 2009 07:01:45 +0200
Message-ID: <20090914050145.GA12985@vidovic>
References: <a4c8a6d00909131737v35d7c63dsea669f47456f5acb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 07:02:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mn3hR-00044N-99
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 07:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbZINFBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 01:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbZINFBt
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 01:01:49 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:47042 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbZINFBt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 01:01:49 -0400
Received: by bwz19 with SMTP id 19so1841444bwz.37
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 22:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=QhBmKh8L2M04pA2s4lXqwOg40R7ygaLqZdJYprGGRq8=;
        b=kULdcuQinlYCboKZrHaUscKLCPTd6QyHak2clChlclKBsbJTFcavxNDd+LfIpmnsJA
         v5J12YaPcaQBqWkQ6ySGWVuxQmBhTqbouBZ6y0IXcLYLmPieZq2y1ohkUyl76IDYJ48u
         jQTdpuorJHsV9ygq09YtHVoAOz94Qj+HLLX7A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lwnTXpVKcqjv3grA8qp9Z3ekEWnbc+l0bwlEiebpOH9VglcJgHeaVLMxZyTNeRkM4F
         D/CBRz8XLtgobSwCgnuOsd1pT+Ygf1XOJmM1NIA4knTx5GclnHQOGUMr7cq94bWcT307
         Gbys71eT4RzLYRf6D4hnSaS9GDH4qahRzg1qI=
Received: by 10.204.38.75 with SMTP id a11mr4752073bke.86.1252904511418;
        Sun, 13 Sep 2009 22:01:51 -0700 (PDT)
Received: from @ (91-164-147-224.rev.libertysurf.net [91.164.147.224])
        by mx.google.com with ESMTPS id 12sm8120899fks.17.2009.09.13.22.01.47
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 13 Sep 2009 22:01:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <a4c8a6d00909131737v35d7c63dsea669f47456f5acb@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128437>

The 13/09/09, Thiago Farina wrote:
> Hi,
> 
> I know that I could do simply, instead of above:
> $ git checkout --track -b maint origin/maint

Or
$ git checkout -t origin/maint

> OK, now I switched to maint branch. And then I did:
> $ git status
> 
> # On branch maint
> # Changes to be committed
> #    (use "git reset HEAD <file>..." to unstage)
> #
> #          new file:    git-remote-curl
> #          new file:    git-replace
> #
> 
> What happened here? What I have to do now?

You've probably added these files to the index, mistakenly. If you don't
have uncommited changes, try :

  git checkout -f master
  git branch -D maint
  git checkout -t origin/maint
  git status

The files should now be shown as "Untracked files".

-- 
Nicolas Sebrecht
