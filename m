From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [BUG] rebase --onto doesn't abort properly
Date: Mon, 6 Jan 2014 23:12:01 +0530
Message-ID: <CALkWK0mEN=LjWKKdWznCXk5YwRQXVDPwtxUvVJnrG9zPPvH-Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 06 18:42:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0ECM-0002kX-Bs
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 18:42:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755432AbaAFRmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 12:42:43 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:36662 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754899AbaAFRmm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 12:42:42 -0500
Received: by mail-ie0-f182.google.com with SMTP id as1so19126379iec.13
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 09:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=kaBT9zfJAS1WD4zEDM+culL7sv91DDRtw/Meu4XCDIY=;
        b=Pk70OM0w8JgW8X8NVfEZHZ8qKZnSl39laJ/2Fm15v05kjCJilfvZOvGLtljJaVjs93
         PDtMXFsHUIs+Q6NdeqlBxfbFWWniJ/iJ6ys+rVfyAOZaass6ufvJc8CNS23/FW9dEdC3
         2EE+Rmn+k8pl8rumEH5CuHLNCLIPtPmOAWG+JtCR1OU/VzjsX/TlgCp/rKwzwCHEiEEJ
         Fbk6mtDKxEyguYV9EIXffcthhnJ7zBCb5+pBZdo5urXtZxaSBtBi1yTrF2jNrzM3WkCK
         u2tl7jrbzEzpTYZJLyPIRsgF1UMPpjZwKJkW+r/NKPKrqHyMT1LuFVA+f/DFuwAmDXSJ
         feuw==
X-Received: by 10.42.47.201 with SMTP id p9mr80172297icf.4.1389030161791; Mon,
 06 Jan 2014 09:42:41 -0800 (PST)
Received: by 10.64.195.9 with HTTP; Mon, 6 Jan 2014 09:42:01 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240037>

Hi,

On the latest git, I noticed that a rebase --onto doesn't abort
properly. Steps to reproduce:

  # on some topic branch
  $ git rebase --onto master @~10
  ^C # quickly!
  $ git rebase --abort
  # HEAD is still detached

I tried going back a few revisions, and the bug seems to be very old;
I'm surprised I didn't notice it earlier.

Are others able to reproduce this?

Thanks.

Ram
