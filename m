From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/7] worktree.c: add clear_worktree()
Date: Wed, 11 May 2016 02:42:17 -0400
Message-ID: <CAPig+cSNvsJH5Ax3CD=z2VR5tUOY2CyzP-MgRHAH7CvQc51qmA@mail.gmail.com>
References: <20160510141416.GA22672@lanh>
	<20160510141553.22967-1-pclouds@gmail.com>
	<20160510141553.22967-5-pclouds@gmail.com>
	<CAPig+cS-tb_hD3k2XsTioJrkzaB3FxSnrxM6JMq5-og1ADnoRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 11 08:42:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0Nqh-0004w6-5d
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 08:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbcEKGmT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 May 2016 02:42:19 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:32994 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbcEKGmS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2016 02:42:18 -0400
Received: by mail-io0-f195.google.com with SMTP id x35so4538709ioi.0
        for <git@vger.kernel.org>; Tue, 10 May 2016 23:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=G0wBYiRRIenwhck7Q1Mt3w9T4O7SLaFuiR6ptqfnbSg=;
        b=CVenUaOc955SLqIjXNdGb0z7Ec/ZYkjFt6xhzisRjx6gVXH2wpjw4h68DurIXZ1+32
         zH+OclE4XSd90VbKeb0/c217awvomCmbUEMqQJoNSeRvdYrjqkKIAwpOUn0rSR+JmDp8
         QmNrIYDZPbrypM7TvuAy8JM15/LM1qM3Ux9Cfon4tkaLHgKwE4m9e30vsuBqS0MXdg8I
         6vj35RtVLyJuaP3Eimq8Qo/Y5IRvgPqqHj28M7WEgZs2Ugf28mbfPjbLo0yjrnRmoLYY
         lclVUo/Z6mnmfKnsdp+0imKSPgl5xUuXpeDl+BWHYxKR9J5fnakXoFOHnX1RCexa0GgZ
         XK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=G0wBYiRRIenwhck7Q1Mt3w9T4O7SLaFuiR6ptqfnbSg=;
        b=WQlhwKt43TU/J7TAblTliaz3FDPOXlArooX4r83Uu7zDf33vPVNZXp9I5OgwKBusp7
         m0yaSPrudmLzkwdo3/E9fyC1TW/6B31hDxov9bKHYMDUqFJjWzX7fLcL+6/ux9ld67OM
         8HbhZyzLb531g1vKAvVHZT06nk0g0Xew9ApzeDY9I6UTevfbF8s1OzJIlyrFNI/ly8bW
         P9ddhGACHpf9McdSD13nOH30yIMth0jV9j8kyh/9SZgTXDOMydasR7zSV2q0XiTv2QO1
         yiyTyw269o5p/JyT7/aKEK3u5WiqQxkbqWGaKES44kIrXfnmKdMY87NNoLqs0TFGNyfp
         TEYQ==
X-Gm-Message-State: AOPr4FXdwsxM9QjXCwApDgsXqT+wpkc9+yBVv5p7eDF06MJ0kTK0+ahONfcvnzYYuqZv8up/XXavwmqBQzLPaA==
X-Received: by 10.107.132.66 with SMTP id g63mr2103163iod.34.1462948937959;
 Tue, 10 May 2016 23:42:17 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Tue, 10 May 2016 23:42:17 -0700 (PDT)
In-Reply-To: <CAPig+cS-tb_hD3k2XsTioJrkzaB3FxSnrxM6JMq5-og1ADnoRg@mail.gmail.com>
X-Google-Sender-Auth: CNc4KOC_YmT7_SnZ20hLkSWJjJ4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294231>

On Wed, May 11, 2016 at 2:36 AM, Eric Sunshine <sunshine@sunshineco.com=
> wrote:
> On Tue, May 10, 2016 at 10:15 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy
> <pclouds@gmail.com> wrote:
>> The use case is keep some worktree and discard the rest of the workt=
ree
>> list.
>
> So, you're saying that rather than a client freeing the entire
> worktree list like this:
>
>     free_worktrees(worktrees);
>
> it might instead want to keep some element ('n') and free all others
> plus the list itself, like this:
>
>     struct worktree *keep =3D worktrees[n];
>     struct worktree **p =3D worktrees;
>     for (; *p; p++)
>         if (*p !=3D keep)
>             clear_worktree(*p);
>     free(worktrees);
>
> Is that correct?
>
> If so, then doesn't this require the client to have far too intimate
> knowledge of the internals of free_worktrees(). Or, was your idea tha=
t
> the client would simply leak the 'worktrees' array after freeing the
> unwanted elements?
>
> In either case, a cleaner approach might be to provide a function for
> copying a worktree element. Perhaps:
>
>     struct worktree *copy_worktree(const struct worktree *);

Of course, you'd still need a clear_worktree() or free_worktree()
function to dispose of the copy.
