From: Jakub Narebski <jnareb@gmail.com>
Subject: Detached HEAD and "git log --all"
Date: Thu, 22 Oct 2009 22:37:01 +0200
Message-ID: <200910222237.04056.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 22 22:43:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N14V0-0004Dw-05
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 22:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755489AbZJVUm4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Oct 2009 16:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754862AbZJVUm4
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 16:42:56 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:63817 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731AbZJVUmz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 16:42:55 -0400
Received: by fxm18 with SMTP id 18so9656968fxm.37
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 13:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=0Sng6jDslUh9Fytp3LP82noqMbjVFGfLSp0mPBsZOTA=;
        b=fJRPpv/qx9sh+wAs80ZXZpuRw1ytgAu05s/jSRGCRQkTAGa8e9k/3Dccu8R6+HEFlt
         kAJqd5py5wnK+gvnHRSZgBih5L+okK93cEeYQKZjvE3ATBJO/XvkRY2e0RI8eqevIedO
         POrwdD+DL2yjbY1NwGjKlKE5uPfJ8CUnPE+PI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=F1zw1yN0dUfvQ/s4FKuNeen7c836W1dxJWGFNxDaDK3dFDVJmuJk/ne5K5hD1etzrp
         YcdjPZHg+2aDERRpCWwadAztMNkxBOsduzt++hsY8J3zu/ljZmwk1nWvlRUiHP7VeM7o
         5oGVXSqaq428q34Q2TopOS5Oj/awrZyY4/wWY=
Received: by 10.204.160.90 with SMTP id m26mr10114539bkx.63.1256243825605;
        Thu, 22 Oct 2009 13:37:05 -0700 (PDT)
Received: from ?192.168.1.13? (abvi94.neoplus.adsl.tpnet.pl [83.8.206.94])
        by mx.google.com with ESMTPS id 16sm108654bwz.7.2009.10.22.13.37.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Oct 2009 13:37:04 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131056>

When discussing differences between concept and implementation
of branches in Git and in Mercurial on StackOverflow[1] (abusing
SO comment system a bit), Steve Losh[2] wrote that he was surprised
by the fact that "git log --all" doesn't include commits made
on detached HEAD.

While documentation clearly states:

  --all  Pretend as if all the refs in `$GIT_DIR/refs/` are listed
         on the command line as <commit>.

and HEAD is in `$GIT_DIR/HEAD`, which is outside `$GIT_DIR/refs/`,
it is nevertheless a bit strange that "git log --all" doesn't list
all (everything).

This is of course only an issue if we are on detached HEAD; I guess
that semantics of `--all` option to git-log predates this feature.

[1] http://stackoverflow.com/questions/1598759/git-and-mercurial-compar=
e-and-contrast/1599930#1599930
[2] http://stevelosh.com/blog/entry/2009/8/30/a-guide-to-branching-in-m=
ercurial/

--=20
Jakub Nar=EAbski      http://stackoverflow.com/users/46058/jakub-narebs=
ki
