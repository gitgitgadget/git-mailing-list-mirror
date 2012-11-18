From: Adam Stankiewicz <sheerun@sher.pl>
Subject: Motd message on git cloning
Date: Sun, 18 Nov 2012 17:04:37 +0100
Message-ID: <CANCidP-d0tXfo6ZsC80LmaS1CJ475rew2D7ztrx9TkNa94a-uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 17:05:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta7ND-0002Hh-Pr
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 17:05:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323Ab2KRQE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2012 11:04:59 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:64525 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091Ab2KRQE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 11:04:58 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so2662737qcr.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 08:04:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:from:date:message-id:subject:to
         :content-type:x-gm-message-state;
        bh=MrEgKdJjGEongj/XJnE7sZaquqWKDiQIz8ssDni3eXA=;
        b=cLI/+Vm+O2bMxvmNkY91E8V/MUp1rLzX9KGtAI4gnDB4wa38i9nNisIEeYKHYqoJMl
         vqHoyUklyPxB3wS+4ilCkvVURzY4nfodNEGmxFCNzcyE4MkdEjnlSD+9S4y6t+tL0Ob2
         W6eGccsplDjf2kTl9pYX/gagzYsBd0vO2SplHDKL4pjb3kk+ylU4vxY23DYZDvFSLTda
         GaFOCxgq/iY2O265WtOCk2v18nzIpx4ec13ZnsIiMuHhhtaV3R9VdDc07Awhb0niqVEd
         9vSNn1FcaRbzyZ9ZoH9/bte84D/Bphs5VQoRLG626bMISlr8Ulle758moCEqsuP9JqYW
         dM4Q==
Received: by 10.224.183.194 with SMTP id ch2mr9479373qab.24.1353254697535;
 Sun, 18 Nov 2012 08:04:57 -0800 (PST)
Received: by 10.49.74.106 with HTTP; Sun, 18 Nov 2012 08:04:37 -0800 (PST)
X-Originating-IP: [62.87.248.204]
X-Gm-Message-State: ALoCoQkbV9SBMspHsKFzE1C88Nd/lP0yX6TwKxciJnWA+e53adj03JZ/9o7vVS7YII2pBFVOQJmJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210027>

I'm dreaming about git feature that shows custom message on git clone.
It would be extremely helpful for informing the person cloning about
init scripts he/she need to execute (for example submodule inits or
hooks set up). For now there is no way to make sure cloning person
will receive such message (unless he/she will read the README).

The server does not need to know if it's fetch or clone, if programmer
executes git clone on client side, then the MOTD message would be
shown.

I think good candidate for MOTD message is .git/description (because
for now no one seems to care about setting repository description).
Another option is to introduce .git/motd file that would consist of
some maximum number of non-control ASCII characters.

I don't really see any security concerns. Git could filter any control
characters from MOTD out, and automation script could add --no-motd
flag. The could also be limit on MOTD file size so no one could
"flood" the terminal window with MOTD messages.

Also it's important to me that such message would be shown
automatically by default and could be turned off, not the other way
(for example --motd flag).

Some other tools like brew package manager have this feature from the
beginning and I find it extremely helpful.

What do you think?
