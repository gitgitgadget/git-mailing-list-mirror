From: Heikki Orsila <shdl@zakalwe.fi>
Subject: Re: [PATCH] Make core.sharedRepository more generic (version 2)
Date: Tue, 15 Apr 2008 04:22:49 +0300
Message-ID: <20080415012249.GJ31039@zakalwe.fi>
References: <20080412195754.GA15091@zakalwe.fi> <7v3apo7zfg.fsf@gitster.siamese.dyndns.org> <20080415004310.GI31039@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Heikki Orsila <heikki.orsila@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 03:24:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlZtw-0005vQ-FQ
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 03:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757159AbYDOBWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 21:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757128AbYDOBWv
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 21:22:51 -0400
Received: from zakalwe.fi ([80.83.5.154]:45508 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756612AbYDOBWv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 21:22:51 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id EBEE32C331; Tue, 15 Apr 2008 04:22:49 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <20080415004310.GI31039@zakalwe.fi>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79554>

On Tue, Apr 15, 2008 at 03:43:10AM +0300, Heikki Orsila wrote:
> On Mon, Apr 14, 2008 at 05:08:03PM -0700, Junio C Hamano wrote:
> > > +		 * of git. Note, we use octal numbers.
> > >  		 */
> > > -		sprintf(buf, "%d", shared_repository);
> > > +		sprintf(buf, "0%o", shared_repository);
> > 
> > Unconditionally doing this makes the resulting repository unusable by git
> > 1.5.5 and older, even when the user wanted to use the bog standard "git
> > init --shared".  You can limit the extent of damage if you continue
> > writing PERM_GROUP and PERM_EVERYBODY out as 1 and 2, and use the new
> > octal notation only when the user used the settings allowed only with new
> > git.
> 
> I submitted a new patch that should address all the points.

Submitted another version that really fixes the o+w case. Forgot 
the 0664 mask there. Now it's 0666.

-- 
Heikki Orsila
heikki.orsila@iki.fi
http://www.iki.fi/shd
