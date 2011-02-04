From: Endre Czirbesz <endre@czirbesz.hu>
Subject: Re: git to p4 conversion
Date: Fri, 4 Feb 2011 16:08:37 +0000
Message-ID: <AANLkTi=dZdSqcNckyU7Lb2Zj-khfj=Xiyzbv7LSC+zT2@mail.gmail.com>
References: <AANLkTi=0TSD6p7WtsVzx=pq8=GVu+jHUdxt1bnC++CT+@mail.gmail.com>
	<4D4AF29E.7070509@vmware.com>
	<AANLkTikW_sU8oCmU9wN5q1OPPJrQbS2YZAvS0C_nBQbD@mail.gmail.com>
	<loom.20110204T004658-497@post.gmane.org>
	<AANLkTikfGapDfZtD9H10797Ted_Av78WD8M7XrACOCpW@mail.gmail.com>
	<AANLkTimrwUxNOAnfxgvReGN+-h4_0jhZ731y22TB6u1K@mail.gmail.com>
	<AANLkTi=_spLE-KMnou-2LLQjwq4FUZxNr9pk7D9C=4PK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Vitor Antunes <vitor.hda@gmail.com>, git@vger.kernel.org,
	Ian Wienand <ianw@vmware.com>
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 04 17:08:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlODF-0002gt-Eq
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 17:08:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938Ab1BDQIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Feb 2011 11:08:39 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50565 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962Ab1BDQIi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Feb 2011 11:08:38 -0500
Received: by qwa26 with SMTP id 26so1891473qwa.19
        for <git@vger.kernel.org>; Fri, 04 Feb 2011 08:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Tn7o6Z0TVtelB4F1d0AD7M/MZNssUiBsPTZxyFeW7/4=;
        b=gJdOLjsH4Enp4VHqyLh7PNFBP0gfRB2XzpUYnodIBi/HX1nGaNe7mDsvOqzil4Nezm
         YkcqGOlPFbEUrwy31SSBY2pJZORrpOl60hm8ugwkaXGFvdDDwnhri09tveoKJ3/5MXx/
         2jjoI58aNtf1GRorq+mDPz2TCrcmM/hW6T3Wo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=Kz+txXJUMEGplcG3d808tmYrkbHbJ1tqy5jYnk2E34O3sU8HTnMNrWN05O4Jg+9cUX
         Yp9A9nsP0UuymCNGcb4vLjd0u44V+fH3GvSKPL9EOAAJdCtvsrajSEAZc8B/KCyhphHL
         X1JizXe4BC889VW19F1QlSapJZBqsSmpCcmKw=
Received: by 10.224.10.195 with SMTP id q3mr11093358qaq.35.1296835717749; Fri,
 04 Feb 2011 08:08:37 -0800 (PST)
Received: by 10.229.67.26 with HTTP; Fri, 4 Feb 2011 08:08:37 -0800 (PST)
In-Reply-To: <AANLkTi=_spLE-KMnou-2LLQjwq4FUZxNr9pk7D9C=4PK@mail.gmail.com>
X-Google-Sender-Auth: gIlEf4Jl2edfqpuOwWqMHg_kd6Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166046>

2011/2/4 Tor Arvid Lund <torarvid@gmail.com>:
> Well, I can get it to work if I do:
> $ git p4 sync
>
> before the 'git p4 submit'.
Same result. :(

My current workflow is:

$ rm -rf projdir
$ git-p4 clone //depot/projdir/...@all
$ cd projdir
$ git remote add gitremote endre@gitserver/gitrepo.git
$ git fetch -q gitremote
$ git checkout -b tempbranch gitremote/master
$ git rebase -q master
$ git-p4 sync
$ git-p4 submit

The result is still tons of file already exists in working directory messages.

> Try that, and see if it works for you. (BTW, when committing
> half-works, and then fails, oftentimes you need to do a bit of cleanup
> in perforce... Revert files, manually remove files created by git
> inside your p4 clientspec root directory, that sort of thing...)

I dropped the whole directory, and then recreated it, I do not know
any better 'cleanup'. :)

Rgds,

Endre
