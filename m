From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: Officially start moving to the term 'staging area'
Date: Wed, 4 Sep 2013 00:23:46 -0400
Message-ID: <CAM9Z-nmLQUrJk73pi_0a1_ccGMnqU_t=uOZze622_GEtWfMvQQ@mail.gmail.com>
References: <20130829180129.GA4880@nysa>
	<xmqqeh9c4a2t.fsf@gitster.dls.corp.google.com>
	<CAM9Z-nmXPgfbXezbORb=NCqQuW4p3Dka+bHVdt_n7Sh=jehY7A@mail.gmail.com>
	<b677f1ae-662f-4728-b625-189bc392c74d@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 06:24:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VH4dQ-0001zr-9w
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 06:24:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756320Ab3IDEXv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Sep 2013 00:23:51 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:52988 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183Ab3IDEXr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Sep 2013 00:23:47 -0400
Received: by mail-ie0-f181.google.com with SMTP id a14so12004833iee.40
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 21:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ZgsEIFk3BS8kky8pBM06IAmEehxcDYvmP9Qge3d/EnI=;
        b=GCbsO6qi51Zt4z0nlCEcflwZMNMcxX4jBjnhkZmhPkdn3U4BlsOIeMVj/HB+D1aKG7
         evu/l1NU9ImyPmX5xrrwmEXGdC0DbmRR8m87Y2ZXywFamJBEmg3Lk+Vv1JuxjnrHoKEF
         9eimn/6/XIBtlpTo2XYkGvNZotmIPPkAfmiQOqDzzSag3kidRvKosvXh/ktBOIVfE4ZW
         gTY0HMKy2yWNUnmzua+nOct/kq6zgl88yP4WE8YNiJfNz3SHq7H8AHYoXTcNE7fgyGVW
         7VjvPoiQGGCND8HteLLNXDnG8vo0wsozDajTkTM+o5x1hey7JuKW99F6eyDveX+VxudU
         ejeA==
X-Received: by 10.50.23.76 with SMTP id k12mr371700igf.37.1378268626573; Tue,
 03 Sep 2013 21:23:46 -0700 (PDT)
Received: by 10.43.111.72 with HTTP; Tue, 3 Sep 2013 21:23:46 -0700 (PDT)
In-Reply-To: <b677f1ae-662f-4728-b625-189bc392c74d@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233802>

On Fri, Aug 30, 2013 at 1:16 AM, Piotr Krukowiecki
<piotr.krukowiecki@gmail.com> wrote:
> Drew Northup <n1xim.email@gmail.com> napisa=C5=82:
>>I agree with Junio. This effort is better spent making the
>>documentation clearer and more succinct. The reality is that a user
>>needs to build a model in their mind of what they are doing which map=
s
>>enough (completely is not required) to what is actually going on to
>>get work done. If the documentation or the instruction is getting in
>>the way of that in the name of simplifying the presentation then the
>>presentation is wrong.
>
> Why do you think the "stage"  model do not map enough?

When I try to explain how to use git to complete VCS newbies in
general they find the "snapshot" model more mentally sensible than the
"staging area" model. (In other words, the user doesn't care how, if,
or where the program is maintaining state.) The "snapshot" model does
not require knowledge of the index and does not get in the way of
later on learning more advanced concepts which benefit from the index
being explained as what it is--explanations which quite frequently
bring up the "staging area" model (but in that case as a portion of
the index used to store snapshot state information).

>>We add content snapshots to the index of content (creating
>>"temporary"--they will be garbage collected eventually if they become
>>orphans--objects into the store at the same time). We build commits
>>from those snapshots (in whole or in part, typically only using the
>>most recent snapshots of new things added to the index) and save thos=
e
>>in the object store with the content and tree objects. Sometimes we
>>create tag objects to record something special about commits, trees,
>>and content blobs.
>
> The above can be rewritten to use the 'staging area' concept just
> fine. And I don't think you should say to inexperienced users things
> like 'tree objects'.

At what time did I say specifically what I tell newbies? I did not do
so. Please refrain from making that sort of assumption. In any case,
no, you cannot rewrite that to use "staging area" in place of "index"
without introducing a different mental model and new concept into the
text (a model which happens to be incomplete, but not incorrect). That
minimalist summary was written for the technically-minded people here
on this list debating the issue of communications with the users--the
bane of all programmers' lives.

> A good exercise would be to take documentation of some command
> and show that it can or can't be rewritten to use the other term.

That may be a good exercise in matters of philosophy, but you will
find few outside of the world of programming who would agree with that
characterization of the optimization of technical writing. (In the
English language in particular it is folly due to the extreme
variation of available terms and metaphors with nearly identical
denotations and greatly varying connotations.)

> Instead of 'indexing' or 'staging' content you could also use term 'm=
ark'.
> You mark content to add, for removal, you can diff it or revert.

So far as I am concerned the introduction of a specific "staging area"
(as if it has a distinct physical presence) is superfluous to that.

>>That's the real model (with some rough edges). Explaining what that
>>has to do with distributed version control is the hard part.

Again, let us keep our argument focused on communications with users.
Renaming core objects is just going to sow confusion without fixing
the user communication issue. That's what I meant the first time I
wrote what I quote directly above and I'm sticking to it.

--=20
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
