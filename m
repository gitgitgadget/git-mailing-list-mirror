From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Removing a commit from a local branch
Date: Sun, 11 Jan 2009 14:48:07 -0800 (PST)
Message-ID: <m3hc45zcgq.fsf@localhost.localdomain>
References: <a038bef50901111441w21959397tc41922656a25027c@mail.gmail.com>
	<a038bef50901111442y16695664y4fed7cdd9d8af27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: "Chris Packham" <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 11 23:49:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM97c-0004Mq-Vu
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 23:49:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbZAKWsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 17:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751695AbZAKWsL
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 17:48:11 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:54859 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbZAKWsK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 17:48:10 -0500
Received: by ewy10 with SMTP id 10so11224638ewy.13
        for <git@vger.kernel.org>; Sun, 11 Jan 2009 14:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=CrVmNmDcH7cCNQ2t3M277/kq18PTaOF695AYPuIg2Gw=;
        b=ZUuGwg9J8R8yvT/gUugUy+RK7TOl0+NlCjxYyRbdUZc+RoELGAO/pwaYo0/ZVvVWIv
         fvNGMnnuhpIxJzUF3yZW42bLw60NL6jMYiftKWaM6oqh8WmBrLEuBU6ygdvQuMmaWS3e
         HArkiKAXJKdRXKEiI+nD6SM6AuYFStRP5+gVA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=iq+ZorUTyniXRGgCAnMylbi1briq4EOMCJPwdf9sTg7x5+vv0sxboMaMJLRyToy0+s
         zdmCAazNQJH8xj7nqG0K9yjdTdAYtdGaq36VGbjSTKhFAbTXpCKVccubRnmyI/HfHwAK
         cUhEnELb5KccGVcChGxChEiuzU1AtXAu3y6tA=
Received: by 10.210.22.16 with SMTP id 16mr247309ebv.56.1231714088246;
        Sun, 11 Jan 2009 14:48:08 -0800 (PST)
Received: from localhost.localdomain (abwj90.neoplus.adsl.tpnet.pl [83.8.233.90])
        by mx.google.com with ESMTPS id 23sm2809215eya.3.2009.01.11.14.48.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Jan 2009 14:48:07 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n0BMm6v7012349;
	Sun, 11 Jan 2009 23:48:07 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n0BMm6bK012346;
	Sun, 11 Jan 2009 23:48:06 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <a038bef50901111442y16695664y4fed7cdd9d8af27@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105246>

"Chris Packham" <judge.packham@gmail.com> writes:

> Consider the following example. The maintainer has the following
> branch locally
> 
>   todeliver: A-B-C-D
> 
> He is happy with commits A, C and D but wants to reject B. Ideally I
> want to be able to say
>   git rebase --onto <parent of B> <child of B> todelvier
> 
> and get
>   todeliver: A-C'-D'
> 
> I know that <parent of B> can be referred to as B~1 but what about
> <child of B>? I've read through the man page for git-rev-parse and
> nothing stands out as child of commit X.
> 
> Is there a better what do achieve what I'm after?

Yes, I think it would be easier to either use "git rebase --interactive"
(with some script taking place of EDITOR, or something), or prod Stephan
Beyer (CC-ed) to finish git-sequencer...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
