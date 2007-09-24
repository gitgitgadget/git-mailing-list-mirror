From: Russ Brown <pickscrape@gmail.com>
Subject: git-svn: Deleting directories
Date: Mon, 24 Sep 2007 09:04:26 -0500
Message-ID: <46F7C3EA.2080806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 24 16:04:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZoYH-0003Qp-Pn
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 16:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbXIXOEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 10:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754746AbXIXOEk
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 10:04:40 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:60331 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbXIXOEj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 10:04:39 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1214991wxd
        for <git@vger.kernel.org>; Mon, 24 Sep 2007 07:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        bh=jHMP7Ld4/FPXAvfP+TPLOx9wYlFB1th0IABE6d1was8=;
        b=Dn0AEg2r1rJENHZ/PpSeJCUy0Bu3LM5aCBYgAkYNvIgubW0mslM/IHn7ajGUp7BzYBBHB/NfLrlj5QZzkB+WfPXdbLNNgBtHOj6ingU+SYPy2wtppaHm6ZjPHravc4a2DKSBzz2TBepQetRvsSpZFN8Bltb6kqtPbeGqnSbqjS4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=QjltSmIunSl/rvMb7dbFzN+ijtMD5ROEDeK+MiWZil30fPGTPTDmosngfNBnRFbmmZHMs3M/AhIa0GTPLSm0b1pGdwmbszuVDQ445Dfz77S8x77qis/vjb2uazW7iMjUFi6E7zI+nZpbFmWwQlo/RFz5zLwlSE84Ud/jnVrg1EE=
Received: by 10.90.92.10 with SMTP id p10mr5595297agb.1190642676683;
        Mon, 24 Sep 2007 07:04:36 -0700 (PDT)
Received: from ?192.168.0.100? ( [71.170.181.151])
        by mx.google.com with ESMTPS id o61sm944301hsc.2007.09.24.07.04.33
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 24 Sep 2007 07:04:35 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070807)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59049>

I've just noticed that when deleting entire directory trees in git, when
the dcommit happens only the files in that trees get deleted, which
leaves a 'ghost town' of a directory tree with folders but no files,
which will no doubt have somewhat confused my svn-using colleagues.

This is obviously an interoperability problem, but I understand that git
does not track folders and is so tricky to fix.

The question though is how to handle it. Ideally, dcommit will detect
that an entire directory has gone and send through a changeset which
deletes just that one directory, instead of the current behaviour of
explicitly deleting every file in the directory but leaving the
directories themselves intact.

-- 

Russ
