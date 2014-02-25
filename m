From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Can't use difftool to selectively revert changes
Date: Tue, 25 Feb 2014 09:22:35 -0600
Message-ID: <CAHd499BGt8KhU=QU7dZ+-AR67=3Rf7VhBXfiHg7Ks=vSg6YOQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 25 16:22:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIJqD-0008FO-VM
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 16:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbaBYPWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Feb 2014 10:22:36 -0500
Received: from mail-vc0-f180.google.com ([209.85.220.180]:57261 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492AbaBYPWg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Feb 2014 10:22:36 -0500
Received: by mail-vc0-f180.google.com with SMTP id ks9so7201820vcb.25
        for <git@vger.kernel.org>; Tue, 25 Feb 2014 07:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=agsbrhhLbFWSqJgdyPraclr18J163+Sz5F3bV9mgiwo=;
        b=PRBNMbC7w5s/AauQywyBN1h5by6p+uGxC/bfmEjPCUeleOjAmH/8FcA5M14e3EHKAn
         Fke+3+AvPBrutOTTssandEmtXmEJgRHaF45/vLnhWpm4K3fKucd7O/3dg4f7FUlw3V7f
         sNQV2NkFJuZlVVEs4qBVkyxmwz1nF0hOm3m5exmROnmTZa0qNKMld1ayYW9DMj4yAMMf
         ur64tacbZVm2BHD+b+0WcWwhQYOMd7hsU75UHd3/lGd1DTaaUmIynx1bbkL4ZX4C6m22
         /Nq5ZVNaz4lgJt797B6AjFSV2eH1yDCXDZFiVu7D8tgyLR/8WVO2g1QPI4f+9jOVFqxG
         vnxQ==
X-Received: by 10.58.252.8 with SMTP id zo8mr174905vec.55.1393341755632; Tue,
 25 Feb 2014 07:22:35 -0800 (PST)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.221.49.68 with HTTP; Tue, 25 Feb 2014 07:22:35 -0800 (PST)
X-Google-Sender-Auth: Zit-56xPXciuLUDDrgfLzbh5xwk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242669>

I have a branch called topic1 that is based on 'master'. For a
particular file in my topic branch, I want to revert some changes by
using my diff tool. I do this by comparing the original revision of
the file with HEAD like so:

$ git difftool $(git merge-base topic1 master) HEAD -- Path/SourceFile.cpp

When I make changes to the right side (HEAD) through my diff tool, and
exit, the changes aren't picked up and applied to my working copy.
Since I'm modifying HEAD, I think it should carry over the changes I
make. Is this by design or a defect? I don't know how else to
selectively revert changes to a file through my diff viewer.
