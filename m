From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Produce a nicer output in case of sha1_object_info
	failures in ls-tree -l
Date: Thu, 19 Mar 2009 23:00:21 +0100
Message-ID: <20090319220020.GA8433@blimp.localdomain>
References: <20090319203002.GA31014@blimp.localdomain> <7v4oxp89eb.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 23:02:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkQJR-0002UP-EP
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 23:02:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753074AbZCSWAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 18:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752471AbZCSWAc
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 18:00:32 -0400
Received: from mout4.freenet.de ([195.4.92.94]:43310 "EHLO mout4.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751892AbZCSWAc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 18:00:32 -0400
Received: from [195.4.92.11] (helo=1.mx.freenet.de)
	by mout4.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #76)
	id 1LkQHp-0007hV-Nc; Thu, 19 Mar 2009 23:00:25 +0100
Received: from x62b3.x.pppool.de ([89.59.98.179]:50010 helo=tigra.home)
	by 1.mx.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 587) (Exim 4.69 #79)
	id 1LkQHp-0002bM-Fz; Thu, 19 Mar 2009 23:00:25 +0100
Received: from blimp.localdomain (blimp.home [192.168.1.28])
	by tigra.home (Postfix) with ESMTP id 6B5D6277D8;
	Thu, 19 Mar 2009 23:00:21 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 2CB4C36D27; Thu, 19 Mar 2009 23:00:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v4oxp89eb.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113844>

Junio C Hamano, Thu, Mar 19, 2009 22:55:56 +0100:
> Alex Riesen <raa.lkml@gmail.com> writes:
> > @@ -91,6 +90,7 @@ static int show_tree(const unsigned char *sha1, const char *base, int baselen,
> >  	if (!(ls_options & LS_NAME_ONLY)) {
> >  		if (ls_options & LS_SHOW_SIZE) {
> >  			if (!strcmp(type, blob_type)) {
> > +				unsigned long size = 0;
> >  				sha1_object_info(sha1, &size);
> >  				printf("%06o %s %s %7lu\t", mode, type,
> >  				       abbrev ? find_unique_abbrev(sha1, abbrev)
> 
> Hmm, shouldn't you be checking the return value from sha1_object_info()
> and skipping the printf() altogether instead?

But then I cannot know the name of the failed tree entry.
