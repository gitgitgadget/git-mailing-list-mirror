From: Leo Koppelkamm <hello@leo-koppelkamm.de>
Subject: Re: Git on Mac OS and precomposed unicode
Date: Thu, 21 Mar 2013 17:30:23 +0100
Message-ID: <E5C0B2ABD2EF46908D0711EF0C09817B@leo-koppelkamm.de>
References: <64B4EB934AFE4B358B94EB717103887E@leo-koppelkamm.de>
 <514B2F98.30409@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Mar 21 17:30:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIiOF-0001Jr-Mv
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 17:30:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756143Ab3CUQa2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Mar 2013 12:30:28 -0400
Received: from mail-bk0-f45.google.com ([209.85.214.45]:38558 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756026Ab3CUQa1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Mar 2013 12:30:27 -0400
Received: by mail-bk0-f45.google.com with SMTP id i18so1493160bkv.18
        for <git@vger.kernel.org>; Thu, 21 Mar 2013 09:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:date:from:to:cc:message-id:in-reply-to:references
         :subject:x-mailer:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-gm-message-state;
        bh=2WNlTox4V0f4X1zIbHOvKq9Kd5nyPIF4WHBMcDkOwgo=;
        b=ANjn/XlEt6BfiSdAPa3ZdOM9cvVaTMAQzyH7qtpYZclKZO6LoQRL5cbQY2bCM8E/3K
         pwWwzMgrIEKdUMXcJ0CtLagzgNFQqb/GVJRBOLMiyXtkkTQHwLvUzfn14qrxGHwxJRmW
         qab1AH5e+pOQek7IrwWLdDeRvEOKIyXZiS45R8WRQWRlDwJcdD3GNCMVUYMTNPEvfqnE
         oxBDXPgxaqBFLV+Lhr0M7ken3BnHrn1QYwvRmYO7GEWpxt76y4ZBmfDeYqE4BCZJTMcc
         cgJ9ZYAA7ODV39Ldo+RsxYzLqaK3RK2qqCDxccIaOI0SwFCYXVpGSjTlrWISMcJkOSKR
         tDbQ==
X-Received: by 10.204.244.135 with SMTP id lq7mr13598436bkb.138.1363883425927;
        Thu, 21 Mar 2013 09:30:25 -0700 (PDT)
Received: from [192.168.0.104] (p3E9D3C40.dip.t-dialin.net. [62.157.60.64])
        by mx.google.com with ESMTPS id v2sm1663223bkw.5.2013.03.21.09.30.24
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 21 Mar 2013 09:30:24 -0700 (PDT)
In-Reply-To: <514B2F98.30409@web.de>
X-Mailer: sparrow 1.6.4 (build 1178)
Content-Disposition: inline
X-Gm-Message-State: ALoCoQlKi+CAT/rUxIQKxYAN7fbynykPJIkcNAqTLyGMZnHqpvRYE5J6Tv5LXMQv8p3gsOb74dT+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218742>

I found the problem:
I copied the config out of your commit message, where you wrote core.pr=
ecompose****d****unicode
Turns out the d is too much. It seems to work now.

Leo =20


On Thursday, 21 March 2013 at 17:04, Torsten B=C3=B6gershausen wrote:

> On 21.03.13 14:00, Leo Koppelkamm wrote:
> > Torsten B=C3=B6gershausen added a patch for this a while ago.
> > It seems it only works for files, not for folders with unicode in i=
t.
> > =20
> > Eg. on ubuntu box:
> > git init
> > mkdir h=C3=A4
> > touch h=C3=A4/file
> > git add h=C3=A4
> > git commit =20
> > =20
> > Later on Mac
> > git clone =E2=80=A6=E2=80=A6=E2=80=A6
> > git status
> > =20
> > # On branch master =20
> > # Untracked files: =20
> > # (use "git add <file>..." to include in what will be committed) =20
> > # =20
> > # h=C3=A4/
> > =20
> > Regards Leo
> That is what I read from the commit message:
> =20
> When creating a new git repository with "git init" or "git clone",
> "core.precomposedunicode" will be set "false".
> =20
> The user needs to activate this feature manually. She typically
> sets core.precomposedunicode to "true" on HFS and VFAT, or file
> systems mounted via SAMBA.
> =20
> (Which is slighty wrong, because the name of the config variable
> is core.precomposeunicode)
> =20
> What does
> git config core.precomposeunicode
> say ?
> =20
> You may consider to set it to set it to true globally,
> git config --global core.precomposeunicode true,
> and the next "git clone" will work as expected.
> =20
> On the other hand,
> could/should we consider to change the default to true in Git 2.0?
> =20
> HTH
> /Torsten
> =20
> =20
> =20
> =20
> =20
> =20
> =20
> =20
> =20
> What does git config =20
