From: "Quim K. Holland" <qkholland@gmail.com>
Subject: git cat-file blob does not convert crlf
Date: Thu, 27 Nov 2008 01:34:56 +0600
Message-ID: <20081127013456.6117@qkholland.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 26 20:36:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5QB3-0000WW-Q8
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 20:35:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbYKZTej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 14:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752691AbYKZTej
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 14:34:39 -0500
Received: from qb-out-0506.google.com ([72.14.204.235]:17347 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482AbYKZTej (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 14:34:39 -0500
Received: by qb-out-0506.google.com with SMTP id f11so619738qba.17
        for <git@vger.kernel.org>; Wed, 26 Nov 2008 11:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :mime-version:content-type:content-transfer-encoding:message-id;
        bh=bpyMblxIc4DyrKn9g8Y/7Usl7+2YxuhKzMBOSbiPwHA=;
        b=AGVftEjNTaJguPy5ru/NDp3GYwiBxa63TDZgVdVE4tFNGO5VIgJYBLTo2CAAYS3ie3
         pWlhntzA7kTgXlOr3vxL8JainIlyUQiTF1hoU7klTFnQxV/lwaKs2u6nRgWija103Ar4
         xCMEyra2gkg94JDiMXjpg9b7x4TxbWv888+hE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:mime-version:content-type
         :content-transfer-encoding:message-id;
        b=Yf0HnN6WhI0B9x7p+qFHdxK08K3YdvDuCerD8JDKcz+UX1Ts8hlilcZja9mungX7B5
         Ury/n2OJgW+SduB5TBMC/urDMinQ+xBaqKdbGNm9+lGZAOPEpJTeZWRJWJQaYPB5NHeC
         0wjKmGdg3AYVIVJADzNhN+kdEN9T1RhWPvilM=
Received: by 10.210.40.10 with SMTP id n10mr6417351ebn.102.1227728077300;
        Wed, 26 Nov 2008 11:34:37 -0800 (PST)
Received: from 8889.smtp.gmail.com ([212.62.97.23])
        by mx.google.com with ESMTPS id 3sm1071987eyj.31.2008.11.26.11.34.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 Nov 2008 11:34:36 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101759>

I think git is buggy.
I wanted to discard the changes I made to my file by checking out a copy from the last commit, so I said
% git cat-file blob HEAD:my-file >my-file
But this does not respect core.autocrlf and the file becomes one long line.
Also it feels stupid that I have to say my-file twice at the command prompt.
