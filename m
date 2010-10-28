From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 06/10] Change incorrect "remote branch" to "remote
 tracking branch" in C code
Date: Thu, 28 Oct 2010 18:23:03 -0500
Message-ID: <20101028232303.GA25133@burratino>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
 <1288290117-6734-7-git-send-email-Matthieu.Moy@imag.fr>
 <20101028191303.GE14212@burratino>
 <vpqtyk6dk0o.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Oct 29 01:23:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBboT-0004lH-GE
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 01:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759345Ab0J1XXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 19:23:13 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:60192 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759139Ab0J1XXM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 19:23:12 -0400
Received: by qwf7 with SMTP id 7so1697900qwf.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 16:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=df5sW8fTA8ztS1TLKv+HKfZlpdgHW1H3d+4Qi/iYUYY=;
        b=nj4NxfRY4x0yLBCKqsDGlIMAdW3WdY7mKU52AFnCHUc79i/owOFwtVU4bYbxbwtqRA
         sE6XxfARCRms3Jc5DjwDPQz4svwxLy9+4jd3Ko9TaulbjQarvPS6MYByogJsiE8Zw+Mi
         +zHFXsQT+NOQafCU3Z3efCdvUTEhLOO4yMdVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=v0PZsnGRRCxBL50SLRY3X7J1Szk0ekqw1UfQgFcaE4HlYYBkqJDX/yx0SmyEOhQPpy
         nzRbJoYcdgDM2kOAsGpTcwJYpf+LiycHpegwGKcMnKKKmnBOPWChGuE8hbAS7jMXgVKR
         xFgn2rlNGhIYYQ78q6qtPFKbEE6hH+4SkTFSY=
Received: by 10.229.224.82 with SMTP id in18mr5867353qcb.262.1288308191245;
        Thu, 28 Oct 2010 16:23:11 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id k15sm1584781qcu.23.2010.10.28.16.23.09
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 16:23:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpqtyk6dk0o.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160248>

Matthieu Moy wrote:

> I don't think any script would parse the last part of FETCH_HEAD,
> which seems really to be meant as a comment

Yes, believable.

> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Is fmt-merge-msg affected?
>
> No (that's why it's a separate patch. In case you missed my earlier
> message: yes, the testsuite passes between the two).

I suspect the testsuite passing is only because the fmt-merge-msg
tests don't try "git fetch . remotes/foo/bar".

In modern times, "git merge" bypasses fmt-merge-msg with its own
code (as you probably noticed :)).

>   In the process, we change "non-remote branch" to "branch outside
>   the refs/remotes/ hierarchy" to avoid the ugly "non-remote-tracking
>   branch". The new formulation actually corresponds to how the code
>   detects this case (i.e. prefixcmp(refname, "refs/remotes")).

Sounds good.  Thanks.
