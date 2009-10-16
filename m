From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH 1/4] Document the HTTP transport protocol
Date: Fri, 16 Oct 2009 07:21:35 -0700
Message-ID: <20091016142135.GR10505@spearce.org>
References: <1255065768-10428-1-git-send-email-spearce@spearce.org> <1255065768-10428-2-git-send-email-spearce@spearce.org> <7vskdss3ei.fsf@alter.siamese.dyndns.org> <slrnhd0nfv.tq2.antti-juhani@kukkaseppele.kaijanaho.fi> <4AD80BBD.8080504@zytor.com> <20091016071942.GC3009@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Antti-Juhani Kaijanaho <antti-juhani@kaijanaho.fi>,
	git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Oct 16 16:25:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MynkM-0008Gh-Rk
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 16:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760069AbZJPOWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 10:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760023AbZJPOWM
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 10:22:12 -0400
Received: from george.spearce.org ([209.20.77.23]:40817 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760002AbZJPOWL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 10:22:11 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A3A81381FE; Fri, 16 Oct 2009 14:21:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091016071942.GC3009@glandium.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130490>

Mike Hommey <mh@glandium.org> wrote:
> On Thu, Oct 15, 2009 at 10:59:25PM -0700, H. Peter Anvin wrote:
> > On 10/10/2009 03:12 AM, Antti-Juhani Kaijanaho wrote:
> > > On 2009-10-09, Junio C Hamano <gitster@pobox.com> wrote:
> > >>> +If there is no repository at $GIT_URL, the server MUST respond with
> > >>> +the '404 Not Found' HTTP status code.
> > >>
> > >> We may also want to add
> > >>
> > >>     If there is no object at $GIT_URL/some/path, the server MUST respond
> > >>     with the '404 Not Found' HTTP status code.
> > >>
> > >> to help dumb clients.
> > > 
> > > In both cases - is it really necessary to forbid the use of 410 (Gone)?

My original text got taken a bit out of context here.  I guess MUST
was too strong of a word.  I more ment something like:

  If there is no repository at $GIT_URL, the server MUST NOT respond
  with '200 OK' and a valid info/refs response.  A server SHOULD
  respond with '404 Not Found', '410 Gone', or any other suitable
  HTTP status code which does not imply the resource exists as
  requested.

> > 410 means "we once had it, it's no longer here, no idea where it went."
> >  It's a largely useless code...
> 
> There is an additional meaning to it, that is "it will never ever
> return". It thus has a stronger meaning than 404. Sadly, not even search
> engine spiders consider it as a hint to not crawl there in the future...

I know.  I broke a URL on a site back in Janurary, MSN keeps crawling
it anyway.  F'king spiders.

-- 
Shawn.
