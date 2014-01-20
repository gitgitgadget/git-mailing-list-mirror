From: Cosmin Apreutesei <cosmin.apreutesei@gmail.com>
Subject: GIT_WORK_TREE and GIT_DIR with git clone
Date: Mon, 20 Jan 2014 17:59:16 +0200
Message-ID: <CAKJdRamFDDWRZDHBCe7GrXg0OWhLfBPq_ofsvowaW9d8VOGTMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 20 16:59:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5HGI-0004z0-Bp
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jan 2014 16:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbaATP7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jan 2014 10:59:38 -0500
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36620 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbaATP7h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jan 2014 10:59:37 -0500
Received: by mail-pd0-f170.google.com with SMTP id p10so2761161pdj.1
        for <git@vger.kernel.org>; Mon, 20 Jan 2014 07:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=beO1x7YviSy5YHvBTCIc/cQMAuW8HDFOGm2v6GfiDhA=;
        b=aYNnon41ehAKXOJJOKOnbUKDqdKys6KFzhMXQlrHabcG99awP5TfygFVBbZaoC40pH
         uotRiC6V6JUWdHXw81RjCYzh7aUf8QvuzPG1WNbFyJK7L77bxkv2/pVcFHYz6DpnRwWd
         drKBnVWfPdYKuRa66enueYe7vGkyD0cVBNwuj06nKW04ByHNLijgEOB6U/fH4dMxXhse
         Zyh0EGU9H+U1IjotCCJ6O/+3vXGJztE95llefhZsID/OR63AGMAICpS5/RqhvF1rtZM8
         6iGXAgWthIgoyT5fWKiqHp6NyIepIzsBIRwdtaDXuTa8xl1mhqC+LVr8RmGKZN1rh2fP
         Cv8w==
X-Received: by 10.66.26.10 with SMTP id h10mr19268472pag.24.1390233576956;
 Mon, 20 Jan 2014 07:59:36 -0800 (PST)
Received: by 10.70.42.228 with HTTP; Mon, 20 Jan 2014 07:59:16 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240711>

Hi,

I would like to have git clone respect GIT_DIR (and --git-dir) so I
can clone multiple repos into the same working directory (I know there
was another request for this[1]).

The pattern here is big projects that are modularized into multiple
git repositories, but supposed to be overlaid over a common directory
structure.

I would like to be able to tell my users that they can simply do:

git clone --git-dir=_/git/module1/.git module1-url
git clone --git-dir=_/git/module2/.git module2-url

which will overlay the files from both modules into the current
directory, which from git's perspective is the work-tree for both
modules.


[1] http://article.gmane.org/gmane.comp.version-control.git/170073/match=git_work_tree+git_dir+git+clone
