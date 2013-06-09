From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2013, #03; Thu, 6)
Date: Sun, 09 Jun 2013 14:20:33 -0700
Message-ID: <7v1u8bouam.fsf@alter.siamese.dyndns.org>
References: <7vzjv2x3p7.fsf@alter.siamese.dyndns.org>
	<20130607000006.GA25731@goldbirke>
	<CALkWK0=D7sHLgptWkFHma1FoS-zdifHqXnuuBKhkyuszgEJ0Xw@mail.gmail.com>
	<7v8v2lu5ks.fsf@alter.siamese.dyndns.org>
	<20130607191643.GA31625@goldbirke>
	<7vwqq5snzi.fsf@alter.siamese.dyndns.org>
	<20130607204430.GD31625@goldbirke>
	<7vk3m5si4h.fsf@alter.siamese.dyndns.org>
	<20130608001147.GA32350@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Jun 09 23:20:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uln2e-0006sW-2v
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 23:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226Ab3FIVUg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 17:20:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33320 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089Ab3FIVUg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 17:20:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85B1325BAB;
	Sun,  9 Jun 2013 21:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=Tn71JyBX8Jsf/i+XbW6c88RNc
	eE=; b=wx7js6SuXH/4PPXmu2jp8v3+/xTEA20sMLpkW6iyGq0jnKlUzsw2V3+qZ
	EIoQzMHsiAMOSDv1SsS4IKZILR97fAzHQEsGvBsndUSBntp8Z5SmW4lNhxY6HpIl
	dD3SlvDUXQ+/1aQ8AnPiepodUfRkKXMOeOTYG+YvdlbFGrDPd4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=oLRJV+P3ZRylQF3wEE1
	oxBg63jWS1bZMWV2ICkV9U0TFjcXht1Po+vjCBcXz9EiNikShW8AyVHxTObJScdq
	WXHCGyeddfNFhN1le1Z7CGQybQfJ/I6gobXNA0dyP7/tRsYBohPcw4+DiitJjopS
	OAhdvl1hlpSuzRNVDHXd2uqg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BAA225BAA;
	Sun,  9 Jun 2013 21:20:35 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B2F5325BA9;
	Sun,  9 Jun 2013 21:20:34 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6C301B70-D14A-11E2-BD6B-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227169>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

>> It is somewhat annoying that "git diff gi<TAB>" stops at expanding
>> it to "git diff git" and then upon another "git diff git<TAB>"
>> offers tags whose names begin with "git" (e.g. gitgui-0.10.0) but
>> the pathname git.c is not included in the choices.  My wish was to
>> take the union in such a fairly limited case.  I tend to agree with
>> you that "git diff <TAB>" that expands to all refs and pathnames
>> would be useless, but so is expansion to all pathnames (or refnames
>> for that matter).
>
> ... or trying to complete a branch name starting with a 'v', and then
> getting all the vx.y.z tags.
>
> If you know you want git.c, then you can force filename completion
> either by entering "--" before hitting tab...

Yes, that is exactly why I said "the current completion code already
works better than reasonably well, at least for me" in the
concluding part of my message.

Regarding that rr/complete-difftool topic, let's revert the tip 2
commits (the "ls-tree, archive and show" one, and the follow-up
resurrection of __git_complete_file) with this:

    Revert 77c1305 and 3c3b46b
   =20
    As explained by SZEDER G=C3=A1bor in $gmane/226272, git_complete_fi=
le
    helper is about completing <tree-ish>, taking <commit> at the tips
    of refs and also understanding <tree-ish>:<path> notation, and
    changing "archive" and "ls-tree" to use git_complete_revlist_file
    that in addition is meant to expand A..B range notation was a
    mistake.
   =20
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

and then queue this on top of d8517cc6670d (completion: difftool
takes both revs and files, 2013-06-02), so that the attached and
d8517cc6670d will be the only two commits that graduate to 'master'
from this topic.

-- >8 --
=46rom: Ramkumar Ramachandra <artagnon@gmail.com>
Date: Sun, 2 Jun 2013 19:33:42 +0530
Subject: [PATCH] completion: show can take both revlist and paths

The 'git show' completion uses __git_complete_file (aliased to
__git_complete_revlist_file), because accepts <tree-ish>:<path> as
well as <commit-ish>.  But the command also accepts range of commits
in A..B notation, so using __git_complete_revlist_file is more
appropriate.

There still remain two users of __git_complete_file, completions for
"archive" and "ls-tree".  As these commands do not take range
notation, and "git show" no longer uses __git_complete_file, the
implementation of can be updated not to complete ranges, but that is
a separate topic.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 1b4b0f9..b9dfc3b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2360,7 +2360,7 @@ _git_show ()
 		return
 		;;
 	esac
-	__git_complete_file
+	__git_complete_revlist_file
 }
=20
 _git_show_branch ()
--=20
1.8.3-477-gc2fede3
