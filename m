From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git branch --switch?
Date: Tue, 17 Apr 2007 16:21:29 +0200
Message-ID: <81b0412b0704170721i2b64999aqbd0d7489074454d6@mail.gmail.com>
References: <4624CD58.90103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Rene Herman" <rene.herman@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 16:21:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdoYu-00027S-U9
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 16:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbXDQOVc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 10:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbXDQOVc
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 10:21:32 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:47783 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030302AbXDQOVa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 10:21:30 -0400
Received: by an-out-0708.google.com with SMTP id b33so2230438ana
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 07:21:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rH2VKNbYsgjXHlPPuVuAgAH81qU8Wc/dUyf4kgkl/wDRq/p5NqPOmxf+PCrssit/bE1du2Gt+b469cowm3Z/MB1eQG7hebBYMUVxTgwpGfyQUQzF/3z5wiYx0OYnnFDsDac48r6t4uZyvyAnGSIiKh1lJ2Yf0oaWTjjMIostw6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CtUmEJbhQOVR1PaTtB+QmgmdrAGFDtirSUDEna7Er1yHFN+wptltiKx4I4xFSs8F7e20lF0jlCyYDpisJJ5N0qGRki707cguJ4kyUMifFRSmefu5QdzkZaj3axLRuXRdz40x5BOeEat7qJFyjhh6qnPaTJ5cFFOYjg4uZ9c/xC0=
Received: by 10.100.190.8 with SMTP id n8mr5464295anf.1176819689463;
        Tue, 17 Apr 2007 07:21:29 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Tue, 17 Apr 2007 07:21:29 -0700 (PDT)
In-Reply-To: <4624CD58.90103@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44769>

On 4/17/07, Rene Herman <rene.herman@gmail.com> wrote:
> Is it possible to switch the current branch without checking it out? Not
> really essential, but I'm happily flaundering around with git and still
> start from scratch fairly regularly; to speed this up I've found the -n
> switch to git clone useful and would like something similar when
> reconstructing my "branch hierarchies".
>
> Upto now I only know about "git checkout" (with or without -b) to switch the
> current branch. As said it's not really essential, but I was expecting there
> would be something like a "branch --switch". Did I overlook it?

Kind of. It can be done with git-read-tree. I.e.:

  $ git-read-tree --index-output=.git/tmp-index <branch-name> && \
     mv tmp-index .git/index && \
     git update-ref HEAD <branch-name>
