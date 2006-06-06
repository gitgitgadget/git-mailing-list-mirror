From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFC] revision limiter in git-rev-list
Date: Tue, 6 Jun 2006 13:46:23 +0200
Message-ID: <e5bfff550606060446rc9160cbt948ceededeb22766@mail.gmail.com>
References: <e5bfff550606060136l59143ef2mdb9dc68ab78e9ff1@mail.gmail.com>
	 <7v7j3uvapa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 06 13:46:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fna0x-0007zH-QE
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 13:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWFFLqY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 07:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWFFLqY
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 07:46:24 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:10575 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751244AbWFFLqY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 07:46:24 -0400
Received: by wr-out-0506.google.com with SMTP id 55so151845wri
        for <git@vger.kernel.org>; Tue, 06 Jun 2006 04:46:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hTvoNmBYMesLwKPxaSOWrHH5Af+TIIF5Oz/s96sA/7WEfQMyFf8vbzF3Jamh4aNfAwrsvBwrbr8ONs68jv5ky4q14XN1tW3jD42htLW8NTJyC4ZerwHmPP24zMycaAO+TnLTKjqs5Kawii4cJeCCNCTwe2Oh2K+RV13W7oR8Qis=
Received: by 10.65.196.16 with SMTP id y16mr4400692qbp;
        Tue, 06 Jun 2006 04:46:23 -0700 (PDT)
Received: by 10.65.210.20 with HTTP; Tue, 6 Jun 2006 04:46:23 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v7j3uvapa.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21374>

>
> While I really do not think this belongs to rev-list, I suspect
> what you want is a command that takes a set of commits you are
> interested in and gives you an abbreviated topology across them.


I was thinking at an extension of git-rev-list because

1) Current git-rev-list options are quite orthogonal with rev limiter.
As example in previous given examples -n and --parents options are
used and I think more could be used with
interesting results.

Current git-rev-list options are a lot and are very powerful, it's a
pity if this new feature do not inherit them.

2) This feature could be seen as a generalization of path limiting.

>From today:
  git-rev-list  HEAD -- <path 1>  <path 2>  ...   <path n>

To possible:
git-rev-list  HEAD -- <obj 1>  <obj 2>  ...   <obj n>

Where obj == <path> || obj == <commit sha> ||  obj == <something else
I didn't think of>

Of course we need a (syntactic) way to disambiguate the arguments
after '--' but the results are very powerful and general, as example
we could mix commit objects _and_ paths in git-rev-list command line
(git-rev-list HEAD -- foo.c  tag1) and also be able to use the full
set of git-rev-list options before the '--'


     Marco
