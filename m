From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Revert "setup: set env $GIT_WORK_TREE when work tree is
 set, like $GIT_DIR"
Date: Tue, 22 Dec 2015 08:06:20 +0700
Message-ID: <CACsJy8DP7ugh1UAU=iGzzHTSwUm5ZPkQhS0fTvkOpQV6vP1Jxg@mail.gmail.com>
References: <xmqqh9k06all.fsf@gitster.mtv.corp.google.com> <1450693372-6863-1-git-send-email-pclouds@gmail.com>
 <xmqqegefhftq.fsf@gitster.mtv.corp.google.com> <xmqqtwnbfybj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 02:06:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBBPk-0001dw-3v
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 02:06:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbbLVBGw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Dec 2015 20:06:52 -0500
Received: from mail-lf0-f43.google.com ([209.85.215.43]:32845 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbbLVBGv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Dec 2015 20:06:51 -0500
Received: by mail-lf0-f43.google.com with SMTP id p203so121601578lfa.0
        for <git@vger.kernel.org>; Mon, 21 Dec 2015 17:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=FecldJFMDeS7WxHo1J8XI+hkrU60CBYW3FX3YE9+gig=;
        b=mmk0tGitSuAWX4OHGAWZQYqWeHlHU0wQ99EHFrlqYPEyXjPBAYArsSDdHx4O4n0w66
         0TuvY8lhEHlq2qgCQS/HMklQCKn0fPfAwk89GkMF4d4KrrBc3tcCfC8ymJD7R2v1bc2k
         8b6E66opfXpmWm7twVBmMcbz9wC22Wst98SfhfF96Mb2ZxbZNKMY9RkyKn5pspGFE1qV
         z8qRzQv8CFjhtvV9gsznfVQ/sKLzurAWzQnSaxuNEU0Z7mt936xxCJrqA47xwSqVPy9v
         1L38yUNBJDwu2yhlL4MV1nK/9F9RxhoCrEvpiEpRC0zle3Dhks41uNQTBPd4dnMUhrZK
         0VNg==
X-Received: by 10.25.137.84 with SMTP id l81mr7440610lfd.45.1450746409788;
 Mon, 21 Dec 2015 17:06:49 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Mon, 21 Dec 2015 17:06:20 -0800 (PST)
In-Reply-To: <xmqqtwnbfybj.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282827>

On Tue, Dec 22, 2015 at 1:31 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
>>
>>> This commit has caused three regression reports so far. All of them=
 are
>>> about spawning git subprocesses, where the new presence of GIT_WORK=
_TREE
>>> either changes command behaviour (git-init or git-clone), or how
>>> repo/worktree is detected (from aliases), with or without $GIT_DIR.
>>> The original bug will be re-fixed another way.
>>>
>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
>>> ---
>>>  On Thu, Dec 3, 2015 at 12:09 AM, Junio C Hamano <gitster@pobox.com=
> wrote:
>>>  > OK, when/if you decide that our first step should be a revert of
>>>  > d95138e please send in a patch to do so with a brief write-up of=
 a
>>>  > follow-up plan.
>>>
>>>  Three reports to me are enough. And I obviously could not push the
>>>  fix out fast enough. So if you want to revert it, here's the patch=
 on
>>>  maint.
>
> Also, can you reference these three reports for future reference?

http://article.gmane.org/gmane.comp.version-control.git/281608
http://article.gmane.org/gmane.comp.version-control.git/281979
http://article.gmane.org/gmane.comp.version-control.git/282691

The last one is not confirmed by the reporter yet. But I'm pretty sure
i'll trigger the special case "when GIT_WORK_TREE is set but GIT_DIR
is not" in setup code
--=20
Duy
