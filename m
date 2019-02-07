Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 445A91F453
	for <e@80x24.org>; Thu,  7 Feb 2019 23:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfBGX6r (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 18:58:47 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45186 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfBGX6q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 18:58:46 -0500
Received: by mail-pl1-f195.google.com with SMTP id a14so758205plm.12
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 15:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xKVYZ8i4oItknYwflDXQzoPwtLOAy5MD7k1j/hBlfqo=;
        b=PIL5ZmT1pc/aAFvFIGs+PKHq8LaGszT4tszj3Uop5x8GhNlE6TnxAId2bqcFwiGRGs
         HluB1d20BWhMLTX2te8kcfBow22ODYkzyrIJVm73z0JUx+m6l0prGSmXDEacRsHY0+PH
         5e01amwB0kulWLANhdciA54EWR1sqPBbfeLdWhZC8vri4KyaOhZzoiyJ8amP9CRdD0ly
         XK11GqsD9jOzak9sHiAy57SWwkASuVaBMHnpYAinoa/UlLLFS5e6V9sHgFJDaTR+xQiC
         NU4cWvIOpCr1PyMAOtYoJ57uUN2CF1dgRB9nSbLEunWJlHCxtWhXhA6MRlHrPT4mPimP
         vPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=xKVYZ8i4oItknYwflDXQzoPwtLOAy5MD7k1j/hBlfqo=;
        b=aoIw1Ub2Z+n0T1Yi7WqenHgElwzJ1Fgck2F/weLclklWjthQ7ikdNtmSiCUxaHBxvf
         LV28Vlap2VCdZan4flTNftvI0wZjbjLlovPcLjhdPyO9rC83dLfvL9MvTQoytgJz6gcJ
         +cMMzvgspYHQ7p6xphSL5YBoEDpu6T18fQKxH2LM427oF+Hz/E7BK392P0MItfQLFiuJ
         LqiaNifAy7rrGLuZpYAk4ShVj3EjfdC5Yflpn6BDgkdqR0m8p9ZoqLZOFNhu6xH7lFf9
         xv573Rc8CKLI/vO7JeQ8QOC+1xu11otfmARuh0VzmTsHEC94oNRHBnNckAreBJ9WFutQ
         k7HA==
X-Gm-Message-State: AHQUAubznAdmjBHqTfgbF67l70b8YgFEkP58OOvY9w9FM6fq8gR9p8nb
        y4rBML63hV65JcnLlRu/hmAaTw==
X-Google-Smtp-Source: AHgI3IbGLb+aFUooIwFoWFQt9bNVX4S2MoOK3BiOjgWPKyRURIuAiS+VDbhPuOE9B2aojj8W3M81bw==
X-Received: by 2002:a17:902:6e0f:: with SMTP id u15mr19087300plk.175.1549583925362;
        Thu, 07 Feb 2019 15:58:45 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id h80sm377753pfd.63.2019.02.07.15.58.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 15:58:44 -0800 (PST)
Date:   Thu, 7 Feb 2019 15:58:38 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH v6 1/1] protocol: advertise multiple supported versions
Message-ID: <CANq=j3u-zdb_FvNJGPCmygNMScseav63GhVvBX3NcVS4f7TejA@mail.gmail.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>
References: <10039ca163a9ca26595d3bbfcf70bc2ca02666f9.1545342797.git.steadmon@google.com>
 <20190205194226.172769-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205194226.172769-1-jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.02.05 11:42, Jonathan Tan wrote:
> Thanks. Overall, one major point: I think that the declaration of
> supported versions need to be transport-scoped (search this email for
> "transport-scoped" for context). And one medium point: it might be
> better for protocol.version to be the preferred and maximum version, not
> only the preferred version. I have other minor points, which you can
> read below.

Thanks for the review, and apologies for the delayed reply. I have some
questions below about making the version advertisement transport scoped.
I think you're right about making the config version the maximum,
although I believe we've also avoided making the protocol versions
strictly orderable, so it may not be feasible if we want to keep that
feature.

> > Currently the client advertises that it supports the wire protocol
> > version set in the protocol.version config. However, not all services
> > support the same set of protocol versions. For example, git-receive-pack
> > supports v1 and v0, but not v2.
>
> That's true, except <see next paragraph>.
>
> > If a client connects to git-receive-pack
> > and requests v2, it will instead be downgraded to v0.
>
> This is a bit misleading. The client never requests v2 - connect.c has
> an override that changes it to v0 (as can be seen from the diff of this
> patch) before the request takes place. If we were to create a custom
> client that requests v2, the server would die with "support for protocol
> v2 not implemented yet". (But maybe this is a bug - the server should
> downgrade instead.)

Ack, will fix the description in the next version.


> > Other services,
> > such as git-upload-archive, do not do any version negotiation checks.
> >
> > This patch creates a protocol version registry. Individual client and
> > server programs register all the protocol versions they support prior to
> > communicating with a remote instance. Versions should be listed in
> > preference order; the version specified in protocol.version will
> > automatically be moved to the front of the registry.
>
> It took me a while to understand what's going on, so let me try to
> summarize:
>
>  - The main issue is that send-pack doesn't support v2, so it would be
>    incorrect for the client to advertise v2; this is currently fine
>    because of the override in connect.c. A side issue is that the client
>    advertises v2 for other things (e.g. archive), which currently works
>    only because the server ignores them.
>
>  - To solve both these issues, each command declares which protocols it
>    supports.
>
>  - Because we now have such a list, it is not too difficult to pass the
>    entire list to the server, so we should do so. (Servers already
>    support multiple versions.)
>
> > The protocol version registry is passed to remote helpers via the
> > GIT_PROTOCOL environment variable.
>
> This is unfortunate to me, but I can't think of a better way to do it -
> we do need to communicate the allowed version list somehow. A transport
> option cannot be ignored by an old remote helper, but an envvar can.
>
> Backwards/forwards compatibility notes:
>
>  - If an old Git uses a new remote helper, no GIT_PROTOCOL is passed so
>    the remote helper uses v0 regardless of what's configured in the
>    repo. This should be fine.
>  - If a new Git uses an old remote helper, what's configured gets used
>    (unless it's for send-pack, in which case a version override occurs),
>    regardless of which versions Git declares that it supports. I can
>    envision some situations in which this would trip us up, but we are
>    already in this exact situation anyway.
>
> > Additionally, remove special cases around advertising version=0.
> > Previously we avoided adding version advertisements to the client's
> > initial connection request if the client wanted version=0. However,
> > including these advertisements does not change the version negotiation
> > behavior, so it's better to have simpler code. As a side effect, this
> > means that client operations over SSH will always include a
> > "SendEnv=GIT_PROTOCOL" option on the SSH command line.
>
> HTTP too, I think?

Correct.


> Also, this means that the client will send different information to the
> server now, but it seems fine (as far as I know, clients already send
> Git version information anyway).
>
> Overall, I would write the commit message this way:
>
>     A Git client can communicate with a Git server through various
>     commands, and for each command, in various protocol versions. Each
>     repo can define protocol.version as 0, 1, or 2 for the protocol
>     version that it prefers. But this integer is handled differently by
>     each command: if communicating with "upload-pack", the integer is
>     passed verbatim to be interpreted by the server; if communicating
>     with "receive-pack", the integer is hardcoded to be overridden to 0
>     or 1; and if communicating with anything else (e.g. "archive"), the
>     integer is passed verbatim but ignored by the server.
>
>     Handle each command the same way by having each client command
>     declare which versions it supports, and whenever a command is
>     invoked, send its list of versions to the server (instead of one
>     single version, as is done currently). The protocol.version is now
>     used as a hint to which version the client prefers; if it is present
>     in the list, it is moved to the front, otherwise the list is sent
>     unchanged.
>
>     The server already supports multiple versions, but currently chooses
>     the greatest. Make the server choose the first supported version
>     instead.
>
>     Because remote helpers now need this list of versions, pass the list
>     of versions as the GIT_PROTOCOL environment variable. (New remote
>     helpers will make use of this, and old remote helpers will use the
>     repo configuration.)
>
>     <special case about advertising version=0>
>
>     <unnecessary externs>

Ack, will adjust the wording in the next version. Thanks for the
suggestion.


> > diff --git a/builtin/archive.c b/builtin/archive.c
> > index e74f675390..8adb9f381b 100644
> > --- a/builtin/archive.c
> > +++ b/builtin/archive.c
> > @@ -8,6 +8,7 @@
> >  #include "transport.h"
> >  #include "parse-options.h"
> >  #include "pkt-line.h"
> > +#include "protocol.h"
> >  #include "sideband.h"
> >
> >  static void create_output_file(const char *output_file)
> > @@ -94,6 +95,8 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
> >             OPT_END()
> >     };
> >
> > +   register_allowed_protocol_version(protocol_v0);
> > +
> >     argc = parse_options(argc, argv, prefix, local_opts, NULL,
> >                          PARSE_OPT_KEEP_ALL);
> >
>
> What happens if a command never declares any version? It might be best
> to explicitly allow such a case, and treat it as a single list of
> protocol_v0.

Addressed below.


> > diff --git a/connect.c b/connect.c
> > index 94547e5056..57266b6cec 100644
> > --- a/connect.c
> > +++ b/connect.c
> > @@ -1046,7 +1046,7 @@ static enum ssh_variant determine_ssh_variant(const char *ssh_command,
> >   */
> >  static struct child_process *git_connect_git(int fd[2], char *hostandport,
> >                                          const char *path, const char *prog,
> > -                                        enum protocol_version version,
> > +                                        const struct strbuf *version_advert,
> >                                          int flags)
> >  {
> >     struct child_process *conn;
> > @@ -1084,12 +1084,9 @@ static struct child_process *git_connect_git(int fd[2], char *hostandport,
> >                 prog, path, 0,
> >                 target_host, 0);
> >
> > -   /* If using a new version put that stuff here after a second null byte */
> > -   if (version > 0) {
> > -           strbuf_addch(&request, '\0');
> > -           strbuf_addf(&request, "version=%d%c",
> > -                       version, '\0');
> > -   }
> > +   /* Add version fields after a second null byte */
> > +   strbuf_addch(&request, '\0');
> > +   strbuf_addf(&request, "%s%c", version_advert->buf, '\0');
> >
> >     packet_write(fd[1], request.buf, request.len);
>
> As expected, the version information for git:// is now written
> differently.
>
> > @@ -1104,14 +1101,13 @@ static struct child_process *git_connect_git(int fd[2], char *hostandport,
> >   */
> >  static void push_ssh_options(struct argv_array *args, struct argv_array *env,
> >                          enum ssh_variant variant, const char *port,
> > -                        enum protocol_version version, int flags)
> > +                        const struct strbuf *version_advert, int flags)
> >  {
> > -   if (variant == VARIANT_SSH &&
> > -       version > 0) {
> > +   if (variant == VARIANT_SSH) {
> >             argv_array_push(args, "-o");
> >             argv_array_push(args, "SendEnv=" GIT_PROTOCOL_ENVIRONMENT);
> > -           argv_array_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
> > -                            version);
> > +           argv_array_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=%s",
> > +                            version_advert->buf);
> >     }
> >
> >     if (flags & CONNECT_IPV4) {
>
> Likewise for ssh://.
>
> [snip other ssh code]
>
> > @@ -1226,16 +1223,10 @@ struct child_process *git_connect(int fd[2], const char *url,
> >  {
> >     char *hostandport, *path;
> >     struct child_process *conn;
> > +   struct strbuf version_advert = STRBUF_INIT;
> >     enum protocol protocol;
> > -   enum protocol_version version = get_protocol_version_config();
> >
> > -   /*
> > -    * NEEDSWORK: If we are trying to use protocol v2 and we are planning
> > -    * to perform a push, then fallback to v0 since the client doesn't know
> > -    * how to push yet using v2.
> > -    */
> > -   if (version == protocol_v2 && !strcmp("git-receive-pack", prog))
> > -           version = protocol_v0;
> > +   get_client_protocol_version_advertisement(&version_advert);
> >
> >     /* Without this we cannot rely on waitpid() to tell
> >      * what happened to our children.
>
> It's great that this hardcoded override is now removed. I see below (in
> another file) that the same occurs for http://.
>
> > +void register_allowed_protocol_versions_from_env(void)
> > +{
> > +   const char *git_protocol = getenv(GIT_PROTOCOL_ENVIRONMENT);
> > +   const char *version_str;
> > +   struct string_list version_list = STRING_LIST_INIT_DUP;
> > +   struct string_list_item *version;
> > +
> > +   if (!git_protocol)
> > +           return;
> > +
> > +   string_list_split(&version_list, git_protocol, ':', -1);
> > +   for_each_string_list_item(version, &version_list) {
> > +           if (skip_prefix(version->string, "version=", &version_str))
> > +                   register_allowed_protocol_version(
> > +                           parse_protocol_version(version_str));
>
> Probably worth BUG() if does not start with "version="?

Agreed.


> > +   }
> > +   string_list_clear(&version_list, 0);
> > +}
>
> [snip]
>
> > +void get_client_protocol_version_advertisement(struct strbuf *advert)
> > +{
> > +   int i, tmp_nr = nr_allowed_versions;
> > +   enum protocol_version *tmp_allowed_versions, config_version;
> > +   strbuf_reset(advert);
> > +
> > +   version_registration_locked = 1;
> > +
> > +   config_version = get_protocol_version_config();
> > +   if (config_version == protocol_v0) {
> > +           strbuf_addstr(advert, "version=0");
> > +           return;
> > +   }
>
> Why is protocol v0 special-cased like this?

To semi-preserve the existing behavior that no version negotiation would
happen when the config specifies version 0. Now we'll send out a version
advertisement where we wouldn't have before, but we only advertise v0 so
that no negotiation can happen.


> > +   if (tmp_nr > 0) {
> > +           ALLOC_ARRAY(tmp_allowed_versions, tmp_nr);
> > +           copy_array(tmp_allowed_versions, allowed_versions, tmp_nr,
> > +                      sizeof(enum protocol_version));
> > +   } else {
> > +           ALLOC_ARRAY(tmp_allowed_versions, 1);
> > +           tmp_nr = 1;
> > +           tmp_allowed_versions[0] = config_version;
>
> In this "else" block, wouldn't this mean that if we forget to declare
> any versions, we might send an unsupported version to the server? I
> didn't check this, but it might happen if we invoked
> transport_fetch_refs() without going through any of the builtins (which
> might happen in the case of a lazy fetch in a partial clone).

Hmm yeah. I changed the else{} here to die if we haven't registered any
versions prior to creating the advertisement string. t0410 case 9 and
t5702 case 20 both fail, and both are lazy fetches in partial clones.

In this case, defaulting to the version in the config works, because
fetching is valid for all protocol versions. But if we ever add some
version X where fetching hasn't been implemented this would break.

Should we change the else{} case here to be a BUG() and then fix
fetch-object to register its supported versions?


> > +   }
> > +
> > +   if (tmp_allowed_versions[0] != config_version)
> > +           for (i = 1; i < nr_allowed_versions; i++)
> > +                   if (tmp_allowed_versions[i] == config_version) {
> > +                           SWAP(tmp_allowed_versions[0],
> > +                                tmp_allowed_versions[i]);
> > +                   }
>
> It doesn't seem right to just directly swap the config_version with the
> front.
>
> Also, I think this is more complicated that it needs to be. You could
> just search for the config version; if found, loop backwards starting
> from the index, shuffling to the right, then put the config version in
> element 0.

Ack. Will fix.


> > +
> > +   strbuf_addf(advert, "version=%s",
> > +               format_protocol_version(tmp_allowed_versions[0]));
> > +   for (i = 1; i < tmp_nr; i++)
> > +           strbuf_addf(advert, ":version=%s",
> > +                       format_protocol_version(tmp_allowed_versions[i]));
> > +
> > +   free(tmp_allowed_versions);
> > +}
>
> [snip]
>
> >     const char *git_protocol = getenv(GIT_PROTOCOL_ENVIRONMENT);
> > @@ -38,9 +142,10 @@ enum protocol_version determine_protocol_version_server(void)
> >     /*
> >      * Determine which protocol version the client has requested.  Since
> >      * multiple 'version' keys can be sent by the client, indicating that
> > -    * the client is okay to speak any of them, select the greatest version
> > -    * that the client has requested.  This is due to the assumption that
> > -    * the most recent protocol version will be the most state-of-the-art.
> > +    * the client is okay to speak any of them, select the first
> > +    * recognizable version that the client has requested.  This is due to
> > +    * the assumption that the protocol versions will be listed in
> > +    * preference order.
> >      */
> >     if (git_protocol) {
> >             struct string_list list = STRING_LIST_INIT_DUP;
> > @@ -53,8 +158,11 @@ enum protocol_version determine_protocol_version_server(void)
> > 
> >                     if (skip_prefix(item->string, "version=", &value)) {
> >                             v = parse_protocol_version(value);
> > -                           if (v > version)
> > +                           if (v != protocol_unknown_version &&
> > +                               is_allowed_protocol_version(v)) {
> >                                     version = v;
> > +                                   break;
> > +                           }
> >                     }
> >             }
>
> Here we see that the server now takes the first version, as discussed.
>
> > diff --git a/protocol.h b/protocol.h
> > index 2ad35e433c..88330fd0ee 100644
> > --- a/protocol.h
> > +++ b/protocol.h
> > @@ -14,7 +14,24 @@ enum protocol_version {
> >   * 'protocol.version' config.  If unconfigured, a value of 'protocol_v0' is
> >   * returned.
> >   */
> > -extern enum protocol_version get_protocol_version_config(void);
> > +enum protocol_version get_protocol_version_config(void);
> > +
> > +/*
> > + * Register an allowable protocol version for a given operation. Registration
> > + * must occur before attempting to advertise a version to a server process.
> > + */
> > +void register_allowed_protocol_version(enum protocol_version version);
>
> I think the allowed protocol versions have to be transport-scoped. A
> single builtin command may invoke multiple remote commands (as will be
> the case if a lazy fetch in a partial clone is ever required).

Wouldn't it need to be per-transport per-command then? For example, if
we ever added a hypothetical git-fetch-then-rebase-then-push builtin, we
couldn't use the same version advertisement for the fetch and the push,
even if they're still using the same transport. Or would we have to use
separate transport objects for the fetch and the push in such a
situation?

If we do move the version list into the transport, what would be the
right way to register the allowed versions? Maybe we would make each
vtable entry declare its versions?

> > @@ -360,16 +373,10 @@ static struct discovery *discover_refs(const char *service, int for_push)
> >             strbuf_addf(&refs_url, "service=%s", service);
> >     }
> > 
> > -   /*
> > -    * NEEDSWORK: If we are trying to use protocol v2 and we are planning
> > -    * to perform a push, then fallback to v0 since the client doesn't know
> > -    * how to push yet using v2.
> > -    */
> > -   if (version == protocol_v2 && !strcmp("git-receive-pack", service))
> > -           version = protocol_v0;
> > +   get_client_protocol_version_advertisement(&version_advert);
> > 
> >     /* Add the extra Git-Protocol header */
> > -   if (get_protocol_http_header(version, &protocol_header))
> > +   if (get_client_protocol_http_header(&version_advert, &protocol_header))
> >             string_list_append(&extra_headers, protocol_header.buf);
> > 
> >     memset(&http_options, 0, sizeof(http_options));
>
> Great to see that this hardcoded override is also removed for http://.
>
> > @@ -489,10 +489,8 @@ test_expect_success 'push with http:// and a config of v2 does not request v2' '
> >     git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" log -1 --format=%s client_branch >expect &&
> >     test_cmp expect actual &&
> > 
> > -   # Client didnt request to use protocol v2
> > -   ! grep "Git-Protocol: version=2" log &&
> > -   # Server didnt respond using protocol v2
> > -   ! grep "git< version 2" log
> > +   # Server responded with version 1
> > +   grep "git< version 1" log
> >  '
>
> Change the test title - the client indeed would request 2, but since 1
> is in front, the server will use version 1.

Will do.
