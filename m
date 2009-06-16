From: Aneurin Price <aneurin.price@gmail.com>
Subject: Transplant branch from one repo to another
Date: Tue, 16 Jun 2009 22:30:34 +0100
Message-ID: <501db8660906161430o25a0c18aw41758390dc171702@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 16 23:31:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGgFs-0005sa-NV
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 23:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763908AbZFPVaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 17:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763836AbZFPVad
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 17:30:33 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:55353 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763675AbZFPVac (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 17:30:32 -0400
Received: by yw-out-2324.google.com with SMTP id 5so3133734ywb.1
        for <git@vger.kernel.org>; Tue, 16 Jun 2009 14:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=x1qJv+n5oTnqPRlZcp19qd6aWS6idUrrERnxtwPQuHs=;
        b=SBC+sDzpAV2ro1Y5qhU6y8nSnlhreaoPrOcVg/waRFVVIy80eJm9tNdVuVndyjYQkc
         3eAeZIV52XVfxfoxpBLENkvUyKLE+1f30HW/HLr88ajKXfxb0VGKPMCY1MYNuYELLimx
         fdHJKPvCm6/lUt4sPW6roXAyK6xgkBRvwGkf4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=oRPjykBZ4ZBtfmpMIFIFZ5Eyqg+PSiumMivGzXy58vWtNF2LuB4RrNaYsCgKauGhP/
         CNh6W/UW/ZpumO/tRB6o4M9fMD2gH0HnllD646WxyD2FVjeS5lKv2b4SddK/t3J9hNDA
         pU724r4lxgcbo9TPWGH/ovE2jRze7s5w/PEbE=
Received: by 10.151.6.17 with SMTP id j17mr16467913ybi.318.1245187834435; Tue, 
	16 Jun 2009 14:30:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121715>

Hello all,

I have a repository cloned from SVN using 'git svn clone http://servername/path
-T trunk -b branches -t tags', or thereabouts, and I've since realised that I
would have been better off with 'git svn clone
http://servername/path/trunk/subdir', as I don't really care about any other
branches, or about the contents of the svn repository outside of 'subdir'.

I have one branch from trunk in which I've been working, which includes one
merge from trunk. I'm interested in how I might be able to get the content of
that branch and transplant it onto the new svn clone, starting at the equivalent
parent commit (ie. the same svn revision). The merge was only a few commits away
from HEAD, so I can manually redo that last part if it complicates things too
much.

I've been thinking about something involving 'filter-branch
--subdirectory-filter' followed by a fast-export on the source, and then a
fast-import on the destination, but I'm not sure I'm going about this the right
way and would appreciate any advice anyone can give me.

So, does anybody have any suggestions for how I should do this?
Thank you for your time,
Nye
