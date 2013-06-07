From: Daniel Krikun <krikun.daniel@gmail.com>
Subject: feature suggestion
Date: Fri, 7 Jun 2013 11:59:48 +0300
Message-ID: <CAMohcw0exP7pDnas4zceoKEADs58axEHYUd6y_MtSoV5=6rMDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 10:59:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UksWZ-00076E-6N
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 10:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754574Ab3FGI7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 04:59:50 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:47536 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753602Ab3FGI7s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 04:59:48 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz12so4450701pbc.17
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 01:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=CDss51d8UMRX1LP7IeISQbObbGTAcwfCuYzN7qXPdqE=;
        b=vkmx8nosQvIZUhx3UY7PA7d9tGiDPvIw9A6puUPlqW5Sg1hxolOEdFnwNVnPUWSLYd
         34O3XcLhw+18S1uEfjQkx8n4O9IUn8dvJB3eaEpM02HoTppRIxlPvdqSmzHEMkJjDEJy
         rFl2nPVLKVl7nplHjRhPX9r2SyRQl3wycLE1Bdiv/EMrrCXbuw2+5K8cN9YbYahVZAqs
         9J5Tr/Sn4Wl5/AFm8SIbytZ74emrZlRmgeUAXuhqb0XUkan/af0yVy1DfrvkCv7Mshi5
         NeD7zJG4D43D8aDrCcJvoPJA35nuUfmLkbh/gFyxkbdr7vMV3JoOe9/ey6MJqb3O9ACN
         XMqA==
X-Received: by 10.66.144.98 with SMTP id sl2mr1783915pab.92.1370595588107;
 Fri, 07 Jun 2013 01:59:48 -0700 (PDT)
Received: by 10.68.204.227 with HTTP; Fri, 7 Jun 2013 01:59:48 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226614>

Hi all,

Problem (scenario):

1. A file `file.xyz` has been added and commited
2. Some time after, let's say `*.xyz` is added to `.gitignore`
(probably by another contributor)
    Nobody notices that `file.xyz` is already tracked by git because
the file is not modified.
3. Another person accidentally changes `file.xyz` (may be it some
local config etc.), but no problem it is ignored anyway,... wait, why
does it shows up in `git status` as modified? Maybe it is not in
.gitignore? ... no it is... you get the point.


The suggestion is that when the .gitignore is updated, some kind of
`git ls-files --others -i --exclude-standard` is rerun and if there
are tracked files that are ignored due to the last update to
.gitignore an appropriate warning is shown.
This will eliminate the described surprise factor.

Sincerely,

--
Daniel Krikun
