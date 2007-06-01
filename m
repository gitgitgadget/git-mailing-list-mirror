From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [mingw port] git plumbing piping with CR/NL
Date: Fri, 1 Jun 2007 19:56:54 -0400
Message-ID: <fcaeb9bf0706011656p2145afe0k8be9797d250566df@mail.gmail.com>
References: <fcaeb9bf0706011123ue4ceaf2i12569c63d1d92584@mail.gmail.com>
	 <20070601231816.GC6360@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Johannes Sixt" <johannes.sixt@telecom.at>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 01:57:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuGzT-0001TU-24
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 01:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758617AbXFAX44 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 19:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758765AbXFAX44
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 19:56:56 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:42178 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758335AbXFAX4z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 19:56:55 -0400
Received: by an-out-0708.google.com with SMTP id d31so211798and
        for <git@vger.kernel.org>; Fri, 01 Jun 2007 16:56:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IvbbYZEW030NTl1Q6wlNB3TkRVXiRbmcqH7n/IisihP5WI3JvQhT9tD2Fyzl4cGritcsYkxKThPnE4hCIMvn4dvJyjKoXWDqGOKnf1/blckM/Eo3t1w1YvX2+YTNEPMiUpd1heFNYyvvpB1klmHDyOJC4c7x7R6HvurZab5vsoE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b0bECpE0xS8PwtS+bq0N0s0yuB6dFB82YLP5Zv7tC376Bvn51ctxEU2pyOiDyvg7TXcJsFpWb+pIjxpwF5QU3Mr6thwPtOnXV3X3vMShxhAdq/w/NzzuYLJAZc38I/AjDnNVC0Vj6/ZdhTiuedJN7SXIIxwCXA0hjO9NrISq4EU=
Received: by 10.100.142.12 with SMTP id p12mr1305036and.1180742214650;
        Fri, 01 Jun 2007 16:56:54 -0700 (PDT)
Received: by 10.100.127.18 with HTTP; Fri, 1 Jun 2007 16:56:54 -0700 (PDT)
In-Reply-To: <20070601231816.GC6360@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48900>

On 6/1/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> Nguyen Thai Ngoc Duy, Fri, Jun 01, 2007 20:23:24 +0200:
> > Hi,
> >
> > I haven't had time looking at the code yet. I report here so that I
> > can free my memory for other things. I made a command like this:
> >
> > $ git ls-tree -r HEAD|grep blah.cc|git update-index --index-info
> >
> > and the output of git-status was:
> >
> > $ git status
> > # On branch master
> > # Changes to be committed:
> > #   (use "git reset HEAD <file>..." to unstage)
> > #
> > #     new file:   path/to/blah.cc\r
> > #
> > # Changed but not updated:
> > #   (use "git add/rm <file>..." to update what will be committed)
> > #
> > #     deleted:    path/to/blah.cc\r
> > ...
> > $ git version
> > git version 1.5.2.651.g80e39-dirty (if the commit isn't in the master
> > branch, it is based on master branch)
> >
> > Apparently git should ignore \r at the end of the path. ...
>
> Why should it? \r is a valid character in filenames almost everywhere
> (except for the some proprietary OSes, as usual).

Right. Although I doubt usage of \r and other special characters in filenames.

> Why does your grep _alters_ the input, instead of filtering it, btw?

I have no idea. It's grep from MKS Toolkit FYI.
-- 
Duy
