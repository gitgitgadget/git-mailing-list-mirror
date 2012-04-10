From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: pre-receive/update hook: how to know forced push?
Date: Tue, 10 Apr 2012 17:59:17 +0400
Message-ID: <20120410175917.0942d8f2@ashu.dyn1.rarus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 10 15:59:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHbbW-0006PJ-PY
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 15:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754097Ab2DJN7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 09:59:25 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56663 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963Ab2DJN7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 09:59:25 -0400
Received: by bkcik5 with SMTP id ik5so4240566bkc.19
        for <git@vger.kernel.org>; Tue, 10 Apr 2012 06:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=LW0jCE6r4Pg4WM3mQmkLFLp5rY84Idmlf5tAPMvvqNU=;
        b=H1Hziieeqnj/oxHOWflZBEh6/s7f6AWejJPNDnL5hCw6R96ljcLrlmIHGDX/ihgJyd
         RIAsc40wchMMio+P/3oPDG8zyLvszIJliWKs5WSqu2LQcUHcNwLqys+3ljSuys2OHqXt
         nqtUNH6k2Fpu4D8hXzmpjpKX4nsXQq6IlkSKUvT5zw+aT9I3nseaYexONJuvw9EMt7Rv
         pt3UuBPG+9naa8b/CDyAE+zkQnAw/g+ujk9djMqiDBf1muS8Nrtdkh3rFzwCPpv72hfZ
         QbWh60TVuuYcrzK+BNJy50vHMjG0Oa7hR+6WV5V8Okl8FBvIJqQD1v4qa71KqQt/FnKD
         104g==
Received: by 10.205.121.138 with SMTP id gc10mr4955215bkc.23.1334066363649;
        Tue, 10 Apr 2012 06:59:23 -0700 (PDT)
Received: from ashu.dyn1.rarus.ru ([85.21.218.130])
        by mx.google.com with ESMTPS id gw19sm33362014bkc.8.2012.04.10.06.59.22
        (version=SSLv3 cipher=OTHER);
        Tue, 10 Apr 2012 06:59:23 -0700 (PDT)
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195082>

Hi, guys!

How to know in pre-receive hook that commit has been pushed with
--force option?

I've written some pre-receive hook that denies pushed commits which have
author's date earlier then current branch HEAD. It's done to prevent
not triggering automated builds which are based on authors' timestamps.

But some time later I had to rollback branch to previous state.
It is not convenient way to "git update-ref ..." on the server, I'd like
to git push --force, but there is a question in the first sentence:

How to know in pre-receive hook that commit has been pushed with
--force option?

Thanx in advance
