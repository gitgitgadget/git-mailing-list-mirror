From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] disable grafts during fetch/push/bundle
Date: Thu, 6 Mar 2014 23:48:32 -0000
Organization: OPDS
Message-ID: <06EAF31C54FB49E5951781E637A79F04@PhilipOakley>
References: <20140304174806.GA11561@sigill.intra.peff.net> <xmqqd2i1k7p9.fsf@gitster.dls.corp.google.com> <20140305005649.GB11509@sigill.intra.peff.net> <xmqqy50oh45n.fsf@gitster.dls.corp.google.com> <20140305185212.GA23907@sigill.intra.peff.net> <xmqqppm0h2ti.fsf@gitster.dls.corp.google.com> <53183506.5080002@alum.mit.edu> <20140306155626.GB18519@sigill.intra.peff.net> <5318A537.4010400@alum.mit.edu> <20140306174803.GA30486@sigill.intra.peff.net> <08A515BA063C44E5A9EFC754793B2AD8@PhilipOakley> <531904E1.6010606@alum.mit.edu>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"Christian Couder" <christian.couder@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
To: "Michael Haggerty" <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Mar 07 00:48:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLi1k-0007YR-6G
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 00:48:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbaCFXsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 18:48:32 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:16417 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750919AbaCFXsb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Mar 2014 18:48:31 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApEXAPIIGVNOl3C4/2dsb2JhbABaDoJ4O4NdhT60a4NyAQIBAYEaF3SCIAUBAQEBAgEIAQEZFR4BASEFBgIDBQIBAw4HAwICBSECAhQBBBoGBwkBDQYTCAIBAgMBh2AMCa5XhVmbDReBKY0ygnY1gRQEhSKKEYo9gmeOEoJuPzw
X-IPAS-Result: ApEXAPIIGVNOl3C4/2dsb2JhbABaDoJ4O4NdhT60a4NyAQIBAYEaF3SCIAUBAQEBAgEIAQEZFR4BASEFBgIDBQIBAw4HAwICBSECAhQBBBoGBwkBDQYTCAIBAgMBh2AMCa5XhVmbDReBKY0ygnY1gRQEhSKKEYo9gmeOEoJuPzw
X-IronPort-AV: E=Sophos;i="4.97,604,1389744000"; 
   d="scan'208";a="456656657"
Received: from host-78-151-112-184.as13285.net (HELO PhilipOakley) ([78.151.112.184])
  by out1.ip02ir2.opaltelecom.net with SMTP; 06 Mar 2014 23:48:29 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243577>

From: "Michael Haggerty" <mhagger@alum.mit.edu>
> On 03/07/2014 12:01 AM, Philip Oakley wrote:
>> From: "Jeff King" <peff@peff.net>
>>> On Thu, Mar 06, 2014 at 05:41:27PM +0100, Michael Haggerty wrote:
>>>
>>>> > We can wrap that in "git replace --convert-grafts", but I do not 
>>>> >  >
>>>> think
>>>> > grafts are so common that there would be a big demand for it.
>>>>
>>>> It's probably easier to wrap it than to explain to Windows users 
>>>> what
>>>> they have to do.
>>>
>>> How would Windows users get a graft file in the first-place? There's 
>>> no
>>> GUI for it! ;)
>>
>> Now, now... It's dead easy using the git-gui and Notepad++, you can 
>> see
>> and confirm the sha1's, copy and paste, and the graft file is a very
>> easy format, so even wimps (windows, icons, menus, pointers aka 
>> mouse)
>> folks can do it. (It worked for me when I needed it ;-)
>
> I didn't mean to insult all Windows users in general.  I was only
> referring to the fact that since the default Windows command line is 
> not
> a POSIX shell, even an experienced Windows user might have trouble
> figuring out how to execute a shell loop.

I'd missed that aspect about the shell loop. I was mainly pointing out 
current awkwardness of creating the replace object, relative to grafts - 
There was an initial attempt by Christian, but it became quite hard to 
make it robust to sha1's embedded in commit messages.

>      Putting this functionality in
> a git command or script, by contrast, would make it work universally, 
> no
> fuss, no muss.
>
> Michael
>
> -- 
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
> 
