From: david@lang.hm
Subject: Re: Git-aware HTTP transport
Date: Thu, 28 Aug 2008 10:37:04 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0808281033070.2713@asgard.lang.hm>
References: <20080826012643.GD26523@spearce.org> <48B36BCA.8060103@zytor.com> <20080826145857.GF26523@spearce.org> <48B4303C.3080409@zytor.com> <20080826172648.GK26523@spearce.org> <48B485F8.5030109@zytor.com> <20080828035018.GA10010@spearce.org>
 <7vhc95iwcs.fsf@gitster.siamese.dyndns.org> <20080828145706.GB21072@spearce.org> <alpine.DEB.1.10.0808281023200.2713@asgard.lang.hm> <20080828172853.GE21072@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 19:39:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYlRj-000321-P7
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 19:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550AbYH1RhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 13:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752690AbYH1RhG
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 13:37:06 -0400
Received: from mail.lang.hm ([64.81.33.126]:42487 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752339AbYH1RhF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 13:37:05 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m7SHabcG017146;
	Thu, 28 Aug 2008 10:36:37 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20080828172853.GE21072@spearce.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94098>

On Thu, 28 Aug 2008, Shawn O. Pearce wrote:

> david@lang.hm wrote:
>> On Thu, 28 Aug 2008, Shawn O. Pearce wrote:
>>>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>>>
>>> Yes, I really did mean for this part of the protocol to be in binary.
>>
>> except that HTTP cannot transport binary data, if you feed it binary data
>> it then encodes it into 7-bit safe forms for transport.
>
> So then how does it transport a GIF file to my browser?  uuencoded?

something like that. it uses the mimetype mechanisms to identify the 
various pieces and encodes each piece (if nothing else it needs to make 
sure that the mimetype seperators don't appear in the data) uuencode is 
one of the available mechanisms.

> Last time I read the RFCs I was pretty certain HTTP is 8-bit clean
> in both directions.

I could be wrong, but I'm pretty sure I'm not. to test this yourself find 
a webserver with an image file and retrieve it via telnet (telnet hostname 
80<enter>GET /path/to/file HTTP/1.0<enter><enter>) and what will come back 
will be text.

> Of course this may all be moot.  I think we're moving in a direction
> of matching the git native protocol more exactly.

true, but it's never a waste of time to learn something (whichever one of 
us is right :-)

David Lang
