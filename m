From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Dealing with rewritten upstream
Date: Fri, 30 Sep 2011 19:28:02 -0400
Message-ID: <CAG+J_Dw9Oa=LH1CSE3Dr_B6de8X-SQfrWGbayPy3OD-UqB6siA@mail.gmail.com>
References: <CAG+J_DwR4vE6iYt475EM7-VDNi4hG3jhdmXWSbJ04Y9fyHeuLw@mail.gmail.com>
	<CAMOZ1Bu-1hq1UN+UQs9HreR4bhJAoxGFLA=jdW8jgoC9g3DJHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 01 01:28:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9mV1-0006kU-6S
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 01:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758786Ab1I3X2G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Sep 2011 19:28:06 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57387 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755775Ab1I3X2D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Sep 2011 19:28:03 -0400
Received: by yxl31 with SMTP id 31so2013522yxl.19
        for <git@vger.kernel.org>; Fri, 30 Sep 2011 16:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=iuqWfAXbGEP8qxmz7gwnG0jvYmhB26KgwhxmHOBw6T4=;
        b=lxSszV4T+sLqrfF7x5mneoquwgS5wW6zbzs6ORgAKd0Aoq3gv4GKz+NypnarISOjEh
         EIsKV6+KJ16T+rkQU/MknyVJFkxflE3IKC7H+skYpAO0cEh6IPMDmGt2N1e3/nFULZZG
         lLrLTdHRQxhdDON/oEeLtEd0hW7aNiwXEY1RI=
Received: by 10.236.190.200 with SMTP id e48mr75454902yhn.59.1317425282362;
 Fri, 30 Sep 2011 16:28:02 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Fri, 30 Sep 2011 16:28:02 -0700 (PDT)
In-Reply-To: <CAMOZ1Bu-1hq1UN+UQs9HreR4bhJAoxGFLA=jdW8jgoC9g3DJHQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182524>

On Fri, Sep 30, 2011 at 7:04 PM, Michael Witten <mfwitten@gmail.com> wr=
ote:
>> Pictorially:
>>
>> ---A---B---C---D---E... new-upstream/master
>>
>> ---a---b---c---d---e... old-upstream/master
>> =C2=A0 =C2=A0\ =C2=A0 =C2=A0 =C2=A0 \ =C2=A0 =C2=A0 =C2=A0 \
>> =C2=A0 =C2=A0 1---2---3---4---5 =C2=A0master
>>
>> The obvious way do deal with this situation is:
>>
>> $ git merge -s ours -m "Splice in new-upstream/master" E
>>
>> Are there any other/better options I'm missing?
>>
>> (Eventually upstream plans to migrate entirely to git, so I can't ju=
st
>> run git-svn myself.)
>
> Surely, you'd rather have your master rewritten such that the relevan=
t
> commits of new-upstream/master are used IN PLACE of the corresponding
> old-upstream/master. Have you considered ways to achieve that?

My master has over two years of history with its commit-IDs referenced
in our bug tracker, in old emails, in archived binaries, etc. So no, I
do not want to rewrite my master.

Now, if you mean, do I want to use something like replacement refs to
try to more cleanly splice the new upstream into my existing master,
no I haven't really explored that. git-replace isn't very well
documented with examples of its intended use case.

I've considered setting up a new repo at a different URL that is
rewritten to be based on the new upstream, and migrating to that,
making the old repo read-only.

But I'm not sure that's worth the trouble. There doesn't seem to be
too much downside to splicing in the new upstream via merge -s ours.
It barely increases the repo size since the trees are the same. Maybe
there's some other downsides I'm missing.

j.
