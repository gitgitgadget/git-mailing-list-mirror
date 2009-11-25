From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Git repository mesh?
Date: Wed, 25 Nov 2009 11:07:51 +0700
Message-ID: <fcaeb9bf0911242007t1294bddej87b48691ea283e21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 25 05:08:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ND9Ax-0005dm-8l
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 05:08:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934362AbZKYEIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 23:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934343AbZKYEIG
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 23:08:06 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:46540 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934311AbZKYEIF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 23:08:05 -0500
Received: by pzk1 with SMTP id 1so5311433pzk.33
        for <git@vger.kernel.org>; Tue, 24 Nov 2009 20:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=2zfHdzceR6aLe9IjjHvqUE3h1fvMNMgrgx7/K00jtnU=;
        b=xQNXwKk3wbu0I53aytVxTdOfOkuQFqpt7WzuCPKivctl14h0CD5xZH6BUlGvfBRvys
         +SV+TbSoaaqDFmVgJssWHDlGNTIIkFZ8nRG+eGZWCWq9QHA7OO39mDZE+sawV+EeG+5W
         HQj4Kwcl4lpKgKuff4DCrAadF15R0PrfDE+tk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=ATDOPIVueFVqHyBpDoXQUEfYctPek2hOJSU3drD2QF3RFzP8uS5+Dxyon4u5+f3YKq
         U3TZvHsd0nBbiHCTnyLnoFpdTQRMnHSVA+3Q1J7uOMr1nqKiWetKwUwweWBIr0R8YbCE
         gvrtcaH8HruA3sYIXwJ0kzAu1ZbGEHMEfxQGg=
Received: by 10.114.33.33 with SMTP id g33mr14258915wag.212.1259122091245; 
	Tue, 24 Nov 2009 20:08:11 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133613>

Hi,

I work on a few machines so I have repositories on all of them. One
repository can pull from or push to any other repositories (in case of
push, it pushes on remote branches). I avoid a central repository
because it's quite inconvenient when you just need to push some
changes to a machine, you have to push it to the central repository
then pull from that (and if the central repository is on WAN, double
inconvenient). Maybe this model is just plain wrong, but it'd be fun
to see if Git can work with this model.

The first thing that annoys me is remote repository management.
Everytime I add a new repository to the mesh, I need to update .config
of all repositories. Putting part of $GIT_DIR/config into working
directory may help (though there will be security concerns, perhaps
only remote.* should be allowed in in-tree config file). Next thing is
sometimes I want to see how many commits ahead/behind other
repositories, from a repository. "git status" does not help much.
Never used Mercurial but the idea of "git in" and "git out" to see how
many commits ahead/behind would be nice.

Has anyone done something like this? Any suggestions?
--
Duy
