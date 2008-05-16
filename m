From: "=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>
Subject: Re: [PATCH] "not uptodate" changed to "has local changes"
Date: Thu, 15 May 2008 23:14:36 -0300
Message-ID: <b8bf37780805151914j65ce5406xc5e6b3d29e3bfb9b@mail.gmail.com>
References: <1209833972-12256-1-git-send-email-timcharper@gmail.com>
	 <e2b179460805060631l506e2a6leaafc9c0acf3b05b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Tim Harper" <timcharper@gmail.com>, git@vger.kernel.org
To: "Mike Ralphson" <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 04:15:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwpTk-0003lg-KT
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 04:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbYEPCOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 22:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753383AbYEPCOj
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 22:14:39 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:53587 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbYEPCOi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 22:14:38 -0400
Received: by fg-out-1718.google.com with SMTP id 19so543253fgg.17
        for <git@vger.kernel.org>; Thu, 15 May 2008 19:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=adeQT99pjImuRMKdFDbfdbGTvyiw/eYRkTTrelG9zd8=;
        b=WpykjFqTcey9Rg0wM6KVWrKFmGi9cTdRmgvS7ZzcfeF0mMZJIyD/8NgKgIBvIil+WyGErwbQCz3RYOA/dDpZxsOCzFbAPGyXQLL9ql+R8OL1smCJXI9pmwY9rpqLAZuCBC8a7jJCkMuTf+gbLSlgh4ZB4vmQsKZI1YD9WV8OWz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N5iwnvkIskbdrhNQ6aLE2ksmByG1U5CCvnht4uRZSVh2RsMq5oumBKYSr5LkxrRUWwLa1Fi5BKhV5C8XTrKTHm+XcWwNsygstNgFO2Vcgzc+g6xwP9JzuhUmhUALok7u22dshq2sTSX/0SLPpeEw8UbaUKCOKJiKpuRnd3MB6NA=
Received: by 10.78.129.16 with SMTP id b16mr729302hud.116.1210904076999;
        Thu, 15 May 2008 19:14:36 -0700 (PDT)
Received: by 10.78.120.2 with HTTP; Thu, 15 May 2008 19:14:36 -0700 (PDT)
In-Reply-To: <e2b179460805060631l506e2a6leaafc9c0acf3b05b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82251>

>>  This patch will make git a little more human friendly, reporting "file.txt: has local changes".
>
> Documentation/git-checkout.txt should also change in this case,
> otherwise users will see different output to that described and
> possibly get confused if following along with the examples.
>

I like the idea too.

---
[PATCH] "not uptodate" changed to "has local changes"

Use more straightforward message for regular user.

Signed-off-by: Andre Goddard Rosa <andre.goddard@gmail.com>

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index a644173..624dea6 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -168,7 +168,7 @@ the above checkout would fail like this:
 +
 ------------
 $ git checkout mytopic
-fatal: Entry 'frotz' not uptodate. Cannot merge.
+fatal: Entry 'frotz' has local changes. Cannot merge.
 ------------
 +
 You can give the `-m` flag to the command, which would try a
