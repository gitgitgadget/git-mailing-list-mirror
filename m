From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new git-remote-hd helper
Date: Wed, 17 Oct 2012 20:12:43 +0200
Message-ID: <CAMP44s2=hhMz35SpYXMBLcQPfVaPxY4pBWZDF7zbqVwz=tbedA@mail.gmail.com>
References: <1350478721-3685-1-git-send-email-felipe.contreras@gmail.com>
	<alpine.DEB.1.00.1210171759230.3049@bonsai2>
	<CAMP44s1WY+Q7jyy4PQvwff7JSxHsnkhrPWozOLnNuNOrn7FGBA@mail.gmail.com>
	<alpine.DEB.1.00.1210171936170.3049@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 17 20:12:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOY6y-0001Hn-7X
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 20:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756551Ab2JQSMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 14:12:44 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51351 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754716Ab2JQSMn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 14:12:43 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so7680780obb.19
        for <git@vger.kernel.org>; Wed, 17 Oct 2012 11:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2nRAIe8FZ1GuYYzDFllhWnioEvYc4CRh6Mx4ljbJ8mY=;
        b=zQ9JDLDp5212q7xnbDCVFDuEaJgQ13r+hTL46Ns2mZRSr5yjDVgh0FZ2gSxoAr7RPH
         uBlXSyQOAW2/C5VIqiHiH+kSjKfUyN49CLbR+yeLr4aDqEU4w7DU6X8KElMSR2Y2p9SE
         dIP1OpEwVqqB5han7mFJLMpWWAN1vLoYML2J6kYwkUwT/g2gNO1HEKK+N7RQEoiIX2vn
         OuuDyfwQwXH3Dtrxqvie3yE1UkaFm1xY3gCS4SdxsGpFpNr188k7XkYZD6Ac27XKd1bm
         xkzkPu0zjs5u/vtQUGdoOcJVfPwQt1SqdSBTg4p2H8XhIyjjIHJ4NpUW2eJIcDrZmHCx
         jk0A==
Received: by 10.60.5.129 with SMTP id s1mr15681298oes.85.1350497563203; Wed,
 17 Oct 2012 11:12:43 -0700 (PDT)
Received: by 10.60.58.137 with HTTP; Wed, 17 Oct 2012 11:12:43 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1210171936170.3049@bonsai2>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207928>

On Wed, Oct 17, 2012 at 7:39 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Wed, 17 Oct 2012, Felipe Contreras wrote:
>
>> On Wed, Oct 17, 2012 at 6:03 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> > On Wed, 17 Oct 2012, Felipe Contreras wrote:
>> >
>> >> I've looked at many hg<->git tools and none satisfy me. Too
>> >> complicated, or too slow, or to difficult to setup, etc.
>> >
>> > The one I merged into Git for Windows (since that is what I install on
>> > all my machines even if they run Linux) is rock-solid. It also comes
>> > with tests. And it requires a fix I tried to get into git.git (but
>> > failed, since I was asked to do much more in addition to what I needed
>> > for myself, and I lack the time to address such requests these days).
>>
>> Maybe, but who uses it? It's quite a lot of code, and it's quite
>> difficult to setup--you would need a non-vanilla version of git.
>
> Okay, so the difficulty of setting it up is because it is not in mainline
> git.git?

My version:
1) cp contrib/remote-hg/git-remote-hg ~/bin

Your version? I don't know, but it certainly will be more than one
step... may more.

>> Compare this:
>> 32 files changed, 3351 insertions(+), 289 deletions(-)
>>
>> To this:
>> 1 file changed, 231 insertions(+)
>
> Yeah, and that's also because of the severe lack of tests. And the lack of
> possible code-sharing with other remote helpers.

What is there to share? It's 230 lines of code. And share it with
which remote helpers? And trying to do so will certainly make it
harder to setup.

As for the tests, I don't see any tests checking that the import of
tags succeeds. Oh, that's right, that is not implemented, so not
surprisingly; there are no tests for that. What does a dozen passing
tests tell you about the code? Not much. If my code had tests, the
test for importing tags would succeed, but I chose to spend my time
implementing features, and trying to make them accessible to as many
people as possible... rather than writing tests.

But fine, lets remove the tests out of the equation (150 lines), the
number of lines of code still exceeds 3000.

Cheers.

-- 
Felipe Contreras
