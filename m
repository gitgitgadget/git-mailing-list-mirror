From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Parent-less branches
Date: Sat, 3 May 2008 02:46:01 +0200
Message-ID: <bd6139dc0805021746q40b384c3nb36a8605d9475a7f@mail.gmail.com>
References: <20080502232008.GA20092@ulrik-ibook>
	 <m38wys6y1q.fsf@localhost.localdomain>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Ulrik Sverdrup" <ulrik.sverdrup@gmail.com>, git@vger.kernel.org,
	"Wincent Colaiuta" <win@wincent.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Pedro Melo" <melo@simplicidade.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 03 02:46:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js5tt-0002rr-AU
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 02:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765206AbYECAqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 20:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763611AbYECAqF
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 20:46:05 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:11213 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758221AbYECAqC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 20:46:02 -0400
Received: by wf-out-1314.google.com with SMTP id 27so190435wfd.4
        for <git@vger.kernel.org>; Fri, 02 May 2008 17:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=QlvoAvPRk8GHyv8XrnF8CvwAYkJV4+uz6CqJ2MQhyW4=;
        b=P+ui46YaXsSZGohIRdnguBgC7RITNOqM9+uht+oPMQYoO5+RIcGFV7d03vf7oOsYPeTt/24QDbluwzTYp5I/lGKH5LkUdy+Ds+fZWZRAZiK1kREkuz97AzgT1Qur2lpKECqeKHs5GH3nBFZxaUt9jT1h3QJPpUgYW+esjQ4a/T0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j9oxx23M5T2t2lYaoDR/sH+ZMzG7XVBn/C3W4tChkWJQE4nB5lNTEbG18B/08T8I5YfhRap0e5b67qOEi/9s1OQcLQBks8rP2z9v2/HlWhvh2wBKNsiC0IStVUKoT/aXRflkOGZ4T7/dyPbNfc6GpkPQcCK2pBfMvN1nJtHuCF8=
Received: by 10.142.237.20 with SMTP id k20mr1496321wfh.174.1209775561746;
        Fri, 02 May 2008 17:46:01 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Fri, 2 May 2008 17:46:01 -0700 (PDT)
In-Reply-To: <m38wys6y1q.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81055>

On Sat, May 3, 2008 at 2:17 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>  In short the solution is to create content-less branch using:
>
>   $ git symbolic-ref HEAD refs/heads/newbranch
>   $ rm .git/index
>
>  then commit.

I guess what Pedro is asking is if there isn't a builtin way to do
this. Which, if I understand correctly, there isn't. Perhaps though
something like "git branch -N newbranchname" which then creates a new
parentless branch. It could just be a shell script that does the
above, but I wonder if there are no side-effects of the above? It
sounds somewhat 'messy' to remove the index? Too 'low level' to do for
a user I mean, what if sometime in the future we decide to store
something in the index that -is- important? I reckon it would be
cleaner to add an option for this.

-- 
Cheers,

Sverre Rabbelier
