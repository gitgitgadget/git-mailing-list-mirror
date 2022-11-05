Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AEBC433FE
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 17:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiKER1S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 13:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiKER1R (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 13:27:17 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8E812622
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 10:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1667669216; bh=WP7FESlA1ZtZyGcrSHwMuc2UskXF7Qnayxma20oX0sg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=mrOXAtNzhmZ7/ycJNCWN4pCCjw50xUFHoTINY/0H/EgT+XP+/TB0pMfBgCRe16Gp2
         zGHemuGVfvZGYZcB59zldoaO2UFbtHz7m1c8M0LVVvy9Xpo+kf95BDMYQvVxv9trbq
         SOQWWCI9k553yBU6YNqlGSF+w2vIA82eaeNjL96XZ59+6NU5mVqfpQ5wapVc9+G324
         SRRq7xAMuR+aWv0W38MFZoZbu6L/x9KA9gmUCMkRV6WGdg/aukNvsT0woeD1D9y++Q
         SZx4A6G1ea+KdeXSTTzspCod3r0MOszNxK1zIThDhSC2RRlq32cmY7wwv4HsPSrEKJ
         oub8zUWC0NQLg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.144.51]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N1d3a-1p2KBE1ZpA-0129eK; Sat, 05
 Nov 2022 18:26:56 +0100
Message-ID: <25776063-a672-fc65-bed3-1bc8536ab8b3@web.de>
Date:   Sat, 5 Nov 2022 18:26:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 09/13] parse-options API: don't restrict OPT_SUBCOMMAND()
 to one *_fn type
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
 <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
 <patch-09.13-2cb3807aa17-20221104T132117Z-avarab@gmail.com>
 <df855ba1-52b1-1007-68e8-2e28e85b6822@web.de>
 <221105.861qqhxz0o.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <221105.861qqhxz0o.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:10TGlXaHpkd6P7HFhNwn0rkCNfktA8/U1+9MmxjAR38rXhPkF8u
 0myyj/XKL/i4enYiV1dRF6xwnA2wRX7ap8/Y1SMuu+vvdxsLdgYOvKkVjT8J4ckRlzLeSJa
 n7Y3awt5C4X8383M8fyX8eXFsLG5UthK85N7WcPdrB5rje6Lks4uFdiG+TMdRPET0P5EvKu
 /wA+mhR3hBOnd2v9PafIA==
UI-OutboundReport: notjunk:1;M01:P0:VH3kjRIBPnY=;clVSqUk0+HIZrUifQ7ZOZTP6ekC
 CpWj16ZAdc0Vi2SiwxyPYIZQf3gjfSpZONR8QKV0qnNHaa9Y2K9RbG4zKNyXL7EzOd43e0gEY
 UEMXjsiMjwt/uGyqajtFBso2ZiKq57pmJnY59O/5m26f545duSsjt0NUicF1f9dLJYYnYNOEF
 1f0Tae2n5jp11gv18OGg6VY46ufg3wVUHqLur+GujM/KKWFQzOD5+zQzqKhbzI7ekuCknOgyC
 GCQOw/X5yw3eZgpz6GafK26SsKd9q8m5lKDRRJ+zPzSVfL4PLsw1z1tXQZzjFrNY8D6gXG1WI
 OXcE4+UPlGexMn7jZlVp2SfyWCTVbNfv8OTncIZ0wpdued4dJ9y0224isTYu69GzFZEsFBEKk
 +uK8d+VrqZJBbfhi4a6AQ68YFzP+eyZCq6pMz6CIproAA2z1lo7IsOmA7a7txz9q8MAN3pqu3
 3vhnNCggWEFGztPRCXcl9CzIk1PxFeWy/nzrD8zjtgImVdF0lOJRlewJjXrComnmxjk5o3hh6
 F4jr2qpaxWutxZKB5IFBw+EuywO5V6x7jSX7pUGTPuW8t4nSBN2iu/odTDAr9BKYptP7vTttj
 M8/yXwNvLJYPliVd+GbRitUe8ATQHa6guHonSan+cJBHSERBD0bcSJkV6SvCrO97ZbpLEpjb5
 KBIYNYt80yACQWko1xizbnft4J80mhoG5FIEyBPoZ1RdSOACwVUNsgb8D6QLkHEw2cPw7zbZe
 nx/yM5KOABkgspHkDkKKE043okvmNfKhBWfmbmHJGiR8YEONojYsLVd4JuTNweTOsHSoEUl1C
 YQm3R/JVeBLqUYFfJ8zzUeWTzhfgNtviCyET9XBwvGqqp8dzUyGuFeh3Eg13uZLn2fiuD76wK
 dbpNYAJnmxDhB1AwFaNn+HgPNBVnXQXSYfRwHLqTJIagrTaG/2MM6sSCMo3qCRnKFM5+f9V2x
 qCBMG3UgJ48c1Xd/JxfLM/QWUSM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.11.22 um 14:52 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> I think that's an "unportable" extension covered in "J.5 Common
> extensions", specifically "J.5.7 Function pointer casts":
>
> 	A pointer to an object or to void may be cast to a pointer to a
> 	function, allowing data to be invoked as a function
>
> Thus, since the standard already establishes that valid "void *" and
> "intptr_t" pointers can be cast'd back & forth, the J.5.7 bridges the
> gap between the two saying a function pointer can be converted to
> either.
>
> Now, I may be missing something here, but I was under the impression
> that "intptr_t" wasn't special in any way here, and that any casting of
> a function pointer to either it or a "void *" was what was made portable
> by "J.5.7".

Do you mean "possible" or "workable" instead of "portable" here?  As you
write above, J.5.7 is an extension, not (fully) portable.

> Anyway, like ssize_t and a few other things this is extended upon and
> made standard by POSIX. I.e. we're basically talking about whether this
> passes:
>
> 	assert(sizeof(void (*)(void)) =3D=3D sizeof(void*))
>
> And per POSIX
> (https://pubs.opengroup.org/onlinepubs/9699919799/functions/dlsym.html):
>
> 	Note that conversion from a void * pointer to a function pointer
> 	as in:
>
> 		fptr =3D (int (*)(int))dlsym(handle, "my_function");
>
> 	is not defined by the ISO C standard. This standard requires
> 	this conversion to work correctly on conforming implementations.

Conversion from object pointer to function pointer can still work if
function pointers are wider.

> So I think aside from other concerns this should be safe to use, as
> real-world data backing that up we've had a intptr_t converted to a
> function pointer since v2.35.0: 5cb28270a1f (pack-objects: lazily set up
> "struct rev_info", don't leak, 2022-03-28).

That may not have reached unusual architectures, yet.  Let's replace
that cast with something boring before someone gets hurt.  Something
like this?


diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 573d0b20b7..9e6f1530c6 100644
=2D-- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4154,14 +4154,15 @@ struct po_filter_data {
 	struct rev_info revs;
 };

-static struct list_objects_filter_options *po_filter_revs_init(void *valu=
e)
+static int list_objects_filter_cb(const struct option *opt,
+				  const char *arg, int unset)
 {
-	struct po_filter_data *data =3D value;
+	struct po_filter_data *data =3D opt->value;

 	repo_init_revisions(the_repository, &data->revs, NULL);
 	data->have_revs =3D 1;

-	return &data->revs.filter;
+	return opt_parse_list_objects_filter(&data->revs.filter, arg, unset);
 }

 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
@@ -4265,7 +4266,7 @@ int cmd_pack_objects(int argc, const char **argv, co=
nst char *prefix)
 			      &write_bitmap_index,
 			      N_("write a bitmap index if possible"),
 			      WRITE_BITMAP_QUIET, PARSE_OPT_HIDDEN),
-		OPT_PARSE_LIST_OBJECTS_FILTER_INIT(&pfd, po_filter_revs_init),
+		OPT_PARSE_LIST_OBJECTS_FILTER_F(&pfd, list_objects_filter_cb),
 		OPT_CALLBACK_F(0, "missing", NULL, N_("action"),
 		  N_("handling for missing objects"), PARSE_OPT_NONEG,
 		  option_parse_missing_action),
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 5339660238..2e560c2fdb 100644
=2D-- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -286,15 +286,9 @@ void parse_list_objects_filter(
 		die("%s", errbuf.buf);
 }

-int opt_parse_list_objects_filter(const struct option *opt,
+int opt_parse_list_objects_filter(struct list_objects_filter_options *fil=
ter_options,
 				  const char *arg, int unset)
 {
-	struct list_objects_filter_options *filter_options =3D opt->value;
-	opt_lof_init init =3D (opt_lof_init)opt->defval;
-
-	if (init)
-		filter_options =3D init(opt->value);
-
 	if (unset || !arg)
 		list_objects_filter_set_no_filter(filter_options);
 	else
@@ -302,6 +296,12 @@ int opt_parse_list_objects_filter(const struct option=
 *opt,
 	return 0;
 }

+int opt_parse_list_objects_filter_cb(const struct option *opt,
+				     const char *arg, int unset)
+{
+	return opt_parse_list_objects_filter(opt->value, arg, unset);
+}
+
 const char *list_objects_filter_spec(struct list_objects_filter_options *=
filter)
 {
 	if (!filter->filter_spec.len)
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 7eeadab2dd..fc6b4da06d 100644
=2D-- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -107,31 +107,26 @@ void parse_list_objects_filter(
 	struct list_objects_filter_options *filter_options,
 	const char *arg);

+int opt_parse_list_objects_filter(struct list_objects_filter_options *fil=
ter_options,
+				  const char *arg, int unset);
+
 /**
  * The opt->value to opt_parse_list_objects_filter() is either a
  * "struct list_objects_filter_option *" when using
  * OPT_PARSE_LIST_OBJECTS_FILTER().
  *
- * Or, if using no "struct option" field is used by the callback,
- * except the "defval" which is expected to be an "opt_lof_init"
- * function, which is called with the "opt->value" and must return a
- * pointer to the ""struct list_objects_filter_option *" to be used.
- *
- * The OPT_PARSE_LIST_OBJECTS_FILTER_INIT() can be used e.g. the
- * "struct list_objects_filter_option" is embedded in a "struct
- * rev_info", which the "defval" could be tasked with lazily
- * initializing. See cmd_pack_objects() for an example.
+ * Or, OPT_PARSE_LIST_OBJECTS_FILTER_F() can be used to specify a
+ * custom callback function that may expect a different type.
  */
-int opt_parse_list_objects_filter(const struct option *opt,
-				  const char *arg, int unset);
+int opt_parse_list_objects_filter_cb(const struct option *opt,
+				     const char *arg, int unset);
 typedef struct list_objects_filter_options *(*opt_lof_init)(void *);
-#define OPT_PARSE_LIST_OBJECTS_FILTER_INIT(fo, init) \
+#define OPT_PARSE_LIST_OBJECTS_FILTER_F(fo, fn) \
 	{ OPTION_CALLBACK, 0, "filter", (fo), N_("args"), \
-	  N_("object filtering"), 0, opt_parse_list_objects_filter, \
-	  (intptr_t)(init) }
+	  N_("object filtering"), 0, (fn) }

 #define OPT_PARSE_LIST_OBJECTS_FILTER(fo) \
-	OPT_PARSE_LIST_OBJECTS_FILTER_INIT((fo), NULL)
+	OPT_PARSE_LIST_OBJECTS_FILTER_F((fo), opt_parse_list_objects_filter_cb)

 /*
  * Translates abbreviated numbers in the filter's filter_spec into their
