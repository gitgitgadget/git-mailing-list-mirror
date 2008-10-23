From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH 2/3] Add -n/--no-prompt option to mergetool
Date: Thu, 23 Oct 2008 07:44:55 +0100
Message-ID: <20081023064455.GA10675@hashpling.org>
References: <1224583999-26279-1-git-send-email-charles@hashpling.org> <1224583999-26279-2-git-send-email-charles@hashpling.org> <48FDC1CA.2080800@op5.se> <20081021122655.GA29294@hashpling.org> <20081022211720.GA23146@hashpling.org> <7vr668tdvy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	William Pursell <bill.pursell@gmail.com>,
	Andreas Ericsson <ae@op5.se>, "Theodore Ts'o" <tytso@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 08:46:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kstxa-00068h-5F
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 08:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756086AbYJWGpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 02:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756031AbYJWGpE
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 02:45:04 -0400
Received: from fhw-relay07.plus.net ([212.159.14.148]:45174 "EHLO
	fhw-relay07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756060AbYJWGpB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 02:45:01 -0400
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by fhw-relay07.plus.net with esmtp (Exim) id 1KstwI-0000cg-6q; Thu, 23 Oct 2008 07:44:58 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id m9N6ivlt011129
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 23 Oct 2008 07:44:57 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id m9N6itld011128;
	Thu, 23 Oct 2008 07:44:55 +0100
Content-Disposition: inline
In-Reply-To: <7vr668tdvy.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: b0b6536a7c2727856254b0e85f3caab5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98943>

On Wed, Oct 22, 2008 at 04:21:21PM -0700, Junio C Hamano wrote:
> Charles Bailey <charles@hashpling.org> writes:
> 
> > I'm pretty keen on this patch, but have no strong opinions on which
> > short option is used, so are there any votes against -y?
> 
> Between 'n' and 'y', I am in favour of the latter, but at the same time I
> have to wonder if there are other commands that would want "Assume yes"
> option.  It could be that this single command that prompts for "Is this
> Ok" is an oddball and giving it an "interactive" option to trigger the
> current behaviour might make things more consistent.  I dunno.
> 

I think that git mergetool probably counts as at least 'unusual', and
I think that there is some merit in the current default behaviour. It
gives you a prompt at which you can C-c if it's about to run something
that you don't want it to do the first few times that you try
mergetool.

After more thoughts, I'm somewhat in favour of dropping the short
switch altogether. As it just saves a single keypress per merge I
imagine that most mergetool users, once they discover this new
feature and decide that they want to use it, will prefer to use a user
config option to switch it on. The command line option then becomes
something that you would only need to use to override your normal
default and something on which to hang the option description in the
man page. 

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
