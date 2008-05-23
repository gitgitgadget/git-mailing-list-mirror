From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: Re: bug in "git log --graph" at the tail end?
Date: Fri, 23 May 2008 22:02:10 +0100
Message-ID: <3f4fd2640805231402n72aaed52l7a163168e9258f25@mail.gmail.com>
References: <7vve14rbu7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Adam Simpkins" <adam@adamsimpkins.net>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 23:03:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzePp-0007tz-Rt
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 23:03:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756787AbYEWVCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 17:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756715AbYEWVCM
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 17:02:12 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:59047 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756695AbYEWVCL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 17:02:11 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1026127rvb.1
        for <git@vger.kernel.org>; Fri, 23 May 2008 14:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=yD7Kf9s2wr61nsh2MCXf6B/u6DQO3ZBxPnxLlU/cexg=;
        b=uqJTBt5hXCsB0onAVYvpH+McaDZp/IoCo1hxWpPW/uTSGcryBeFDe1+xOLRQL+MBwgDZsf/lhGj9/YSRMVB+1jcKkz8wd4xil3DFo9Tm3mLz+dxIVEPD8dutmQBJSgF3gBb93xi9t1ziiA+KoCsR9en/3PGFjm+HXA7JG8htMT0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L4xQLULpMc6hGvg4iHv9FcUQIm5fQNpQm+g//xF8bTb506yJgViUZS19Ik4nnxDd/nCxllrITEpj2u85/l5/zDgtGe1+PkEakqho0SwdOmqInZye5ssjF/X4ONnhvOUrf5sTEEsk8t6EVjf4Ltdnn7B/qBcmFd0n1KSQkw0nVkY=
Received: by 10.141.170.10 with SMTP id x10mr870268rvo.92.1211576530936;
        Fri, 23 May 2008 14:02:10 -0700 (PDT)
Received: by 10.141.133.7 with HTTP; Fri, 23 May 2008 14:02:10 -0700 (PDT)
In-Reply-To: <7vve14rbu7.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82759>

2008/5/23 Junio C Hamano <gitster@pobox.com>:
> It appears that "log --graph" output has a bug at its tail end.
>
>    $ git log --pretty=oneline --abbrev-commit --graph 9d88058^..1af8bca
>    M   1af8bca... Merge branch 'maint'
>    |\
>    | M   008442f... Merge branch 'maint-1.5.4' into maint
>    | |\
>    | * e77b0b5... git-am: fix typo in usage message
>    | * 74190d2... doc/git-daemon: s/uploadarchive/uploadarch/

Shouldn't this be:
>    | M   008442f... Merge branch 'maint-1.5.4' into maint
>    | |\
>    | | * e77b0b5... git-am: fix typo in usage message
>    | | * 74190d2... doc/git-daemon: s/uploadarchive/uploadarch/

as well?

> This is purely cosmetic, but because --graph is only about the cosmetics,
> we may want to do something about it.
>
> Thoughts?

It is also consistent and makes the output easier to scan, so +1.

- Reece
