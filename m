From: "seventh guardian" <seventhguardian@gmail.com>
Subject: Re: [bug] git-clone over ssh fails when repository has local commits
Date: Sun, 6 Apr 2008 17:22:39 +0100
Message-ID: <1caff7430804060922seba4978qa13b123103b8282b@mail.gmail.com>
References: <1caff7430804060645s764f24f8y3d07ee8647ec8f25@mail.gmail.com>
	 <20080406161120.GB24358@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 06 18:23:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiXeP-0005ep-77
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 18:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865AbYDFQWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 12:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753766AbYDFQWk
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 12:22:40 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:10221 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539AbYDFQWk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 12:22:40 -0400
Received: by wa-out-1112.google.com with SMTP id v27so943425wah.23
        for <git@vger.kernel.org>; Sun, 06 Apr 2008 09:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=G2Fo4mSBEr2Xx7cOgtFRaCiNt2BRBj1W9kkodRJP2+4=;
        b=qMRbexAj4Rq8xxfVsScp86ra3FlhJocb9aDFAXRRw/qqhlu80uxUhfYmPkmU5zuCM8nilDU0M6r7+G+VVi00yQoXBozEUBoD4dxIDiWlYr05g1TCteHez+idbXZ5IKbhmEZPzWPgYVDtPHI7ofAZySSEQ/GMQ0f0RMnBT8k/pX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lxiM6sbaJluV3HIMz0VWS2KlfuaUZ+7FtYV294Cur8qGcJboehadoVTX6EPq5FE7kwSGYbCUx0Np6y/70JQbbDL4JdwSgkGFUnEgIG2nzH0T6J6Y86CcPxDXgmcsHkPDfli2NIGWPoObXbOlsbUnWKSfedY3xacxMawpb9f6tMg=
Received: by 10.114.254.2 with SMTP id b2mr1757956wai.192.1207498960001;
        Sun, 06 Apr 2008 09:22:40 -0700 (PDT)
Received: by 10.114.126.18 with HTTP; Sun, 6 Apr 2008 09:22:39 -0700 (PDT)
In-Reply-To: <20080406161120.GB24358@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78897>

On Sun, Apr 6, 2008 at 5:11 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Apr 06, 2008 at 02:45:22PM +0100, seventh guardian wrote:
>
>  >  $ git-clone ssh://<host>/<path>
>  > Initialized empty Git repository in <path>/.git/
>  > Password:
>  > remote: Counting objects: 132468, done.
>  > remote: Compressing objects: 100% (25543/25543), done.
>  > remote: Total 132468 (delta 107355), reused 130574 (delta 105466)
>  > Receiving objects: 100% (132468/132468), 42.12 MiB | 4161 KiB/s, done.
>  > Resolving deltas: 100% (107355/107355), done.
>  > error: Trying to write ref REMOTE_HEAD with nonexistant object
>  > f7a51afd56964cb0f10178353315d2680832ea54
>  > fatal: Cannot update the ref 'REMOTE_HEAD'.
>  > Warning: Remote HEAD refers to nonexistent ref, unable to checkout.
>
>  It sounds like your remote repository has a bogus HEAD that points to a
>  non-existent object. Can you ssh to <host> and confirm that you can do a
>  "git show HEAD" in the remote repo?

I can, but it is a local commit. It seems like local commits aren't
being "cloned over" to the slaves.. As I said, this only happens for
"local masters" where I have local commits. If my master is untouched,
then I can successfuly clone the repo.

Thanks,
  Renato
