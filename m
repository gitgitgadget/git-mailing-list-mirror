From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: Determining if a file exists in a bare repo
Date: Tue, 4 May 2010 09:18:09 -0700
Message-ID: <h2z8c9a061005040918s33bd5020sa89e95aedb7b8cb@mail.gmail.com>
References: <w2q799406d61005040911p8fd7c234s5e6382298129985f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Adam Mercer <ramercer@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 04 18:18:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9KpS-0003cg-E7
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 18:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933565Ab0EDQSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 12:18:31 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35921 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932192Ab0EDQSa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 12:18:30 -0400
Received: by mail-vw0-f46.google.com with SMTP id 12so55350vws.19
        for <git@vger.kernel.org>; Tue, 04 May 2010 09:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=UUyoSjx4XaljFXD+GScrN2xq1ZJ/DvpcUtg9IvfBeq8=;
        b=JDp3VfWorBGPOeeYC3VSdYlTrBowRkt22nuONoupqYwaMvrkvQ+oHA0VezR/MJw3ZE
         xsFr8eZbD1xAWG6vzYg6MRSmCjg1Hf74TapnHXnm59VGxsxjdxQa6uIjuzeBfgbvfSCT
         DALtwcsG7YLaCYau6acjdEZQ67Cfrw1jjvYHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=RqyKQCi61P0wctyRZss4ODQeQD+XfnrMa4vOVbyMa5gJfsrfDrCHjPoGsB7jco7zDI
         g5AKSZtF7WGmJvDHVVju3SwdktBrzs7JMRVlqHVfnRyK+W6qLIorwgFVeeDfuA1p2M9d
         8AHI0UARUVeBUnGsKOf+2plUMZw5Lp+Vhl7WA=
Received: by 10.229.184.130 with SMTP id ck2mr3311778qcb.95.1272989909712; 
	Tue, 04 May 2010 09:18:29 -0700 (PDT)
Received: by 10.229.215.131 with HTTP; Tue, 4 May 2010 09:18:09 -0700 (PDT)
In-Reply-To: <w2q799406d61005040911p8fd7c234s5e6382298129985f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146321>

On Tue, May 4, 2010 at 09:11, Adam Mercer <ramercer@gmail.com> wrote:
> Hi
>
> I'm trying to write a post-receive hook that generates some HTML files
> from reStructured text files stored in a repository. Essentially I'm
> doing this with
>
> git show master:INSTALL | rst2html --no-raw --no-file-insertion >
> /path/to/INSTALL.html
>
> However I would like this script to fail gracefully if the INSTALL
> file is not available in the repository so would like to check if this
> file exists. The problem I'm having is that git-show seems to return a
> zero return code even if the file you request doesn't exist, e.g.:
>
> $ git show master:NoneExistantFile
> fatal: ambiguous argument 'master:NoneExistantFile': unknown revision
> or path not in the working tree.
> Use '--' to separate paths from revisions
> $ echo $?
> 0
> $
>
> is there another, scriptable, way to determine if a given file exists
> in a given branch of a bare repository?
>
> Cheers
>
> Adam

What about using "git ls-tree master" to get a file listing?
