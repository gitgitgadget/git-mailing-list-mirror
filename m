From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Optimizing cloning of a high object count repository
Date: Sat, 13 Dec 2008 22:46:50 +0700
Message-ID: <fcaeb9bf0812130746l38a12f37wde26f31d5fa0d2a2@mail.gmail.com>
References: <200812131624.57618.Resul-Cetin@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gentoo-scm@gentoo.org
To: "Resul Cetin" <Resul-Cetin@gmx.net>
X-From: git-owner@vger.kernel.org Sat Dec 13 16:48:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBWiy-0000wp-Df
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 16:48:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbYLMPqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 10:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbYLMPqx
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 10:46:53 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:23203 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667AbYLMPqx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 10:46:53 -0500
Received: by fg-out-1718.google.com with SMTP id 19so881542fgg.17
        for <git@vger.kernel.org>; Sat, 13 Dec 2008 07:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=l4GTel1DCue8fUbyqLvEHYXi0SPjn7TasuTP0zQufwU=;
        b=UvMQZiryaNX+eRgEpd5J/U/4qn/EYV5WzxOXRZ9ZinurufrxXfffQbNfpLtepCh9uB
         ml5OgdLFZu5E6/BGqDkUx9DRJWtnXZ037FdDXIZVHyXTWvl8UnnnNh4MyRXM5OMh95Uo
         UD9aEQGNImYMIvaWNdYGNpXzXiX80iql1lfzU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=QScpkhskNuk6KV59dSmCwb/sM+XcBY9yh+NEdJZW3oQJVBrkc00f7x4tdZpEKIh+Dj
         iQGyuSyJQWCj6GFTzo1RbX7Gxle1oJJaHjM8JtSYejsKP2VnxikjlWYLIGauPy45bdqQ
         vUJsltS43zWaJoNmbuJoyl0vv04OZ6SLqg8So=
Received: by 10.86.4.14 with SMTP id 14mr2691550fgd.27.1229183210989;
        Sat, 13 Dec 2008 07:46:50 -0800 (PST)
Received: by 10.86.87.14 with HTTP; Sat, 13 Dec 2008 07:46:50 -0800 (PST)
In-Reply-To: <200812131624.57618.Resul-Cetin@gmx.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103002>

On 12/13/08, Resul Cetin <Resul-Cetin@gmx.net> wrote:
> Hi,
>  there are currently different ideas to move gentoo's cvs repository to an
>  other scm. Current tests showed that svn will not make anything better (it
>  gets in most perfomance and size based benchmarks even worse). Another idea is
>  to move to git. It looks really promising in size based benchmarks but cloning
>  seems nearly impossible. The current test repository is available at
>  git://git.overlays.gentoo.org/exp/gentoo-x86.git and is around 900MB in size
>  and has 4696137 objects. It really takes ages to do the counting of the
>  objects on the server and compressing takes much longer.
>  The size of the linux repository seems to be smaller but in the same range
>  object count and repository size but clones are much much faster. Is there any
>  way to optimize the server operations like counting and compressing of objects
>  to get the same speed as we get from git.kernel.org (which does it in nearly
>  no time and the only limiting factor seems to be my bandwith)?
>  The only other information I have is that Robin H. Johnson made a single
>  ~910MiB pack for the whole repository.

Make yearly packed repository snapshots and publish them via http.
People can wget the latest snapshot, then pull updates later.
-- 
Duy
