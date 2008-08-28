From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git-aware HTTP transport
Date: Thu, 28 Aug 2008 10:10:52 -0700
Message-ID: <20080828171052.GC21072@spearce.org>
References: <20080826012643.GD26523@spearce.org> <48B36BCA.8060103@zytor.com> <20080826145857.GF26523@spearce.org> <48B4303C.3080409@zytor.com> <20080826172648.GK26523@spearce.org> <48B485F8.5030109@zytor.com> <20080828035018.GA10010@spearce.org> <7vhc95iwcs.fsf@gitster.siamese.dyndns.org> <48B6DABD.7090800@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 19:12:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYl2P-0003R1-KO
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 19:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613AbYH1RKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 13:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753412AbYH1RKy
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 13:10:54 -0400
Received: from george.spearce.org ([209.20.77.23]:40331 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948AbYH1RKx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 13:10:53 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1046238375; Thu, 28 Aug 2008 17:10:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48B6DABD.7090800@zytor.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94086>

"H. Peter Anvin" <hpa@zytor.com> wrote:
> Junio C Hamano wrote:
>
>>
>> It appears that you really meant "Binary", as opposed to "Hexadecimal"
>> that show-ref example illustrate, judging from the later 3,276 number.
>> I'd prefer hexadecimal here.
>>
>
> I *think* the "native" git protocol uses binary here.  It makes sense to  
> be consistent, to allow them to share code?

No, the native protocol is horribly verbose here:

	0032want ac3abe10ed54d512fbbaeb7cef19972eedd8e4a8
	0032want 404c3bbec34f5c65c5024c856eed4dbbfc27831e
	0032want 9bcc7aff6095549c1425aef6ca0034c47189705d
	0032have 471287a3c311e486206d3c6ff94faf3dfffc736c
	0032have 48f27055a4fa5f4da8234f44808f0b0c70629218
	0032have d4cc612f218b3dd3b831e3b976bf85165cd4f3d4
	...

so its doing it in hex, and its using 10 bytes of "framing" for
every SHA-1 it sends as each is sent in its own pkt-line with the
have/want header.

-- 
Shawn.
