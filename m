From: Ivan Todoroski <grnch_lists@gmx.net>
Subject: Re: [PATCH/RFC 1/2] fetch-pack: new option to read refs from stdin
Date: Mon, 26 Mar 2012 19:49:59 +0200
Message-ID: <4F70AC47.1010405@gmx.net>
References: <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com> <20120319024436.GB10426@sigill.intra.peff.net> <4F69B5F0.2060605@gmx.net> <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com> <20120321171423.GA13140@sigill.intra.peff.net> <4F6A33C5.2080909@gmx.net> <20120321201722.GA15021@sigill.intra.peff.net> <4F6E3446.9080001@gmx.net> <20120325011948.GC27651@sigill.intra.peff.net> <4F6F7941.8060008@gmx.net> <20120326172145.GC7942@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 19:49:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCE37-0001jE-F3
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 19:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933142Ab2CZRtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 13:49:40 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:54486 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932903Ab2CZRtj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 13:49:39 -0400
Received: (qmail invoked by alias); 26 Mar 2012 17:49:36 -0000
Received: from unknown (EHLO [127.0.0.1]) [77.28.170.173]
  by mail.gmx.net (mp002) with SMTP; 26 Mar 2012 19:49:36 +0200
X-Authenticated: #14478976
X-Provags-ID: V01U2FsdGVkX1+RHwxJzyWRo3CQxRo1gTu2lAdevyEpSNcl8dfuCu
	bc+fwDWxP+4sEw
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <20120326172145.GC7942@sigill.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193939>

On 26.03.2012 19:21, Jeff King wrote:
> On Sun, Mar 25, 2012 at 10:00:01PM +0200, Ivan Todoroski wrote:
> 
>> On 25.03.2012 03:19, Jeff King wrote:
>>> On Sat, Mar 24, 2012 at 09:53:26PM +0100, Ivan Todoroski wrote:
>>> I think there is a minor formatting bug in the above. Asciidoc will make
>>> your two paragraphs into a single one, won't it? I think you need to do
>>> the (horribly ugly):
>>>
>>>  --stdin::
>>>      First paragraph.
>>>  +
>>>  Second paragraph.
>> Apparently this works too (i.e. indent the "+" too):
>>
>>   --stdin::
>>       First paragraph.
>>       +
>>       Second paragraph.
> 
> Sadly, it's not quite the same (because I consider the source of your
> version much more readable). The diff of the resulting HTML between my
> version and yours is:
> 
> --- no-indent.html	2012-03-26 13:19:26.206728013 -0400
> +++ indent.html	2012-03-26 13:19:04.270727319 -0400
> @@ -5,7 +5,8 @@
>  <dd>
>  <p>
>      First paragraph.
> +   <br />
> +    Second paragraph.
>  </p>
> -<div class="paragraph"><p>Second paragraph.</p></div>
>  </dd>
>  </dl></div>
> 
> So in your case it is putting in a line break, but not actually starting
> a new paragraph.
> 
> -Peff

Ah, that's too bad. OK, I guess we have two options:

1) Unindent the second paragraph - looks ugly in source but good in 
final output.

2) Just merge the two paragraphs into a single paragraph. It's not that 
much text anyway, it doesn't really *have* to be in two paragraphs.

Let me know which option you prefer.
