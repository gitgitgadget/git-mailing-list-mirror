From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/3] Move copy_note_for_rewrite + friends from
 builtin/notes.c to notes-utils.c
Date: Wed, 12 Jun 2013 13:28:05 -0500
Message-ID: <CAMP44s3KAeDPo1Cw8eFsU=A6H7oUGmf+eLAMvGV+R2_hPXHLbw@mail.gmail.com>
References: <7vehc8a05n.fsf@alter.siamese.dyndns.org>
	<1370995981-1553-1-git-send-email-johan@herland.net>
	<1370995981-1553-3-git-send-email-johan@herland.net>
	<CAMP44s2pUW_+w6B_R-A=vxOg1Ay6iLmc4MQsA_sfDF+GP-XsWw@mail.gmail.com>
	<CALKQrgfxrKz5bB=AAmL1ZtBFRK2Bx6TrRd1AsMEVv8bTAH0KCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, git@vger.kernel.org, jrnieder@gmail.com,
	pclouds@gmail.com, artagnon@gmail.com, john@keeping.me.uk,
	vfr@lyx.org, peff@peff.net, torvalds@linux-foundation.org,
	Thomas Rast <trast@inf.ethz.ch>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jun 12 20:28:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmpmH-0003hn-2q
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 20:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757894Ab3FLS2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 14:28:08 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:63445 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755957Ab3FLS2G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 14:28:06 -0400
Received: by mail-lb0-f179.google.com with SMTP id w20so8892755lbh.38
        for <git@vger.kernel.org>; Wed, 12 Jun 2013 11:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=94WYgsFVB/g6yDq07Xkmoh5jc3L5dcS/vKHBRIS4ciE=;
        b=aXsxzHdAjHJkV5zcns4PjoW9LubflITbkRgM3k/5rQbu8PScs62HKdwwd9oCRhnpGl
         dxHc0Ipb05H7e5sb+Lh71KJPvw3p8AW7tsDdx2FvUpRZ7Ot0dHdiTUS3sMbMNmC+fT6w
         naHafjeZ14Zb2GT09PtBROPP0jtdWocZegMABI+C5Ltd5JGE5KmZdzBOVeshho2n8fbE
         g5RN+Kg9g16Hz5CMfGFjLo3Tna0NP5z5ZMEkJG6k97Ql+9capSVh5x0Ajvep0ovcjxhX
         aCAzIqNZ6muhXcaUvkUCnqTUff6D1/bMWBQa/ThQ7+Bn1fS8+SSzEfAr8KC0iXYDcC34
         VTYg==
X-Received: by 10.152.28.162 with SMTP id c2mr5769739lah.45.1371061685264;
 Wed, 12 Jun 2013 11:28:05 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Wed, 12 Jun 2013 11:28:05 -0700 (PDT)
In-Reply-To: <CALKQrgfxrKz5bB=AAmL1ZtBFRK2Bx6TrRd1AsMEVv8bTAH0KCg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227661>

On Wed, Jun 12, 2013 at 2:10 AM, Johan Herland <johan@herland.net> wrote:
> On Wed, Jun 12, 2013 at 2:32 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Tue, Jun 11, 2013 at 7:13 PM, Johan Herland <johan@herland.net> wrote:
>>> This is a pure code movement of the machinery for copying notes to
>>> rewritten objects. This code was located in builtin/notes.c for
>>> historical reasons. In order to make it available to builtin/commit.c
>>> it was declared in builtin.h. This was more of an accident of history
>>> than a concious design, and we now want to make this machinery more
>>> widely available.
>>>
>>> Hence, this patch moves the code into the new notes-utils.[hc] files
>>> which are included into libgit.a. Except for adjusting #includes
>>> accordingly, this patch merely moves the relevant functions verbatim
>>> into the new files.
>>>
>>> Cc: Thomas Rast <trast@inf.ethz.ch>
>>> Signed-off-by: Johan Herland <johan@herland.net>
>>
>> I wonder where you got that idea from. Did you come up with that out thin air?
>
> Obviously not. I should add
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>

You are still not explaining where the idea came from. And you are
doing that with the express purpose of annoying.

Where did the idea come from?

-- 
Felipe Contreras
