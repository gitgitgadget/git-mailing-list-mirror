From: Alex Riesen <raa.lkml@gmail.com>
Subject: Runaway "git remote" if group definition contains a remote by the
 same name
Date: Wed, 17 Nov 2010 18:10:00 +0100
Message-ID: <AANLkTinni=VJLoZp1Hjm4dfW8faChytDObJbXsFF5iXv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 17 18:10:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIlWM-0005f3-0s
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 18:10:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934988Ab0KQRKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Nov 2010 12:10:03 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62234 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934967Ab0KQRKB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Nov 2010 12:10:01 -0500
Received: by gyh4 with SMTP id 4so1228681gyh.19
        for <git@vger.kernel.org>; Wed, 17 Nov 2010 09:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=4VvQ4KGYaZ89AKfZfEPGpbw9BMhLuMrdqSs8NbYC/Jc=;
        b=nXCCHZGo/TDdJqHpM8OM4LwsIll+DsCfzWsgrHKbZBnSJxbT8rFXK7wXU+DcuoATYC
         jXvXaMxNoPzFY0COtIg5DvnVVIfX+Ohxd/dR2e3xxH66DcXmWOBNeitQLFUFOz6QOtIv
         aGwaHuJ89Ps/U+4GHKV93/wF05mWagIKkviMY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=kZY5fewRcGe7mQYqTIT1FI4WZDSojmqJzYxJ7rB3TtXIK8Ys0+8mTt66cnJ86Luc3x
         l6AR9xSAU1HjEKVrsS6BrzKCEpw8Rmt3Zxg0C/LbCWOOnSj44vRBv5y1c+f5hvcxxv0e
         TcH/SFuv7YAdg3KLg8YN7362eB0mnKqswLvH0=
Received: by 10.90.2.23 with SMTP id 23mr11816083agb.97.1290013800604; Wed, 17
 Nov 2010 09:10:00 -0800 (PST)
Received: by 10.90.6.32 with HTTP; Wed, 17 Nov 2010 09:10:00 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161625>

Hi,

it is also a way to create a fork bomb out of the innocent tool on platforms
where pressing Ctrl-C does not terminate subprocesses of the foreground
process (like, of course, Windows).

To reproduce, run

   git -c remotes.origin='origin other' remote update origin

I just cannot look at it right now, and have to resolve to only reporting
the problem to warn people. Something seems to resolve the remotes group
definition over and over again.
