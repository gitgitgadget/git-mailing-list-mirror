From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: RFD: fast-import is picky with author names (and maybe it should
 - but how much so?)
Date: Sun, 11 Nov 2012 18:16:43 +0100
Message-ID: <CAMP44s1pWm_n-SwB5Bi8UxM-oRG=4dGXq7jVKx_E1rcoRaXaHw@mail.gmail.com>
References: <5093DC0C.5000603@drmicha.warpmail.net>
	<20121108200919.GP15560@sigill.intra.peff.net>
	<509CCCBC.8010102@drmicha.warpmail.net>
	<CAMP44s3Lhxzcj93=e8TXwqAVvGJBKhZEVX33G8Q=n2+8+UfCww@mail.gmail.com>
	<509E8EB2.7040509@drmicha.warpmail.net>
	<CAMP44s219Zi2NPt2vA+6Od_sVstFK85OXZK-9K1OCFpVh220+A@mail.gmail.com>
	<509EAA45.8020005@gmail.com>
	<CAMP44s1dsEU=E8tdgMYxWFyFw+F03bstdb5o7Ww_-RCQPd3R0w@mail.gmail.com>
	<509FD9BC.7050204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Sun Nov 11 18:16:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXb9V-0003l4-Gf
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 18:16:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171Ab2KKRQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 12:16:44 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:62529 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627Ab2KKRQo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 12:16:44 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so5532931obb.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 09:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8US9m6bOAtf5CeqVyrhV45dI7ZQh4JLVq8XPs1fqg1I=;
        b=km4Eho1X1t6uTdU2IqSRyzdeT/oR+SSVvNjFHOS0ZVwupvpYhDTvuPf3+vgHESywCj
         lpMV1G6rDPqL7fRbVug/YrnjWX4bFZiU8Z7SagDWZjr0m4FKLbwLgrAecdbRpDC+XAH7
         juZaNAZ9tx6qMUMcWyDRwOaPvsrAlOR+sv1aVUxqugIPBI0lrevr6peUDHFOCUZ+bBOy
         xn8F476aHwQUFuir9q1n1it/wh0so3mnP5mAFaKPYMPlHp6nQ+M21aCmS8C8jUftUWxJ
         vK7F0c0Ebg5EWMz2xJI2qhqSsbtLKF7l4w+nCBAFmDo1U8oT73CB8j4YQHjftI4oPtEr
         82bA==
Received: by 10.60.32.19 with SMTP id e19mr12989939oei.9.1352654203542; Sun,
 11 Nov 2012 09:16:43 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sun, 11 Nov 2012 09:16:43 -0800 (PST)
In-Reply-To: <509FD9BC.7050204@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209423>

On Sun, Nov 11, 2012 at 6:00 PM, A Large Angry SCM <gitzilla@gmail.com> wrote:
> On 11/11/2012 07:41 AM, Felipe Contreras wrote:

>> Such a filter would probably be quite complicated, and would decrease
>> performance.
>
> Really?
>
> The fast import stream protocol is pretty simple. All the filter really
> needs to do is pass through everything that isn't a 'commit' command. And
> for the 'commit' command, it only needs to do something with the 'author'
> and 'committer' lines; passing through everything else.

And how do you propose to find the commit commands without parsing all
the other commands? If you randomly look for lines that begin with
'commit /refs' you might end up in the middle of a commit message or
the contents of a file.

> I agree that an additional filter _may_ decrease performance somewhat if you
> are already CPU constrained. But I suspect that the effect would be
> negligible compared to the all of the SHA-1 calculations.

Well. If it's so easy surely you can write one quickly, and I can measure it.

Cheers.

-- 
Felipe Contreras
