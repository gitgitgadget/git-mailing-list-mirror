From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [RFC] git rm -u
Date: Sun, 20 Jan 2013 14:17:09 -0800
Message-ID: <CANiSa6gTOFkDA_Cuu3BrHDNE17z8qukB7h9OMvP8OVjy2ej04Q@mail.gmail.com>
References: <50FB1196.2090309@gmail.com>
	<20130119214921.GE4009@elie.Belkin>
	<vpq622s9jk1.fsf@grenoble-inp.fr>
	<7v622rn1bh.fsf@alter.siamese.dyndns.org>
	<7vobgjk0iw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	git <git@vger.kernel.org>,
	Tomas Carnecky <tomas.carnecky@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 23:23:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx3Ii-0006Be-Te
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 23:23:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561Ab3ATWXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 17:23:18 -0500
Received: from mail-wi0-f182.google.com ([209.85.212.182]:62486 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515Ab3ATWXR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 17:23:17 -0500
Received: by mail-wi0-f182.google.com with SMTP id hn14so4440717wib.15
        for <git@vger.kernel.org>; Sun, 20 Jan 2013 14:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=pW86ux/JW70waxZmTS/+CMsAXRp8bGWkRT3ZOg7Csbc=;
        b=cgDpzgyZ8uGqWxUTOOv0lg9QpbuovZGb0+CpUFU7LjcfJP0L0nKtfYonJ3yCrw1zFg
         ZVQxEa15QEhAVH1j6Lrf/zA0E6rFMlyws8qBaCSCteVvT231evVmkvI2vRi7zl6RqsXx
         IntakM74IhW4s7HQhm5aM4KbfpYQU/mJupzSV4cNZY9JwJBgEmSQ2WmQf2C80CLk0qKc
         QswWRxhfsJbBZLGgeKKNNzV4xGs6ZNVg3cd373rHcrl06n4tqlE2wiQmT00K7CiOnemW
         UQRJ9vWCjX1fgEXD4ac40yJM7ayMHJq/Sno0nOMUDicZvLBczL8EQ7VBDEnaSyzlKW4X
         Corw==
X-Received: by 10.180.84.131 with SMTP id z3mr12339986wiy.25.1358720229995;
 Sun, 20 Jan 2013 14:17:09 -0800 (PST)
Received: by 10.180.85.8 with HTTP; Sun, 20 Jan 2013 14:17:09 -0800 (PST)
In-Reply-To: <7vobgjk0iw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214056>

On Sun, Jan 20, 2013 at 1:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>
>>> "git add -u" is one of the only exceptions (with "git grep"). I consider
>>> this as a bug, and think this should be changed. This has been discussed
>>> several times here, but no one took the time to actually do the change
>
>  - As we have the "from the root" magic pathspec these days,
>    requiring "git add -u :/" when the user really means to add
>    everything is no longer too much of a burden, but if we suddenly
>    changed "git add -u" to mean "git add -u .", that is too much of
>    a change in the semantics.

And I think someone (Jeff?) pointed out that that last part is even
more true for "git clean", which also currently works on the current
directory if not told otherwise.
