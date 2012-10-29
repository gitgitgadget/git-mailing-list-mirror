From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: gitk: crash when pressing Shift-F5 while still loading a diff
Date: Mon, 29 Oct 2012 22:34:21 +0100
Message-ID: <508EF65D.2080208@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 29 22:35:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSwz8-0004mD-Dz
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 22:35:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761030Ab2J2Vet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 17:34:49 -0400
Received: from mail-in-18.arcor-online.net ([151.189.21.58]:34549 "EHLO
	mail-in-18.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760480Ab2J2Ves (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Oct 2012 17:34:48 -0400
Received: from mail-in-02-z2.arcor-online.net (mail-in-02-z2.arcor-online.net [151.189.8.14])
	by mx.arcor.de (Postfix) with ESMTP id A5FE63DC833
	for <git@vger.kernel.org>; Mon, 29 Oct 2012 22:34:46 +0100 (CET)
Received: from mail-in-15.arcor-online.net (mail-in-15.arcor-online.net [151.189.21.55])
	by mail-in-02-z2.arcor-online.net (Postfix) with ESMTP id 96E61522007
	for <git@vger.kernel.org>; Mon, 29 Oct 2012 22:34:46 +0100 (CET)
Received: from [10.0.0.2] (188-22-38-93.adsl.highway.telekom.at [188.22.38.93])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-15.arcor-online.net (Postfix) with ESMTPA id 5F14D1AB53B
	for <git@vger.kernel.org>; Mon, 29 Oct 2012 22:34:46 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-15.arcor-online.net 5F14D1AB53B
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1351546486; bh=seShQjHAvjn70ATDio/Yjsjnn/pgLhX86qf8gectI3I=;
	h=Message-ID:Date:From:MIME-Version:To:Subject:Content-Type:
	 Content-Transfer-Encoding;
	b=JOdVdYibAmtRhXhUDVXd2JpFfveFXSEWbOrlqY2GsRsG5CvcsG4GFNS2e3hN2m0eK
	 VbVpu6E298JZfjurex/OPeyKuQDDsBoatA/n3XF8S8nTeySMvTpCfAdJiBy3MjOLQO
	 NAZVpLhLYiMUoGxIQGtej99o0+0dbdEAAR2neb8U=
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:16.0) Gecko/20121011 Thunderbird/16.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208639>

Hi,

i recently tested gitk a bit more myself and on some people in the office.
And i noticed when I repeatedly press Shift-F5 gitk
crashes/displays a message box [1].
my current version: c83ae78864493a30ed5b544b4910a384371a5eaf

This also happens a lot when gitk is still loading a big diff
and using View->Some view to change the current view.
(I have made a convenience shortcut "--all" to show all branches without having
the windows people going to the commandline)

Greetings Peter

crash1:
can't read "treediffs(7affa01c56f17778e92b57fd4fc8d749a672d930)": no such variable
can't read "treediffs(7affa01c56f17778e92b57fd4fc8d749a672d930)": no such variable
    while executing
"lsearch -exact $treediffs($ids) $fname"
    (procedure "makediffhdr" line 7)
    invoked from within
"makediffhdr $fname $ids"
    (procedure "getblobdiffline" line 61)
    invoked from within
"getblobdiffline file8 7affa01c56f17778e92b57fd4fc8d749a672d930"
    ("eval" body line 1)
    invoked from within
"eval $script"
    (procedure "dorunq" line 11)
    invoked from within
"dorunq"
    ("after" script)

crash2:
can't read "varcid(0,7affa01c56f17778e92b57fd4fc8d749a672d930)": no such element in array
can't read "varcid(0,7affa01c56f17778e92b57fd4fc8d749a672d930)": no such element in array
    while executing
"set a $varcid($v,$p)"
    (procedure "insertfakerow" line 6)
    invoked from within
"insertfakerow $nullid $p"
    (procedure "readdifffiles" line 29)
    invoked from within
"readdifffiles file7 7 71"
    ("eval" body line 1)
    invoked from within
"eval $script"
    (procedure "dorunq" line 11)
    invoked from within
"dorunq"
    ("after" script)


error3 (output on stderr):
oops rowofcommit no arc for 7affa01c


7affa01c is my top commit on the current branch.

Greetings Peter
