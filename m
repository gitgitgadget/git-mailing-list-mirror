From: Caleb Thompson <caleb@calebthompson.io>
Subject: Re: [PATCH v4 4/4] commit: support commit.verbose and --no-verbose
Date: Wed, 11 Jun 2014 16:26:30 -0500
Message-ID: <20140611212247.GB30119@sirius.local>
References: <1402511079-17735-1-git-send-email-caleb@calebthompson.io>
 <1402511079-17735-5-git-send-email-caleb@calebthompson.io>
 <5398BEDE.1040305@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jt0yj30bxbg11sci"
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Kastrup <dak@gnu.org>, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 11 23:26:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wuq2X-0003K5-Li
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 23:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbaFKV0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 17:26:34 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:38538 "EHLO
	new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751983AbaFKV0c (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jun 2014 17:26:32 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 0E6215FE;
	Wed, 11 Jun 2014 17:26:32 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 11 Jun 2014 17:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=calebthompson.io;
	 h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=mesmtp; bh=gx27JnEXl2rIZqoJa39XuEJ1
	dGY=; b=T2wizzPV+obG5dVbPChrjWNli2WPqPH504XJ8129S6ga6gpABVr+y2q3
	iYaRNeTPriPexjVhLqC7zn8q9I2jUI83RvJVKNloAlHGMm6S8Ng0wN/cTDNlZFHv
	XTlKT6fhj/6NuZydhWS+uKyeWOwGvAAUnqyKeoC2yNy95xSM+UE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=smtpout;
	 bh=gx27JnEXl2rIZqoJa39XuEJ1dGY=; b=ZSTiyh1N1Da/zZpDcPGxZIBCkqyc
	b1f91sriHZj4h2tqyDw5JaRrZa3EJiOq1tKmQsMC6JUjmhclHG/HQ53p0Bfwbv+J
	zpqypcTv0cShJjmucEtF4Rhz1TGrLN7Xyw0Q6swylUseM6R4GyUONahPe2ymimFu
	mjyI7pvKvMiPEEo=
X-Sasl-enc: bH0rj+6CtFynfDtj9PWdyVWtQ79RXR143+qUHWhOJ3Rb 1402521991
Received: from localhost (unknown [67.78.97.126])
	by mail.messagingengine.com (Postfix) with ESMTPA id 2EC39680230;
	Wed, 11 Jun 2014 17:26:31 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <5398BEDE.1040305@web.de>
X-PGP-Key: fp="B432 C068 2FD1 C2D0 6A8B 3951 1621 ADC2 A0AC E70A";
 id="0xA0ACE70A"; get=<http://calebthompson.io/pubkey.asc>;
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251387>


--jt0yj30bxbg11sci
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2014, at 01:41 PM, Ren=E9 Scharfe wrote:
>> @@ -1556,7 +1560,7 @@ int cmd_commit(int argc, const char **argv, const =
char *prefix)
>>  static struct wt_status s;
>>  static struct option builtin_commit_options[] =3D {
>>    OPT__QUIET(&quiet, N_("suppress summary after successful commit")),
>> -    OPT__VERBOSE(&verbose, N_("show diff in commit message template")),
>> +    OPT_BOOL('v', "verbose", &verbose, N_("show diff in commit message =
template")),
>
>Hmm, this hunk seems to make sure that there can only be two verbosity
>levels, 0 and 1, while before there could be higher levels (which
>produce the same output as verbose =3D 1).  This change is not mentioned
>in the commit message.  Why is it necessary?
>
>NB: --no-verbose already works without this hunk.

I had no idea, but you're quite right. I suppose that option was just a no-=
op
before, or could cancel a previous --verbose flag?

Updated diff with that hunk removed follows. I rebuilt the branch and the t=
ests
I added for --no-verbose work as expected, as does actually using the
flag/config with the local build.

Caleb Thompson

------------------------ >8 ------------------------

Add a new configuration variable commit.verbose to implicitly pass
`--verbose` to `git-commit`. Add `--no-verbose` to commit to negate that
setting.

Signed-off-by: Caleb Thompson <caleb@calebthompson.io>
---
 Documentation/config.txt               |  5 +++++
 Documentation/git-commit.txt           |  8 +++++++-
 builtin/commit.c                       |  4 ++++
 contrib/completion/git-completion.bash |  1 +
 t/t7507-commit-verbose.sh              | 36 ++++++++++++++++++++++++++++++=
++++
 5 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index cd2d651..ec51e1c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1017,6 +1017,11 @@ commit.template::
  "`~/`" is expanded to the value of `$HOME` and "`~user/`" to the
  specified user's home directory.

+commit.verbose::
+ A boolean to enable/disable inclusion of diff information in the
+ commit message template when using an editor to prepare the commit
+ message.  Defaults to false.
+
 credential.helper::
  Specify an external helper to be called when a username or
  password credential is needed; the helper may consult external
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 0bbc8f5..8cb3439 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -282,7 +282,13 @@ configuration variable documented in linkgit:git-confi=
g[1].
  Show unified diff between the HEAD commit and what
  would be committed at the bottom of the commit message
  template.  Note that this diff output doesn't have its
- lines prefixed with '#'.
+ lines prefixed with '#'.  The `commit.verbose` configuration
+ variable can be set to true to implicitly send this option.
+
+--no-verbose::
+ Do not show the unified diff at the bottom of the commit message
+ template.  This is the default behavior, but can be used to override
+ the `commit.verbose` configuration variable.

 -q::
 --quiet::
diff --git a/builtin/commit.c b/builtin/commit.c
index 99c2044..c782388 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1489,6 +1489,10 @@ static int git_commit_config(const char *k, const ch=
ar *v, void *cb)
    sign_commit =3D git_config_bool(k, v) ? "" : NULL;
    return 0;
  }
+ if (!strcmp(k, "commit.verbose")) {
+   verbose =3D git_config_bool(k, v);
+   return 0;
+ }

  status =3D git_gpg_config(k, v, NULL);
  if (status)
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/gi=
t-completion.bash
index 2c59a76..b8f4b94 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1976,6 +1976,7 @@ _git_config ()
    color.ui
    commit.status
    commit.template
+   commit.verbose
    core.abbrev
    core.askpass
    core.attributesfile
diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index 35a4d06..512eef3 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -7,6 +7,10 @@ write_script check-for-diff <<-'EOF'
  exec grep '^diff --git' "$1"
 EOF

+write_script check-for-no-diff <<-EOF
+ exec grep -v '^diff --git' "\$1"
+EOF
+
 cat >message <<'EOF'
 subject

@@ -48,6 +52,38 @@ test_expect_success 'verbose diff is stripped out (mnemo=
nicprefix)' '
  check_message message
 '

+test_expect_success 'commit shows verbose diff with commit.verbose true' '
+ echo morecontent >>file &&
+ git add file &&
+ test_config commit.verbose true &&
+ test_set_editor "$PWD/check-for-diff" &&
+ git commit --amend
+'
+
+test_expect_success 'commit --verbose overrides commit.verbose false' '
+ echo evenmorecontent >>file &&
+ git add file &&
+ test_config commit.verbose false  &&
+ test_set_editor "$PWD/check-for-diff" &&
+ git commit --amend --verbose
+'
+
+test_expect_success 'commit does not show verbose diff with commit.verbose=
 false' '
+ echo evenmorecontent >>file &&
+ git add file &&
+ test_config commit.verbose false &&
+ test_set_editor "$PWD/check-for-no-diff" &&
+ git commit --amend
+'
+
+test_expect_success 'commit --no-verbose overrides commit.verbose true' '
+ echo evenmorecontent >>file &&
+ git add file &&
+ test_config commit.verbose true &&
+ test_set_editor "$PWD/check-for-no-diff" &&
+ git commit --amend --no-verbose
+'
+
 cat >diff <<'EOF'
 This is an example commit message that contains a diff.

--
2.0.0

--jt0yj30bxbg11sci
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJTmMmGAAoJEBYhrcKgrOcKl4wH/1yjCC+YFS23HOQ78JbbCVBs
jLfcLTKp/rmQAce+cVGLucURv5F4ZX0Vo1krRfaxIpF2Rypu1XTFfgH0s2MZj6Gv
BFEVsYSAq8hmfLhjueqsrJ0D+oqRcKCwux8uBHp9GmGc2ugcuJRJW16GsjyjIsiq
xDo1M4PiZqdN+9xldj4qCKDmKSoM1KYLM2B0+3racW+5xq1g4ZdSOZVgc7zd81xW
/eZH2aDiRuCJH+s1K9MHB4xRD1qVnufNFDbz6j67V3IXb9FyEaH2/CdxGLgaTJr9
Fyxiw4QS+yqOZ4mgOSbk2PiFeV+A1ZhamUEMSMkioFfjYY3uxlqF9M90Vhq/sM4=
=aIcd
-----END PGP SIGNATURE-----

--jt0yj30bxbg11sci--
