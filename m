From: Joshua Shrader <jshrader83@gmail.com>
Subject: Git Notes on Branches
Date: Thu, 22 Jul 2010 16:22:48 -0400
Message-ID: <AANLkTinnDBUzoDj-C289l4Kui2qSiKmF-027MzijyCFY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Joshua Shrader <jshrader83@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 22 22:23:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc2IH-0005Jv-5A
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 22:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250Ab0GVUWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 16:22:50 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57588 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031Ab0GVUWt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 16:22:49 -0400
Received: by vws3 with SMTP id 3so566475vws.19
        for <git@vger.kernel.org>; Thu, 22 Jul 2010 13:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=bTLmO8s7eLGoS8S4iL8QGkbDFIScfpihSl1Wdvf0Nrk=;
        b=BukUWbCXgdlezvNKsYFTWuMdc5e0yS/aIck3YDkfVTpGfpb0Fj34OuAtLafrOtrlaZ
         I4XdLG3QQ65e01KLqOsREr4/t5NQk7ieqCSodJ57EzwZH3Q0p+M+S9j6WigJ9GA+Y9sO
         +ReuzA8tGUPLXRzXRt6gBbrnbQTBKlP5+QRUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=xllHvI4mC777CAhI58C/OUolN3mso/X+dRCp0nvrqQsf9CwnE5rdtHYj8anBpxtAW3
         3HAIIL9pKK34amr87l0+kWMnIsV7q4DzRCLsjzQJrCajE+8ccz1Iw/gl/TlVCgyknMEh
         EhDEP7UB5Jid0/md9DZAUKabEN9wbJ9R1ePfw=
Received: by 10.220.60.70 with SMTP id o6mr1023482vch.2.1279830168262; Thu, 22 
	Jul 2010 13:22:48 -0700 (PDT)
Received: by 10.220.97.20 with HTTP; Thu, 22 Jul 2010 13:22:48 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151480>

I'm wondering if there is a way to (or a reason that would prevent one
from implementing a feature that allows one to) associate a note with
a branch, rather than a specific object.  It seems like a notes object
contains a reference to the object that it annotates:

Annotate 4bd93734af...

Rather than forcing this to be a SHA1, can the same approaches as
taken with HEAD be employed?  That is, allow it to be either an object
ID, or a local branch?

This would essentially define a new use case for notes.  Rather than
just being used to annotate objects, they could be used to describe a
feature branch or a bug fix, for example.  Then, when a release is
created (from, say, master), a "git branches --merged" will show all
merged branches.  Assuming the workflow is to develop on well-defined
branches, if each of these branches had a description in an attached
note, created Release Notes would be a piece of cake.  Add a
description via "git notes add feat-branch-2" that you want to show up
in the Release Notes once the branch is re-integrated.

I see a potential problem when working remotely and trying to push the
note to origin, but I don't think its insurmountable.

Thoughts?

Josh
