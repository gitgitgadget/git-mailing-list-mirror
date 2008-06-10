From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Date parsing
Date: Tue, 10 Jun 2008 16:58:27 +0200
Message-ID: <bd6139dc0806100758xb41d08dh18e3051088b707e5@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 10 16:59:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K65Ji-0007Ge-LX
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 16:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974AbYFJO62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 10:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753887AbYFJO62
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 10:58:28 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:2686 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274AbYFJO61 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 10:58:27 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2625180wfd.4
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 07:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=c9O+63gZ3i7O11YOVLejtSUj/FoeWtzp3LmUp4UqxJo=;
        b=YmPE0pWdn/yau4B/XnOfoVNCqg4BTHk0VDXmU8jY/iG8TZK1o34r4bqD04NdOCpHN4
         uY8iEiyGMsxs9GKGgOQalOicsh9H1VUwrD8W2agkrOBZp9ejGW5/qTXwMDnxxfDTROg3
         BOiejZbuwdGnTiymJoOEBoMq2VEahq0rqiTg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=m0JfsEbvEpJMO/7pQCx8qALXF15LoTvtgb/S+N7c57Y1BQU8nNbET3fHKDgcSLb4cx
         aCKccKYrMXnfLyI8/hu79Ifg3bH7IUaCwBsIoGOx3hVoNVgzRDXXda+7P9T1RXC6zrjY
         3xAvBhHM+F0URraoKnQXIt2NgY5pm2IDmXUg8=
Received: by 10.142.238.12 with SMTP id l12mr145592wfh.204.1213109907196;
        Tue, 10 Jun 2008 07:58:27 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Tue, 10 Jun 2008 07:58:27 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84512>

Heya,

I noticed that we parse
GIT_COMMITTER_DATE="31-05-2008 11:30pm" as "31st of July at 23:30 +0200"
whereas we parse
GIT_COMMITTER_DATE="01-06-2008 11:30pm" as "6th of January at 23:30 +0100"

Not only is it strange that we accept both orders (since apparently we
don't resort to the latter order unless the first digit > 12), but
it's also weird that the timezone changes based on which option was
chosen! What does the list think about this? Is this "normal"
behavior? If not, what (if anything) should we do about it?

-- 
Cheers,

Sverre Rabbelier
