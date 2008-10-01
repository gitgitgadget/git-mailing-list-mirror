From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH (GIT-GUI,GITK) 0/8] Encoding support in GUI
Date: Wed, 01 Oct 2008 13:35:34 +0200
Message-ID: <48E36086.7050504@viscovery.net>
References: <1221685659-476-1-git-send-email-angavrilov@gmail.com> <18646.53492.20994.908025@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alexander Gavrilov <angavrilov@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 13:36:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl00e-0004UF-Vx
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 13:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271AbYJALfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 07:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753269AbYJALfi
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 07:35:38 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:37363 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753239AbYJALfh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 07:35:37 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KkzzS-0006f4-Ja; Wed, 01 Oct 2008 13:35:34 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5119254D; Wed,  1 Oct 2008 13:35:34 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <18646.53492.20994.908025@cargo.ozlabs.ibm.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97218>

Paul Mackerras schrieb:
> Alexander Gavrilov writes:
>> 3) It can be further set on per-file basis by specifying
>>    the 'encoding' attribute in gitattributes.
> 
> I haven't used .gitattributes before, but I would expect that the
> .gitattributes files would be stored in the repository along with
> everything else.  If that's the case, then for gitk at least there is
> the question of which version of a given .gitattributes file one
> should use when viewing the tree for a commit which isn't the
> currently checked-out commit - do you use the version from that tree,
> or the version in the working directory?  We seem to be using the
> latter at present, and caching the results.  Is there a philosophical
> reason to do that, other than speed?

I understand your concerns that an encoding may be picked from the "wrong"
.gitattributes file. But in practice it doesn't matter much, and picking
the attribute from a past commit's tree would even be counter-productive:

I'm about to add a .gitattributes file that specifies the encoding for
some of my files *today* because I was not clever enough to anticipate the
usefulness of an "encoding" attribute a year ago when those files were
added to the repository. When I browse history, I *do* want that *today's*
encoding is picked.

> (Also it seems that we won't
> notice if the user changes .gitattributes after we've looked at it, or
> if they create one after we've looked for one and not found it.)

This is not a show stopper, IMHO. The user will notice soon enough, and
can restart gitk. Nobody sane will change the encoding attributes every hour.

That said, a menu command to flush the attribute cache would be useful
every now and then.

-- Hannes
