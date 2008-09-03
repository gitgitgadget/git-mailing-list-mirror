From: Ittay Dror <ittay.dror@gmail.com>
Subject: Merge only complete commits
Date: Wed, 03 Sep 2008 16:52:58 +0300
Message-ID: <48BE96BA.1000106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 03 15:54:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kasoe-0000kS-M9
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 15:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbYICNxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 09:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752032AbYICNxa
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 09:53:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:46181 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbYICNx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 09:53:29 -0400
Received: by ug-out-1314.google.com with SMTP id c2so1845893ugf.37
        for <git@vger.kernel.org>; Wed, 03 Sep 2008 06:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=igZh7wwVwWqH+S4ccLqKXNm22pr3zCxcqOdzaLlVCj0=;
        b=lCW+ZuYHczsTWSNHI8Pzdqy4/jrU36GzV3/Qj1/6aK8OWPCGDctHzFXZMaiv7UfAUN
         /sU+B+LWYnyqusD+x4hWRFP3Sl/r4MuJjLewa/l7bynTUVUGT41CEvxD1Ri1fMu/F/zo
         FcjOTaruz8Q/T1L/yMC6vZA2mJDowdWQrVK0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=kCJzPyA+v82RaBPOyGwcd6Wb/YIvfmIWv5eP6oigXk/PZmzOwXS+EEmT6yopDyD6VF
         6+E2eLlckNKmxUKDU7A2PLBftyJzWTDOnOJA/3ucqkx3cdCa0dkZ/HoH622Z7GABomN6
         GuRPZdApQuKoq1ndL2I6lV2Gj4+DD2eW6ghNU=
Received: by 10.67.27.3 with SMTP id e3mr5229735ugj.74.1220450007604;
        Wed, 03 Sep 2008 06:53:27 -0700 (PDT)
Received: from ?10.10.2.7? ( [212.143.191.180])
        by mx.google.com with ESMTPS id b39sm22257505ugf.41.2008.09.03.06.53.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Sep 2008 06:53:26 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94795>

Hi,

Starting with '12345678', one branch creates a change '1A345678', the 
other '1B345C78'. Merging of the branches will result in '1<A=B>345C78'.

But isn't it logical to assume that if changes 'B' and 'C' were done in 
the same commit, then they are related and so a conflict in one 
implicitly means a conflict in the whole commit?

Of course, in a case of a single file, with a single commit, it is easy 
to detect. But what if there have been a history of commits before the 
merge, or if several files were changed?

Maybe help me find the commit by including them in the RCS conflict 
markers?

Ittay


-- 
--
Ittay Dror <ittay.dror@gmail.com>
