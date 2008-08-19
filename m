From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [FYI] How I compile on SunOS 5.7 with the SUNWspro compiler
	and ksh
Date: Tue, 19 Aug 2008 08:13:47 +0200
Message-ID: <20080819061346.GA4046@blimp.local>
References: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Aug 19 08:16:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVKVu-0000Rp-0S
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 08:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974AbYHSGNv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 02:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753035AbYHSGNu
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 02:13:50 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:26081 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951AbYHSGNu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 02:13:50 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r44hO88yw==
Received: from tigra.home (Fa968.f.strato-dslnet.de [195.4.169.104])
	by post.webmailer.de (fruni mo18) (RZmta 16.47)
	with ESMTP id 506c7dk7J4ZoOY ; Tue, 19 Aug 2008 08:13:47 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 94A70277AE;
	Tue, 19 Aug 2008 08:13:47 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 2716936D1A; Tue, 19 Aug 2008 08:13:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92813>

Brandon Casey, Tue, Aug 19, 2008 01:39:40 +0200:
> 
> GIT_SKIP_TESTS='
>    t3900.1[0-289] t3900.2[023]
>    t3901.*
>    t5000.1[0-24-689] t5000.2[01]
>    t5100.[56] t5100.1[02]
>    t6030.1[2-9] t6030.2[0-9]
>    t9301.4
> '
> 
> GIT_TEST_CMP='cmp -s'
> 
> PATH="/usr/xpg4/bin:$PATH"
> 
> export PATH GIT_TEST_CMP GIT_SKIP_TESTS
> 
> exec gmake \
>     CC=/opt/SUNWspro/bin/cc \
>     INSTALL=ginstall \
>     TAR=gtar \
>     CFLAGS='-fast' \
>     NO_CURL=1 \
>     NO_OPENSSL=1 \
>     NO_TCLTK=1 \
>     NO_PERL_MAKEMAKER=1 \
>     THREADED_DELTA_SEARCH=1 \
>     "$@"

You can put all of it in config.mak. It is exactly what it is there
for: build customizations.
