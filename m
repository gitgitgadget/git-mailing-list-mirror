From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: Reference has invalid format: check maybe a bit to harsh?
Date: Mon, 31 Oct 2011 20:14:25 +0100
Message-ID: <60007404.ge1WXNp2Qn@soybean>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 20:15:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKxKP-0004ry-Pm
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 20:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934132Ab1JaTPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 15:15:20 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:53932 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933236Ab1JaTPT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Oct 2011 15:15:19 -0400
Received: from mail-in-12-z2.arcor-online.net (mail-in-12-z2.arcor-online.net [151.189.8.29])
	by mx.arcor.de (Postfix) with ESMTP id 673C610BBB6;
	Mon, 31 Oct 2011 20:15:18 +0100 (CET)
Received: from mail-in-17.arcor-online.net (mail-in-17.arcor-online.net [151.189.21.57])
	by mail-in-12-z2.arcor-online.net (Postfix) with ESMTP id 59A381DF134;
	Mon, 31 Oct 2011 20:15:18 +0100 (CET)
Received: from soybean.localnet (178-191-141-246.adsl.highway.telekom.at [178.191.141.246])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-17.arcor-online.net (Postfix) with ESMTPSA id 45436CBE0E;
	Mon, 31 Oct 2011 20:15:18 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-17.arcor-online.net 45436CBE0E
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1320088518; bh=v9CtOoQn+jC/I6yWlePokDvgNLpCndvoS8Yegdbg1ao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=Mvj3clt6PLJQoua8xCdwTxndGrD/h3TrLUDaerY7GLRlidNn3WsLmUayOs+moF49f
	 HRDELEBgSVozrIXUlH3mE1cb6I9rOPQggkjGpIuRKrO7aQkbSmTF3mPITUQCw1zfWd
	 GDzNSJiYuQ+LM8BoGtI6TxBgN2cTUfRTGMgHJCK8=
User-Agent: KMail/4.7.2 (Linux/3.0.0-12-generic-pae; KDE/4.7.2; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184516>

Hi,

i am using the next branch for testing and i noticed the following:
about any git command i execute in a certain repo dies with
fatal: Reference has invalid format: 
'refs/patches/obd_development/blah:_various_improvements_remote_debugging'

This is probably caused by
dce4bab6567de7c458b334e029e3dedcab5f2648 add_ref(): verify that the refname is 
formatted correctly

The invalid refs(about 30, loose and packed) containing a ':' were created by 
stgit a long time ago(Dec 2006)

Personally i do not care too much, i patched my git to not die at this point 
but to only display a error.
-> The invalid refs are not accessible, but the rest of the repo still works.

But i'm just wondering if dieing when seeing a single invalid ref might be a 
bit too harsh since no git tools can be used anymore on this repo at all.


Small side note:
It seems t1402-check-ref-format.sh contains not test
for the invalid ref char ':' yet.
(i do not know if it is tested somewhere else...)

Thanks,
Greetings Peter
