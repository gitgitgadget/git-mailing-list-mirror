From: david@lang.hm
Subject: Re: Git-aware HTTP transport
Date: Thu, 28 Aug 2008 10:26:15 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0808281023200.2713@asgard.lang.hm>
References: <20080826012643.GD26523@spearce.org> <48B36BCA.8060103@zytor.com> <20080826145857.GF26523@spearce.org> <48B4303C.3080409@zytor.com> <20080826172648.GK26523@spearce.org> <48B485F8.5030109@zytor.com> <20080828035018.GA10010@spearce.org>
 <7vhc95iwcs.fsf@gitster.siamese.dyndns.org> <20080828145706.GB21072@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 19:27:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYlHG-0007oS-KZ
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 19:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbYH1R0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 13:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752300AbYH1R0M
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 13:26:12 -0400
Received: from mail.lang.hm ([64.81.33.126]:49810 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751683AbYH1R0M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 13:26:12 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m7SHPmnM017102;
	Thu, 28 Aug 2008 10:25:48 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20080828145706.GB21072@spearce.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94095>

On Thu, 28 Aug 2008, Shawn O. Pearce wrote:

> Junio C Hamano <gitster@pobox.com> wrote:
>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>>
>> It appears that you really meant "Binary", as opposed to "Hexadecimal"
>> that show-ref example illustrate, judging from the later 3,276 number.
>> I'd prefer hexadecimal here.
>
> Yes, I really did mean for this part of the protocol to be in binary.
> We have to exchange a bunch of commits to figure out what is common.
> The binary form is 1/2 the size of the hexadecimal form, resulting
> in fewer TCP packets for the same request.

except that HTTP cannot transport binary data, if you feed it binary data 
it then encodes it into 7-bit safe forms for transport.

while it's true that it can pack it more efficiantly than hex, it's not 
double the density.

> Reading/writing the SHA-1s in binary is usually faster than doing
> it in hex; you don't have to go through the formatting routines.
> So there's a few less CPU cycles on the server end.

except you then need to go through the formatting routines to send it via 
HTTP.

David Lang
