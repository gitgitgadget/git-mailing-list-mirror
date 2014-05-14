From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Watchman support for git
Date: Wed, 14 May 2014 17:52:12 +0700
Message-ID: <CACsJy8CDGP1QwX4C3yKVUOw3h90EcLSXXXy=t6XFSVOrVjxA4A@mail.gmail.com>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
 <CACsJy8DVVpfYEmE8pSZNyXy1m5WRkdm08deW3EXgAy_0Gn72zw@mail.gmail.com>
 <1400024691.14179.40.camel@stross> <CACsJy8C49EDwjtv_L2pTRy3XbPptp7+nNzT=Jp4BaH_TOZtvnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed May 14 12:52:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkWno-0000MK-8q
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 12:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665AbaENKwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 06:52:44 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:45376 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656AbaENKwn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 06:52:43 -0400
Received: by mail-qg0-f51.google.com with SMTP id q107so2445823qgd.38
        for <git@vger.kernel.org>; Wed, 14 May 2014 03:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=st/O5HrMxWmOJUkIrDdmpm4rh4+8H+mueFFAyxeNmKg=;
        b=Q3mKyhQAmdErlL+NAitxN1IvTmshz3cqICWrOryyj6x+ivDG0tQtQHgMSvbyl5NkXn
         vDz+wPvvc3Dr1lYwfUIRONorMdgllL4Mf+Vgae2yyp3lpy6Bicn76wAoLpeacdfLVYF7
         Jy9p9Zy+rcPCcWm4gDhOyHE2ihn6a8VXRULekvxQeQN6Yavh4POt23m4jC7+8JcNqVwo
         jBG1WrILbbpoJdmUXKPq7U765F3a0homdC9jOZrsJ16rrwnhgNsydpZV9uduLOydjk/R
         /c0QHOIHN7AI43e03rxbs3lShcd+rADtqzdFbKj4Yfc4PCAEwV0Bs7jP8dSCYfHAZhJI
         XYuQ==
X-Received: by 10.224.23.5 with SMTP id p5mr2044764qab.88.1400064762982; Wed,
 14 May 2014 03:52:42 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Wed, 14 May 2014 03:52:12 -0700 (PDT)
In-Reply-To: <CACsJy8C49EDwjtv_L2pTRy3XbPptp7+nNzT=Jp4BaH_TOZtvnQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248909>

One more thing I think we can solve with watchman is the racy
timestamp issue (see 29e4d36 and 407c8eb). Basically if a file is
updated within a second (and the system only supports timestamp
granuarity down to a second) then git can't know if a file is changed
by comparing stat data, so it compares content anyway. With watchman,
I think we know that a file is updated or not and can disable racy
test. How often this happens and whether it is worth supporting is
something to think about.
-- 
Duy
