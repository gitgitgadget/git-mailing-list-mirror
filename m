From: Dmitry Potapov <dpotapov@gmail.com>
Subject: git archive without path
Date: Mon, 30 Nov 2009 15:32:03 +0300
Message-ID: <20091130123203.GA11235@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 30 13:32:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF5Qd-0005Vg-1H
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 13:32:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbZK3McT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 07:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbZK3McT
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 07:32:19 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:60833 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbZK3McS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 07:32:18 -0500
Received: by fxm5 with SMTP id 5so3597603fxm.28
        for <git@vger.kernel.org>; Mon, 30 Nov 2009 04:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=o4fteWfNyDdEtfY0PFwnqLLeU2RUmVDxlegsAPT9rHc=;
        b=WTA4VoBykzF2i9rDKn5UVFxvSDqZSVjG9X4cbIQsNqk2BgzgJi8QGTQnQbZU1BXe/B
         aqJ1V9f2HI7hvnaJGuxODjnuob2WA5+DRIaFG9Ybzhd6AlTCdeBJYFz6yYglV+nB7fC1
         jw4CLpAzGZcVWHCqAz7wxJlwLrtnq5V6f6jZM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=Ev0vEEgy67DpeEiGn9An9d98zYM3CM24H/dAcxjZ9JdeX+E77KEonHCwjnq5NfewcD
         mey9l4Osb9+DRDtcsk/3E0/pDb/O/LkQL9NvPvxg6IoccCRZMwHWZFj8Ug0Rn9IQsJTU
         TY4leL6Knc40FcHaQ89qqlaPogCKvlvdoMLso=
Received: by 10.103.76.21 with SMTP id d21mr1494634mul.78.1259584343856;
        Mon, 30 Nov 2009 04:32:23 -0800 (PST)
Received: from localhost (ppp85-140-126-192.pppoe.mtu-net.ru [85.140.126.192])
        by mx.google.com with ESMTPS id j10sm11685945muh.56.2009.11.30.04.32.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Nov 2009 04:32:23 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134093>

Hi!

I have never run "git archive" inside of a subdirectory but somehow I
have always assumed that it creates an archive containing all files in
it regardless the current directory. In fact, the git-archive man page
says so:

path
    If one or more paths are specified, include only these in the
    archive, otherwise include all files and subdirectories.


But it turned out that "git archive" works as "git archive .", i.e.
adds files starting with the current directory. Is any rational for
this behavior? It smells to me like a bug rather than a feature. I
cannot imagine wanting to create archive containing just part of the
whole repository just because he happened to be in that directory,
and documentation clearly says that all files should be added unless
one or more paths are specified.


Dmitry
