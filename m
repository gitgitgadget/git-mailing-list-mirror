From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: General support for ! in git-config values
Date: Wed, 1 Feb 2012 18:33:47 +0100
Message-ID: <CACBZZX6U+1Fmdaz2ikbbc6zUyF=pMGQOqUGVOWCkUFBUkovCBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 01 18:34:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rse4V-0008R4-Mh
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 18:34:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754304Ab2BAReK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 12:34:10 -0500
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:52570 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753505Ab2BAReJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2012 12:34:09 -0500
Received: by lbom4 with SMTP id m4so209049lbo.19
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 09:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=UNWq2eW3spLxaCnVmEprOpHOD0RiBBKIRMgWikyi+5M=;
        b=GA8BCCJJ9FiHH5+aiO9dpZV+dbIUSUq3ffV0wTl89DeMFmobY+JgnxxgrJ3BLCNYTz
         iJXwMdtK5WGOpKXc0rr9sgK18Ia/wdD/dNQ/2Qd3hm20pHZIRrsSd5Mo4L7k6re5/j+H
         hxreqMoRcmMlZWPvpCErb0eO9g8xUKdOWkvVA=
Received: by 10.112.40.72 with SMTP id v8mr7033964lbk.49.1328117648164; Wed,
 01 Feb 2012 09:34:08 -0800 (PST)
Received: by 10.112.30.67 with HTTP; Wed, 1 Feb 2012 09:33:47 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189527>

alias.* values can start with !, in which case a shell command will be
executed with the arguments you give.

For a program I'm working on (git-deploy) I'd like to have this as a
general facility, i.e. users can specify either:

    foo.bar = value

Or:

    foo.bar = !cat /some/path

I'm wondering why git-config doesn't do this already, if there's no
reason in particular I can just patch it in, either as a new option:

    git config --with-exec --get foo.bar

Or as the default behavior.
