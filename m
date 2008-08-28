From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Git-aware HTTP transport
Date: Thu, 28 Aug 2008 10:20:58 -0700
Message-ID: <48B6DE7A.1020207@zytor.com>
References: <20080826012643.GD26523@spearce.org> <48B36BCA.8060103@zytor.com> <20080826145857.GF26523@spearce.org> <48B4303C.3080409@zytor.com> <20080826172648.GK26523@spearce.org> <48B485F8.5030109@zytor.com> <20080828035018.GA10010@spearce.org> <7vhc95iwcs.fsf@gitster.siamese.dyndns.org> <48B6DABD.7090800@zytor.com> <20080828171052.GC21072@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 19:22:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYlCi-0006T8-CH
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 19:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746AbYH1RVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 13:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752712AbYH1RVd
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 13:21:33 -0400
Received: from terminus.zytor.com ([198.137.202.10]:51992 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbYH1RVc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 13:21:32 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m7SHL4ZC004206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 Aug 2008 10:21:04 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m7SHL4Vo026189;
	Thu, 28 Aug 2008 10:21:04 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m7SHKwoE029471;
	Thu, 28 Aug 2008 10:20:59 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080828171052.GC21072@spearce.org>
X-Virus-Scanned: ClamAV 0.93.3/8109/Thu Aug 28 07:33:58 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94089>

Shawn O. Pearce wrote:
> "H. Peter Anvin" <hpa@zytor.com> wrote:
>> Junio C Hamano wrote:
>>
>>> It appears that you really meant "Binary", as opposed to "Hexadecimal"
>>> that show-ref example illustrate, judging from the later 3,276 number.
>>> I'd prefer hexadecimal here.
>>>
>> I *think* the "native" git protocol uses binary here.  It makes sense to  
>> be consistent, to allow them to share code?
> 
> No, the native protocol is horribly verbose here:
> 
> 	0032want ac3abe10ed54d512fbbaeb7cef19972eedd8e4a8
> 	0032want 404c3bbec34f5c65c5024c856eed4dbbfc27831e
> 	0032want 9bcc7aff6095549c1425aef6ca0034c47189705d
> 	0032have 471287a3c311e486206d3c6ff94faf3dfffc736c
> 	0032have 48f27055a4fa5f4da8234f44808f0b0c70629218
> 	0032have d4cc612f218b3dd3b831e3b976bf85165cd4f3d4
> 	...
> 
> so its doing it in hex, and its using 10 bytes of "framing" for
> every SHA-1 it sends as each is sent in its own pkt-line with the
> have/want header.
> 

Hm.  It's probably not enough data to worry significantly about.

	-hpa
