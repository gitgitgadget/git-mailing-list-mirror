From: demerphq <demerphq@gmail.com>
Subject: git diff --summary only seems to work when combined with --stat
Date: Mon, 6 Dec 2010 21:55:26 +0100
Message-ID: <AANLkTimCAy8kcQaKNaxz4UJp2ZB=_HeRMmeaQ5ZHNV4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 06 21:55:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPi5t-00010t-Ja
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 21:55:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753311Ab0LFUz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 15:55:28 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50727 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745Ab0LFUz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 15:55:27 -0500
Received: by qwd7 with SMTP id 7so1702237qwd.19
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 12:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=WDTwpp6937ebA9j2AHWNsc7lHRxDQzDwKTldD4STlEw=;
        b=Oq2qZH1lKWObbsE+6LB1ga2pn12AolG6F6ILU+xl+a1pWNIvooDK6XGUO/c/qazShN
         5ohck6YrDbkBkS9MyVliPWZXVS5PhrATQ2g04/BUgBvmLSEmwS+/0eKFS50vZNqrQM/X
         4uBysdtYyRStORQJlucnFNvPXpe5qUQT6MNQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=eqfbMP4D4IENlyixu144kE8RpscqtWKRkeUq04cnq0752OYtmDXUzHMQHMPbSD1Yw2
         bJ4CdADPPC1S1AMgRHYWrshDceDLfo/IbuCk8G9hUHtwHitxe01Vp5Z/BismdXqP149k
         XViVT82rfyVDr8iodXlL4r0iczgMJ4X5G8UNQ=
Received: by 10.229.183.135 with SMTP id cg7mr4715779qcb.296.1291668926713;
 Mon, 06 Dec 2010 12:55:26 -0800 (PST)
Received: by 10.229.192.193 with HTTP; Mon, 6 Dec 2010 12:55:26 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163020>

Hi,

It seems like the --summary option only works in combination --stat.

It doesn't seem to work if I use it by itself, nor in combination with
--name-status or --num-stat. And depending on the order, it either
does nothing, or causes a usage note.

Is this intentional? If so, could it be reconsidered?  At the very
least in combination with --name-status and by itself, I can kind of
understand it not working with --numstat

Ive tested with two gits, and it seems to be the same in both:

git version 1.7.2.1 and git version 1.7.3.2.168.gd6b63

Cheers,
yves

$ git diff --summary --stat HEAD^
 somefile |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)
$ git diff --summary HEAD^
$ git diff --summary --numstat HEAD^
12      2       somefile
$ git diff --summary --name-status HEAD^
M       somefile
$ git diff --name-status --sumary HEAD^
usage: git diff <options> <rev>{0,2} -- <path>*
$ git diff --numstat --sumary HEAD^
usage: git diff <options> <rev>{0,2} -- <path>*



-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
