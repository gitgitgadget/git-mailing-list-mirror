From: Jeff Adamson <jwa@urbancode.com>
Subject: Value size limits on git config files
Date: Tue, 5 Apr 2011 12:29:31 -0400
Message-ID: <BANLkTikknAiYr4y-it3+qZ3dnXE56dQBoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 18:30:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q798u-0005ta-TD
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 18:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740Ab1DEQaG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Apr 2011 12:30:06 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:50165 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339Ab1DEQaF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Apr 2011 12:30:05 -0400
Received: by pzk9 with SMTP id 9so207534pzk.19
        for <git@vger.kernel.org>; Tue, 05 Apr 2011 09:30:04 -0700 (PDT)
Received: by 10.142.98.13 with SMTP id v13mr248332wfb.279.1302021004457; Tue,
 05 Apr 2011 09:30:04 -0700 (PDT)
Received: by 10.68.56.71 with HTTP; Tue, 5 Apr 2011 09:29:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170886>

When trying to=A0incorporate=A0large aliases into my ~/.gitconfig file =
via
`git config --global "!$(cat myscript)"`, I determined that there
appears to be a limit to the size of a value. =A0When exceeded, git
prints out "fatal: bad config file line 82 in ~/.gitconfig". =A0I was
able to strip enough comments and such from myscript that it then no
longer invalidated the config once the value was less than 1024 chars.
 (Minor aside, I am doing this as a small experiment to potentially
aid in=A0synchronizing=A0all my git=A0behaviors=A0across machines by in=
lining
them into the config file. =A0Whether this is a good path to explore or
not is a separate issue.)

My questions are:
=A0 =A0Is this 1024 char limit on config file values documented somewhe=
re?
=A0 =A0Should it be considered a bug that git config can write out conf=
ig
files which it can not then read (e.g. it should be changed to either
enforce the value-length limit during writing, or the parser updated
to handle large values)?


Thanks,
Jeff
