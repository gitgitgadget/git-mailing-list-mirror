Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D79671F461
	for <e@80x24.org>; Sat, 11 May 2019 21:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfEKVHR (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 May 2019 17:07:17 -0400
Received: from mout.web.de ([212.227.17.11]:40179 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfEKVHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 May 2019 17:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557608826;
        bh=ye8IdA1fiomcj9ZfqvF5Wb2EENfBwGC9d+Nh/cyBLhw=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=l8GXU3YEeK1PgrCxwtc4+UvE5WUNJyIYVbPThit6X7GG1zk0iIDYCOBNbOY6MLNr+
         2rMsZWgqYm4catkYqfBVXy71BKZbZ5vyzsbrW2f7RRn78wHzIxwh4k7nR1CAqZoRW5
         2YuSEqNHfbasG4CE1F9f3Q7Ff0hnhOIqPoeLxBVg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MZUS9-1h8r8Z2Yeb-00LArn; Sat, 11
 May 2019 23:07:06 +0200
Date:   Sat, 11 May 2019 23:07:04 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Elijah Newren <newren@gmail.com>
Cc:     gitster@pobox.com, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 5/5] fast-export: do automatic reencoding of commit
 messages only if requested
Message-ID: <20190511210704.w2mxw3jv2ra2dr7w@tb-raspi4>
References: <20190430182523.3339-1-newren@gmail.com>
 <20190510205335.19968-1-newren@gmail.com>
 <20190510205335.19968-6-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510205335.19968-6-newren@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:D3fC532SsL8wuw67XeVp4GmNvJXvNuY9LVtnAOsivVbEyAQeNgD
 xnTdu0vqSEf23z7qcAk+6CX/imlUr33XSXoQhTadx743uI7/iEPg9Nk/TeKpV1r4ckcFEEO
 Do8D9+9u2Mah7FAjnl7cdylpbyBgC7Dtcg6ns3jzWXlubulJLlfWYEMQ6veJEuKFswBzB2R
 B9WsGKXrZDrjGZ5R/Q+aw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S/CUvoUWv/c=:Ha/TbK8nE0lHU+PotK2Ott
 M2bsETFg7629PsLja9Bsg9H2sTtxx9CVH5A2CJtAaNl6tqHXRm17od7ukKkL9RpXQDd4AUhUJ
 VjTuuvpc0wd5HGTP6un0Ccv5OFJfgNkSpY7tCaLETgSDc0gKkbwWgDSnyJFDfgMSZPf30fP1q
 dGWbrBGXG2S7mzJ4GIczdrbh3yKbDsaFbwqXUDpwGcwb3T6zpw3PbqG41Of0TbJrWqs3DoDHt
 P3AlGBguW5mlMn2ukJFxaMRXxD6AQ9epdErhEMpfCzotQRTtPMINJeEYw3VrzlgUn8kWP2OuF
 4Nk2GGgHmkt4vZ96w9I0IpZQw4mF6U7kutYOmgPtUT3EVK/qLLTpA8tQMOWprdI25N97qB4uE
 /l/9FWqkEdWOtQDz/ZHkfKO80VIeLU1KuJ4xxyDoOuYDWoD5bSrS82XGPms6MwFZpJpPBjyqY
 HIGBugNqaf+eeQqZmSHzpAnnvrw50O9UCWW+ZlsXbeR8r+d6cBt5S20MyiILZm0nuzpKSb/Tk
 L9Yb2DFp/XhnDFzQgjzf0uipul/qk+g9dgTtPgFWkXUQ4cNInUvqsUFRnF+Fk/QjF1aCsWv3d
 V7BlmRZ6yM8Pgdb8G801u2gAF3oyfdmjXYwxQt2T94jfk4tp7cuhemWH31sq2I4nULITmWGJf
 PC5iitv9jZHaDw5aLzjXppbXobf6M4ovrUenB2VhjcN4eduaMcs7LaiJhV+a4aXqKL77HHDMH
 rqSpUylpGfgX43NZtrbDzek+BTv9GRUuY2A5T+iHa962gabOsp880ExEf0/q8ulpGLDfpJxcx
 ULNJyAxwXeZAPumFyyrqxT0N4Laz2SxMVnBLVcP+C9sTA5/dCLF/dqAntEe0E11xsEeCPVw9a
 vqUge8DggfhpBcyC1DdvAl72J0SV+CSo37rQ4kFfGq8O9JzDwOgAs2zSB+TUhZ
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 10, 2019 at 01:53:35PM -0700, Elijah Newren wrote:
> Automatic re-encoding of commit messages (and dropping of the encoding
> header) hurts attempts to do reversible history rewrites (e.g. sha1sum
> <-> sha256sum transitions, some subtree rewrites), and seems
> inconsistent with the general principle followed elsewhere in
> fast-export of requiring explicit user requests to modify the output
> (e.g. --signed-tags=3Dstrip, --tag-of-filtered-object=3Drewrite).  Add a
> --reencode flag that the user can use to specify, and like other
> fast-export flags, default it to 'abort'.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/fast-export.c  | 35 ++++++++++++++++++++++++++++++++---
>  t/t9350-fast-export.sh | 37 ++++++++++++++++++++++++++++++++++---
>  2 files changed, 66 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 66331fa401..43cc52331c 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -33,6 +33,7 @@ static const char *fast_export_usage[] =3D {
>  static int progress;
>  static enum { SIGNED_TAG_ABORT, VERBATIM, WARN, WARN_STRIP, STRIP } sig=
ned_tag_mode =3D SIGNED_TAG_ABORT;
>  static enum { TAG_FILTERING_ABORT, DROP, REWRITE } tag_of_filtered_mode=
 =3D TAG_FILTERING_ABORT;
> +static enum { REENCODE_ABORT, REENCODE_PLEASE, REENCODE_NEVER } reencod=
e_mode =3D REENCODE_ABORT;
>  static int fake_missing_tagger;
>  static int use_done_feature;
>  static int no_data;
> @@ -77,6 +78,20 @@ static int parse_opt_tag_of_filtered_mode(const struc=
t option *opt,
>  	return 0;
>  }
>
> +static int parse_opt_reencode_mode(const struct option *opt,
> +				   const char *arg, int unset)
> +{

This one is good:
> +	if (unset || !strcmp(arg, "abort"))
> +		reencode_mode =3D REENCODE_ABORT;

But here: does it make sense to use REENCODE_YES/NO to be more consistant =
?
> +	else if (!strcmp(arg, "yes"))
> +		reencode_mode =3D REENCODE_PLEASE;
> +	else if (!strcmp(arg, "no"))
> +		reencode_mode =3D REENCODE_NEVER;
> +	else
> +		return error("Unknown reencoding mode: %s", arg);
> +	return 0;
> +}
> +
>  static struct decoration idnums;
>  static uint32_t last_idnum;
>
> @@ -633,10 +648,21 @@ static void handle_commit(struct commit *commit, s=
truct rev_info *rev,
>  	}
>
>  	mark_next_object(&commit->object);
> -	if (anonymize)
> +	if (anonymize) {
>  		reencoded =3D anonymize_commit_message(message);
> -	else if (!is_encoding_utf8(encoding))
> -		reencoded =3D reencode_string(message, "UTF-8", encoding);
> +	} else if (encoding) {
> +		switch(reencode_mode) {
> +		case REENCODE_PLEASE:
> +			reencoded =3D reencode_string(message, "UTF-8", encoding);
> +			break;
> +		case REENCODE_NEVER:
> +			break;
> +		case REENCODE_ABORT:
> +			die("Encountered commit-specific encoding %s in commit "
> +			    "%s; use --reencode=3D<mode> to handle it",
Should we be more helpfull and say !use --reencode=3D[yes|no] to handle it=
 ?

> +			    encoding, oid_to_hex(&commit->object.oid));
> +		}
> +	}
>  	if (!commit->parents)
>  		printf("reset %s\n", refname);
>  	printf("commit %s\nmark :%"PRIu32"\n", refname, last_idnum);
> @@ -1091,6 +1117,9 @@ int cmd_fast_export(int argc, const char **argv, c=
onst char *prefix)
>  		OPT_CALLBACK(0, "tag-of-filtered-object", &tag_of_filtered_mode, N_("=
mode"),
>  			     N_("select handling of tags that tag filtered objects"),
>  			     parse_opt_tag_of_filtered_mode),
> +		OPT_CALLBACK(0, "reencode", &reencode_mode, N_("mode"),
> +			     N_("select handling of commit messages in an alternate encoding=
"),
> +			     parse_opt_reencode_mode),
>  		OPT_STRING(0, "export-marks", &export_filename, N_("file"),
>  			     N_("Dump marks to this file")),
>  		OPT_STRING(0, "import-marks", &import_filename, N_("file"),
> diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
> index fa124f4842..3cf4c7fc0c 100755
> --- a/t/t9350-fast-export.sh
> +++ b/t/t9350-fast-export.sh
> @@ -94,14 +94,14 @@ test_expect_success 'fast-export --show-original-ids=
 | git fast-import' '
>  	test $MUSS =3D $(git rev-parse --verify refs/tags/muss)
>  '
>
> -test_expect_success 'iso-8859-7' '
> +test_expect_success 'reencoding iso-8859-7' '
>
>  	test_when_finished "git reset --hard HEAD~1" &&
>  	test_config i18n.commitencoding iso-8859-7 &&
>  	test_tick &&
>  	echo rosten >file &&
>  	git commit -s -F "$TEST_DIRECTORY/t9350/simple-iso-8859-7-commit-messa=
ge.txt" file &&
> -	git fast-export wer^..wer >iso-8859-7.fi &&
> +	git fast-export --reencode=3Dyes wer^..wer >iso-8859-7.fi &&
>  	sed "s/wer/i18n/" iso-8859-7.fi |
>  		(cd new &&
>  		 git fast-import &&
> @@ -120,13 +120,44 @@ test_expect_success 'iso-8859-7' '
>  		 ! grep ^encoding actual)
>  '
>
> +test_expect_success 'aborting on iso-8859-7' '
> +
> +	test_when_finished "git reset --hard HEAD~1" &&
> +	test_config i18n.commitencoding iso-8859-7 &&
> +	echo rosten >file &&
> +	git commit -s -F "$TEST_DIRECTORY/t9350/simple-iso-8859-7-commit-messa=
ge.txt" file &&
> +	test_must_fail git fast-export --reencode=3Dabort wer^..wer >iso-8859-=
7.fi
> +'
> +
> +test_expect_success 'preserving iso-8859-7' '
> +
> +	test_when_finished "git reset --hard HEAD~1" &&
> +	test_config i18n.commitencoding iso-8859-7 &&
> +	echo rosten >file &&
> +	git commit -s -F "$TEST_DIRECTORY/t9350/simple-iso-8859-7-commit-messa=
ge.txt" file &&
> +	git fast-export --reencode=3Dno wer^..wer >iso-8859-7.fi &&
> +	sed "s/wer/i18n-no-recoding/" iso-8859-7.fi |
> +		(cd new &&
> +		 git fast-import &&
> +		 # The commit object, if not re-encoded, is 240 bytes.
> +		 # Removing the "encoding iso-8859-7\n" header would drops 20
> +		 # bytes.  Re-encoding the Pi character from \xF0 in
> +		 # iso-8859-7 to \xCF\x80 in utf-8 would add a byte.  I would
> +		 # grep for the # specific bytes, but Windows lamely does not
This is somewhat unclear to me. What does Windows not allow ?

> +		 # allow that, so just search for the expected size.
> +		 test 240 -eq "$(git cat-file -s i18n-no-recoding)" &&
> +		 # Also make sure the commit has the "encoding" header
> +		 git cat-file commit i18n-no-recoding >actual &&
> +		 grep ^encoding actual)
> +'
> +
>  test_expect_success 'encoding preserved if reencoding fails' '
>
>  	test_when_finished "git reset --hard HEAD~1" &&
>  	test_config i18n.commitencoding iso-8859-7 &&
>  	echo rosten >file &&
>  	git commit -s -F "$TEST_DIRECTORY/t9350/broken-iso-8859-7-commit-messa=
ge.txt" file &&
> -	git fast-export wer^..wer >iso-8859-7.fi &&
> +	git fast-export --reencode=3Dyes wer^..wer >iso-8859-7.fi &&
>  	sed "s/wer/i18n-invalid/" iso-8859-7.fi |
>  		(cd new &&
>  		 git fast-import &&
> --
> 2.21.0.782.g2063122293
>
