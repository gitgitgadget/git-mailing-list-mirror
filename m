From: Roy Lee <roylee17@gmail.com>
Subject: Re: Does cloning a shallow repo require special setting in the cloned 
	one?
Date: Thu, 26 Feb 2009 21:01:34 +0800
Message-ID: <6eac7f470902260501v6d826af7rbc5afd1df7b214a3@mail.gmail.com>
References: <1235620146513-2387799.post@n2.nabble.com> <87tz6hn1tg.fsf@iki.fi>
	 <20090226104657.GB4226@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 26 14:03:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcftN-0007nX-LC
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 14:03:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858AbZBZNBj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Feb 2009 08:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752758AbZBZNBi
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 08:01:38 -0500
Received: from rv-out-0506.google.com ([209.85.198.225]:25947 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbZBZNBi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Feb 2009 08:01:38 -0500
Received: by rv-out-0506.google.com with SMTP id g37so535856rvb.1
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 05:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=StW1wO+mSVADkW081U7ULw8NX5IRtrm6Rra0y6f4vts=;
        b=wchRdB7zVrT4mtiCBrc6OdWVbLhWh+67oO5dyPMVnxa3cXfXk61qMrI4cNV1+fuAx/
         /ApndPZH7k6vRwD7zqX05oJKhszt6OPaPXZiKFf8wg1pI2oUS9ftzC146JAtenrCcqcT
         gxXS3p48ssVEXpndhXRXvw9gkeVjaSHox2+oE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Zi2u6qv1MrELo7hgAHcE4qpstvGLaCMAUli2STAlLacsvPHINo2jsRFFQCrwd7iysD
         tLNIc8kOqHfC0aO0sQxCYZeac+bxECcTVaUaSNmXDJmCQ0bQzHgbSQ8+Hc60awSJIuoC
         D3Q5RpfaCgFpFn51It5EO+Pza0vc3ySXNm6XE=
Received: by 10.141.175.5 with SMTP id c5mr634721rvp.176.1235653294959; Thu, 
	26 Feb 2009 05:01:34 -0800 (PST)
In-Reply-To: <20090226104657.GB4226@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111558>

On Thu, Feb 26, 2009 at 6:46 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Feb 26, 2009 at 08:34:51AM +0200, Teemu Likonen wrote:
>
>> On 2009-02-25 19:49 (-0800), roylee17 wrote:
>>
>> > $ git clone --depth 1 git-full git-shallow2
>> > 'git log' still gives a full history
>> >
>> > Why can't I clone a shallow repo from the git-full?
>> > Does it requires some settings in the git-full repo?
>>
>> I don't know the "why" part but using file:// URL should work:
>>
>> =A0 =A0 git clone --depth 1 file:///path/to/git-full git-shallow2
>
> I don't think the behavior is intentional, but a side effect of the
> fact that git takes some shortcuts when cloning locally. In particula=
r,
> it will try to copy or hardlink the object database rather than
> transmitting over the git protocol locally. Using file:// has always
> been the way to suppress that shortcut.
>
> Perhaps to avoid surprise, that optimization should be turned off for
> options which cause it to behave differently (like --depth). But I ha=
ve
> to wonder what the point of --depth is locally; if you are worried ab=
out
> space, hardlinks (the default) or alternates ("clone -s") are a bette=
r
> solution.
>
> -Peff
>

Actully, the original intention was to find a quick way to checkout and
build several projects regularly. The first thing came to me was clonin=
g
shallow repos for saving some time. So I tried it with my local repo fi=
rst.

Later, one of my co-works suggested me to try git archive, and that did
reallly fit my needs.

Thanks for clarifying my confusion.

Roy
