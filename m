From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: cvsimport weird
Date: Thu, 18 May 2006 14:54:34 +1200
Message-ID: <46a038f90605171954n7e75ee64t412b22e8d405d909@mail.gmail.com>
References: <4fb292fa0605171800n4f041dd2l8af06d82bdbe6bff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 18 04:54:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgYf9-0003LW-Eh
	for gcvg-git@gmane.org; Thu, 18 May 2006 04:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWERCyg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 22:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWERCyg
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 22:54:36 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:37319 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750820AbWERCyf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 22:54:35 -0400
Received: by wr-out-0506.google.com with SMTP id 50so323899wri
        for <git@vger.kernel.org>; Wed, 17 May 2006 19:54:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y8K+FsfOVj2pnvnWO1rIFqXGVEI6a7KfH6CDBKryl39o2CIMaBb9UdRzSwq2N4gRjNn2zC8WQeb3kefUgKt8HjhBad6EvtVe7cqx5pK14UXaMGcwZhZbo1ZVWauth4pIIpKeHG2uyQGOvAHGuqlt+NABER1loFkqQ/t4w6ecA5E=
Received: by 10.54.132.6 with SMTP id f6mr30170wrd;
        Wed, 17 May 2006 19:54:34 -0700 (PDT)
Received: by 10.54.127.17 with HTTP; Wed, 17 May 2006 19:54:34 -0700 (PDT)
To: "Bertrand Jacquin" <beber.mailing@gmail.com>
In-Reply-To: <4fb292fa0605171800n4f041dd2l8af06d82bdbe6bff@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20256>

On 5/18/06, Bertrand Jacquin <beber.mailing@gmail.com> wrote:
> Hi,
>
> I would like to make some git-cvsimport test on a public repo. And I
> get some problem and don't know if it's a remote server
> (enlightenment) problem or a git-cvsimport one.
>
> Here is the log :
>
> /mnt/data/src/e-tmp % git-cvsimport -v
> -d:pserver:anonymous@anoncvs.enlightenment.org:/var/cvs/e e17
> connect error: Network is unreachable
> WARNING: malformed CVS version str: Server:
> WARNING: Your CVS client version:
> [Client: Concurrent Versions System (CVS) 1.12.12 (client)]
> and/or server version:
> [Server: ]
> are too old to properly support the rlog command.
> This command was introduced in 1.11.1.  Cvsps
> will use log instead, but PatchSet numbering
> may become unstable due to pruned empty
> directories.

The cvs server is strange -- buggy probably. cvsps thinks it is old,
but it is not even returning a version string. Is it really cvs?

> cvs [log aborted]: end of file from server (consult above messages if any)

The remote end is dying on you.

> I don't why it tell me that Network is unreachable as I can do normal
> cvs checkout.

I think it is the remote end that is saying Network unreachable.
Perhaps it is a cvs proxy that only allows some commands?

> Also, I have the repo in another directory, and I don't know how to
> use a :local: CVSROOT

   git-cvsimport -d /tmp/cvsrepo/ modulename

should work ok. You should also try parsecvs ;-)



m
