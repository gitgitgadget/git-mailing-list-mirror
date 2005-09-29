From: Tony Luck <tony.luck@gmail.com>
Subject: Re: Pull from one branch to another?
Date: Thu, 29 Sep 2005 10:52:10 -0700
Message-ID: <12c511ca0509291052108fa0a7@mail.gmail.com>
References: <433B84BD.8030003@pobox.com>
Reply-To: Tony Luck <tony.luck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 29 19:53:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL2aL-0000QA-HF
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 19:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbVI2RwN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 13:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbVI2RwM
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 13:52:12 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:31158 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932285AbVI2RwL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 13:52:11 -0400
Received: by zproxy.gmail.com with SMTP id 13so855471nzn
        for <git@vger.kernel.org>; Thu, 29 Sep 2005 10:52:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YqZh0Fsce5xiCIECpohOijVTF+zR5/T4x3NA+Vm7ShMxwFXJjhPEdTwkSHlaKeWE/aD6m21plQwmBRYMF7JutAO5KkFIIqr1AxlVE4k4PaOD9v8Bnb6B1k61y/kwMtGxTAqB2Var/KIQxbBWNfWIF3qZ0GoZhlNr9tQR800rdD0=
Received: by 10.37.15.4 with SMTP id s4mr2042508nzi;
        Thu, 29 Sep 2005 10:52:10 -0700 (PDT)
Received: by 10.36.58.18 with HTTP; Thu, 29 Sep 2005 10:52:10 -0700 (PDT)
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <433B84BD.8030003@pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9494>

On 9/28/05, Jeff Garzik <jgarzik@pobox.com> wrote:

>         $ git checkout -f sky2
...
>         $ git checkout -f upstream
...
>         $ git checkout -f ALL

Those "-f" arguments to git checkout shouldn't be needed, and may
eventually cause a problem.  The "-f" option doesn't quite work as
"forcibly" as you might think it does because it ignores the index, and
so doesn't do what you[1] expect with files that exist in the previously
checked out tree, and not in the new tree ... it won't delete them, so
there's a small risk that with the wrong git operation you may
accidentally add them to the new branch.

In the sequence you described a simple "git checkout" should do the
right thing ... and will be faster too.

-Tony

[1] well what *I* expected, and was part of a snafu I made earlier
