From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then slowest to fastest
Date: Mon, 25 Jan 2016 13:52:18 -0800
Message-ID: <xmqqegd5fht9.fsf@gitster.mtv.corp.google.com>
References: <xmqqegdd8997.fsf@gitster.mtv.corp.google.com>
	<20160120002606.GA9359@glandium.org>
	<xmqqfuxt6n00.fsf@gitster.mtv.corp.google.com>
	<DBA834D2-BFC9-4A2F-94D9-A1D0D60377BD@gmail.com>
	<20160122023359.GA686558@vauxhall.crustytoothpaste.net>
	<20160122055255.GA14657@sigill.intra.peff.net>
	<20160122060720.GA15681@sigill.intra.peff.net>
	<20160124143403.GL7100@hank>
	<xmqqd1sqd9sq.fsf@gitster.mtv.corp.google.com>
	<xmqq8u3ed45r.fsf@gitster.mtv.corp.google.com>
	<20160125144250.GM7100@hank>
	<xmqqk2mxa7ug.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 22:52:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNp3i-0004aR-Id
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 22:52:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754968AbcAYVwX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jan 2016 16:52:23 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63502 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753790AbcAYVwV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jan 2016 16:52:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8F3ED40840;
	Mon, 25 Jan 2016 16:52:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=w/eix3xTFRBF
	8G+y8Gp7dJXhNo0=; b=NCvtGRfoz83ISZBsAvtEV8oCI6ljMZE7es3KB6hnAVJV
	awbS9qIsMceYRSZWHuXH/Pg2xXZ+bNlgQtl7WyutM2HForhxR5camAaFJZz853Hy
	aZ+r4DA/3npO8sqtHhB71GLNUeNczgNthmue4ljSqm8qfE+dQ45bRwY+zLtLHYw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=N3+UTL
	LvNympGDcEmWYHm5AHFYdyKX1JPJ1xFK8KzfCJ4E1RaguPDmdJct3Dv5iP9Yo4/c
	9uB711AC/+HrjapWl9XiI8FzE0rYECAKnjXxzfHSYeKul81mdqFWCCuOFCOlbnQ6
	KWr4yUBe0qfPHgpi1kp/as7ruhLfBeWWlr930=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 865BE4083F;
	Mon, 25 Jan 2016 16:52:20 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C20854083E;
	Mon, 25 Jan 2016 16:52:19 -0500 (EST)
In-Reply-To: <xmqqk2mxa7ug.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 25 Jan 2016 09:26:31 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E84DA4E0-C3AD-11E5-B7C8-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284760>

Junio C Hamano <gitster@pobox.com> writes:

> I am not saying that we shouldn't have support for users to fix
> their repository and get out of this transititory broken state.  A
> recent work by Torsten B=C3=B6gershausen to have ls-files report the =
end
> of line convention used in the blob in the index and the settings
> that affect conversion for each path (among other things) is a step
> in the right direction.  With a support like that, those who noticed
> that they by mistake added CRLF files to the index as-is when they
> wanted their project to be cross platform can recover from it by
> setting necessary attributes (i.e. mark them as "text") and then
> find paths that are broken out of "ls-files --eol" output to see
> which ones are not using lf end-of-line in the index.
>
> I do not think there is a canned command to help dealing with these
> broken paths right now.  You would have to check them out of the
> index (you would get a CRLF file in the working tree in the example
> we are discussing), fix the line endings (you would run dos2unix on
> it in this example, as you would want "text=3Dtrue" attribute) and
> "git add" them to recover manually, but I can imagine that Torsten's
> work can be extended to do all of these, without molesting the
> working tree files, with minimum work by the end user.  That is:
>
>  * Reuse Torsten's "ls-files --eol" code to find paths that record
>    the blob in the index that does not follow the eol convention
>    specified for the path;
>
>  * For each of these index entries, run convert_to_working_tree() on
>    the indexed contents, and then on the result of it, run
>    convert_to_git().  The result is the blob that the index ought to
>    have had, if it were to be consistent with the attribute
>    settings.  So add that to the index.
>
>  * Write the index out.
>
>  * Tell the user to commit or commit it automatically with a canned
>    log message "fix broken encoding" or something.

Here is what I whipped up as a lunch-break hack.  I do not claim
that "git add" would be the best place to do this, but it should be
sufficient to illustrate the overall idea.

The user can say "git add --fix-index" and have a simplified version
of the above happen, i.e. for each path in the index, if the
contents recorded there does not round-trip to the identical
contents when first converted to the working tree representation
(i.e. passing through core.eol and smudge filter conversion) and
then converted back to the Git blob representation (i.e. clean
filter and core.crlf), and when the result is different from what we
started from, we know we have an unnormalized blob registered in the
index, so we replace it.  After this, "git diff --cached" would show
the correction made by this operation, and committing it would let
you fix the earlier mistake that added CRLF content when the path
was marked with text=3Dtrue attribute.

We could go even fancier and attempt the round-trip twice or more.
It is possible that the in-index representation will not converge
when you use a misconfigured pair of clean/smudge filters (e.g.
using "gzip -d -c" as the smudge filter, and then using "gzip -c"
without "-n" option as the clean filter would most likely make the
in-index representation fuzzy, as each time the cycle is run, the
compressed contents will be made with different timestamps, even
though the working tree representation will be the same), and an
operation "we screwed up the filters, please repair the damage!"
like this "add --fix-index" is probably the best place to catch such
a misconfiguration.

 builtin/add.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 64 insertions(+)

diff --git a/builtin/add.c b/builtin/add.c
index 145f06e..36d3915 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -233,6 +233,7 @@ N_("The following paths are ignored by one of your =
=2Egitignore files:\n");
=20
 static int verbose, show_only, ignored_too, refresh_only;
 static int ignore_add_errors, intent_to_add, ignore_missing;
+static int fix_index;
=20
 #define ADDREMOVE_DEFAULT 1
 static int addremove =3D ADDREMOVE_DEFAULT;
@@ -263,6 +264,7 @@ static struct option builtin_add_options[] =3D {
 	OPT_BOOL( 0 , "refresh", &refresh_only, N_("don't add, only refresh t=
he index")),
 	OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip file=
s which cannot be added because of errors")),
 	OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even =
missing - files are ignored in dry run")),
+	OPT_BOOL( 0 , "fix-index", &fix_index, N_("fix contents in the index =
that is inconsistent with the eol and clean/smudge filters")),
 	OPT_END(),
 };
=20
@@ -297,6 +299,64 @@ static int add_files(struct dir_struct *dir, int f=
lags)
 	return exit_status;
 }
=20
+static int fix_index_roundtrip(int ac, const char **av, const char *pr=
efix)
+{
+	int i;
+
+	if (ac)
+		die(_("git add --fix-index does not take any other argument"));
+
+	if (read_cache() < 0)
+		die(_("index file corrupt"));
+
+	for (i =3D 0; i < active_nr; i++) {
+		struct cache_entry *ce =3D active_cache[i];
+		struct strbuf buf =3D STRBUF_INIT;
+		char *contents;
+		unsigned long size;
+		enum object_type type;
+		unsigned char sha1[20];
+
+		if (ce_stage(ce) || !S_ISREG(ce->ce_mode))
+			continue;
+		if (!would_convert_to_git(ce->name))
+			continue;
+
+		contents =3D read_sha1_file(ce->sha1, &type, &size);
+		if (type !=3D OBJ_BLOB)
+			die(_("object in the index at path '%s' is not a blob"),
+			    ce->name);
+
+		/*
+		 * Round-trip conversion; act as if we wrote it out to the
+		 * working tree and then re-read it, with clean/smudge and
+		 * eol conversions.  Do we get the same result?
+		 */
+		if (convert_to_working_tree(ce->name, contents, size, &buf))
+			strbuf_add(&buf, contents, size);
+		free(contents);
+
+		contents =3D strbuf_detach(&buf, &size);
+
+		if (!convert_to_git(ce->name, contents, size, &buf, 0))
+			strbuf_add(&buf, contents, size);
+		free(contents);
+
+		/* Hash the result - does it match? */
+		hash_sha1_file(buf.buf, buf.len, "blob", sha1);
+		if (hashcmp(sha1, ce->sha1)) {
+			hashcpy(ce->sha1, sha1);
+			active_cache_changed =3D 1;
+		}
+		strbuf_release(&buf);
+	}
+
+	if (active_cache_changed)
+		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+			die(_("Unable to write new index file"));
+	return 0;
+}
+
 int cmd_add(int argc, const char **argv, const char *prefix)
 {
 	int exit_status =3D 0;
@@ -318,6 +378,10 @@ int cmd_add(int argc, const char **argv, const cha=
r *prefix)
=20
 	if (edit_interactive)
 		return(edit_patch(argc, argv, prefix));
+
+	if (fix_index)
+		exit(fix_index_roundtrip(argc, argv, prefix));
+
 	argc--;
 	argv++;
=20
