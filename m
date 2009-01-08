From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: Git (svn) merge - but ignore certain commits?
Date: Thu, 8 Jan 2009 13:29:54 -0500
Message-ID: <eaa105840901081029h220e06e4m1a1af693e908751e@mail.gmail.com>
References: <49562749.9060705@sneakemail.com>
	 <eaa105840812271617n74406517x3335a05d224f5e0@mail.gmail.com>
	 <49663CA2.90102@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Peter_Valdemar_M=F8rch_(Lists)?=" 
	<4ux6as402@sneakemail.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 19:39:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKzf8-0002Tm-H4
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 19:31:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756508AbZAHS36 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jan 2009 13:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756275AbZAHS35
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 13:29:57 -0500
Received: from mail-gx0-f13.google.com ([209.85.217.13]:44828 "EHLO
	mail-gx0-f13.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792AbZAHS34 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jan 2009 13:29:56 -0500
Received: by gxk6 with SMTP id 6so7206253gxk.13
        for <git@vger.kernel.org>; Thu, 08 Jan 2009 10:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=V/b660Ngk+uiro7VD5ggvr6nOevkvlQb1Lwl7W+JfX0=;
        b=x8dGzkhoBsUiMBx6vBsL+rrVvutEUGv7CWCSbttqVPkrMuOkc5noLn59WspTahZNFT
         dNMeEx5okhBJXHaueZvyzwEw6a0iL14O4GiqvRPDBGtq7Hg2VjNxZRj3KrAVrj2PVqGX
         cZxp3jlYf2djg4Vpe+mDGeX1FIS7QybvB4Z0E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=TS/9Mc+RsbXyNbJBp7Njp6JAleqy+4CKbBL2sAy6sewvlC2ptmd73zSLU6WUaqg12o
         ZRmH5GmD13s6FOqsdDwPF4SQb3sHWxW50vpDIt2Q3Tp6GIWdxlNYLhlLhs4eHwkJYXPD
         +s6tfE5iuzQ9u0g5wJJz7u5M47P00qw+XmnjE=
Received: by 10.65.160.5 with SMTP id m5mr1891586qbo.100.1231439394965;
        Thu, 08 Jan 2009 10:29:54 -0800 (PST)
Received: by 10.64.210.7 with HTTP; Thu, 8 Jan 2009 10:29:54 -0800 (PST)
In-Reply-To: <49663CA2.90102@sneakemail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 7867fe9a02104482
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 8, 2009 at 12:49 PM, "Peter Valdemar M=F8rch (Lists)" wrote=
:
>
> However *the* problem was with repeated merges: I later discovered a =
problem
> on the branch and need to add a commit for it to both master and
> newbranch/gitnewbranch. Aside from git cherry-pick (where I take care=
 of the
> repeated merge problem) I still haven't found a good solution.

Well, the real problem is that it *isn't* a repeated merge. Subversion
rebased your trunk on you, so you...

> I ended up using git cherry-pick, and diff and patch / git diff and g=
it
> apply.

=2E..wind up needing to do this.

Don't rebase trunk (which implies ditching subversion,
(un)fortunately), and repeated merges should Just Work. See, for
example, the git repository itself, where the master branch is
repeatedly merged into next.

Peter Harris
