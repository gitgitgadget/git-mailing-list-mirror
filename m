From: Magnus =?iso-8859-1?Q?B=E4ck?= <baeck@google.com>
Subject: Re: Selectively commit/publish files to GIT
Date: Fri, 8 Nov 2013 09:13:30 -0500
Message-ID: <20131108141329.GA26790@google.com>
References: <CA+PenvEDY6mc+DyjXy4ebZKdK4R=ucM28MDXGC42XKxvJ=a-pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Manson <dev.mansonthomas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 08 15:13:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vemob-0005TH-1G
	for gcvg-git-2@plane.gmane.org; Fri, 08 Nov 2013 15:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756884Ab3KHONd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Nov 2013 09:13:33 -0500
Received: from mail-vc0-f202.google.com ([209.85.220.202]:59308 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755054Ab3KHONc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Nov 2013 09:13:32 -0500
Received: by mail-vc0-f202.google.com with SMTP id ld13so159817vcb.5
        for <git@vger.kernel.org>; Fri, 08 Nov 2013 06:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Ava6rzXa8P4J/R4Q27EzOEo1xayi+0FuGvUd+aS38go=;
        b=Yhpcam4yT0g60PnxWODnOd41FyoU2/mkzNar2Mixys4HL39iPZg2v8czW98sMC04sa
         ab1E+Pkh/hgw74cOKrH4dzugKLQc6pMQwa9Wl6XyjG984hetPdbZGwG94H20cLzEuoMW
         G2vN/drVeA5H0njGjIwbrdYcZCphjG7tFa4XcNJDKxkfyCbi+HJgZRa/Cr5YRaoVbC23
         xte/8Wh1A7kZbtqYOTpBUIZJ4qCNZntryxXLHDPFh3VV3UedfF3pRvSZUN/3znfaJPkh
         unTWTIK1wbpF+H2hGt7+Y0xLncHEhzuswHxGfSuHUkw9PgGj1ktqZxaZCrMWCOpYpk5w
         BfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Ava6rzXa8P4J/R4Q27EzOEo1xayi+0FuGvUd+aS38go=;
        b=JOV1fVZzU96j7NSCNr1iUTF9yfRIN1dBsowgdRV5IkurD7da9rmUJEUZThv+QjQfCf
         ytqvsnuMwfmBSLXX+dgCGMljkbYB3OGn1Ya6XQspkvvA4uKGUiBydyTgCKh60WxjF6nQ
         EEsbalgAoJaCgZ86zSNUqGt0gnNDFwUJ81Nra+umizUDqmvd6d7dAkPjqkmIS4pIfRNs
         PBrU9YQpAsenj8WC5eMuXFlpzINjQNxnhC68ypxGE7+Yxa73CWvYGGFKcHsr1ET7Q3BQ
         DbTntVH8kTsbJMF5K/19v5ZusTjkaW0akCxC4R//+dxmb58phvzNjE3EFjEfYgzlxP60
         tIbQ==
X-Gm-Message-State: ALoCoQl07qiHJTFWo9vZnAwYC0VZ0RU/acbZ2ucHd6BA8lhgSgqQeBAMaDtVNLbDAvPQZW0x6jYQoqi+DpDqzMwZ/ETWHZSHkWXS0jeEpnfqByIrV/lBXp6XTRhBtqd87DaPyjak7bJxJJr2fGLD0Mp+P9MsFeGbkwTFdU9lMAibxbv3ffP9aJ34gupwiUYfL/6bFqvWklEA
X-Received: by 10.236.115.198 with SMTP id e46mr2725203yhh.33.1383920011573;
        Fri, 08 Nov 2013 06:13:31 -0800 (PST)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id k47si943535yha.2.2013.11.08.06.13.31
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Nov 2013 06:13:31 -0800 (PST)
Received: from valle.nyc.corp.google.com (valle.nyc.corp.google.com [172.26.78.170])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 76CC65A4245;
	Fri,  8 Nov 2013 06:13:31 -0800 (PST)
Received: by valle.nyc.corp.google.com (Postfix, from userid 159662)
	id 19F7D40656; Fri,  8 Nov 2013 09:13:30 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CA+PenvEDY6mc+DyjXy4ebZKdK4R=ucM28MDXGC42XKxvJ=a-pQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237454>

On Friday, November 08, 2013 at 05:52 EST,
     Thomas Manson <dev.mansonthomas@gmail.com> wrote:

[...]

>   How can I search git history for big files and remove them, or mark
> them to be not published ?
>=20
> I've tryed this solution found on the link in the error:
>=20
> git filter-branch --force --index-filter   'git rm --cached
> --ignore-unmatch giant_file'   --prune-empty --tag-name-filter cat --
> --all
> git commit --amend -CHEAD

[...]

> here is the error I have using the GitHub application on Mac :
> (after that I intend to use Eclipse)
>=20
> File Ressources/dwr/dwr-3.0.0.110.dev-src.zip is 67.69 MB; this is
> larger than GitHub's recommended maximum file size of 50 MB
> GH001: Large files detected.
> Trace: 8f0259b29260f0c4d7ae4d4ae70e0306
> See http://git.io/iEPt8g for more information.
> File .bzr/repository/packs/a7bcd6ba235114ab88c80fe8a97adcfa.pack is
> 178.76 MB; this exceeds GitHub's file size limit of 100 MB

Did you actually replace the 'giant_file' placeholder with the path to
*your* giant file? The error message indicates that you didn't, or that
something else went wrong during the filtering.

You can use 'git log' to look for commits touching particular pathnames=
,
making it easy to verify that a file has been eradicated.

git log --all -- path/to/big-honking-file.zip

--=20
Magnus B=E4ck
baeck@google.com
