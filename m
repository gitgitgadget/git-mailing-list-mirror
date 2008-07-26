From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: how about removing --exec-path?
Date: Sat, 26 Jul 2008 08:48:31 +0200
Message-ID: <20080726064831.GA3698@blimp.local>
References: <20080725094015.GA22077@blimp.local> <alpine.DEB.1.00.0807260448210.26810@eeepc-johanness>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 26 09:07:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMdsR-0007G2-Q6
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 09:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbYGZHGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 03:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbYGZHGj
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 03:06:39 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:17839 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbYGZHGj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 03:06:39 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20tf50K7
Received: from tigra.home (Fad3c.f.strato-dslnet.de [195.4.173.60])
	by post.webmailer.de (mrclete mo30) (RZmta 16.47)
	with ESMTP id n06eddk6Q3AXbK ; Sat, 26 Jul 2008 09:06:33 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 04693277BD;
	Sat, 26 Jul 2008 08:48:31 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id D062736D18; Sat, 26 Jul 2008 08:48:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807260448210.26810@eeepc-johanness>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90187>

Johannes Schindelin, Sat, Jul 26, 2008 04:49:06 +0200:
> On Fri, 25 Jul 2008, Alex Riesen wrote:
> 
> > The thing has at least this problem: is not passed to upload-pack when
> > running fetch.
> 
> It should be added to PATH, and so it is passed to upload-pack, amongst 
> others, in a sense.
> 

Yes, but next time upload-pack runs a program, it adds builtin exec
path to PATH (because --exec-path not given to transport's uploadpack
command). So it looks like this:

    $GIT_EXEC_PATH:/usr/local/libexec/git-core:/orig/exec-path:\
    $GIT_EXEC_PATH:/usr/local/libexec/git-core:$ORIG_USER_PATH

which kind of useless for debugging. So using GIT_EXEC_PATH is the
only way (and why did we need more? Working around something?)
