From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [PATCH] git-difftool: allow skipping file by typing 'n' at prompt
Date: Wed, 5 Oct 2011 04:35:44 +0530
Message-ID: <CAMK1S_gssgpy7nF46c1roJUCN5yvQaOYfVE_-ZrvMfHGWKvk0w@mail.gmail.com>
References: <20111004105333.GA24331@atcmail.atc.tcs.com>
	<7vbotwdbjg.fsf@alter.siamese.dyndns.org>
	<CABURp0qmYWRJzHZZwZreKnj0ymFyM_AYXWXqwy=vTZspoPvvvg@mail.gmail.com>
	<7vty7oblpu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Phil Hord <phil.hord@gmail.com>,
	Sitaram Chamarty <sitaram@atc.tcs.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 01:05:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBE3b-0004ZL-7l
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 01:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933708Ab1JDXFq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Oct 2011 19:05:46 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58532 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933158Ab1JDXFp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2011 19:05:45 -0400
Received: by qadb15 with SMTP id b15so813566qad.19
        for <git@vger.kernel.org>; Tue, 04 Oct 2011 16:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=A1hLoVLIUH9qozZ8cfffQ8H4RA7I/Yu9xy6QHHCQO6w=;
        b=wzf0D0erGa+t4KY9ebYrO4P/X1GaNrJp+kHv0fRc2sShI/ErwEXX0n4ezEpo9FHSTV
         xAA3QurAAB6qoeRY5dtt56yKixQpi7N3WTKkD1whVk1YkPxB+aGOxbr2M9v1Y1t3eyvQ
         Of/0tfeAWllR839BFF6ukdP5MJnyZD7n66xzg=
Received: by 10.224.210.10 with SMTP id gi10mr1589386qab.21.1317769544831;
 Tue, 04 Oct 2011 16:05:44 -0700 (PDT)
Received: by 10.224.54.71 with HTTP; Tue, 4 Oct 2011 16:05:44 -0700 (PDT)
In-Reply-To: <7vty7oblpu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182813>

On Wed, Oct 5, 2011 at 12:58 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Phil Hord <phil.hord@gmail.com> writes:
>
>> On Tue, Oct 4, 2011 at 11:25 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>
>>> I think I've seen this done as: "do this? [Y/n]" elsewhere.
>>>
>>> Not telling you what to do, but trying to feel what others may thin=
k.
>>
>> I think so, too. =C2=A0The [y]/n syntax is not clear enough for me t=
o
>> confidently know what the default value will be.
>
> One downside of "do this [Y,n,m,o,p,q]? " is that it limits us to
> lowercase responses, which means we cannot assign 'q' for quitting fr=
om
> the innermost nested context and assign 'Q' for quitting from the who=
le
> interactive loop (e.g. "git add -p").
>
> =C2=A0 =C2=A0"do this [y,n,m,o,p,q] (default=3Dy)? "

Does this even make a difference in this case?  I was going to send
out a new patch using [Y/n] instead of my original [y]/n.  There's
only one loop in this thing, and till now people have been presumably
hitting Ctrl-C to get out of it.  I see no real need to make that more
elegant; all I set out to do is add one teeny weeny bit of
functionality to a prompt that -- other than giving you a chance to
hit that Ctrl-C -- was not actually doing anything useful at all.

>
> may have been a better choice in hindsight.
>
> No matter what we end up doing, let's try to be consistent.

The only other part of git where I have ever used a prompt is 'git add
-p'.  Consistency with *that* prompt, to me, would mean colors.  And
help text.  And I'm not sure what else, really, since I only used it
superficially.

Isn't that overkill for this case?

I'll wait a few hours for any further comments then send out a patch
that is the same as my original one except it uses [Y/n] instead of
[y]/n.
