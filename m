From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v10 11/12] Documentation: add documentation for 'git interpret-trailers'
Date: Tue, 27 May 2014 11:17:52 +0200
Message-ID: <CALKQrgdMxCP8e+6wJugnJUhLfHvf-t9MDPqdiZvc+HQc+GcBiQ@mail.gmail.com>
References: <534414FB.6040604@alum.mit.edu>
	<20140425.230710.1024850359228182788.chriscool@tuxfamily.org>
	<535E2A69.30600@alum.mit.edu>
	<20140525.103721.1806399553055631284.chriscool@tuxfamily.org>
	<53844AEF.1080502@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	ramsay@ramsay1.demon.co.uk, Jonathan Nieder <jrnieder@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 27 11:18:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpDWH-0000rK-VC
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 11:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbaE0JSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 05:18:01 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:59015 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbaE0JSA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 05:18:00 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1WpDWA-0004VM-0i
	for git@vger.kernel.org; Tue, 27 May 2014 11:17:58 +0200
Received: from mail-oa0-f42.google.com ([209.85.219.42])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1WpDW7-0008pw-SD
	for git@vger.kernel.org; Tue, 27 May 2014 11:17:56 +0200
Received: by mail-oa0-f42.google.com with SMTP id j17so9324925oag.29
        for <git@vger.kernel.org>; Tue, 27 May 2014 02:17:52 -0700 (PDT)
X-Received: by 10.60.56.8 with SMTP id w8mr9067097oep.74.1401182272486; Tue,
 27 May 2014 02:17:52 -0700 (PDT)
Received: by 10.182.245.10 with HTTP; Tue, 27 May 2014 02:17:52 -0700 (PDT)
In-Reply-To: <53844AEF.1080502@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250160>

On Tue, May 27, 2014 at 10:21 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> tl;dr: This patch series wants to introduce a permanent new Git data
> format.  The current version can write trailers in formats that it is
> incapable of reading, which I consider broken.  I advocate a stricter
> specification of the format of trailers, at least until we get feedback
> from users that they need more flexibility.
>
> On 05/25/2014 10:37 AM, Christian Couder wrote:

[...]

>> My opinion is that many Git developers have been engaged and you can
>> see that in the Cc.
>>
>> I cannot tell if they are all very happy or not but I suppose that if
>> they were very unhappy they would tell it.
>> [...]
>
> It was unfair of me to try to characterize the opinions of other
> developers.  On the other hand, even though many people have commented
> on this proposal over its long lifetime, I didn't get the feeling that
> it has won a consensus of +1s in its current form.
>
> I'd love to hear the opinion of others because maybe I'm totally out in
> left field.

FWIW, after a quick read, I find myself agreeing very much with
Michael's arguments for a stricter format (at least in its initial
version).

We are formalizing and applying tools/automation to a part of the
commit message that has so far been ad hoc and very informal. There is
no expectation that _every_ _single_ existing use of (informal)
trailers (except the somewhat-formalized support for --signoff) must
be supported by git-interpret-trailers.

However, there _is_ an expectation that git-interpret-trailers is
self-consistent and does not stumble over its own trailers. Therefore,
it makes perfect sense to make v1 very strict in what formats it
produce (i.e. a strict "key: value" format is enough for now).

> And I want to reiterate that the reason I'm so emphatic about this
> proposal is because I think it will be such a great new feature.  I just
> think that some tweaks would make it a more solid foundation for
> building even more functionality onto.

Fully agreed. git-interpret-trailers have come up in several other
discussion, both on the git mailing list and elsewhere, and I have no
doubt that this will be a very useful feature that will be put to good
use in many projects.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
