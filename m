From: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
Subject: Re: How to add custom metadata to Git commit object
Date: Tue, 31 May 2016 18:17:23 +0300
Message-ID: <A5ADADA5-B772-488E-8FAD-20FCB68E5933@jetbrains.com>
References: <959E96F7-0FF3-4336-B098-58836136DB08@jetbrains.com> <20160530183016.GB17253@sigill.intra.peff.net> <xmqqtwhf8jl7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, kostix+git@007spb.ru
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 31 17:17:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7lQB-00043t-U5
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 17:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754371AbcEaPR1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 May 2016 11:17:27 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:33746 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754604AbcEaPR1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2016 11:17:27 -0400
Received: by mail-lf0-f46.google.com with SMTP id s64so68985000lfe.0
        for <git@vger.kernel.org>; Tue, 31 May 2016 08:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jetbrains.com; s=googleapps;
        h=from:mime-version:subject:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xU3vpbVXQmeb50tiaFyzIdpkfqKNmJDhsfaWhCX7arg=;
        b=A8aOdoew4c4i2l4MXrvy+GA5InxlVYnDhScuOLnDrAD13cTnu4RZWgU6mgK4jb289f
         jnPEdcLOgUODnBZyMr7WALArQYzIkcaDAyhbEb9V1p6dRU638JCFBlXHavGZI3Gf3Aa7
         Jjv/FlrqNqN+L0s9HbzjKJhksr6zIGQiFIOXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:mime-version:subject:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xU3vpbVXQmeb50tiaFyzIdpkfqKNmJDhsfaWhCX7arg=;
        b=c7KWFo2MAymouwp30SZpN3NWA5d51R+53Za3fOGKbC8UuQ7mdB/d1BX86qkYebP8y1
         6o8oo3Pq1rAUQsoUN5BLc88C39TgesiD9OnBe6ekrWQySYC5XDsBpEzR7Bj2UkqkfeOz
         uZPlj40joIDOJLbWgwaAMJ5sxSeRsCaFfhhUP7P1Uimf+osK/P+esnXl564QPc9FZGY+
         tpnuMuij9/kZbMzYvI3OaQG4Pt40w7iIdaJDDEtv2buNZvtiWzNQ/HXHYiRebTIZRF7N
         c3jf+8HbWGfWlQGvQgCANXjDja2677dwforbSwV+DjvLRNukjHGseEjUIboVBa3uk3es
         VpVw==
X-Gm-Message-State: ALyK8tJmozb4fUCsRiT9f4ndcBPEN9LEfFQ3u6PqmiL0S/Z9PHhVZe/r3OO95zFh5wq0gYId
X-Received: by 10.25.24.88 with SMTP id o85mr11791463lfi.58.1464707845009;
        Tue, 31 May 2016 08:17:25 -0700 (PDT)
Received: from loki.times.labs.intellij.net ([195.144.231.194])
        by smtp.gmail.com with ESMTPSA id qd3sm1397329lbb.0.2016.05.31.08.17.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 31 May 2016 08:17:23 -0700 (PDT)
X-Google-Original-From: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
In-Reply-To: <xmqqtwhf8jl7.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295984>


Thanks a lot for your suggestions!

> And "the user can use notes for other purposes" is not a good reason
> to reject them.  The whole point of allowing custom notes ref is so
> that Kirill is not restricted to use the usual notes/commits ref to
> store this custom notes in its dedicated notes/kirills-metadata ref.

I think the suggestion from Junio will suit best.
=20
Somehow I missed the fact that notes can reside in several namespaces.=20
Now I see that the notes are very powerful having namespaces
and several configuration and environment variables.

Jeff,

> there are user-invisible headers before the commit message, too, but =
we do not
> usually recommend people to add new headers here, as their semantics
> would be unclear to git. For example, when rebasing such a commit,
> should the header be preserved or not? It depends on its meaning.
> Whereas commit messages are always preserved.


Good point about rebase.=20
Just out of curiosity, is it possible to add a custom invisible header=20
to commit object with some Git command?=20
git commit or commit-tree don=E2=80=99t have an option for this.


> On 30 May 2016, at 21:52 , Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Jeff King <peff@peff.net> writes:
>=20
>> On Mon, May 30, 2016 at 08:58:08PM +0300, Kirill Likhodedov wrote:
>> ...
>>> There are git-notes, which could be used for the purpose, but they =
are
>>> visible to the user via standard Git command, and could be used by =
the
>>> user for other purposes, so they are not very suitable for the task=
=2E
>>=20
>> Notes would work for this, too, but their main advantage is that the=
y
>> can be created _after_ a commit has already been made (whereas anyth=
ing
>> in the commit object itself will influence its sha1 id).
>=20
> I would have said the same but with s/but/and/.  If the "rename
> hint" or whatever other "custom metadata" Kirill gives to a commit
> is found to be wrong, it can be corrected later.
>=20
> And "the user can use notes for other purposes" is not a good reason
> to reject them.  The whole point of allowing custom notes ref is so
> that Kirill is not restricted to use the usual notes/commits ref to
> store this custom notes in its dedicated notes/kirills-metadata ref.
