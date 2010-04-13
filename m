From: Jay Soffian <jaysoffian@gmail.com>
Subject: TODO: git should be able to init a remote repo
Date: Tue, 13 Apr 2010 13:30:44 -0400
Message-ID: <i2i76718491004131030sc2f8ffa3u97a91aa9a57923b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 13 19:30:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1jwq-0001nO-F3
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 19:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916Ab0DMRaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 13:30:46 -0400
Received: from mail-iw0-f197.google.com ([209.85.223.197]:43788 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab0DMRap (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 13:30:45 -0400
Received: by iwn35 with SMTP id 35so2115480iwn.21
        for <git@vger.kernel.org>; Tue, 13 Apr 2010 10:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:content-type;
        bh=m+gQWjmzbe4UE7LatX1UQDGOkrkoBwPUeZQ7L9fUtSQ=;
        b=CbCJ5Mgy04raeKeoqutAvfqE36QIsNnH1x/2y91pIwOBl87gtDvYeaNlHijF6BRUXO
         gFBRYNjWa1ezVOOKjXXPJ4hs2QNXuD2CJLqO8nZyhbA6w+mvid8BtFJatYSjlrKMyTki
         fLDXGuawA4XIxlL3M32hIvv02mWF5DGGXiZk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=pTM4+YABbchGIVFJnzuxlQlmdL/6haL1uP7AajzPsgv1/17/NFCuGf2rdSFgGSy6Hm
         4kMWklgV+K6JbGhazVJPFbTpK0yNCzvAPsk6qzWpy+YYXd7i61Dc2wWdyHZcUX8Wtc+e
         V17Gl785LEbjpckOzoPvj9j5biPziT+ClW+ck=
Received: by 10.231.36.9 with HTTP; Tue, 13 Apr 2010 10:30:44 -0700 (PDT)
Received: by 10.231.182.206 with SMTP id cd14mr2783609ibb.39.1271179844638; 
	Tue, 13 Apr 2010 10:30:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144824>

[Mostly I'm sending this so I can add a "TODO" label to it in my gmail.] :-)

With modern git, setting up a remote bare repo that you can push to is
finally down to a reasonable number of commands:

$ ssh remote git init --bare myproject.git
$ git remote add -m master origin remote:myproject.git
$ git push -u origin master

But we can do better. I was thinking something like:

$ git remote init [--push] [--mirror] <name> <ssh_url>

This would perform all of the steps above, except for the push itself,
unless given --push (in which case, that too). This is meant to
simplify what I believe is the common case of setting up remote repos.

j.
