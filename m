From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Which file is older in history?
Date: Thu, 21 Mar 2013 01:51:38 +0530
Message-ID: <CALkWK0nTjoR9qBY-hnkrDKnyf8088ZDJ1LK_zNqAoAB7ndvaww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 20 21:22:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIPWn-0004nS-Pl
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 21:22:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754749Ab3CTUV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 16:21:59 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:37339 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754455Ab3CTUV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 16:21:58 -0400
Received: by mail-ie0-f172.google.com with SMTP id c10so2596435ieb.17
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 13:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=MyYKQCEnSBNbhks1Q44gdPYGCFJMG5rAM603wKbntQE=;
        b=c6LyhsJsyTSsPfH/7d6ccuJXokvUqskgs4ZXIHRRpPEggo9v+sOnq9lvL9qNMKCyUv
         2UITqIrIiQHcDK+XemgQzpMZjJIEhY2nCrWwAoV9MMLMxgMm9JeOMMRO9sdVhimMPXnf
         w7GVTyzEAW7MX0boVrFQeKXNADDkmiaCNBNhz2mguIVTlasutj44pk/q6tZAHrrXu2ql
         8DmbIUamScO8OcVyW8c5WfrlGRiN9++m9bnyaXtX1+zbS4ttrsh2ds89m2bXg3sdKCFN
         dFJob3mnUW0RXxMZXTsCJJam/IWKJGeWQ4wM+fFw+JDdjIe+Vau8j0kOhgyEyHvx/QKX
         jB9A==
X-Received: by 10.50.50.71 with SMTP id a7mr331392igo.14.1363810918489; Wed,
 20 Mar 2013 13:21:58 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Wed, 20 Mar 2013 13:21:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218674>

Hi,

I want to compare two files in a git repository and tell which one was
introduced into the repository earlier, assuming that they're in the
same history line (by ancestry, not timestamp).  The naive way to do
this is to find the individual commits that introduced the files
(`rev-list HEAD -- <filename> | tail -n 1`), and query whether there
are commits between them (`rev-list commit1 ^commit2`). However, this
is slow.  What about bisecting the history until we find a tree that
contains one file but not the other?

Thanks.

Ram
