From: Stefan Karpinski <stefan.karpinski@gmail.com>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Tue, 10 Feb 2009 11:29:15 -0800
Message-ID: <d4bc1a2a0902101129y22224c89y144b223e7d7dd463@mail.gmail.com>
References: <20090205204436.GA6072@diku.dk> <4991814A.6050803@tedpavlic.com>
	 <2c6b72b30902101029s72628a88n16473ee30f853198@mail.gmail.com>
	 <6BA2725C-2127-48BE-871E-7449A507CCD8@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jonas Fonseca <fonseca@diku.dk>, Ted Pavlic <ted@tedpavlic.com>,
	git <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 20:30:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWyJj-0007Z3-RH
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 20:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754548AbZBJT3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 14:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754526AbZBJT3S
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 14:29:18 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:43374 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754465AbZBJT3R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Feb 2009 14:29:17 -0500
Received: by wa-out-1112.google.com with SMTP id v33so1264473wah.21
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 11:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hfwu9rKaZGqGFfK7uK0F6RyP9kauEXoQQ2dXhWNvoDc=;
        b=vLR4y0Dm2mOc6JmqJlbBUbRTn1c3dDa4WLAz8nrbLuE49RBf0KD8uMwxjv/dR0nSCC
         0UBPBh27MSt9wIGtrWwmrJ/bJP5bEQj+DCepW6eRwbRkTv2x1WiJQvCKmns142fWV6sH
         UV9QdAtWy5tmW9PNPfBiFA3ldAue/YkNrsiug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NMKtZ2bu99I0ccrAt9niXWD5Xha4lIrxPv0DA4jXrlAlx8plqAVXKAodza3I3vTbmb
         WdjhN9yZy4y2DqWpAdIN2zWZdToxTqcoI8vmFQEAbqvx1Gz/xkPavO8UTYqJuwBJtOqM
         n3lADSG7GmRlTm3xuffbOdezSuhqZ/qYc39Zc=
Received: by 10.114.181.6 with SMTP id d6mr4988432waf.8.1234294155303; Tue, 10 
	Feb 2009 11:29:15 -0800 (PST)
In-Reply-To: <6BA2725C-2127-48BE-871E-7449A507CCD8@silverinsanity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109296>

On Tue, Feb 10, 2009 at 11:07 AM, Brian Gernhardt
<benji@silverinsanity.com> wrote:
>
> On Feb 10, 2009, at 1:29 PM, Jonas Fonseca wrote:
>
>> On Tue, Feb 10, 2009 at 14:29, Ted Pavlic <ted@tedpavlic.com> wrote:
>>>
>>> I notice that when I do the sequence...
>>>
>>> *) open tig
>>> *) hit <CR> to view first changeset
>>> *) hit "j" to scroll one line
>>>
>>> the green highlighting on the first line moves to the second, but the
>>> whitespace following the "commit 00000000000000" stays green. For example,
>>> if I do the sequence above in the tig repo, I'm left with
>>>
>>> commit e278600f599f60a2b98aeae6bfbb6ba92cf92d6f---GREEN BG HERE---
>>> ---This line (Refs:) has GREEN BG---
>>>
>>> The "commit" has a black background.
>>>
>>> Is that a bug? Or do I need to upgrade my ncurses?
>>
>> Sounds like a bug. Probably from the drawing optimizations in tig-0.14.
>
> I am also getting this bug.  It is easiest to reproduce for me by running "git log | tig" and just moving the cursor down.  Any action that causes the entire window to update (pressing up/down at the bottom/top of the screen, PageUp/PageDown, or even just <Enter> to scroll down a line) causes the line to appear normally again, although movement from that point usually breaks it again.
>
>> No upgrade should be necessary. Could you give me some information
>> about what terminal application you are using. Also, have you added
>> any specific color settings to ~/.tigrc?
>
> OS 10.5.6's Terminal.app, with TERM=xterm-color
> I have no .tigrc

Ditto. Same bug. Completely vanilla tig setup. OS X Leopard,
tig-0.14-9-gd06137e, TERM=xterm-color.
