From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: tracking repository
Date: Mon, 17 Mar 2008 12:23:26 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803171219260.19665@iabervon.org>
References: <frh8dg$t9j$1@ger.gmane.org> <7vabkzmltc.fsf@gitster.siamese.dyndns.org> <1205697779.12760.20.camel@duo> <7vwso2ieuu.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0803161716470.19665@iabervon.org> <7vlk4ichm4.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803162234270.19665@iabervon.org> <7v3aqpdc4n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, kenneth johansson <ken@kenjo.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 17:24:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbI8A-0002Wo-Va
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 17:24:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbYCQQXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 12:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbYCQQXa
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 12:23:30 -0400
Received: from iabervon.org ([66.92.72.58]:50784 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751514AbYCQQX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 12:23:29 -0400
Received: (qmail 14638 invoked by uid 1000); 17 Mar 2008 16:23:26 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Mar 2008 16:23:26 -0000
In-Reply-To: <7v3aqpdc4n.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77444>

On Mon, 17 Mar 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > On Sun, 16 Mar 2008, Junio C Hamano wrote:
> >
> >> Daniel Barkalow <barkalow@iabervon.org> writes:
> >> 
> >> > We don't currently have any concept of an invalid refspec;
> >> 
> >> We don't? or just that parse_ref_spec() does not detect one?
> >> 
> >> > ... we just have 
> >> > things that fall back to not being patterns and not being possible to 
> >> > match (due to one or the other side being invalid as a ref name).
> >> 
> >> I am afraid that is an invitation for more bugs and confusions.
> >
> > Yeah, we're definitely too lenient. t3200-branch has been using the 
> > refspec "=" since July without anybody noticing that it's wrong.
> 
> You mean these that came in 6f084a5 (branch --track: code cleanup and
> saner handling of local branches, 2007-07-10), right?

Yup. That actually makes me wonder if git-config should complain if it 
doesn't do anything due to the value_regex not matching anything.

> Will you fix them while you come up with a patch to tighten the parsing?
> Fixing these does seem to trigger problems in later parts of the test
> sequence.

Yeah, we just need to remove those options once that case finishes (or I 
suppose that test could go at the end).

	-Daniel
*This .sig left intentionally blank*
