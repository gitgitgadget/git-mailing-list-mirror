From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 2/2] receive-pack: ignore duplicated commands which can 
	occur with symrefs
Date: Thu, 15 Apr 2010 19:07:52 -0400
Message-ID: <y2g76718491004151607u58021df8naab23b6daf06513d@mail.gmail.com>
References: <1271364848-32805-1-git-send-email-jaysoffian@gmail.com>
	 <1271364848-32805-2-git-send-email-jaysoffian@gmail.com>
	 <7v39ywiat9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O . Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 16 01:09:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2YB8-0003AN-1E
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 01:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758046Ab0DOXH4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Apr 2010 19:07:56 -0400
Received: from mail-iw0-f197.google.com ([209.85.223.197]:57590 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758033Ab0DOXHx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Apr 2010 19:07:53 -0400
Received: by iwn35 with SMTP id 35so934208iwn.21
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 16:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NY4iOjsCrtomnifx4uM1zESKogkNVIFqEA/PzbJuX1Y=;
        b=WBGFmVz8meB3wc39+rUkpwBw9Jr622mShssxMxVHl2Z9ZLcqLGNRoQ7U02vOUExWv8
         h4iOBRPyM7v01splXXU0AjKNTJPT7imdH2QZzjgV9foNje1lEHZw/M0omSpOPcWO4zrn
         BW0si7yVfUZgRv5UU5XX5zssaM/MGuc16sQ0M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=U4OaUL/6MJMLcw4n1EC/gRlr5IWHzIaqVq022Wl0PoMVFj7drwsUROXsoJ5+s1DKz3
         V4mgjjnNGdbrg0yEoo3q1um4nbPt8cxg8nIK+IxDMT6MNExpxsYw+w5PYfxbYTsMUFRT
         W4nRV1N3SlYDr8pX0uBRi8zSngHo6jb7VZiVA=
Received: by 10.231.36.9 with HTTP; Thu, 15 Apr 2010 16:07:52 -0700 (PDT)
In-Reply-To: <7v39ywiat9.fsf@alter.siamese.dyndns.org>
Received: by 10.231.156.65 with SMTP id v1mr284430ibw.67.1271372873060; Thu, 
	15 Apr 2010 16:07:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145033>

On Thu, Apr 15, 2010 at 6:57 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> When pushing to a remote repo, normally the sending side tries to
>> filter out any aliased updates (e.g, foo:baz bar:baz). However, it
>> is impossible for the sender to know if two refs are aliased on the
>> receiving side via symrefs. Here is one such scenario:
>>

> [... lots of good feedback ...]

Will incorporate and re-roll.

> This will also catch two symrefs that point at the same underlying re=
f.
> If all three are updated consistently then all will be fine. =C2=A0If=
 even one
> of them is inconsistent, we will try the update() and give an error
> message.
>
> We _could_ give even stronger error message to help diagnosing the
> situation if we wanted to.

Okay, I'll see what I can figure out.

> Very nice.

I appreciate the compliment, but it is unexpected after reading your
reply to "failed to lock". I think your suggestion there (fix
verify_lock()) probably addresses the real problem in which case this
is just a band-aid.

j.
