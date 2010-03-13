From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: message on no-args push to an empty repo
Date: Sat, 13 Mar 2010 07:29:21 +0530
Message-ID: <2e24e5b91003121759k34ec294cl8a57ef22eda2bbf5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 13 02:59:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqGdU-0006T6-Gr
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 02:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753995Ab0CMB7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 20:59:22 -0500
Received: from mail-qy0-f179.google.com ([209.85.221.179]:45832 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753384Ab0CMB7W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 20:59:22 -0500
Received: by qyk9 with SMTP id 9so1771445qyk.5
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 17:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=GJd38nK2wP5Ha98+lmxc4W++Swe5wD0cfawQi5Zf690=;
        b=iwuzTkqpDZMOELm6xMUrLOj57qqVTIrhQN7cYIvbmlITeU4eixHAgQgVYi6RwAp+c3
         57NQcSVNcMKaU6MHFANLpJWF7ua4/5PD8kYcHbOwMlQ929Ji9ooH5Rb6LUJu5N3ArAxb
         N88vbrXBUcd764l6k/xOjVYzRHYTlZbsjj/uY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=cRbjDKZsKINJBF6RKtDDdzPAFHbdadOSZv4MvegIJvdihUZ5UOlKvqmcxqFv/3oHhq
         FppyyghwQtQHfbsh9RuKgHPNwYNJgOeHjaMt9vB5aIRcI4flqzsKR2rwU+jZOAS0QBUu
         Q5IbiNaBmF6gWeWr10krJsG2fUpYLcFSyqBp8=
Received: by 10.220.127.17 with SMTP id e17mr1564352vcs.169.1268445561060; 
	Fri, 12 Mar 2010 17:59:21 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142071>

Hello,

When someone is doing the *first* push to an empty remote repo, and
they try to use the no-args "git push", they get this:

> No refs in common and none specified; doing nothing.
> Perhaps you should specify a branch such as 'master'.
> fatal: The remote end hung up unexpectedly
> error: failed to push some refs to 'git@gitsrv:testsite.git'

This is a fairly clear message, except that by only mentioning the
branch name, and not the remote name, it perhaps confuses people into
doing this:

> $ git push master
>
> fatal: 'master' does not appear to be a git repository
> fatal: The remote end hung up unexpectedly

The correct answer of course is "git push origin master", and yes I
realise they should read the git-push manpage...

Can we think of a possible wording change to that message to help this
situation?  For example, would it be safe to assume the remote would
always (in such cases) be "origin" and say:

    Perhaps you should specify the remote and the branch explicitly,
like 'git push origin master'

Regards,

Sitaram
