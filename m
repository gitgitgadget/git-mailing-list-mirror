From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Bizarre behavior on git commit
Date: Wed, 5 May 2010 09:52:31 -0700
Message-ID: <t2ga038bef51005050952u3370cf68pa45496e56a4adb7b@mail.gmail.com>
References: <s2t6f5a4e781005042246sb9ef3d48j134b22b5b41133ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Dan Loewenherz <dloewenherz@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 05 18:59:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9hwI-0003bV-NR
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 18:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755652Ab0EEQ7B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 12:59:01 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46163 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712Ab0EEQ6w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 12:58:52 -0400
Received: by vws12 with SMTP id 12so1137005vws.19
        for <git@vger.kernel.org>; Wed, 05 May 2010 09:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=bicl5Eg5TTxEdxgfht5ntOjeoWzkmFrbwdkbTwIEMPI=;
        b=r8W9BiW+VQw5CV5itpz3/U2UwsEamxKZVeEq3JyZhMBhloCzO9Zwf0j80hja5fme7d
         eTG30WasDuZhApkhvpT47UHkgX3D5rc7sWVMTFImmy/tr83XdVSCcfi/rnvaDA7/Cj5Q
         ujJT26wsw4w7V2KHX+jf2jfd/3vj9YYGHsHRU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=qgQmRVYVNmc+nVyUToeMEJhaiBdsz5jhpC9EBFkowPI0roKdXvut5OXkx5TlYq8S5g
         CX7vgQbL88fOqab8xneuumRFDGag/EkvD73y0Tkh82/IxDy/xyytHfXvZ0L2jE+Hookr
         noQ3vENbS/fYkk8ySW75vSGMIYakLte/QH2L0=
Received: by 10.224.122.234 with SMTP id m42mr6634469qar.305.1273078351390; 
	Wed, 05 May 2010 09:52:31 -0700 (PDT)
Received: by 10.229.28.3 with HTTP; Wed, 5 May 2010 09:52:31 -0700 (PDT)
In-Reply-To: <s2t6f5a4e781005042246sb9ef3d48j134b22b5b41133ed@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146411>

Hi,

On Tue, May 4, 2010 at 10:46 PM, Dan Loewenherz <dloewenherz@gmail.com> wrote:
> I'm running into a weird issue in a specific repo where "git show-ref"
> usage is being displayed after invocating "git commit".
>
> E.g.
> $ git commit -m "my commit message"
> usage: git show-ref [-q|--quiet] [--verify] [--head]
> ...

This may or may not be the case for you but I did have a bit of a
face-palm issue a while back because I was tinkering with a __git_ps1
bash script and forgot. I was actually getting output from one git
command or another and couldn't figure out why until I eventually
figured out that the commands that were complaining were used in my
__git_ps1 script. This was mainly when I was doing slightly unexpected
things (at least as far as __git_ps1 was concerned, e.g during an
interactive rebase ).

Its probably not your problem but just double check with 'echo "$PS1"'
from your shell.
