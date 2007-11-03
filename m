From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Reuse previous annotation when overwriting a tag
Date: Sat, 3 Nov 2007 14:59:54 +0100
Organization: glandium.org
Message-ID: <20071103135954.GA26204@glandium.org>
References: <1194082273-19486-1-git-send-email-mh@glandium.org> <Pine.LNX.4.64.0711031148460.4362@racer.site> <20071103122707.GA7227@glandium.org> <Pine.LNX.4.64.0711031236160.4362@racer.site> <20071103131030.GA18670@glandium.org> <Pine.LNX.4.64.0711031321320.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 03 15:01:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoJZA-00045i-Gv
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 15:01:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185AbXKCOBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 10:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754141AbXKCOBX
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 10:01:23 -0400
Received: from vawad.err.no ([85.19.200.177]:49705 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754050AbXKCOBW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 10:01:22 -0400
Received: from aputeaux-153-1-33-156.w82-124.abo.wanadoo.fr ([82.124.3.156] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IoJYl-0005Xp-OK; Sat, 03 Nov 2007 15:01:14 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IoJXX-0007yM-EX; Sat, 03 Nov 2007 14:59:57 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711031321320.4362@racer.site>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63273>

On Sat, Nov 03, 2007 at 01:22:44PM +0000, Johannes Schindelin wrote:
> Hi,
> 
> On Sat, 3 Nov 2007, Mike Hommey wrote:
> 
> > On Sat, Nov 03, 2007 at 12:36:36PM +0000, Johannes Schindelin wrote:
> > 
> > > On Sat, 3 Nov 2007, Mike Hommey wrote:
> > > 
> > > > On Sat, Nov 03, 2007 at 11:54:38AM +0000, Johannes Schindelin wrote:
> > > > > Why not teach write_annotations() (or write_tag_body() like I 
> > > > > would prefer it to be called) to grok a null_sha1?  It's not like 
> > > > > we care for performance here, but rather for readability and ease 
> > > > > of use.
> > > > 
> > > > By the way, I think it would be much better if this function was 
> > > > made more generic and would not write, but return an strbuf 
> > > > containing the object body. It could also be used by e.g. git-commit 
> > > > --amend.
> > > > 
> > > > What would be the best suited place for such a function ?
> > > 
> > > editor.c, I'd say.
> > 
> > On which topic is this ?
> 
> On none so far.  But the plan was to move some functions used by both 
> builtin-tag and builtin-commit (such as launch_editor()) into the files 
> editor.[ch].
> 
> Unfortunately, that plan has not been executed by anybody.  Yet.

Anyways, I took a quick glance at builtin-commit.c on pu, and it doesn't
look like it would benefit from having a shared function to get the
commit body. So I'll just forget about this idea for now.

Mike
