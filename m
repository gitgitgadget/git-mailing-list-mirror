From: skillzero@gmail.com
Subject: git merge and cherry-pick and duplicated commits?
Date: Tue, 13 Jan 2009 18:40:53 -0800
Message-ID: <2729632a0901131840v5c7ce0c7l3f87c03caabf68de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 03:42:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMvhz-0005nb-OL
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 03:42:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbZANCk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 21:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbZANCk4
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 21:40:56 -0500
Received: from rn-out-0910.google.com ([64.233.170.188]:55851 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653AbZANCkz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 21:40:55 -0500
Received: by rn-out-0910.google.com with SMTP id k40so293500rnd.17
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 18:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=kNRUucCtMQbZr08eTSCCAzl/kod5OVhIC1ojqYXcit0=;
        b=NvPiW6ZEeu7zkQ0NKxGYJ7X2SvQFEkSqMTc0gHB+UrTM9BNL2n5A7CvhZ9KD4amOAI
         OWlTT6eYm7J7ELlUoYcaNiw5YZe4O6H/Mu2MAOKz2zK/A2pnIV6vWz4kFBmf6lTdRxy9
         0iDF9xZGdgFSZMI0kuzqJJ85FPrI4cLbDmNtk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=xEzPEFbkHwxcdph9vpvtZG0CkXxTqxAO5y6eJ9sm5aGFP19lA2SKICh33q9rxliEn6
         xWwvgJjrE0WP48T9sh6W5Z0V2cJVFvU2n26iRxYqnZGHWdQPhuJfGzzpZEP8FmgaEqHE
         oXpt7mO+qUDugLyBamUQtb5UjXnDJ+zeDlTAA=
Received: by 10.65.234.18 with SMTP id l18mr20990388qbr.22.1231900853659;
        Tue, 13 Jan 2009 18:40:53 -0800 (PST)
Received: by 10.64.242.15 with HTTP; Tue, 13 Jan 2009 18:40:53 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105577>

I created a branch from master, did a commit (8e9fdd), then did 2 more
commits (11c59c and 7024d), then did another commit (2daf23). From
master, I did a commit (47bd1b) then cherry-pick'd 2 commits from the
branch (11c59c and 7024d). When merged the branch into master, I see
the 2 cherry-picked commits twice in the log (once from the original
cherry-pick's and again from the merge).

I thought git would realize that master already had those 2 commits
and not add them again when merging?
