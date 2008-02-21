From: Mike Hommey <mh@glandium.org>
Subject: Re: git-send-email getting filtered as spam by vger.kernel.org
Date: Thu, 21 Feb 2008 22:49:59 +0100
Organization: glandium.org
Message-ID: <20080221214959.GA4338@glandium.org>
References: <200802210429.58353.lenb@kernel.org> <200802210721.29188.lenb@kernel.org> <20080221205104.GA14247@informatik.uni-freiburg.de> <7vejb6t3kk.fsf@gitster.siamese.dyndns.org> <76718490802211341o1ddc36bbne4e6d551712e7cd0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>, Len Brown <lenb@kernel.org>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 22:49:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSJHq-0002Ws-7p
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 22:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935069AbYBUVsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 16:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935056AbYBUVsQ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 16:48:16 -0500
Received: from vuizook.err.no ([85.19.215.103]:54667 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935055AbYBUVsO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 16:48:14 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JSJGc-0000mi-CF; Thu, 21 Feb 2008 22:47:53 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JSJIl-0001Dl-JF; Thu, 21 Feb 2008 22:49:59 +0100
Content-Disposition: inline
In-Reply-To: <76718490802211341o1ddc36bbne4e6d551712e7cd0@mail.gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74666>

On Thu, Feb 21, 2008 at 04:41:08PM -0500, Jay Soffian wrote:
> On Thu, Feb 21, 2008 at 4:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >  Perhaps we should fix it up like this...
> 
> Doh, my bad...
> 
> >  diff --git a/git-send-email.perl b/git-send-email.perl
> >  index ccb87a2..c9f8c6b 100755
> >  --- a/git-send-email.perl
> >  +++ b/git-send-email.perl
> >  @@ -475,7 +475,7 @@ if ($thread && !defined $initial_reply_to && $prompting) {
> >
> >         $initial_reply_to = $_;
> >   }
> >  -if (defined $initial_reply_to) {
> >  +if (defined $initial_reply_to && $initial_reply_to ne '') {
> >         $initial_reply_to =~ s/^\s*<?/</;
> >         $initial_reply_to =~ s/>?\s*$/>/;
> >   }
> 
> Actually:
> 
> if ($initial_reply_to) { ...
> 
> should be all that's needed.

And reminds me something ;)
http://kerneltrap.org/mailarchive/git/2007/12/11/488177

Mike
