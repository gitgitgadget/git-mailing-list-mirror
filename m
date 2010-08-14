From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] reset: Better warning message on git reset --mixed <paths>
Date: Sat, 14 Aug 2010 19:34:59 +0000
Message-ID: <1281814499-11797-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Ralf Ebert <info@ralfebert.de>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 14 21:35:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkMVy-0002KP-Q1
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 21:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180Ab0HNTfJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Aug 2010 15:35:09 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43390 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963Ab0HNTfI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Aug 2010 15:35:08 -0400
Received: by wyb32 with SMTP id 32so4023405wyb.19
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 12:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=4+1qmsg+eNevJtx2r2yxf99UbgOcDr9lSaHQLlGtDVM=;
        b=R8s7r/DJNl93IUTZ6QGJx0n18OKZ0/IUkk02GVX7pYIik1gMSdkLhraE6bwxVkOimr
         TWGJm8XlbhEgkx6+DS32PDEEtax/WnmE3zeiNhVppl+MtL0dVpMSqwypFFq1JKpOWx+w
         6H3wH4ro1dr75zYmI2m/O5i9cBmXWq6il/zv0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=IUo3EWcG+upF9J+e17QCxOgIyyzZIjh+Frjq1SrJFKiAb5kzddVXOOMWrZkNxJtyBr
         DwxGffG+lfCHpUpdXGVrshAsB1zLjpkdc+QBtfrKLrEoduQi162RYg+D4tU8l7bGZia4
         vuYCKyVyYaznSQX0Kx70b9guGJsLW/4/oa38c=
Received: by 10.227.134.69 with SMTP id i5mr2686883wbt.165.1281814506205;
        Sat, 14 Aug 2010 12:35:06 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id a28sm3617659wbe.9.2010.08.14.12.35.04
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 14 Aug 2010 12:35:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.339.g9c5d4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153575>

When you call "git reset --mixed <paths>" git will complain that using
mixed with paths is deprecated:

    warning: --mixed option is deprecated with paths.

That doesn't tell the user why it's deprecated, or what he should use
instead. Expand on the warning and tell the user to just omit --mixed:

    warning: --mixed is redundant with paths, use 'git reset <paths>' i=
nstead.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

On Sat, Aug 14, 2010 at 19:12, Ralf Ebert <info@ralfebert.de> wrote:
> On 14.08.2010 20:55, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> On Sat, Aug 14, 2010 at 18:40, Ralf Ebert<info@ralfebert.de> =C2=A0w=
rote:
>>>
>>> On 14.08.2010 17:23, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>>
>>>> So what should I use instead? 0e5a7faa which introduced it doesn't=
 say.
>>>
>>> It doesn't currently exist, but I'm pretty sure it should be called=
 'git
>>> unstage' :)
>>
>> Then perhaps it should be undeprecated? If what you say is correct
>> it's been whining about that since 2007 with no alternative, while
>> doing what I mean when I run it.
>
> Sorry, I misremembered '--mixed' again, '--mixed' is the default and =
it
> doesn't complain if you just omit it, and if I read&tried right, 'git=
 reset
> <file>' does the same as 'git reset --mixed <file>'.

Right you are, if only we had a manpage to explain this or something >:=
)

Anyway, I think the warning could be better, here's a patch to
implement that. We could also warn on a plain "git reset --mixed"
since it's also redundant, but that would be adding something new so I
haven't done that here.

 builtin/reset.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 1283068..a7878d4 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -318,7 +318,7 @@ int cmd_reset(int argc, const char **argv, const ch=
ar *prefix)
 	 * affecting the working tree nor HEAD. */
 	if (i < argc) {
 		if (reset_type =3D=3D MIXED)
-			warning("--mixed option is deprecated with paths.");
+			warning("--mixed is redundant with paths, use 'git reset <paths>' i=
nstead.");
 		else if (reset_type !=3D NONE)
 			die("Cannot do %s reset with paths.",
 					reset_type_names[reset_type]);
--=20
1.7.2.1.339.g9c5d4
