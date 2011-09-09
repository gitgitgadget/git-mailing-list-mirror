From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: git-rebase skips automatically no more needed commits
Date: Fri, 9 Sep 2011 08:43:17 +0200
Message-ID: <CAC9WiBhApjEr-NYm9NkyXaZPNCivoJ65c=xx2bg5Li60kfZMTQ@mail.gmail.com>
References: <CAC9WiBg9+30NjO+NKXVdBiWjR-HU2689JQqVY7Rk5+DM7MiNBg@mail.gmail.com>
	<7v1uvta97o.fsf@alter.siamese.dyndns.org>
	<CAC9WiBjrfJeJ854dkJMPwRSwuujRsYLnAd7QX7C_oU8_FdOvQA@mail.gmail.com>
	<4E676F6A.3060906@drmicha.warpmail.net>
	<CAC9WiBi_bkLNJZckq2fr3eb6ie+KVfauE_PyA3GcaW5Ga-isFw@mail.gmail.com>
	<7vk49k48q4.fsf@alter.siamese.dyndns.org>
	<CAC9WiBjMUg3SUOP9AJw6qCKrGVLs6Qy_O2fQa_SHX30NkjAEdw@mail.gmail.com>
	<alpine.DEB.2.00.1109080753460.12564@debian>
	<CAC9WiBiMYUfaPtrXyW=W7qaZnJqLeFO-B3od7X4u8wUrb8hfUA@mail.gmail.com>
	<alpine.DEB.2.00.1109082123300.12564@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 08:43:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1uoA-00078J-6c
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 08:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756629Ab1IIGnU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Sep 2011 02:43:20 -0400
Received: from mail-vw0-f43.google.com ([209.85.212.43]:35984 "EHLO
	mail-vw0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728Ab1IIGnS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2011 02:43:18 -0400
Received: by vws10 with SMTP id 10so995040vws.2
        for <git@vger.kernel.org>; Thu, 08 Sep 2011 23:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=YfStSrEYmhdjt7+K/379W+QySWcZf6VpzXvxOKcCCKk=;
        b=GXPZMj8ZT7YLr5bP1794hVhYUIk7S67oL/HKaChoE3sk7w+ENY1wiclM5bBw53zw5/
         33hROvscLxmd2DoIdSJSX9uYAcQg0d1mVQfA7q7nmBU4xfcFXQMj9DNtJZiJLufnD+J4
         36I9h1swhBpjma3pM8U9uEm76/adkq7owpthQ=
Received: by 10.52.22.175 with SMTP id e15mr1693294vdf.280.1315550597567; Thu,
 08 Sep 2011 23:43:17 -0700 (PDT)
Received: by 10.52.108.227 with HTTP; Thu, 8 Sep 2011 23:43:17 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1109082123300.12564@debian>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181028>

On Fri, Sep 9, 2011 at 4:23 AM, Martin von Zweigbergk
<martin.von.zweigbergk@gmail.com> wrote:
> On Thu, 8 Sep 2011, Francis Moreau wrote:
>
>> On Thu, Sep 8, 2011 at 3:14 PM, Martin von Zweigbergk
>> <martin.von.zweigbergk@gmail.com> wrote:
>> >
>> > Patches that are in both sides of v2.6.39...foo will be filtered, =
but
>>
>> what do you mean by "both sides" ?
>
> See the section called "SPECIFYING RANGES" in "git --help
> rev-parse". It doesn't define "both sides", but what I mean by that i=
s
> "both in v2.6.39..foo and in foo..v2.6.39". I believe that section
> will answer most of the other questions too.
>
>> Yes my use of "git rebase --onto master foo~10 foo" =A0is equivalent=
 to
>> "git rebase master foo, the only difference is that the --onto varia=
nt
>> allow me to limit the range of commits that I want to rebase. So I
>> still want git rebase to do its the filtering process.
>
> Ok, that is different. I think you used v2.6.39 instead of foo~10
> previously. Assuming that v2.6.39 is the merge base of foo and master
> and that foo~10 is a later commit than v2.6.39,

That's what I meant.

> you are right that
> "git rebase --onto master foo~10 foo" could potentially filter out
> patches already in foo..master, without calculating patch-ids for all
> commits in master..foo for that matter. I think that would make sense

you meant master..foo~10, didn't you ?

> and as I said, it has been on my todo list for a long time. If

please let me know when you submitting your work, I'm interested to see=
 it.

> necessary, we could have a flag to disable the filtering e.g. when th=
e
> user knows that master is part of a completely separate history from
> foo.

Can't git figure this out itself ? (I'm not saying the switch is useles=
s)

Thanks
--=20
=46rancis
