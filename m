From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: permissions
Date: Wed, 9 Jun 2010 09:20:27 +0200
Message-ID: <AANLkTikGpbeP1ba0y0oUsWGQXsrL8Z-GKjybCB83W_FJ@mail.gmail.com>
References: <4C0A19FE.1020802@wpursell.net>
	<m27hmdn704.fsf@igel.home>
	<4C0A9615.4090307@wpursell.net>
	<AANLkTileRHwUuJpvKJbivRiM9Prn9wJ0zH6abExBgcq0@mail.gmail.com>
	<4C0B6C32.1090700@wpursell.net>
	<7vvd9wvswy.fsf@alter.siamese.dyndns.org>
	<4C0E1AB1.2030702@wpursell.net>
	<AANLkTimAmSxq8dC-4bnpLsvN3JabQeTO6pDTh9ds7D0D@mail.gmail.com>
	<7vtypds09x.fsf@alter.siamese.dyndns.org>
	<4C0EC3D0.6060509@wpursell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 09:20:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMFae-0007aj-Lc
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 09:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755473Ab0FIHUa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 03:20:30 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49975 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755440Ab0FIHU2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jun 2010 03:20:28 -0400
Received: by gye5 with SMTP id 5so3812573gye.19
        for <git@vger.kernel.org>; Wed, 09 Jun 2010 00:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2QX0NvRpuDz+kUmAgRUOwyLD9mi/+V+dZe6sKyzdmnE=;
        b=eo+OxGMoDgI0V2SqPeIoKE3KqsAAYqEvrV9qroFZrTKA9yd+5B2Qx3cLfktHj+waRz
         +XRw0+2lyPfBamXw8Jlc44EDoggxKkb+ECGkacNiGLMALtL90kXcC3UkS8MgvE2gx9sh
         YbI3kK9jrRqhvlrP+gkyj3jXsY4htstwyU2jI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CJnlaZRAV9k8clJCiUJlhD+P4+tpUh+QBvDPYcvzIUodxyqLoBlsSc52wNk0IDVr0G
         Lr+TtYgxcDN7O5FGNEIZi9A9vz1Wf5TN369Ea3m9lo0IjGUj6Bkj18/zpB/8VxQe88M/
         VIHij2xjGnlB5iWKaT7D6D11lb7YxAM9M+b0s=
Received: by 10.100.244.32 with SMTP id r32mr18621339anh.28.1276068027263; 
	Wed, 09 Jun 2010 00:20:27 -0700 (PDT)
Received: by 10.100.229.5 with HTTP; Wed, 9 Jun 2010 00:20:27 -0700 (PDT)
In-Reply-To: <4C0EC3D0.6060509@wpursell.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148748>

On Wed, Jun 9, 2010 at 00:27, William Pursell <bill.pursell@gmail.com> =
wrote:
> Junio C Hamano wrote:
>> Alex Riesen <raa.lkml@gmail.com> writes:
>>
>>> On Tue, Jun 8, 2010 at 12:25, William Pursell <bill.pursell@gmail.c=
om> wrote:
>>>> Here's a patch. =C2=A0This doesn't address the issue of a damaged
>>>> repository, but just catches access errors and permissions.
>>> The change looks fishy.
>>>
>>> The patch moves the function is_git_directory at the level of user
>>> interface where it wasn't before: it now complains and die.
>>> Not all callers of the function call it only to die if it fails.
>>
>> Thanks for shooting it down before I had to look at it ;-)
>
> The point of the patch is that it now complains and dies.

At wrong point. Points, actually. There are many callers of the
function you modified. You should have looked at them all.

> Perhaps I'm being obtuse, but can you describe a situation
> in which this causes git to terminate inappropriately?

Maybe. BTW, can you? (if you try, I mean). But your questions
misses the point of my complaint about your patch:

The patch makes the function you modified act not as one
can guess from its other uses. Imagine someone replaced
open(2) implementation to kill your program everytime you
tried to open /etc/passwd. How'd you like that?

That alone is reason enough to dislike the change and put
you personally into a list of persons to be careful with (as
you don't seem to care about what happens with the code
after you changed it).
