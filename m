From: "Jeremy Ramer" <jdramer@gmail.com>
Subject: post-update hook
Date: Thu, 13 Nov 2008 08:53:28 -0700
Message-ID: <b9fd99020811130753o13c5aa0cj79126a502d449cde@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 16:55:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0eXF-0001eR-5A
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 16:55:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbYKMPxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 10:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbYKMPxb
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 10:53:31 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:53331 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbYKMPxa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 10:53:30 -0500
Received: by qw-out-2122.google.com with SMTP id 3so571693qwe.37
        for <git@vger.kernel.org>; Thu, 13 Nov 2008 07:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=ydysESooCy/MDc3V0MFDWIpt8GpuyWtbETGGly5Xlcg=;
        b=hneNtbqytG1bgrNhb4PG2/jLDS7+bHTdSc7QR7xntLqvvxMLmZE0xpyLhCwurWVNnM
         j+aZNFljrmv2R+CfFz58oFi77r/lj1dw8UpFMs75iMHRbNQ4NAigsunW5PtadwsAEVpH
         9+G8Tcc/c+RMT+Oo5ks9ZcNmJ/bhVDJzO061Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=Gel7QPxnbczDchTYNxlcG8ZLRkuF/VnCy0vjTbsvnlwHQjfMwz6PP2zgzAiNGFB+dN
         rLSVVEkug650ZhbYYrHvD/HBG7QUgIT5xbS22PlTG9DxIVsPk1jO+K/WcZCsqrIYNn3A
         1xF0L0xvjPM1qga6PALU0GV09AEJJv9eZax2k=
Received: by 10.214.215.18 with SMTP id n18mr11260971qag.278.1226591608539;
        Thu, 13 Nov 2008 07:53:28 -0800 (PST)
Received: by 10.214.217.13 with HTTP; Thu, 13 Nov 2008 07:53:28 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100880>

I have a set up where I have a local git repo (local1) that I make
changes to and two public repos (remote1, remote2) that hold the
current state of the repo for other applications to access.  So my
plan is to make the change is local1, then
git commit
git push remote1 master
git push remote2 master

However, the remotes currently have master checked out so though the
repo gets updated the working directory does not.  I tried editting
the post-update hook as follows

#!/bin/sh
echo Update changes...
git checkout master .

but it does not seem to make any difference.  Am I missing something
in the way post-update works?  It would be really nice to get this
working so I don't have to log into each remote and do a pull.  local1
is running git version 1.6.0.2. remotes are running git version 1.5.6.

Thanks!
Jeremy
