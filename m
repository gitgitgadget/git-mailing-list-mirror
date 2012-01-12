From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH RFC] commit: allow to commit even if there are
 intent-to-add entries
Date: Thu, 12 Jan 2012 09:53:22 +0700
Message-ID: <CACsJy8CHOuZMP4hWp6Lb_TbdfwSgofSg_0tDZ4oDcD0veie2Dw@mail.gmail.com>
References: <1326261707-11484-1-git-send-email-pclouds@gmail.com>
 <7vr4z67jbb.fsf@alter.siamese.dyndns.org> <20120111110222.GA32173@burratino> <7vr4z654m3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Will Palmer <wmpalmer@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 03:54:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlAng-0004oU-8P
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 03:54:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388Ab2ALCxz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jan 2012 21:53:55 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53638 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198Ab2ALCxy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2012 21:53:54 -0500
Received: by bkvi17 with SMTP id i17so924986bkv.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 18:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=7cHu3M7YLUogd1/NTrHWls463Pbww/nQg1SeXNYV620=;
        b=ehdTnQedN7gk+mkVQ1wCe9DAQL3OhPU7nkoGiD5aXJkU5dKK5x+O1/RTu9zyRbJ+Qh
         dIMlz5qbY3x3cUcYWLAi+u6OCSl3kZbT+cw/LPz2rbYToTia5eBiI9Rgl6Ixp7C1FgXr
         895Mhl9BG+T61g31k36qUk8VLbcW4Ra8cnfIc=
Received: by 10.204.156.83 with SMTP id v19mr539737bkw.40.1326336833146; Wed,
 11 Jan 2012 18:53:53 -0800 (PST)
Received: by 10.204.66.77 with HTTP; Wed, 11 Jan 2012 18:53:22 -0800 (PST)
In-Reply-To: <7vr4z654m3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188418>

2012/1/12 Junio C Hamano <gitster@pobox.com>:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> When running "commit" and "status" with files marked with "intent t=
o add",
>>> I think there are three possible interpretations of what the user
>>> wants to do.
>> [ (1) thanks for stopping me, I had forgotten about that file;
>> =C2=A0 (2) I changed my mind, please leave that file out; or (3) ple=
ase
>> =C2=A0 dwim and add the file ]
>>
>> I think (3) was a trick --- no one that does not use the "-a" option
>> would want that. :)
>
> I really wish it were the case, but I doubt it.
>
> People from other VCS background seem to still think that "commit" wi=
thout
> paths should commit everything; after getting told that "what you add=
 to
> the index is what you will commit", I can easily see this commint: bu=
t but
> but I told Git that I _want_ to add with -N! Why aren't you committin=
g it?

I see "-N" just as an indication, not really an "add" operation.
Perhaps update-index is a better place for it.

>> (2) makes intent-to-add entries just like any other tracked index
>> entry with some un-added content.
>
> You are comparing files edited in the working tree without the user
> telling anything about them to Git (both tracked and untracked) and f=
iles
> the user explicitly told Git that the user hasn't made up her mind
> about. Why is it a good thing to make the latter behave "just like an=
y
> other"?

The way I see this flag is "include these files in my diff in addition
to tracked files", and therefore should not have any effects at commit
time. I might turn some of those extra files to tracked some time if I
want to commit.
--=20
Duy
