From: Patrick Doyle <wpdster@gmail.com>
Subject: Fwd: How to tell what paths changed in a merge?
Date: Mon, 28 Mar 2011 21:50:45 -0400
Message-ID: <AANLkTikRSv6Y4GGV5Qx_5MXUQx-7SAXq8gGz0w7hbfa5@mail.gmail.com>
References: <AANLkTi=DOf0beuts8TO0c5JJtDtjNAcQ_4hcKNkZoXjM@mail.gmail.com>
 <20110328202039.GA27755@sigill.intra.peff.net> <AANLkTinhRTwbU8DXc7sYxmxjKEiHASYmdKqxofmn+wgs@mail.gmail.com>
 <20110328204750.GA2998@sigill.intra.peff.net> <AANLkTi=vB4CsMZ_hT-Mruqs6tiEjUgEzbA2Vwaog6wNK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 29 03:51:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4O5R-0000NE-2k
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 03:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938Ab1C2BvI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Mar 2011 21:51:08 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47949 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536Ab1C2BvH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Mar 2011 21:51:07 -0400
Received: by fxm17 with SMTP id 17so3128372fxm.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 18:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=vdY9cX8YxZHQzNWqi0Khr7VK1tueqTWTRlhI4IZsGcQ=;
        b=AA/ys/uXgmRdCR9G3jPHrAKYNopg1Gdbz5tA2zCSoylCsB/rusbHn9D0fkGXuqjNQU
         0uGv1RYYyvaBnARlTw5Cr79k9aYIwPkZK+/8rPcHHtiMRUfaU3TRFXMCsYh9CzQ8ggHg
         b9Hdu1vtQiHOjV55H4Oh3xL6tchTAYQ9cFlLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=IiihQbUPq1hWDhzDUJBsjMhqCuLK4VTOkiNZH0xetCjptiWcjgxe5kLoyVcB1z7tKL
         vjPut6lfDWW9zaeEB2prWiDzAOnaNMHHe5WIQrs2kYJgKIjRFtLh7Y1hsp1GhNfXB2+m
         ibLpZXLUaM1n0w4c7qiuXY6gdPGdJKaYTxmak=
Received: by 10.223.159.9 with SMTP id h9mr4186580fax.145.1301363465109; Mon,
 28 Mar 2011 18:51:05 -0700 (PDT)
Received: by 10.223.116.20 with HTTP; Mon, 28 Mar 2011 18:50:45 -0700 (PDT)
In-Reply-To: <AANLkTi=vB4CsMZ_hT-Mruqs6tiEjUgEzbA2Vwaog6wNK@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170214>

Oops... I just realized I did a "Reply" instead of "Reply-All".

It's been one of those days... sigh.

--wpd
On Mon, Mar 28, 2011 at 4:47 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Mar 28, 2011 at 04:39:03PM -0400, Patrick Doyle wrote:
>
>> Thank you for your quick reply... =A0you are correct in your assessm=
ent
>> that somebody botched a merge. =A0Probably several of them from seve=
ral
>> different working trees. =A0I am trying to figure out
>>
>> a) What he changed how & when
>>
>> b) How to politely tell him not to do that again.
>
> Heh. You're on your own for (b).
and I thought this was a full-service list. =A0Oh well :-)


> Have you tried "git log -p broken-file"? That should show you everywh=
ere
> that broken-file was touched (and how). It might make more sense to u=
se
> "gitk broken-file", as I suspect the actual shape of history will be
> useful in seeing what happened.
That's the bizarre thing -- "git log broken-file" doesn't show my
recent modifications at all, although "git log shows my commit where I
last modified the file (182451), followed (a few commits later) by his
merge commit.

git show 182451:path/to/broken-file

shows my most recent change to the file.

My commit got merged with one of his at 63252 without any problems.

That tree got merged with another one of his (from a different working
directory) at 693a2 and, for some reason, my original file shows up
from there on forward.

I think he probably did a "git pull" which failed (most of our
repository is binary CAD files, unfortunately), he probably uttered a
few choice words, threw things around the room, and then grabbed his
sledgehammer to force things back into the shape he wanted, and failed
to notice that he left some dents in other places.

I think I'm gonna have to just go back and review each of his merge
commits manually, compare the tree on one side to the tree on the
other, and figure out what got changed.

It's confusing to me that I can't figure out the right options to
git-log to make this easier. =A0"git log --name-status 693a2" doesn't
list any files as having changed. =A0I don't know what he did to force
the immediate ancestor of the file I changed to be re-committed to the
repository, but somehow he did that.

My biggest concern is to wonder what else got stomped on as he wielded
his sledgehammer.

I just noticed your suggestion about "gitk broken-file". =A0I think I'l=
l
go give that a shot and see what I can learn from that.
--wpd
