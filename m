From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Should GIT_AUTHOR_{NAME,EMAIL} set the tagger name/email?
Date: Sat, 1 Sep 2012 18:06:47 +0200
Message-ID: <CACBZZX4Egrx_vrKNV68pL8DL4xkLd5j8o-1t4+fA7+Ai758-9g@mail.gmail.com>
References: <CACBZZX7Ud8Xx225ss6SYqZFXyW0FG2XJimBWdvW_NuMqn8yOnA@mail.gmail.com>
 <m2ehmlwxb2.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Sep 01 18:07:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7qEB-0001uK-Ig
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 18:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755537Ab2IAQHJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Sep 2012 12:07:09 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:47530 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071Ab2IAQHI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Sep 2012 12:07:08 -0400
Received: by obbuo13 with SMTP id uo13so7227482obb.19
        for <git@vger.kernel.org>; Sat, 01 Sep 2012 09:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=jHJwmzHM29M+2sUHXi9gI3V7NK5GGksEUdJgLzrH6K8=;
        b=sjJ369VKanmC6AkIX9hIMKnlpnU0h2CtAjIvRAxnCMHnHDM0Z/3GcwgdgXfeCPG3Ua
         o7Ej8/TQfZMlWUgpPihTMmLg3WSOAuflji4s22PiU/A5krnoD3KfWzF7mBjOxchundU8
         73MG6vkFH18h5V6WYoqUD5VgLLjL458HkDW5XuNtOFJVdAhBr/JXiknejLmW3LZGJXVK
         I4+4a6r7R6D69ajYAfNZRW2ROwIBgHfOtxnvLvlqIcH/4c/R+p2Xk9Nx96q/4en/mzUX
         WmY9bItv4DcutmBRwg+SB+bZIoOaRFkeIvuQXMjcYP0MUeE05uGEU+XDa8wsG1N+yeF3
         5lEw==
Received: by 10.60.28.162 with SMTP id c2mr10730706oeh.3.1346515628066; Sat,
 01 Sep 2012 09:07:08 -0700 (PDT)
Received: by 10.182.48.34 with HTTP; Sat, 1 Sep 2012 09:06:47 -0700 (PDT)
In-Reply-To: <m2ehmlwxb2.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204637>

On Sat, Sep 1, 2012 at 5:57 PM, Andreas Schwab <schwab@linux-m68k.org> =
wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>     git --no-pager show tag-name-1 | grep ^Author
>
> A tag doesn't have an author, it has a tagger.  This shows the author=
 of
> the *commit*.

I got the grep wrong, I meant that I expected the tagger to be set
according to GIT_AUTHOR_{NAME,EMAIL}, but it isn't either:

    $ sh /tmp/test-tag.sh
    Initialized empty Git repository in /tmp/test-git/.git/
    [master (root-commit) f83fc11] README: testing content
     1 file changed, 1 insertion(+)
     create mode 100644 README
    Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
    [master ef65731] README: testing content again
     1 file changed, 1 insertion(+), 1 deletion(-)
    Author: Test User <test@example.com>
    Tagger: Test User <test@example.com>
    Author: Test User <test@example.com>
    Tagger: Test User <test@example.com>
    Author: Test User <test@example.com>

>>     GIT_AUTHOR_NAME=3D"Tag Test User"
>> GIT_AUTHOR_EMAIL=3D"tagtest@example.com" git tag -a -m"another annot=
ated
>> tag" tag-name-2
>
> The tagger is controlled by the committer info.

I don't get what you mean, what committer info?
