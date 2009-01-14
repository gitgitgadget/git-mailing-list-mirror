From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Fix nested links problem with ref markers
Date: Tue, 13 Jan 2009 22:56:28 -0500
Message-ID: <cb7bb73a0901131956s7f441c38o3a0b1e5f456a3cd3@mail.gmail.com>
References: <200901120215.13668.jnareb@gmail.com>
	 <200901130113.54517.jnareb@gmail.com>
	 <cb7bb73a0901121659h7277c074ia73786b15d66b804@mail.gmail.com>
	 <200901140117.38803.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 04:57:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMwt9-00041a-2R
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 04:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540AbZAND4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 22:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753511AbZAND4b
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 22:56:31 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:48988 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753311AbZAND4b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 22:56:31 -0500
Received: by ey-out-2122.google.com with SMTP id 22so65946eye.37
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 19:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=+rSBlJ+TcAUPNjD/ZLT0d5Csy4xaMBaNms6qWDIYJVA=;
        b=pALCnIeRj18erZmGuiePmjxeWUj4GT1EwEQKcR2BbcbKqupszNgJ8hV5HfSxHXoyT7
         /nNNIk14qogYTvK6HjPVEhovPtyc6TTRaczif95SmEAkjPE0JsaTBl1e8ZiXorZjnW31
         iNiN5Kq8lRtHbr+Vfn2Gc7/t6mTGeuHqy0CoU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=BSAyn180AbSa3jzOE8OCQdDhhSIEihHmw9J907tweePNORaacMby3upCn56esZzUHI
         UabdDwcY8d5le32+8dES5wEkPTENJD80dSmqV4KqtzutDWLd53dHn22W77Odmp10Wxk/
         ltnES3T7ZLrcRdBSZcvTWK2NkjY8oxK0fhzow=
Received: by 10.210.137.14 with SMTP id k14mr36574090ebd.175.1231905388181;
        Tue, 13 Jan 2009 19:56:28 -0800 (PST)
Received: by 10.210.57.20 with HTTP; Tue, 13 Jan 2009 19:56:28 -0800 (PST)
In-Reply-To: <200901140117.38803.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105581>

On Tue, Jan 13, 2009 at 7:17 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Tue, 13 Jan 2009, Giuseppe Bilotta wrote:
>> On Mon, Jan 12, 2009 at 7:13 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>>> On Mon, 12 Jan 2009, Giuseppe Bilotta wrote:
>>>> On Sun, Jan 11, 2009 at 8:15 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>
> [...]
>> Notice that nested links are actually valid *XML*. Indeed, I asked on
>> www-style and they suggested leaving the problem as-is, serving as
>> html+xml which is what we do.
>
> But nested links are neither valid HTML nor valid XHTML.  This
> restriction (no nested links) is IMVHO quite sensible

Sensible? I think it's idiotic, especially since CSS does not and
cannot provide enough expression power to obtain the same layout and
functionality as what can be achieved by nesting links, so that to
achieve these results one has to resort to horirble trickes,
effectively destroying the whole purporse of HTML+CSS which is to
separate layout from semantics.

But anyway.

>> The float thing was the second suggestion I was given on www-style.
>
> What was the first suggestion? And what is www-style?

The first suggestion was to just leave things as they are. www-style
is www-style@w3c.org, the CSS mailing list of the W3C

>> Can you provide a patch I can apply to my tree for testing to see how
>> it comes up?
>
> Here it is. Note that CSS could be I think reduced. The size of
> gitweb.perl changes is affected by changing calling convention for
> git_print_header_html subroutine.

It's funny, I was working on a very similar patch myself a couple of
days ago, but couldn't get the horizontal filler after the link to
work properly, which is why I asked on www-style.

I'll test your patch and let you know.

> There is also strange artifact at least in Mozilla 1.17.2: if I hover
> over ref marker, the subject (title) gets darker background. Curious...

Might be some kind of bug with the capturing vs bubbling phase.
-- 
Giuseppe "Oblomov" Bilotta
