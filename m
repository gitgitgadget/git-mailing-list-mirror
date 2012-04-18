From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: git clone - not getting the correct default branch
Date: Wed, 18 Apr 2012 13:53:23 +0000
Message-ID: <1334757203-ner-3478@calvin>
References: <CAE5ih7-KmknO8aD=ws-GnUw2RO4fLzscdNYsxkUsFD0Y=28iew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 15:54:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKVKp-0001dg-KX
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 15:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437Ab2DRNyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 09:54:09 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52191 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab2DRNyF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 09:54:05 -0400
Received: by eaaq12 with SMTP id q12so1885200eaa.19
        for <git@vger.kernel.org>; Wed, 18 Apr 2012 06:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:references:in-reply-to:mime-version:date:message-id
         :content-type;
        bh=i6rqD4X2sP9J74fCtzdVPIkNYOL9AU9givNujzbQ5XU=;
        b=MMlJxV0obP8KSmWu03TL/OsR9WpYuTtGkoYHXbGb9SVCa2YEHOlq1pZq11hCoaA+W9
         wvOv/FHIV+6pTnWSOpVWihHzdUGDUZT6bbZ3syFBk8eUeLth+7zUCWf26kFCt8wf7OZ2
         mCrbA4pzR23u9gZLAI6hjogR5sh1u3TSD+GbdPgZh7u1Rbgr5/oBimAKcGZQLn38GZMO
         6gHYE5Gi690d1a49/DPr/HPCRiW8xr7n6WivKUoP8KfSbgfrYj4XtrE0BCM+Hm4mGUTS
         Ua6ZcJSdkJHO/iGxpfmLQLd0XKhbWxw9EAQu1c50lhvaP83utPMEcW0rHMJtpBFzrfoC
         WihQ==
Received: by 10.14.52.80 with SMTP id d56mr364639eec.105.1334757244482;
        Wed, 18 Apr 2012 06:54:04 -0700 (PDT)
Received: from calvin.caurea.org (62-2-168-230.static.cablecom.ch. [62.2.168.230])
        by mx.google.com with ESMTPS id m42sm118226552eef.0.2012.04.18.06.54.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 18 Apr 2012 06:54:03 -0700 (PDT)
Received: by calvin.caurea.org (Postfix, from userid 3301)
	id 4C998211E0D; Wed, 18 Apr 2012 13:53:24 +0000 (UTC)
In-Reply-To: <CAE5ih7-KmknO8aD=ws-GnUw2RO4fLzscdNYsxkUsFD0Y=28iew@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195868>

On Wed, 18 Apr 2012 14:05:14 +0100, Luke Diamand <luke@diamand.org> wrote:
> A bit weird this.
> 
> I have a bare repo (managed with gitolite) which, when I clone it,
> always comes up with origin/HEAD pointed to origin/master.
> 
> This despite the fact that on the repo, HEAD is a symbolic ref to origin/dev.
> 
> i.e.
> 
> % git clone git@myserver:myrepo
> ...
> % git branch
> * master
> 
> % ssh myserver
> % cd /path/to/myrepo.git
> % cat HEAD
> ref: refs/heads/dev
> 
> What could be going wrong? Other repos don't have this problem.

Does master and dev in the repo on the server point to the same commit?
Because the git protocol does not expose which *branch* HEAD points to, only
which *commit*. So if two branches point to the same commit, git just takes
the first branch and points the local HEAD to that.

tom
