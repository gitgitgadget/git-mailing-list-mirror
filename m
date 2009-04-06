From: David Aguilar <davvid@gmail.com>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Sun, 5 Apr 2009 20:24:58 -0700
Message-ID: <20090406032457.GA14758@gmail.com>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com> <200904052358.53028.markus.heidelberg@web.de> <94a0d4530904051535v8bd901fsedecdf61bc4acb33@mail.gmail.com> <200904060117.24810.markus.heidelberg@web.de> <fabb9a1e0904051622k66352ea4v542ecd99bd5d9c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: markus.heidelberg@web.de,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 05:26:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqfU6-0002yv-JY
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 05:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214AbZDFDZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 23:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752137AbZDFDZK
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 23:25:10 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:6027 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbZDFDZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 23:25:09 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1567259wah.21
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 20:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=9vO6oYwWngr4OIFYllSO6wr9eTTSe9zafmeFlbbEIFE=;
        b=cVU16ghhtPnW+rpmc1yBGBkPVrj3uFWqAvoGiJ0Rshd731LtGxNDrtwFyev3/ADi9u
         +Qgw5I5wTVFPaFgxMrVNca4FNY7hbp4vnImCz8/e0aKx0Vj7rxo7T9Wd26Ln98d5YAX4
         eFK9fn43M+LSeXjrdIEpp0X3uP58F14+TFszg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GHn4UyxLFQGl1pBsc3vc6Moct1DSLjlUe4H4ezRPhwNFbYI7hXcb3HSc3WXrNNu7Q0
         HyGElqusMUcq2v8TTdieGfg5d6tjHob5KxmqG2Ow2yFtNAZxMfpUPSpkJcy9nNnFSvNO
         9XbfmDiFygZsoeFIx8KMI0sdO1h++77H+c4vc=
Received: by 10.114.36.4 with SMTP id j4mr2020082waj.119.1238988307657;
        Sun, 05 Apr 2009 20:25:07 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id l28sm4942040waf.65.2009.04.05.20.25.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Apr 2009 20:25:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <fabb9a1e0904051622k66352ea4v542ecd99bd5d9c6@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115757>

On  0, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
> 
> On Mon, Apr 6, 2009 at 01:17, Markus Heidelberg
> <markus.heidelberg@web.de> wrote:
> > Felipe Contreras, 06.04.2009:
> >> But actually, "git diff --cached" is a
> >> different action; you can't do "git diff --cached HEAD^.." for
> >> example.
> >
> > And I neither could I do "git stage diff HEAD^.."
> 
> I rest my case ;). That's the whole point Felipe is trying to make here.
> $ git diff --cached
> $ git diff HEAD^..
> 
> That's two different modes of operation with the only difference being
> a switch ('--cached'), which changes what is, and what is not valid
> after that.
> 
> Whereas with
> $ git stage diff
> 
> There is no confusion that 'HEAD^..' is not a valid argument, as there
> is no command in 'git stage diff' to which it _is_ a valid argument.

Hello

Here's an interesting email from a while back:

http://kerneltrap.org/mailarchive/git/2008/10/29/3857134

The above mentions the following suggestion:

    git diff STAGE WORKTREE   (like "git diff" today)
    git diff HEAD WORKTREE    (like "git diff HEAD" today)
    git diff WORKTREE HEAD    (like "git diff -R HEAD" today)
    git diff HEAD STAGE       (like "git diff --cached" today)
    git diff commit STAGE     (like "git diff --cached commit" today)


>From a consistency and usability perspective, the above
example seems very appealing because:

a) it does not introduce any new commands, and

b) it is consistent with the way git-diff's command-line
   interface works today.

All we'd have to do is teach git-diff to special-case
'STAGE' and 'WORKTREE'.  Now, whether we'd want to do
that is a completely different discussion, but I figured I'd
throw the old thread out there.


-- 

	David
