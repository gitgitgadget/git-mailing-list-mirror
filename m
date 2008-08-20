From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 2/2] Honor ~/.ssh/config whenever possible during
	SSH based transport
Date: Wed, 20 Aug 2008 13:38:18 -0700
Message-ID: <20080820203818.GL3483@spearce.org>
References: <1218821705-2631-1-git-send-email-spearce@spearce.org> <1218821705-2631-2-git-send-email-spearce@spearce.org> <200808202234.08348.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 22:39:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVuSi-0001ni-Qf
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 22:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755420AbYHTUiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 16:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755419AbYHTUiT
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 16:38:19 -0400
Received: from george.spearce.org ([209.20.77.23]:33513 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755401AbYHTUiS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 16:38:18 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2C20C38375; Wed, 20 Aug 2008 20:38:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200808202234.08348.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93040>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> fredagen den 15 augusti 2008 19.35.05 skrev Shawn O. Pearce:
> > +	private void addIdentity(final File identityFile)
> > +			throws JSchException {
> > +		final String path = identityFile.getAbsolutePath();
> > +		if (loadedIdentities.add(path))
> > +			provider.getJSch().addIdentity(path);
> >  	}
> 
> Ok, this breaks 3.3 compatibility and I accidentally pushed it to master. Now Marek also
> has stuff that only works (well) with 3.4 becaujse of bugs in 3.3, that won't be fixed. So maybe
> we'd better skip 3.3 in order to work faster. I.e. I won't revert this commit, but I am willing to
> accept a patch to "fix" it in order to prolong 3.3 compatibilty.

I agree.  But I'm not going to be supplying that fix myself.  I don't
want to spend a lot of time messing around with the SSH transport,
that was just annoying me one morning.

-- 
Shawn.
