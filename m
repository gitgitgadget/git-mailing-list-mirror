From: "Leo Razoumov" <slonik.az@gmail.com>
Subject: [BUG] git log --walk-reflogs --pretty=oneline --all
Date: Thu, 30 Oct 2008 11:19:57 -0400
Message-ID: <ee2a733e0810300819r373ce1eeta335a39a0fcb77df@mail.gmail.com>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 30 16:21:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvZKp-0007Mu-Tl
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 16:21:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754959AbYJ3PT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 11:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754857AbYJ3PT7
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 11:19:59 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:52483 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754855AbYJ3PT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 11:19:59 -0400
Received: by fg-out-1718.google.com with SMTP id 19so532146fgg.17
        for <git@vger.kernel.org>; Thu, 30 Oct 2008 08:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=6/LPnakXSknyAEDVGzuC9n8uUwQZ8g4YQMiK/3VIUpQ=;
        b=Bd9F3cHzf3/1Q3ep2I+i9/wjoURD//Q7EtlIRIUfXFtBRSOlHtDvFi0+gBSsMpLzKL
         cEcpY9qm2wKybCTmQ5UTYp13X0CKo3r/gSNwQ7Skex5fV7tR9oYxUY9+ep6CrfQ4MFRI
         NrU95Wgcn7NMlAFj2rETGexuvsvbBrtGNBKbk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=vb1mCFgXxa+xFAxTZWKbfvCGHStmlAp4eC1cECmIOCkOh1T94YsNSx4zG0CEbP4FXe
         4oEYz6068cP1YZ1oUfiNu5nExOXZUvtLErZmkix8hfr1eNYFCsfpqw7ECvaEvdMoCoYH
         0S2deY2lCiFpseb6ydP75Jfo/TYj4n1V5fZcY=
Received: by 10.181.229.12 with SMTP id g12mr351356bkr.176.1225379997278;
        Thu, 30 Oct 2008 08:19:57 -0700 (PDT)
Received: by 10.181.7.8 with HTTP; Thu, 30 Oct 2008 08:19:57 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99487>

Take a test repository that already has several commits in it, do the
following and watch the results:

sh$ git reflog expire --expire=1.second.ago --all
sh$ git log --walk-reflogs --pretty=oneline --all

I am using git-1.6.0.2 and that's what I get

sh$ git reflog expire --expire=1.second.ago --all
sh$ git log --walk-reflogs --pretty=oneline --all
60684d9df4193d91ef679173ef211275b9ad457f
810948facab2268139a1d4aac1368282e5ef1a9a
56f321d71b1bf6180977e9e3ff23836350ea2921 020
9e7f5cfb0fa20c44747f3d9111ccf161a2892
6160d0084fb8b02c3c1b5f1dd835d921d53ec86a
84de8b17fcab52a9c00587b81eb043c8614b37c5 68762f
c23396e88e8ef8a1497d4f340a1bd69fa4
96bb86bfdd5f506ef233608c2ca8d58a13c834dd
287c7e907cd41dba25454d5708262e73a80c2bbb 2fcde3a98
09755d33f4b4093b1f2ef319f7ebe36
8e5b9847a38905e9d921d231c712c54720a4de5a
6ecfbc2bde9b771fba56d4b85ad2952b4fe0405c 0b71dc288ac2
af4a2670e608c22e26beee272fd0 455601d6f414e400bfabb6410074b6ebee2696e0
e78e5c0b98dfd44cc9e1e5d56a1e094d295a7c97

First of all, this log's content is next to zero. Secondly, all
reflogs are already empty and I expected no output at all.

--Leo--
