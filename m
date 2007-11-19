From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: git merge no longer handles add/add
Date: Mon, 19 Nov 2007 16:18:33 +1300
Message-ID: <46a038f90711181918s2743137amc6a827db6d1a6a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 19 04:18:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Itx9y-0005f2-6d
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 04:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528AbXKSDSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 22:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753453AbXKSDSf
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 22:18:35 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:59835 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328AbXKSDSf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 22:18:35 -0500
Received: by ug-out-1314.google.com with SMTP id z38so887030ugc
        for <git@vger.kernel.org>; Sun, 18 Nov 2007 19:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=6PqwcQ+vFs47fJnIPrshH1GsLfLyjiSNqnRBwbx0By8=;
        b=BeKtEzHP/tasJyjJZXoT90Hv3djMTBnYsdjqs8HmXDOFyuXAhmZOvBVPU7/Dh3ldkZAYIj0qYlwWsw5J994psLWNJqkXKeXBI2FTKecsjjDfGr3EN2sP9BSfQRqY5OWzHLns+66q45swOmUyvutfOfD9NCApII6IiBRN6gzjXN8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kWw1UmwGqUESW7ggDrv1ceNkrPaLCC1kbTuZUZs7DBN8I6dSljxAhj6AJ0zX9RFPGHAjaSCRg9aNp5+OVshwZPLvZ/4t31O+6gNtAyP7DL4J2uBmJS2QVf07BEOU1tVR5D3YD8cQTgmTxUeOkVRCeMXIY7CdYFAnf+aaX1312SQ=
Received: by 10.67.20.11 with SMTP id x11mr506872ugi.1195442313220;
        Sun, 18 Nov 2007 19:18:33 -0800 (PST)
Received: by 10.66.250.13 with HTTP; Sun, 18 Nov 2007 19:18:33 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65401>

git used to be really good at merging 2 branches that had gotten the
same code added independently. Right now, both master
(1.5.3.5.737.gdee1b)
and next (9445b41) are telling me that the exact same file (same
sha1), with the same mode added on 2 branches is a merge conflict. On
_one_ of the branches there is an extra commit.

Hmmm.

I am pretty sure that early git (pre 1.0) could handle this correctly.
I remember sending git-archimport to Junio and immediately doing 3 or
4 commits on top, and having the next pull work correctly without
conflict because the merge machinery spotted the "last common sha1"
for that file and saw that only one side had changed since then.

Happens with recursive and resolve. Happy to provide a minimal repro
case, but I think this is fairly obvious...

cheers,



martin
