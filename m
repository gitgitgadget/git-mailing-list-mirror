From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: How to specify remote branch correctly
Date: Mon, 17 Dec 2012 07:21:44 +0000
Message-ID: <1355728904-ner-4851@calvin>
References: <slrnkct0r3.dsp.narkewoody@zuhnb712.local.com>
	<CAH5451=7frqa-YHXubvO=dMK2CvVoWR-VFZ3XCmKouNiQz4gAg@mail.gmail.com>
	<slrnkcta0j.mlu.narkewoody@zuhnb712.local.com>
	<CAH5451kmTW+nO4V4pjSdaqhHAb=RX-tawLo=rJfuPnDRDWeSEA@mail.gmail.com>
	<1355722245-ner-6603@calvin> <slrnkctgqh.mmj.narkewoody@zuhnb712.local.com>
Mime-Version: 1.0
Content-Type: text/plain
To: Woody Wu <narkewoody@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 17 08:22:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkV1Y-0005IY-DS
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 08:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124Ab2LQHVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 02:21:48 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:55517 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938Ab2LQHVr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 02:21:47 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so3006564eek.19
        for <git@vger.kernel.org>; Sun, 16 Dec 2012 23:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:references:in-reply-to:mime-version:date:message-id
         :content-type;
        bh=7iDpkbvw4O07OOieLeUhvyeEFRWQVEW1UqG1mZrS6o4=;
        b=xWN34XQZeDa6JmtNi1kkWdt1pW+yywPUR9DJN07rsdrUh3Weg8wa7Ink9H8CM1SB+0
         eduXNy6sI/Ayk3ikSIzkr0ILG/3viSJPEoAahhmKtCGAwOGK9o6Us666hBV7ROMfAogU
         kEOBZcm3R40C8LEAGwu8IfGbcnBLds9Ec/tcWKR7wZx41t/aS12xetMpnEKiT3+AbOzO
         E8MVeTWdELOB09H4oC6OxTQvpDbWFV60xkuV9erbTwB8+npb7pDXVJEc/LlQxoFyBMve
         HxeTgOvMhrH1D1Gjc1aTsv0vTj19xSv0y4/hLIPoEc8AzdVvNdU996r4YHqxpS0uRuJq
         +x9A==
Received: by 10.14.213.134 with SMTP id a6mr38866045eep.45.1355728906089;
        Sun, 16 Dec 2012 23:21:46 -0800 (PST)
Received: from calvin.caurea.org (pub082136067238.dh-hfc.datazug.ch. [82.136.67.238])
        by mx.google.com with ESMTPS id w3sm27323550eel.17.2012.12.16.23.21.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Dec 2012 23:21:45 -0800 (PST)
Received: by calvin.caurea.org (Postfix, from userid 3301)
	id 55C0212656B; Mon, 17 Dec 2012 07:21:44 +0000 (UTC)
In-Reply-To: <slrnkctgqh.mmj.narkewoody@zuhnb712.local.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211647>

On Mon, 17 Dec 2012 07:02:46 +0000, Woody Wu <narkewoody@gmail.com> wrote:
> On 2012-12-17, Tomas Carnecky <tomas.carnecky@gmail.com> wrote:
> > 'git checkout foo' has special meaning if a local branch with that
> > name doesn't exist but there is a remote branch with that name. In
> > that case it's equivalent to: git checkout -t -b foo origin/foo.
> > Because that's what people usually want.
> 
> I think this is what exactly happened to me in the first time I got the
> 'foo'.  One new thing to me is the '-t'.  I am not sure wether the '-t'
> was used or not in the background.  How do I check the 'upstream'
> relationships?  Is there any file under .git recoreded that kind of
> information?

Yes, that information is recorded in a file somewhere in .git. However, for
most users it's irrelevant which file it is. Git has commands to access this
information. Try one of these:

  git branch -vv
  git remote show origin
  git rev-parse --abbrev-ref --symbolic-full-name @{u}
