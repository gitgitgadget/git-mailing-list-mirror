Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 717F91FD09
	for <e@80x24.org>; Tue, 30 May 2017 07:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750908AbdE3HLa (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 03:11:30 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:32818 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbdE3HLa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 03:11:30 -0400
Received: by mail-vk0-f65.google.com with SMTP id c185so2682838vkd.0
        for <git@vger.kernel.org>; Tue, 30 May 2017 00:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Vze3Sd+w3h/4ekUjoOYyMWLFKuMh98UYzBF+zamEj4o=;
        b=f+Kpnuu4duS8C9XdmeBr89h9m7qgQY+qXkZAyqacRBqbGnp4TZPExW+A3z/WKYGceN
         58XIZVZFoAbvwTDVDMtm81xjko1PaVdNX74dP0AXZSlelU9v/iXx8/cn7OMMPiu83w2G
         Y8hLQ0DA+NJ3WhosCS8vlgEBvEVBZNzpVJaPCLbfyB0HIXOIbuY+/ta04eoSwf+QLZtY
         yca+XrtAamtU5HwtEwl1nJVnCFjFCazsN+y3w2KDk/0bxXoArh/CwOmnO2p/eCKLUWtp
         E7UJrAzkGz84Ne6WWjutN0YlCkjYr/EqtPbw5LkkwLLoPNS50Nnb6py9I3DaoXBkeT1k
         cp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vze3Sd+w3h/4ekUjoOYyMWLFKuMh98UYzBF+zamEj4o=;
        b=JcxBaPQ+541N1+gbUpwqXJm/mTXD7LRAAetB3KGfMX9d+2E9+dl6BpvseKZxD0SN0b
         y0OZCoegybUrsBVvK8RxNrkhTZ+//9DhcI/dz2DH+XmmQjIr3+PUXnQ3Yoa9M+8qrHYm
         XhZkgQcDZpfMXzTeAZpaZZ2WSogs18ZkBoH4zidC+8hs9CpwesIdVj09i8X2ROnFD1nI
         xmhZqNapgNaviBJaidFdHI1ioHtQcrT78r98+rYrcYdI59DMbFoPwRNOL3ZvCjwKYSVw
         pwo/F6XQVbkfi9vI9MMhorXZwWS32Vqy7byz/dMGBqdKPDixqYWzpFtkTDvEis/Z2EbT
         gJCw==
X-Gm-Message-State: AODbwcC6yX4RGDvGrc1EtC7WoDN0BARnkWQprtfmlBAiLN4I0Iu3YAj9
        zvAopeY10lTmnxphpOet659pLvikh/z7
X-Received: by 10.31.76.132 with SMTP id z126mr7364094vka.137.1496128288946;
 Tue, 30 May 2017 00:11:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.82.57 with HTTP; Tue, 30 May 2017 00:11:28 -0700 (PDT)
In-Reply-To: <xmqq8tlfdmpg.fsf@gitster.mtv.corp.google.com>
References: <20170515230727.hw75whugf25asuor@sigill.intra.peff.net>
 <20170526100403.19270-1-szeder.dev@gmail.com> <20170526133024.g5rztiv3lea37n72@sigill.intra.peff.net>
 <xmqq8tlfdmpg.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Tue, 30 May 2017 09:11:28 +0200
Message-ID: <CAM0VKjnOSxQg_VCBO2cgtbqesmNYx+e_H7m=36PsNWi9K9rQ1Q@mail.gmail.com>
Subject: Re: [PATCHv3 1/4] clone: respect additional configured fetch refspecs
 during initial fetch
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 30, 2017 at 5:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
> So... do we have a further plan for this topic, or are
> the patches more or less good as they are?

Yup, here it comes.

The main change since v3 is that clone's default refspec is now added
to the 'struct remote' using a function based on Peff's
recommendation, with slight changes:

 - I call that function add_and_parse_fetch_refspec(), because, well,
   that's what it does, and
 - I dropped the if (remote->fetch) condition, because the function
   should work when there are no refspecs in the configuration, too.

I also dropped Peff's two patches that were included in v3, because:

 - his last patch doesn't apply anymore, because the variable it frees
   properly doesn't exist anymore, and
 - with that patch gone his second patch is not tangled up with this
   topic, so I think it should go on its own branch.

Interdiff against the first two patch of v3 below.


SZEDER G=C3=A1bor (2):
  clone: respect additional configured fetch refspecs during initial
    fetch
  Documentation/clone: document ignored configuration variables

 Documentation/git-clone.txt |  4 ++++
 builtin/clone.c             | 34 +++++++++++++++++-----------------
 remote.c                    | 13 +++++++++++++
 remote.h                    |  1 +
 t/t5611-clone-config.sh     | 44 +++++++++++++++++++++++++++++++++++++++++=
+++
 5 files changed, 79 insertions(+), 17 deletions(-)

--
2.13.0.35.g14b6294b1


diff --git a/builtin/clone.c b/builtin/clone.c
index 4144190da..4157922d8 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -853,16 +853,13 @@ int cmd_clone(int argc, const char **argv, const
char *prefix)
        const struct ref *our_head_points_at;
        struct ref *mapped_refs;
        const struct ref *ref;
-       struct strbuf key =3D STRBUF_INIT, value =3D STRBUF_INIT;
+       struct strbuf key =3D STRBUF_INIT, default_refspec =3D STRBUF_INIT;
        struct strbuf branch_top =3D STRBUF_INIT, reflog_msg =3D STRBUF_INI=
T;
        struct transport *transport =3D NULL;
        const char *src_ref_prefix =3D "refs/heads/";
        struct remote *remote;
        int err =3D 0, complete_refs_before_fetch =3D 1;

-       struct refspec *refspec;
-       const char *fetch_pattern;
-
        packet_trace_identity("clone");
        argc =3D parse_options(argc, argv, prefix, builtin_clone_options,
                             builtin_clone_usage, 0);
@@ -980,7 +977,6 @@ int cmd_clone(int argc, const char **argv, const
char *prefix)
                strbuf_addf(&branch_top, "refs/remotes/%s/", option_origin)=
;
        }

-       strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
        strbuf_addf(&key, "remote.%s.url", option_origin);
        git_config_set(key.buf, repo);
        strbuf_reset(&key);
@@ -988,15 +984,10 @@ int cmd_clone(int argc, const char **argv, const
char *prefix)
        if (option_reference.nr)
                setup_reference();

-       fetch_pattern =3D value.buf;
-       refspec =3D parse_fetch_refspec(1, &fetch_pattern);
-
-       strbuf_reset(&value);
-
        remote =3D remote_get(option_origin);
-       REALLOC_ARRAY(remote->fetch, remote->fetch_refspec_nr + 1);
-       memcpy(remote->fetch+remote->fetch_refspec_nr, refspec,
-              sizeof(*refspec));
+       strbuf_addf(&default_refspec, "+%s*:%s*", src_ref_prefix,
+                   branch_top.buf);
+       add_and_parse_fetch_refspec(remote, default_refspec.buf);

        transport =3D transport_get(remote, remote->url[0]);
        transport_set_verbosity(transport, option_verbosity, option_progres=
s);
@@ -1039,7 +1030,7 @@ int cmd_clone(int argc, const char **argv, const
char *prefix)

        if (refs) {
                mapped_refs =3D wanted_peer_refs(refs, remote->fetch,
-                                              remote->fetch_refspec_nr + 1=
);
+                                              remote->fetch_refspec_nr);
                /*
                 * transport_get_remote_refs() may return refs with null sh=
a-1
                 * in mapped_refs (see struct transport->get_refs_list
@@ -1117,9 +1108,8 @@ int cmd_clone(int argc, const char **argv, const
char *prefix)
        strbuf_release(&reflog_msg);
        strbuf_release(&branch_top);
        strbuf_release(&key);
-       strbuf_release(&value);
+       strbuf_release(&default_refspec);
        junk_mode =3D JUNK_LEAVE_ALL;

-       free(refspec);
        return err;
 }
diff --git a/remote.c b/remote.c
index ad6c5424e..b8fd09dc9 100644
--- a/remote.c
+++ b/remote.c
@@ -626,6 +626,19 @@ struct refspec *parse_fetch_refspec(int
nr_refspec, const char **refspec)
        return parse_refspec_internal(nr_refspec, refspec, 1, 0);
 }

+void add_and_parse_fetch_refspec(struct remote *remote, const char *refspe=
c)
+{
+       struct refspec *rs;
+
+       add_fetch_refspec(remote, refspec);
+       rs =3D parse_fetch_refspec(1, &refspec);
+       REALLOC_ARRAY(remote->fetch, remote->fetch_refspec_nr);
+       remote->fetch[remote->fetch_refspec_nr - 1] =3D *rs;
+
+       /* Not free_refspecs(), as we copied its pointers above */
+       free(rs);
+}
+
 static struct refspec *parse_push_refspec(int nr_refspec, const char **ref=
spec)
 {
        return parse_refspec_internal(nr_refspec, refspec, 0, 0);
diff --git a/remote.h b/remote.h
index 924881169..9ad8c1085 100644
--- a/remote.h
+++ b/remote.h
@@ -164,6 +164,7 @@ struct ref *ref_remove_duplicates(struct ref *ref_map);

 int valid_fetch_refspec(const char *refspec);
 struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec);
+void add_and_parse_fetch_refspec(struct remote *remote, const char *refspe=
c);

 void free_refspec(int nr_refspec, struct refspec *refspec);
