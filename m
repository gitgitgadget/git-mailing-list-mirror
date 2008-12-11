From: "Jeff Whiteside" <jeff.m.whiteside@gmail.com>
Subject: Re: Removing a merge commit
Date: Wed, 10 Dec 2008 16:24:05 -0800
Message-ID: <3ab397d0812101624h77c5198bqd38f30dee1830605@mail.gmail.com>
References: <4A07B3ED-D048-4455-B4C3-5DAB1F8E6965@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Ray Morgan" <raycmorgan@mac.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 01:25:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAZN5-0001UI-Uw
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 01:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbYLKAYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 19:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752418AbYLKAYK
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 19:24:10 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:41638 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864AbYLKAYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 19:24:09 -0500
Received: by nf-out-0910.google.com with SMTP id d3so152192nfc.21
        for <git@vger.kernel.org>; Wed, 10 Dec 2008 16:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=oKKRL4MdTBnRfymRdZarUy3WC2THeqr18VpdD6rB53Q=;
        b=kqgAIwdWZL5QQUNgPOhJ/ElGNNKB0WIhPCHo2ZHGNTFu4Jblj0UzkbfHRO5lKAmqJ/
         n4IjjBrK6/ej1FJgBTof1sYAXBEXwcCoo7Ge9cY7Nd5uMf4lh2sQXYKcUO3OjQ5gxAR+
         IzlJ2WFRhJqDQjt23OaRdKPZXTGuT9YQnPHik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=tJds8xd9+e0yXgNFqy4CezKqSioL7oVdBNtwzMQNXZgQx9jWvT7CHAm4Z5TNhe9DGb
         yS9B6B4myu8Y+nIv5f+lj6Sb94ghpWGchhaocpzHXfR5tlF2MZ+KVEog03DEUx4fQXXf
         tvmckf7jLCdUrW2eJkyS5j0v7bvslIRxsYsoY=
Received: by 10.67.15.2 with SMTP id s2mr4488176ugi.84.1228955045847;
        Wed, 10 Dec 2008 16:24:05 -0800 (PST)
Received: by 10.66.220.9 with HTTP; Wed, 10 Dec 2008 16:24:05 -0800 (PST)
In-Reply-To: <4A07B3ED-D048-4455-B4C3-5DAB1F8E6965@mac.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102751>

Isn't this what you want? (taken from
http://www.kernel.org/pub/software/scm/git/docs/git-rebase.html)



A range of commits could also be removed with rebase. If we have the
following situation:

    E---F---G---H---I---J  topicA

then the command

git rebase --onto topicA~5 topicA~3 topicA

would result in the removal of commits F and G:

    E---H'---I'---J'  topicA



On Wed, Dec 10, 2008 at 12:20 PM, Ray Morgan <raycmorgan@mac.com> wrote:
> Hello,
>
> To build a release for our site, we merge branches that developers create.
> We do this with --no-ff in order to make it only one commit to pull if it
> fails QA. Say the qa branch's history has 4 merge commits in a row, is there
> any way to remove the 3rd (just pulling it out.. much like how a rebase
> works)?
>
> Currently we just checkout below that failed branch and re-merge everything
> above it.. but that just seems very clumsy (and manual).
>
> Thanks!
> Ray
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
