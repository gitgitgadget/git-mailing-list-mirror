Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A64761F600
	for <e@80x24.org>; Thu, 20 Jul 2017 18:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935614AbdGTSXG (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 14:23:06 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:37955 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935408AbdGTSXE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 14:23:04 -0400
Received: by mail-pg0-f52.google.com with SMTP id s4so18064532pgr.5
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 11:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CMXVia6LKAKYSpq2PioHlFGpoyOL71BZuMzxmp+juVE=;
        b=FAXPFo42cfNJM2gW1h9cVFQ/HESjNn1M7VgadTYXN5U3jgvUn9NYeXKioB+/boJal/
         Twc7fjRCKNz58qoWoHD4v1xBch0CCMAImV+e1XMga14GsDTksVCgUX947FYIwTCpJZmR
         YCprNQ4hJiYEy1lDQ+HCOJlLft4FtJJwHdVCW3wRr/ZUhxUv6C8WL43BPXAw+oDcP2qK
         AR97l+uPPoLbh+OcGAMiMkg0mPhCG7iFut83bVzV+eaUYCFi1ZNKZGFW39mPkYyxL58x
         VJVOuIk64rg+iiT2jv/tn5KAqlwhr4DqIIub9PLgpcgEW2IYL6TNFZ3R+71Edv187lna
         o7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CMXVia6LKAKYSpq2PioHlFGpoyOL71BZuMzxmp+juVE=;
        b=suUSGQmBqSzZ2ZY6Ax688+yiV//GqB7XCLzSzkZtq1fMHf6Wwdhw2snUBRNz/AT/GV
         6ph/VXG0LB11JEblZ/Sqgn0v9TS3l+/WXh/mNo7cAYndZdPytdfsYgaf5Ag1DVggYz13
         scH/ZjS/XuxpT+4PMhXuiaJIMv2Qfhf0hTrxx5j+ClX6dI3ki0LV/3TEOv0T5TqS6IeY
         f6+7kzAWJL7NwfGIh7LJB6bVBivS2cPPvolv0f2cLh/M1mysm0+v6KS3/dAF76aszmsq
         Qr4T59dqL0Xy5Fs3qZbbcyVSHfn2ESso641aKlDjEc7OQ9zSz9QudqTVeqXHV4YBa9um
         0UpQ==
X-Gm-Message-State: AIVw111hdpvJEudvkWwGiQP4ktmhDrpen3JxI20hSYm7YMTFDQLQr4hG
        Wh27EiMva9RzStyjooaR3zobxqPB5uSu
X-Received: by 10.84.231.131 with SMTP id g3mr5183881plk.176.1500574983410;
 Thu, 20 Jul 2017 11:23:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Thu, 20 Jul 2017 11:23:02 -0700 (PDT)
In-Reply-To: <a7fa848672281e29bff01f8caf2abe9f6ce5f4ba.1500508695.git.jonathantanmy@google.com>
References: <cover.1499800530.git.jonathantanmy@google.com>
 <cover.1500508695.git.jonathantanmy@google.com> <a7fa848672281e29bff01f8caf2abe9f6ce5f4ba.1500508695.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 20 Jul 2017 11:23:02 -0700
Message-ID: <CAGZ79ka6vcF4Douc7EizwL_+_xaorro=gVw=1hfJv56kvN+7oQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/4] sha1_file: support promised object hook
To:     Jonathan Tan <jonathantanmy@google.com>,
        Lars Schneider <larsxschneider@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Ben Peart <peartben@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 19, 2017 at 5:21 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> Teach sha1_file to invoke a hook whenever an object is requested and
> unavailable but is promised. The hook is a shell command that can be
> configured through "git config"; this hook takes in a list of hashes and
> writes (if successful) the corresponding objects to the repo's local
> storage.
>
> The usage of the hook can be suppressed through a flag when invoking
> has_object_file_with_flags() and other similar functions.
> parse_or_promise_object() in object.c requires this functionality, and
> has been modified to use it.
>
> This is meant as a temporary measure to ensure that all Git commands
> work in such a situation. Future patches will update some commands to
> either tolerate promised objects (without invoking the hook) or be more
> efficient in invoking the promised objects hook.
>
> In order to determine the code changes in sha1_file.c necessary, I
> investigated the following:
>  (1) functions in sha1_file that take in a hash, without the user
>      regarding how the object is stored (loose or packed)
>  (2) functions in sha1_file that operate on packed objects (because I
>      need to check callers that know about the loose/packed distinction
>      and operate on both differently, and ensure that they can handle
>      the concept of objects that are neither loose nor packed)
>
> (1) is handled by the modification to sha1_object_info_extended().
>
> For (2), I looked at for_each_packed_object and at the packed-related
> functions that take in a hash. For for_each_packed_object, the callers
> either already work or are fixed in this patch:
>  - reachable - only to find recent objects
>  - builtin/fsck - already knows about promised objects
>  - builtin/cat-file - fixed in this commit
>
> Callers of the other functions do not need to be changed:
>  - parse_pack_index
>    - http - indirectly from http_get_info_packs
>  - find_pack_entry_one
>    - this searches a single pack that is provided as an argument; the
>      caller already knows (through other means) that the sought object
>      is in a specific pack
>  - find_sha1_pack
>    - fast-import - appears to be an optimization to not store a
>      file if it is already in a pack
>    - http-walker - to search through a struct alt_base
>    - http-push - to search through remote packs
>  - has_sha1_pack
>    - builtin/fsck - already knows about promised objects
>    - builtin/count-objects - informational purposes only (check if loose
>      object is also packed)
>    - builtin/prune-packed - check if object to be pruned is packed (if
>      not, don't prune it)
>    - revision - used to exclude packed objects if requested by user
>    - diff - just for optimization
>
> An alternative design that I considered but rejected:
>
>  - Adding a hook whenever a packed object is requested, not on any
>    object.  That is, whenever we attempt to search the packfiles for an
>    object, if it is missing (from the packfiles and from the loose
>    object storage), to invoke the hook (which must then store it as a
>    packfile), open the packfile the hook generated, and report that the
>    object is found in that new packfile. This reduces the amount of
>    analysis needed (in that we only need to look at how packed objects
>    are handled), but requires that the hook generate packfiles (or for
>    sha1_file to pack whatever loose objects are generated), creating one
>    packfile for each missing object and potentially very many packfiles
>    that must be linearly searched. This may be tolerable now for repos
>    that only have a few missing objects (for example, repos that only
>    want to exclude large blobs), and might be tolerable in the future if
>    we have batching support for the most commonly used commands, but is
>    not tolerable now for repos that exclude a large amount of objects.
>
> Helped-by: Ben Peart <benpeart@microsoft.com>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  Documentation/config.txt                         |   8 +
>  Documentation/gitrepository-layout.txt           |   8 +
>  Documentation/technical/read-object-protocol.txt | 102 ++++++++++++
>  builtin/cat-file.c                               |   9 ++
>  cache.h                                          |   2 +
>  object.c                                         |   3 +-
>  promised-object.c                                | 194 +++++++++++++++++++++++
>  promised-object.h                                |  12 ++
>  sha1_file.c                                      |  44 +++--
>  t/t3907-promised-object.sh                       |  32 ++++
>  t/t3907/read-object                              | 114 +++++++++++++
>  11 files changed, 513 insertions(+), 15 deletions(-)
>  create mode 100644 Documentation/technical/read-object-protocol.txt
>  create mode 100755 t/t3907/read-object
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index d5c9c4cab..c293ac921 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -393,6 +393,14 @@ The default is false, except linkgit:git-clone[1] or linkgit:git-init[1]
>  will probe and set core.ignoreCase true if appropriate when the repository
>  is created.
>
> +core.promisedBlobCommand::
> +       If set, whenever a blob in the local repo is attempted to be read, but
> +       is both missing and a promised blob, invoke this shell command to
> +       generate or obtain that blob before reporting an error. This shell
> +       command should take one or more hashes, each terminated by a newline,
> +       as standard input, and (if successful) should write the corresponding
> +       objects to the local repo (packed or loose).
> +
>  core.precomposeUnicode::
>         This option is only used by Mac OS implementation of Git.
>         When core.precomposeUnicode=true, Git reverts the unicode decomposition
> diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
> index f51ed4e37..7dea7fe6b 100644
> --- a/Documentation/gitrepository-layout.txt
> +++ b/Documentation/gitrepository-layout.txt
> @@ -47,6 +47,10 @@ use with dumb transports but otherwise is OK as long as
>  `objects/info/alternates` points at the object stores it
>  borrows from.
>  +
> +. You could have objects that are merely promised by another source.
> +When Git requires those objects, it will invoke the command in the
> +`extensions.promisedObjects` configuration variable.
> ++
>  This directory is ignored if $GIT_COMMON_DIR is set and
>  "$GIT_COMMON_DIR/objects" will be used instead.
>
> @@ -91,6 +95,10 @@ objects/info/http-alternates::
>         this object store borrows objects from, to be used when
>         the repository is fetched over HTTP.
>
> +objects/promised::
> +       This file records the sha1 object names, types, and sizes of
> +       promised objects.
> +
>  refs::
>         References are stored in subdirectories of this
>         directory.  The 'git prune' command knows to preserve
> diff --git a/Documentation/technical/read-object-protocol.txt b/Documentation/technical/read-object-protocol.txt
> new file mode 100644
> index 000000000..a893b46e7
> --- /dev/null
> +++ b/Documentation/technical/read-object-protocol.txt
> @@ -0,0 +1,102 @@
> +Read Object Process
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^

This protocol reads very similar to the protocol that is used in
clean/smudge filtering, designed by Lars (cc'd)

> +
> +The read-object process enables Git to read all missing blobs with a
> +single process invocation for the entire life of a single Git command.
> +This is achieved by using a packet format (pkt-line, see technical/
> +protocol-common.txt) based protocol over standard input and standard
> +output as follows. All packets, except for the "*CONTENT" packets and
> +the "0000" flush packet, are considered text and therefore are
> +terminated by a LF.
> +
> +Git starts the process when it encounters the first missing object that
> +needs to be retrieved. After the process is started, Git sends a welcome
> +message ("git-read-object-client"), a list of supported protocol version
> +numbers, and a flush packet. Git expects to read a welcome response
> +message ("git-read-object-server"), exactly one protocol version number
> +from the previously sent list, and a flush packet. All further
> +communication will be based on the selected version.
> +
> +The remaining protocol description below documents "version=1". Please
> +note that "version=42" in the example below does not exist and is only
> +there to illustrate how the protocol would look with more than one
> +version.
> +
> +After the version negotiation Git sends a list of all capabilities that
> +it supports and a flush packet. Git expects to read a list of desired
> +capabilities, which must be a subset of the supported capabilities list,
> +and a flush packet as response:
> +------------------------
> +packet: git> git-read-object-client
> +packet: git> version=1
> +packet: git> version=42
> +packet: git> 0000
> +packet: git< git-read-object-server
> +packet: git< version=1
> +packet: git< 0000
> +packet: git> capability=get
> +packet: git> capability=have
> +packet: git> capability=put
> +packet: git> capability=not-yet-invented
> +packet: git> 0000
> +packet: git< capability=get
> +packet: git< 0000
> +------------------------
> +The only supported capability in version 1 is "get".
> +
> +Afterwards Git sends a list of "key=value" pairs terminated with a flush
> +packet. The list will contain at least the command (based on the
> +supported capabilities) and the sha1 of the object to retrieve. Please
> +note, that the process must not send any response before it received the
> +final flush packet.
> +
> +When the process receives the "get" command, it should make the requested
> +object available in the git object store and then return success. Git will
> +then check the object store again and this time find it and proceed.
> +------------------------
> +packet: git> command=get
> +packet: git> sha1=0a214a649e1b3d5011e14a3dc227753f2bd2be05
> +packet: git> 0000
> +------------------------
> +
> +The process is expected to respond with a list of "key=value" pairs
> +terminated with a flush packet. If the process does not experience
> +problems then the list must contain a "success" status.
> +------------------------
> +packet: git< status=success
> +packet: git< 0000
> +------------------------
> +
> +In case the process cannot or does not want to process the content, it
> +is expected to respond with an "error" status.
> +------------------------
> +packet: git< status=error
> +packet: git< 0000
> +------------------------
> +
> +In case the process cannot or does not want to process the content as
> +well as any future content for the lifetime of the Git process, then it
> +is expected to respond with an "abort" status at any point in the
> +protocol.
> +------------------------
> +packet: git< status=abort
> +packet: git< 0000
> +------------------------
> +
> +Git neither stops nor restarts the process in case the "error"/"abort"
> +status is set.
> +
> +If the process dies during the communication or does not adhere to the
> +protocol then Git will stop the process and restart it with the next
> +object that needs to be processed.
> +
> +After the read-object process has processed an object it is expected to
> +wait for the next "key=value" list containing a command. Git will close
> +the command pipe on exit. The process is expected to detect EOF and exit
> +gracefully on its own. Git will wait until the process has stopped.
> +
> +A long running read-object process demo implementation can be found in
> +`contrib/long-running-read-object/example.pl` located in the Git core
> +repository. If you develop your own long running process then the
> +`GIT_TRACE_PACKET` environment variables can be very helpful for
> +debugging (see linkgit:git[1]).
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 96b786e48..33f636926 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -12,6 +12,7 @@
>  #include "streaming.h"
>  #include "tree-walk.h"
>  #include "sha1-array.h"
> +#include "promised-object.h"
>
>  struct batch_options {
>         int enabled;
> @@ -432,6 +433,13 @@ static int batch_packed_object(const struct object_id *oid,
>         return 0;
>  }
>
> +static int batch_promised_object(const struct object_id *oid,
> +                                void *data)
> +{
> +       oid_array_append(data, oid);
> +       return 0;
> +}
> +
>  static int batch_objects(struct batch_options *opt)
>  {
>         struct strbuf buf = STRBUF_INIT;
> @@ -473,6 +481,7 @@ static int batch_objects(struct batch_options *opt)
>
>                 for_each_loose_object(batch_loose_object, &sa, 0);
>                 for_each_packed_object(batch_packed_object, &sa, 0);
> +               for_each_promised_object(batch_promised_object, &sa);
>
>                 cb.opt = opt;
>                 cb.expand = &data;
> diff --git a/cache.h b/cache.h
> index dd94b5ffc..75b71f38b 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1835,6 +1835,8 @@ struct object_info {
>  #define OBJECT_INFO_SKIP_CACHED 4
>  /* Do not retry packed storage after checking packed and loose storage */
>  #define OBJECT_INFO_QUICK 8
> +/* Ignore list of promised objects */
> +#define OBJECT_INFO_IGNORE_PROMISES 16
>  extern int sha1_object_info_extended(const unsigned char *, struct object_info *, unsigned flags);
>  extern int packed_object_info(struct packed_git *pack, off_t offset, struct object_info *);
>
> diff --git a/object.c b/object.c
> index 0aeb95084..23f2a6cbc 100644
> --- a/object.c
> +++ b/object.c
> @@ -285,7 +285,8 @@ struct object *parse_or_promise_object(const struct object_id *oid)
>  {
>         enum object_type type;
>
> -       if (has_object_file(oid))
> +       if (has_object_file_with_flags(oid, OBJECT_INFO_SKIP_CACHED |
> +                                           OBJECT_INFO_IGNORE_PROMISES))
>                 return parse_object(oid);
>
>         if (is_promised_object(oid, &type, NULL)) {
> diff --git a/promised-object.c b/promised-object.c
> index 487ade437..d8d95ebb2 100644
> --- a/promised-object.c
> +++ b/promised-object.c
> @@ -2,6 +2,12 @@
>  #include "promised-object.h"
>  #include "sha1-lookup.h"
>  #include "strbuf.h"
> +#include "run-command.h"
> +#include "sha1-array.h"
> +#include "config.h"
> +#include "sigchain.h"
> +#include "sub-process.h"
> +#include "pkt-line.h"
>
>  #define ENTRY_SIZE (GIT_SHA1_RAWSZ + 1 + 8)
>  /*
> @@ -128,3 +134,191 @@ int fsck_promised_objects(void)
>         }
>         return 0;
>  }
> +
> +#define CAP_GET    (1u<<0)
> +
> +static int subprocess_map_initialized;
> +static struct hashmap subprocess_map;
> +
> +struct read_object_process {
> +       struct subprocess_entry subprocess;
> +       unsigned int supported_capabilities;
> +};
> +
> +int start_read_object_fn(struct subprocess_entry *subprocess)
> +{
> +       int err;
> +       struct read_object_process *entry = (struct read_object_process *)subprocess;
> +       struct child_process *process;
> +       struct string_list cap_list = STRING_LIST_INIT_NODUP;
> +       char *cap_buf;
> +       const char *cap_name;
> +
> +       process = subprocess_get_child_process(&entry->subprocess);
> +
> +       sigchain_push(SIGPIPE, SIG_IGN);
> +
> +       err = packet_writel(process->in, "git-read-object-client", "version=1", NULL);
> +       if (err)
> +               goto done;
> +
> +       err = strcmp(packet_read_line(process->out, NULL), "git-read-object-server");
> +       if (err) {
> +               error("external process '%s' does not support read-object protocol version 1", subprocess->cmd);
> +               goto done;
> +       }
> +       err = strcmp(packet_read_line(process->out, NULL), "version=1");
> +       if (err)
> +               goto done;
> +       err = packet_read_line(process->out, NULL) != NULL;
> +       if (err)
> +               goto done;
> +
> +       err = packet_writel(process->in, "capability=get", NULL);
> +       if (err)
> +               goto done;
> +
> +       for (;;) {
> +               cap_buf = packet_read_line(process->out, NULL);
> +               if (!cap_buf)
> +                       break;
> +               string_list_split_in_place(&cap_list, cap_buf, '=', 1);
> +
> +               if (cap_list.nr != 2 || strcmp(cap_list.items[0].string, "capability"))
> +                       continue;
> +
> +               cap_name = cap_list.items[1].string;
> +               if (!strcmp(cap_name, "get")) {
> +                       entry->supported_capabilities |= CAP_GET;
> +               }
> +               else {
> +                       warning(
> +                               "external process '%s' requested unsupported read-object capability '%s'",
> +                               subprocess->cmd, cap_name
> +                       );
> +               }
> +
> +               string_list_clear(&cap_list, 0);
> +       }
> +
> +done:
> +       sigchain_pop(SIGPIPE);
> +
> +       if (err || errno == EPIPE)
> +               return err ? err : errno;
> +
> +       return 0;
> +}
> +
> +static int read_object_process(const unsigned char *sha1)
> +{
> +       int err;
> +       struct read_object_process *entry;
> +       struct child_process *process;
> +       struct strbuf status = STRBUF_INIT;
> +       uint64_t start;
> +
> +       start = getnanotime();
> +
> +       if (!repository_format_promised_objects)
> +               die("BUG: if extensions.promisedObjects is not set, there "
> +                   "should not be any promised objects");
> +
> +       if (!subprocess_map_initialized) {
> +               subprocess_map_initialized = 1;
> +               hashmap_init(&subprocess_map, (hashmap_cmp_fn)cmd2process_cmp, 0);
> +               entry = NULL;
> +       } else {
> +               entry = (struct read_object_process *)subprocess_find_entry(&subprocess_map, repository_format_promised_objects);
> +       }
> +       if (!entry) {
> +               entry = xmalloc(sizeof(*entry));
> +               entry->supported_capabilities = 0;
> +
> +               if (subprocess_start(&subprocess_map, &entry->subprocess, repository_format_promised_objects, start_read_object_fn)) {
> +                       free(entry);
> +                       return -1;
> +               }
> +       }
> +       process = subprocess_get_child_process(&entry->subprocess);
> +
> +       if (!(CAP_GET & entry->supported_capabilities))
> +               return -1;
> +
> +       sigchain_push(SIGPIPE, SIG_IGN);
> +
> +       err = packet_write_fmt_gently(process->in, "command=get\n");
> +       if (err)
> +               goto done;
> +
> +       err = packet_write_fmt_gently(process->in, "sha1=%s\n", sha1_to_hex(sha1));
> +       if (err)
> +               goto done;
> +
> +       err = packet_flush_gently(process->in);
> +       if (err)
> +               goto done;
> +
> +       err = subprocess_read_status(process->out, &status);
> +       err = err ? err : strcmp(status.buf, "success");
> +
> +done:
> +       sigchain_pop(SIGPIPE);
> +
> +       if (err || errno == EPIPE) {
> +               err = err ? err : errno;
> +               if (!strcmp(status.buf, "error")) {
> +                       /* The process signaled a problem with the file. */
> +               }
> +               else if (!strcmp(status.buf, "abort")) {
> +                       /*
> +                        * The process signaled a permanent problem. Don't try to read
> +                        * objects with the same command for the lifetime of the current
> +                        * Git process.
> +                        */
> +                       entry->supported_capabilities &= ~CAP_GET;
> +               }
> +               else {
> +                       /*
> +                        * Something went wrong with the read-object process.
> +                        * Force shutdown and restart if needed.
> +                        */
> +                       error("external process '%s' failed", repository_format_promised_objects);
> +                       subprocess_stop(&subprocess_map, (struct subprocess_entry *)entry);
> +                       free(entry);
> +               }
> +       }
> +
> +       trace_performance_since(start, "read_object_process");
> +
> +       return err;
> +}
> +
> +int request_promised_objects(const struct oid_array *oids)
> +{
> +       int oids_requested = 0;
> +       int i;
> +
> +       for (i = 0; i < oids->nr; i++) {
> +               if (is_promised_object(&oids->oid[i], NULL, NULL))
> +                       break;
> +       }
> +
> +       if (i == oids->nr)
> +               /* Nothing to fetch */
> +               return 0;
> +
> +       for (; i < oids->nr; i++) {
> +               if (is_promised_object(&oids->oid[i], NULL, NULL)) {
> +                       read_object_process(oids->oid[i].hash);
> +                       oids_requested++;
> +               }
> +       }
> +
> +       /*
> +        * The command above may have updated packfiles, so update our record
> +        * of them.
> +        */
> +       reprepare_packed_git();
> +       return oids_requested;
> +}
> diff --git a/promised-object.h b/promised-object.h
> index 7eaedff17..8ad47aa4c 100644
> --- a/promised-object.h
> +++ b/promised-object.h
> @@ -2,6 +2,7 @@
>  #define PROMISED_OBJECT_H
>
>  #include "cache.h"
> +#include "sha1-array.h"
>
>  /*
>   * Returns 1 if oid is the name of a promised object. For non-blobs, 0 is
> @@ -19,4 +20,15 @@ int for_each_promised_object(each_promised_object_fn, void *);
>   */
>  int fsck_promised_objects(void);
>
> +/*
> + * If any of the given objects are promised objects, invokes
> + * core.promisedobjectcommand with those objects and returns the number of
> + * objects requested. No check is made as to whether the invocation actually
> + * populated the repository with the promised objects.
> + *
> + * If none of the given objects are promised objects, this function does not
> + * invoke anything and returns 0.
> + */
> +int request_promised_objects(const struct oid_array *oids);
> +
>  #endif
> diff --git a/sha1_file.c b/sha1_file.c
> index 5862386cd..ded0ef46b 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -28,6 +28,11 @@
>  #include "list.h"
>  #include "mergesort.h"
>  #include "quote.h"
> +#include "iterator.h"
> +#include "dir-iterator.h"
> +#include "sha1-lookup.h"
> +#include "promised-object.h"
> +#include "sha1-array.h"
>
>  #define SZ_FMT PRIuMAX
>  static inline uintmax_t sz_fmt(size_t s) { return s; }
> @@ -2983,6 +2988,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
>         const unsigned char *real = (flags & OBJECT_INFO_LOOKUP_REPLACE) ?
>                                     lookup_replace_object(sha1) :
>                                     sha1;
> +       int already_retried = 0;
>
>         if (!oi)
>                 oi = &blank_oi;
> @@ -3007,30 +3013,40 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
>                 }
>         }
>
> -       if (!find_pack_entry(real, &e)) {
> -               /* Most likely it's a loose object. */
> -               if (!sha1_loose_object_info(real, oi, flags)) {
> -                       oi->whence = OI_LOOSE;
> -                       return 0;
> -               }
> +retry:
> +       if (find_pack_entry(real, &e))
> +               goto found_packed;
>
> -               /* Not a loose object; someone else may have just packed it. */
> -               if (flags & OBJECT_INFO_QUICK) {
> -                       return -1;
> -               } else {
> -                       reprepare_packed_git();
> -                       if (!find_pack_entry(real, &e))
> -                               return -1;
> +       /* Most likely it's a loose object. */
> +       if (!sha1_loose_object_info(real, oi, flags)) {
> +               oi->whence = OI_LOOSE;
> +               return 0;
> +       }
> +
> +       /* Not a loose object; someone else may have just packed it. */
> +       reprepare_packed_git();
> +       if (find_pack_entry(real, &e))
> +               goto found_packed;
> +
> +       /* Check if it is a promised blob */
> +       if (!already_retried && !(flags & OBJECT_INFO_IGNORE_PROMISES)) {
> +               struct oid_array promised = OID_ARRAY_INIT;
> +               oid_array_append_sha1(&promised, real);
> +               if (request_promised_objects(&promised)) {
> +                       already_retried = 1;
> +                       goto retry;
>                 }
>         }
>
> +       return -1;
> +
> +found_packed:
>         if (oi == &blank_oi)
>                 /*
>                  * We know that the caller doesn't actually need the
>                  * information below, so return early.
>                  */
>                 return 0;
> -
>         rtype = packed_object_info(e.p, e.offset, oi);
>         if (rtype < 0) {
>                 mark_bad_packed_object(e.p, real);
> diff --git a/t/t3907-promised-object.sh b/t/t3907-promised-object.sh
> index 3e0caf4f9..d9e6a6486 100755
> --- a/t/t3907-promised-object.sh
> +++ b/t/t3907-promised-object.sh
> @@ -38,4 +38,36 @@ test_expect_success '...but fails again with GIT_IGNORE_PROMISED_OBJECTS' '
>         unset GIT_IGNORE_PROMISED_OBJECTS
>  '
>
> +test_expect_success 'sha1_object_info_extended (through git cat-file)' '
> +       test_create_repo server &&
> +       test_commit -C server 1 1.t abcdefgh &&
> +       HASH=$(git hash-object server/1.t) &&
> +
> +       test_create_repo client &&
> +       test_must_fail git -C client cat-file -p "$HASH"
> +'
> +
> +test_expect_success '...succeeds if it is a promised object' '
> +       printf "%s03%016x" "$HASH" "$(wc -c <server/1.t)" |
> +               hex_pack >client/.git/objects/promised &&
> +       git -C client config core.repositoryformatversion 1 &&
> +       git -C client config extensions.promisedobjects \
> +               "\"$TEST_DIRECTORY/t3907/read-object\" \"$(pwd)/server/.git\"" &&
> +       git -C client cat-file -p "$HASH"
> +'
> +
> +test_expect_success 'cat-file --batch-all-objects with promised objects' '
> +       rm -rf client &&
> +       test_create_repo client &&
> +       git -C client config core.repositoryformatversion 1 &&
> +       git -C client config extensions.promisedobjects \
> +               "\"$TEST_DIRECTORY/t3907/read-object\" \"$(pwd)/server/.git\"" &&
> +       printf "%s03%016x" "$HASH" "$(wc -c <server/1.t)" |
> +               hex_pack >client/.git/objects/promised &&
> +
> +       # Verify that the promised object is printed
> +       git -C client cat-file --batch --batch-all-objects | tee out |
> +               grep abcdefgh
> +'
> +
>  test_done
> diff --git a/t/t3907/read-object b/t/t3907/read-object
> new file mode 100755
> index 000000000..9666ad597
> --- /dev/null
> +++ b/t/t3907/read-object
> @@ -0,0 +1,114 @@
> +#!/usr/bin/perl
> +#
> +# Example implementation for the Git read-object protocol version 1
> +# See Documentation/technical/read-object-protocol.txt
> +#
> +# Allows you to test the ability for blobs to be pulled from a host git repo
> +# "on demand."  Called when git needs a blob it couldn't find locally due to
> +# a lazy clone that only cloned the commits and trees.
> +#
> +# A lazy clone can be simulated via the following commands from the host repo
> +# you wish to create a lazy clone of:
> +#
> +# cd /host_repo
> +# git rev-parse HEAD
> +# git init /guest_repo
> +# git cat-file --batch-check --batch-all-objects | grep -v 'blob' |
> +#      cut -d' ' -f1 | git pack-objects /guest_repo/.git/objects/pack/noblobs
> +# cd /guest_repo
> +# git config core.virtualizeobjects true
> +# git reset --hard <sha from rev-parse call above>
> +#
> +# Please note, this sample is a minimal skeleton. No proper error handling
> +# was implemented.
> +#
> +
> +use strict;
> +use warnings;
> +
> +#
> +# Point $DIR to the folder where your host git repo is located so we can pull
> +# missing objects from it
> +#
> +my $DIR = $ARGV[0];
> +
> +sub packet_bin_read {
> +       my $buffer;
> +       my $bytes_read = read STDIN, $buffer, 4;
> +       if ( $bytes_read == 0 ) {
> +
> +               # EOF - Git stopped talking to us!
> +               exit();
> +       }
> +       elsif ( $bytes_read != 4 ) {
> +               die "invalid packet: '$buffer'";
> +       }
> +       my $pkt_size = hex($buffer);
> +       if ( $pkt_size == 0 ) {
> +               return ( 1, "" );
> +       }
> +       elsif ( $pkt_size > 4 ) {
> +               my $content_size = $pkt_size - 4;
> +               $bytes_read = read STDIN, $buffer, $content_size;
> +               if ( $bytes_read != $content_size ) {
> +                       die "invalid packet ($content_size bytes expected; $bytes_read bytes read)";
> +               }
> +               return ( 0, $buffer );
> +       }
> +       else {
> +               die "invalid packet size: $pkt_size";
> +       }
> +}
> +
> +sub packet_txt_read {
> +       my ( $res, $buf ) = packet_bin_read();
> +       unless ( $buf =~ s/\n$// ) {
> +               die "A non-binary line MUST be terminated by an LF.";
> +       }
> +       return ( $res, $buf );
> +}
> +
> +sub packet_bin_write {
> +       my $buf = shift;
> +       print STDOUT sprintf( "%04x", length($buf) + 4 );
> +       print STDOUT $buf;
> +       STDOUT->flush();
> +}
> +
> +sub packet_txt_write {
> +       packet_bin_write( $_[0] . "\n" );
> +}
> +
> +sub packet_flush {
> +       print STDOUT sprintf( "%04x", 0 );
> +       STDOUT->flush();
> +}
> +
> +( packet_txt_read() eq ( 0, "git-read-object-client" ) ) || die "bad initialize";
> +( packet_txt_read() eq ( 0, "version=1" ) )                             || die "bad version";
> +( packet_bin_read() eq ( 1, "" ) )                       || die "bad version end";
> +
> +packet_txt_write("git-read-object-server");
> +packet_txt_write("version=1");
> +packet_flush();
> +
> +( packet_txt_read() eq ( 0, "capability=get" ) )    || die "bad capability";
> +( packet_bin_read() eq ( 1, "" ) )                  || die "bad capability end";
> +
> +packet_txt_write("capability=get");
> +packet_flush();
> +
> +while (1) {
> +       my ($command) = packet_txt_read() =~ /^command=([^=]+)$/;
> +
> +       if ( $command eq "get" ) {
> +               my ($sha1) = packet_txt_read() =~ /^sha1=([0-9a-f]{40})$/;
> +               packet_bin_read();
> +
> +               system ('git --git-dir="' . $DIR . '" cat-file blob ' . $sha1 . ' | git -c core.virtualizeobjects=false hash-object -w --stdin >/dev/null 2>&1');
> +               packet_txt_write(($?) ? "status=error" : "status=success");
> +               packet_flush();
> +       } else {
> +               die "bad command '$command'";
> +       }
> +}
> --
> 2.14.0.rc0.284.gd933b75aa4-goog
>
