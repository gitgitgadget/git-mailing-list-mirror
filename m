From: bill lam <cbill.lam@gmail.com>
Subject: checkout to a reflog entry
Date: Tue, 25 Aug 2009 12:52:35 +0800
Message-ID: <20090825045235.GB391@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 25 06:52:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfo1X-0005LL-6V
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 06:52:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754435AbZHYEwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 00:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754431AbZHYEwi
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 00:52:38 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:55192 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754410AbZHYEwh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 00:52:37 -0400
Received: by rv-out-0506.google.com with SMTP id f6so864366rvb.1
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 21:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:user-agent;
        bh=1kKOaRSLtmtaPfxOKX3LKmslldd96MGgtTT3bJaF8b8=;
        b=jQiWviozQ5WGUcV6QcZkYYhX8ZmTFLRdhSmbOyrIjr6ZUAsRjNsF+cx/Ak05yBvCYk
         r0RacYvaEu2hH7T0d7oOOBG4TRQ6NH1FBDe+gTJYxEhvIJoe9lu8V8HPjG9+J835tQMY
         NxZ3oB+syqjGazZyjKdXMIXgi4Njt1sJsZWU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:user-agent;
        b=WE9dTiA1L7CLxwsSWTfXwxfXGM2FYBvwtl1Vzumpx+2vnPQR/0nIKQloBvZu8tHLFo
         yMoawQaUTTio6EEnU0GxGlUDfRJJ05G5ou5R2oqpj4yfxbmwFa9l0FiISHKvSM54ng+I
         TtIMeprWHr7EL4iNG2ps8Wh3MBqPTLyFVC+9s=
Received: by 10.140.174.1 with SMTP id w1mr2511306rve.132.1251175959988;
        Mon, 24 Aug 2009 21:52:39 -0700 (PDT)
Received: from localhost (n218103237119.netvigator.com [218.103.237.119])
        by mx.google.com with ESMTPS id c20sm3038755rvf.0.2009.08.24.21.52.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 Aug 2009 21:52:39 -0700 (PDT)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126999>

Sometimes when git reflog and try to checkout to a previous commit, 

project((6a33dbc...))$ git reflog show master
77aa688 master@{0}: rebase -i (finish): refs/heads/master onto fc3eaa4
6a33dbc master@{1}: commit: wip
.....


project(master)$ git checkout master@{1}
Note: moving to 'master@{1}' which isn't a local branch
If you want to create a new branch from this checkout, you may do so
(now or later) by using -b with the checkout command again. Example:
  git checkout -b <new_branch_name>
HEAD is now at 6a33dbc... wip
project((6a33dbc...))$ 

project((6a33dbc...))$ git branch
* (no branch)
  master

It becomes (no branch) although the SHA1 is correct. If I then checkout master,
then it revert and jump back up the previous master HEAD.  I tried HEAD@{xx}
also failed.  What is the correct way of to checkout that master@{..} and stay
in that master branch?  (Sometimes it worked I forgot how and why)

-- 
regards,
====================================================
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
