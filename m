From: Jon Smirl <jonsmirl@gmail.com>
Subject: Wrong conflicts on file splits
Date: Mon, 4 May 2009 08:53:11 -0400
Message-ID: <9e4733910905040553u377ab11n1609d980021be498@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 04 14:59:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0xlR-0002n1-TW
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 14:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754507AbZEDM7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 08:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754008AbZEDM7N
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 08:59:13 -0400
Received: from mail-qy0-f133.google.com ([209.85.221.133]:32995 "EHLO
	mail-qy0-f133.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754002AbZEDM7M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 08:59:12 -0400
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 May 2009 08:59:12 EDT
Received: by qyk39 with SMTP id 39so27258qyk.33
        for <git@vger.kernel.org>; Mon, 04 May 2009 05:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=v4D+QqTpJXAeFA1AfrdEUnveGP2+NZS5o5qOU6Wszik=;
        b=u7Kb5d62domdLGFJtZMb7Ph2mpPGR/nxl7kdjbUC//KwnwUrQB52RD5kjFsejMDzQM
         fNLek+318PZD+fB3oawatK24Qk3FwIl5BWAZbRbnRMGZbvRDvbdni2daW3qlWdHGJfdu
         TpEMzsW29KjE8MB70ukX1/SFT6zjbear1bNCg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=GNQxgVc0+uJuTkY2t8I7nz//yre0D5KE2hkWFBd0amyLccJeEQo6vNaj9G+ZBtIDzq
         D/OSaRBOmGjOtgsx2c97MabSdA9oj/x89jXVtTkZdnKaqS21L7Sg5w1DkknlklLPdoAu
         g7/PqzMxsgQdzgku3dmDMCB3t+YyShzW4okQo=
Received: by 10.220.74.81 with SMTP id t17mr9140381vcj.56.1241441591290; Mon, 
	04 May 2009 05:53:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118230>

I keep running into this problem, is there anything I can do to make
it better? I'm using stgit but this is a problem in git itself.

I have a patch that splits file A into two files, A and B.
Now I merge with another tree and bring in a one line fix to A.
The fix touches the pre-split file A in a section that is going to end up in B.
Next I re-apply the patch that splits A into A and B.

This results in a large conflict in the post split file A.
And no patch being applied to file B which is where the fix belongs.

Repeat this process with a multi-line fix and the whole automated
merge process breaks down and I have to carefully figure everything
out by hand.

The merge process seems to be unaware of the newly created file B. No
patches or conflict ever end up in it.

-- 
Jon Smirl
jonsmirl@gmail.com
