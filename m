From: Shaun Cutts <scutts@entropycap.com>
Subject: submodules for different deployment directories?
Date: Thu, 19 Mar 2009 04:33:04 -0400
Message-ID: <F042F333-32C4-4B0E-AB1A-4524AB1D9654@entropycap.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 19 09:34:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkDiD-0006Bk-Dt
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 09:34:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755028AbZCSIdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 04:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753483AbZCSIdU
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 04:33:20 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:1710 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700AbZCSIdT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 04:33:19 -0400
Received: by yx-out-2324.google.com with SMTP id 31so434854yxl.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 01:33:17 -0700 (PDT)
Received: by 10.100.229.12 with SMTP id b12mr2499870anh.52.1237451596948;
        Thu, 19 Mar 2009 01:33:16 -0700 (PDT)
Received: from ?192.168.0.115? (dsl092-072-228.bos1.dsl.speakeasy.net [66.92.72.228])
        by mx.google.com with ESMTPS id d38sm1873369and.9.2009.03.19.01.33.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Mar 2009 01:33:16 -0700 (PDT)
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113733>

Hello,

We are currently migrating from svn....

We have a growing project that is deployed differently in various  
places. The deployment-specific stuff is in a subdirectory called  
"deployment".

In svn, we used svn switch to point that subdirectory at a different  
tag. Then "update" on the overall tree left alone the switched parts  
at the various different installations. We could "push" changes in any  
overall copy of the project and the differences between the switched  
subdirectories would be immaterial.

It would seem (to me at least) that the equivalent functionality is  
provided by "submodule" in git.

Accordingly I started a separate project with different branches  
corresponding to the different deployment models.

I added this a submodule to the main project. In fact, we are thinking  
of organizing some other things that differ by install this way, so I  
made the actual directory a subdirectory of the "deployment" project,  
which I "submodule added" to the various installations as a submodule  
off the root repository, then used "ln -s"  to link that subdirectory  
into the appropriate place in the overall tree. (Is this a mistake?)

However, I'm not sure its working right. It seems that the various  
overall repositories differ, even if only really the submodule's  
branch differs. Also a diff comes up with lots of differences between  
the submodules's trees. (Aside: where is the branch of the submodule  
written down in the overall module -- if you add with -b... is this  
just "transient info"?) But I thought that the idea of submodules were  
that they are opaque?

I would enjoy help figuring out what is going on. I would be most  
grateful, however, to learn how I'm *supposed* to do in this situation.

-- Shaun Cutts

----------------
Shaun Cutts
Partner
Entropy Capital, LLC
scutts@entropycap.com
