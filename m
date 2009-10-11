From: bill lam <cbill.lam@gmail.com>
Subject: meaning of HEAD in context of filter-branch
Date: Sun, 11 Oct 2009 10:43:57 +0800
Message-ID: <20091011024357.GA9021@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 11 04:48:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwoTX-00048e-L5
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 04:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756044AbZJKCom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Oct 2009 22:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756011AbZJKCol
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Oct 2009 22:44:41 -0400
Received: from mail-px0-f179.google.com ([209.85.216.179]:50441 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755987AbZJKCol (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Oct 2009 22:44:41 -0400
Received: by pxi9 with SMTP id 9so7756815pxi.4
        for <git@vger.kernel.org>; Sat, 10 Oct 2009 19:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=hL8ESgkgYEsI1ibun3Lvjdtg7/16VGbLMDw/y4UbEkk=;
        b=n5uUedeZG17WFv36LJHOkOjbS2Ihzx14xVjqsR0O07/+DH0ytkZ1RI6OL+616yZ5Mu
         5WPWVe7VGUeC39IBb0AEkleRl8hW7o2q0cXq7yoaYYmFeuT6HHzB1b5Jo3hh/oVUI/gS
         ZNDn9GQMyF1FVYetgodgQtoyiFyyKijcnYTg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=qCRGvHJmse10h1nS+TGLWNh16NytYEJQxNQFzMKhL+SY47focY2E7TYSzvLCQvipn4
         lgsbnRuL4haUOW8rb04b4V0DnQ48vk2IWlHZLlI4onJyNZSgpf+BeLKcgJlVZPL2RVfI
         9IDfyQ3x+HH00sJ5zNzc5EWbjEwSZOWy2sijo=
Received: by 10.114.164.28 with SMTP id m28mr6215597wae.221.1255229044172;
        Sat, 10 Oct 2009 19:44:04 -0700 (PDT)
Received: from localhost (pcd632137.netvigator.com [218.102.164.137])
        by mx.google.com with ESMTPS id 21sm665483pzk.7.2009.10.10.19.44.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Oct 2009 19:44:03 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129902>

I tried to process some files that changed between each commit using
the command

git filter-branch --tree-filter 'git diff --name-only HEAD^.. | foo

however it seems that HEAD is fixed to mean the HEAD of the current
tip before starting git-filter-branch, by trying like this

$ git rev-list -1 HEAD^
2bf95faed2d51c338ea6fa93e7bb6cc9c1bc759b

git filter-branch --tree-filter 'git rev-list -1 HEAD^ >>/tmp/sha' -- --all
$ cat /tmp/sha
2bf95faed2d51c338ea6fa93e7bb6cc9c1bc759b
2bf95faed2d51c338ea6fa93e7bb6cc9c1bc759b
2bf95faed2d51c338ea6fa93e7bb6cc9c1bc759b
2bf95faed2d51c338ea6fa93e7bb6cc9c1bc759b


how to get the HEAD during filter-branch or other workaround?

-- 
regards,
====================================================
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
