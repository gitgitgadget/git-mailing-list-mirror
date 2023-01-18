Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E802AC00A5A
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 03:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjARDav (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 22:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjARDa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 22:30:26 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07F83803F
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 19:30:22 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id k16so3101799wms.2
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 19:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuCPM2oJwJ1lQSy4V81rKNfCAJ0QXbqDmnqZ7pgVht4=;
        b=eWbXtLrt5v34So3+LwJmaGIQTLlNfIHQOsmZz/kEh5qM2tOre7zVF/EIQ4AZ15n8yi
         apwKXrjHJlxhKnvoTYQcBqVMl94nFSUXW+ZCCVA56wC3ObpOUXafqS8stetfb/IjU28i
         CrjCTFAajqd0V6C8PdcJfw6GYDc107j8300Nt6Z0bA1RnxeP18I1kAQ640CHRAjDedxD
         91NoN64EIor8NLCU266i54g9fjwUSjtOjdkRtI3R2F+45w9ZMaKcByavTF+fe55S5thi
         ZUcDBbvgBUIu8bV7XA+IPy41rneptmKDxLLKxvqQHPMBl1J4yQwRZ5dCqS6w9GkeOr3L
         HeVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NuCPM2oJwJ1lQSy4V81rKNfCAJ0QXbqDmnqZ7pgVht4=;
        b=bujyMTNq8orAHJOluYRT1vBUodCbzYTS/pz1Iofu6jliGY+VnUHa3VL/5ll256q8PN
         bYHcJ4INcxxpheKWfFjpXGUEec8WHdbCpojAYR4Bblq8i5d7BscIe7n5SearCZd6mSff
         4KHiIA5ElxW/yCGkZrpxg5G63XhRh9RUwAGBugJ7cix3zaVJ4/oIlxexjf2sLY6zlzvp
         3xpCTBIx303O9IpLcg9xdlZlP7GaXBQH/R4CjNSpeXJ68plhVdi+2PGZV1JwbPUeirW/
         +17+BesYQRDuQwfSqjnoG9idHvawVAFTxo+NejlS7WTBaY2W2Xny08Kh8HKTOiMfiAfl
         BpSQ==
X-Gm-Message-State: AFqh2kr7Hppd82APc8eXO6uD7izSG2R92SIAu/z3a6Nw0bWZYjA7drfT
        mokuhGseQGG2tCfuFl6/cuJa/ZbthcE=
X-Google-Smtp-Source: AMrXdXsVdMqQKd3zA3+X9vbqsPBNIciTlDMFqkgjFjMbCJZ0c+3uJqr4OMnbJLvsfdZAtiNDM94gZA==
X-Received: by 2002:a05:600c:3ca6:b0:3d1:caf1:3f56 with SMTP id bg38-20020a05600c3ca600b003d1caf13f56mr13914978wmb.9.1674012620079;
        Tue, 17 Jan 2023 19:30:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h1-20020a05600c350100b003d990372dd5sm628407wmq.20.2023.01.17.19.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 19:30:19 -0800 (PST)
Message-Id: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
References: <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Jan 2023 03:30:05 +0000
Subject: [PATCH v6 00/12] Enhance credential helper protocol to include auth headers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Matthew John Cheetham <mjcheetham@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following from my original RFC submission [0], this submission is considered
ready for full review. This patch series is now based on top of current
master (9c32cfb49c60fa8173b9666db02efe3b45a8522f) that includes my now
separately submitted patches [1] to fix up the other credential helpers'
behaviour.

In this patch series I update the existing credential helper design in order
to allow for some new scenarios, and future evolution of auth methods that
Git hosts may wish to provide. I outline the background, summary of changes
and some challenges below.

Testing these new additions, I introduce a new test helper test-http-server
that acts as a frontend to git-http-backend; a mini HTTP server sharing code
with git-daemon, with simple authentication configurable by a config file.


Background
==========

Git uses a variety of protocols [2]: local, Smart HTTP, Dumb HTTP, SSH, and
Git. Here I focus on the Smart HTTP protocol, and attempt to enhance the
authentication capabilities of this protocol to address limitations (see
below).

The Smart HTTP protocol in Git supports a few different types of HTTP
authentication - Basic and Digest (RFC 2617) [3], and Negotiate (RFC 2478)
[4]. Git uses a extensible model where credential helpers can provide
credentials for protocols [5]. Several helpers support alternatives such as
OAuth authentication (RFC 6749) [6], but this is typically done as an
extension. For example, a helper might use basic auth and set the password
to an OAuth Bearer access token. Git uses standard input and output to
communicate with credential helpers.

After a HTTP 401 response, Git would call a credential helper with the
following over standard input:

protocol=https
host=example.com


And then a credential helper would return over standard output:

protocol=https
host=example.com
username=bob@id.example.com
password=<BEARER-TOKEN>


Git then the following request to the remote, including the standard HTTP
Authorization header (RFC 7235 Section 4.2) [7]:

GET /info/refs?service=git-upload-pack HTTP/1.1
Host: git.example
Git-Protocol: version=2
Authorization: Basic base64(bob@id.example.com:<BEARER-TOKEN>)


Credential helpers are encouraged (see gitcredentials.txt) to return the
minimum information necessary.


Limitations
===========

Because this credential model was built mostly for password based
authentication systems, it's somewhat limited. In particular:

 1. To generate valid credentials, additional information about the request
    (or indeed the requestee and their device) may be required. For example,
    OAuth is based around scopes. A scope, like "git.read", might be
    required to read data from the remote. However, the remote cannot tell
    the credential helper what scope is required for this request.

 2. This system is not fully extensible. Each time a new type of
    authentication (like OAuth Bearer) is invented, Git needs updates before
    credential helpers can take advantage of it (or leverage a new
    capability in libcurl).


Goals
=====

 * As a user with multiple federated cloud identities:
   
   * Reach out to a remote and have my credential helper automatically
     prompt me for the correct identity.
   * Allow credential helpers to differentiate between different authorities
     or authentication/authorization challenge types, even from the same DNS
     hostname (and without needing to use credential.useHttpPath).
   * Leverage existing authentication systems built-in to many operating
     systems and devices to boost security and reduce reliance on passwords.

 * As a Git host and/or cloud identity provider:
   
   * Enforce security policies (like requiring two-factor authentication)
     dynamically.
   * Allow integration with third party standard based identity providers in
     enterprises allowing customers to have a single plane of control for
     critical identities with access to source code.


Design Principles
=================

 * Use the existing infrastructure. Git credential helpers are an
   already-working model.
 * Follow widely-adopted time-proven open standards, avoid net new ideas in
   the authentication space.
 * Minimize knowledge of authentication in Git; maintain modularity and
   extensibility.


Proposed Changes
================

 1. Teach Git to read HTTP response headers, specifically the standard
    WWW-Authenticate (RFC 7235 Section 4.1) headers.

 2. Teach Git to include extra information about HTTP responses that require
    authentication when calling credential helpers. Specifically the
    WWW-Authenticate header information.
    
    Because the extra information forms an ordered list, and the existing
    credential helper I/O format only provides for simple key=value pairs,
    we introduce a new convention for transmitting an ordered list of
    values. Key names that are suffixed with a C-style array syntax should
    have values considered to form an order list, i.e. key[]=value, where
    the order of the key=value pairs in the stream specifies the order.
    
    For the WWW-Authenticate header values we opt to use the key wwwauth[].


Handling the WWW-Authenticate header in detail
==============================================

RFC 6750 [8] envisions that OAuth Bearer resource servers would give
responses that include WWW-Authenticate headers, for example:

HTTP/1.1 401 Unauthorized
WWW-Authenticate: Bearer realm="login.example", scope="git.readwrite"
WWW-Authenticate: Basic realm="login.example"


Specifically, a WWW-Authenticate header consists of a scheme and arbitrary
attributes, depending on the scheme. This pattern enables generic OAuth or
OpenID Connect [9] authorities. Note that it is possible to have several
WWW-Authenticate challenges in a response.

First Git attempts to make a request, unauthenticated, which fails with a
401 response and includes WWW-Authenticate header(s).

Next, Git invokes a credential helper which may prompt the user. If the user
approves, a credential helper can generate a token (or any auth challenge
response) to be used for that request.

For example: with a remote that supports bearer tokens from an OpenID
Connect [9] authority, a credential helper can use OpenID Connect's
Discovery [10] and Dynamic Client Registration [11] to register a client and
make a request with the correct permissions to access the remote. In this
manner, a user can be dynamically sent to the right federated identity
provider for a remote without any up-front configuration or manual
processes.

Following from the principle of keeping authentication knowledge in Git to a
minimum, we modify Git to add all WWW-Authenticate values to the credential
helper call.

Git sends over standard input:

protocol=https
host=example.com
wwwauth[]=Bearer realm="login.example", scope="git.readwrite"
wwwauth[]=Basic realm="login.example"


A credential helper that understands the extra wwwauth[n] property can
decide on the "best" or correct authentication scheme, generate credentials
for the request, and interact with the user.

The credential helper would then return over standard output:

protocol=https
host=example.com
path=foo.git
username=bob@identity.example
password=<BEARER-TOKEN>


Note that WWW-Authenticate supports multiple challenges, either in one
header:

HTTP/1.1 401 Unauthorized
WWW-Authenticate: Bearer realm="login.example", scope="git.readwrite", Basic realm="login.example"


or in multiple headers:

HTTP/1.1 401 Unauthorized
WWW-Authenticate: Bearer realm="login.example", scope="git.readwrite"
WWW-Authenticate: Basic realm="login.example"


These have equivalent meaning (RFC 2616 Section 4.2 [12]). To simplify the
implementation, Git will not merge or split up any of these WWW-Authenticate
headers, and instead pass each header line as one credential helper
property. The credential helper is responsible for splitting, merging, and
otherwise parsing these header values.

An alternative option to sending the header fields individually would be to
merge the header values in to one key=value property, for example:

...
wwwauth=Bearer realm="login.example", scope="git.readwrite", Basic realm="login.example"



Future work
===========

In the future we can further expand the protocol to allow credential helpers
decide the best authentication scheme. Today credential helpers are still
only expected to return a username/password pair to Git, meaning the other
authentication schemes that may be offered still need challenge responses
sent via a Basic Authorization header. The changes outlined above still
permit helpers to select and configure an available authentication mode, but
require the remote for example to unpack a bearer token from a basic
challenge.

More careful consideration is required in the handling of custom
authentication schemes which may not have a username, or may require
arbitrary additional request header values be set.

For example imagine a new "FooBar" authentication scheme that is surfaced in
the following response:

HTTP/1.1 401 Unauthorized
WWW-Authenticate: FooBar realm="login.example", algs="ES256 PS256"


With support for arbitrary authentication schemes, Git would call credential
helpers with the following over standard input:

protocol=https
host=example.com
wwwauth[]=FooBar realm="login.example", algs="ES256 PS256", nonce="abc123"


And then an enlightened credential helper could return over standard output:

protocol=https
host=example.com
authtype=FooBar
username=bob@id.example.com
password=<FooBar credential>
header[]=X-FooBar: 12345
header[]=X-FooBar-Alt: ABCDEF


Git would be expected to attach this authorization header to the next
request:

GET /info/refs?service=git-upload-pack HTTP/1.1
Host: git.example
Git-Protocol: version=2
Authorization: FooBar <FooBar credential>
X-FooBar: 12345
X-FooBar-Alt: ABCDEF



Why not SSH?
============

There's nothing wrong with SSH. However, Git's Smart HTTP transport is
widely used, often with OAuth Bearer tokens. Git's Smart HTTP transport
sometimes requires less client setup than SSH transport, and works in
environments when SSH ports may be blocked. As long as Git supports HTTP
transport, it should support common and popular HTTP authentication methods.


References
==========

 * [0] [PATCH 0/8] [RFC] Enhance credential helper protocol to include auth
   headers
   https://lore.kernel.org/git/pull.1352.git.1663097156.gitgitgadget@gmail.com/

 * [1] [PATCH 0/3] Correct credential helper discrepancies handling input
   https://lore.kernel.org/git/pull.1363.git.1663865974.gitgitgadget@gmail.com/

 * [2] Git on the Server - The Protocols
   https://git-scm.com/book/en/v2/Git-on-the-Server-The-Protocols

 * [3] HTTP Authentication: Basic and Digest Access Authentication
   https://datatracker.ietf.org/doc/html/rfc2617

 * [4] The Simple and Protected GSS-API Negotiation Mechanism
   https://datatracker.ietf.org/doc/html/rfc2478

 * [5] Git Credentials - Custom Helpers
   https://git-scm.com/docs/gitcredentials#_custom_helpers

 * [6] The OAuth 2.0 Authorization Framework
   https://datatracker.ietf.org/doc/html/rfc6749

 * [7] Hypertext Transfer Protocol (HTTP/1.1): Authentication
   https://datatracker.ietf.org/doc/html/rfc7235

 * [8] The OAuth 2.0 Authorization Framework: Bearer Token Usage
   https://datatracker.ietf.org/doc/html/rfc6750

 * [9] OpenID Connect Core 1.0
   https://openid.net/specs/openid-connect-core-1_0.html

 * [10] OpenID Connect Discovery 1.0
   https://openid.net/specs/openid-connect-discovery-1_0.html

 * [11] OpenID Connect Dynamic Client Registration 1.0
   https://openid.net/specs/openid-connect-registration-1_0.html

 * [12] Hypertext Transfer Protocol (HTTP/1.1)
   https://datatracker.ietf.org/doc/html/rfc2616


Updates from RFC
================

 * Submitted first three patches as separate submission:
   https://lore.kernel.org/git/pull.1363.git.1663865974.gitgitgadget@gmail.com/

 * Various style fixes and updates to- and addition of comments.

 * Drop the explicit integer index in new 'array' style credential helper
   attrbiutes ("key[n]=value" becomes just "key[]=value").

 * Added test helper; a mini HTTP server, and several tests.


Updates in v3
=============

 * Split final patch that added the test-http-server in to several, easier
   to review patches.

 * Updated wording in git-credential.txt to clarify which side of the
   credential helper protocol is sending/receiving the new wwwauth and
   authtype attributes.


Updates in v4
=============

 * Drop authentication scheme selection authtype attribute patches to
   greatly simplify the series; auth scheme selection is punted to a future
   series. This series still allows credential helpers to generate
   credentials and intelligently select correct identities for a given auth
   challenge.


Updates in v5
=============

 * Libify parts of daemon.c and share implementation with test-http-server.

 * Clarify test-http-server Git request regex pattern and auth logic
   comments.

 * Use STD*_FILENO in place of 'magic' file descriptor numbers.

 * Use strbuf_* functions in continuation header parsing.

 * Use configuration file to configure auth for test-http-server rather than
   command-line arguments. Add ability to specify arbitrary extra headers
   that is useful for testing 'malformed' server responses.

 * Use st_mult over unchecked multiplication in http.c curl callback
   functions.

 * Fix some documentation line break issues.

 * Reorder some commits to bring in the tests and test-http-server helper
   first and, then the WWW-Authentication changes, alongside tests to cover.

 * Expose previously static strvec_push_nodup function.

 * Merge the two timeout args for test-http-server (--timeout and
   --init-timeout) that were a hang-over from the original daemon.c but are
   no longer required here.

 * Be more careful around continuation headers where they may be empty
   strings. Add more tests to cover these header types.

 * Include standard trace2 tracing calls at start of test-http-server
   helper.


Updates in v6
=============

 * Clarify the change to make logging optional in the check_dead_children()
   function during libification of daemon.c.

 * Fix missing pointer dereference bugs identified in libification of child
   process handling functions for daemon.c.

 * Add doc comments to child process handling function declarations in the
   daemon-utils.h header.

 * Align function parameter names with variable names at callsites for
   libified daemon functions.

 * Re-split out the test-http-server test helper commits in to smaller
   patches: error response handling, request parsing, http-backend
   pass-through, simple authentication, arbitrary header support.

 * Call out auth configuration file format for test-http-server test helper
   and supported options in commit messages, as well as a test to exercise
   and demonstrate these options.

 * Permit auth.token and auth.challenge to appear in any order; create the
   struct auth_module just-in-time as options for that scheme are read. This
   simplifies the configuration authoring of the test-http-server test
   helper.

 * Update tests to use auth.allowAnoymous in the patch that introduces the
   new test helper option.

 * Drop the strvec_push_nodup() commit and update the implementation of HTTP
   request header line folding to use xstrdup and strvec_pop and _pushf.

 * Use size_t instead of int in credential.c when iterating over the struct
   strvec credential members. Also drop the not required const and cast from
   the full_key definition and free.

 * Replace in-tree test-credential-helper-reply.sh test cred helper script
   with the lib-credential-helper.sh reusable 'lib' test script and shell
   functions to configure the helper behaviour.

 * Leverage sed over the while read $line loop in the test credential helper
   script.

Matthew John Cheetham (12):
  daemon: libify socket setup and option functions
  daemon: libify child process handling functions
  daemon: rename some esoteric/laboured terminology
  test-http-server: add stub HTTP server test helper
  test-http-server: add HTTP error response function
  test-http-server: add HTTP request parsing
  test-http-server: pass Git requests to http-backend
  test-http-server: add simple authentication
  test-http-server: add sending of arbitrary headers
  http: replace unsafe size_t multiplication with st_mult
  http: read HTTP WWW-Authenticate response headers
  credential: add WWW-Authenticate header to cred requests

 Documentation/git-credential.txt    |  19 +-
 Makefile                            |   2 +
 contrib/buildsystems/CMakeLists.txt |  11 +-
 credential.c                        |  12 +
 credential.h                        |  15 +
 daemon-utils.c                      | 286 +++++++++
 daemon-utils.h                      |  55 ++
 daemon.c                            | 306 +---------
 http.c                              |  98 ++-
 t/helper/.gitignore                 |   1 +
 t/helper/test-http-server.c         | 910 ++++++++++++++++++++++++++++
 t/lib-credential-helper.sh          |  27 +
 t/t5556-http-auth.sh                | 398 ++++++++++++
 13 files changed, 1838 insertions(+), 302 deletions(-)
 create mode 100644 daemon-utils.c
 create mode 100644 daemon-utils.h
 create mode 100644 t/helper/test-http-server.c
 create mode 100644 t/lib-credential-helper.sh
 create mode 100755 t/t5556-http-auth.sh


base-commit: c48035d29b4e524aed3a32f0403676f0d9128863
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1352%2Fmjcheetham%2Femu-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1352/mjcheetham/emu-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/1352

Range-diff vs v5:

  1:  74b0de14185 =  1:  74b0de14185 daemon: libify socket setup and option functions
  2:  bc972fc8d3d !  2:  b6ba344a671 daemon: libify child process handling functions
     @@ Commit message
          from the parent daemon-like process from `daemon.c` to the new shared
          `daemon-utils.{c,h}` files.
      
     +    One minor functional change is introduced to `check_dead_children()`
     +    where the logging of a dead/disconnected child is now optional. With the
     +    'libification' of these functions we extract the call to `loginfo` to a
     +    call to a function pointer, and guard the log message creation and
     +    logging behind a `NULL` check. Callers can now skip logging by passing
     +    `NULL` as the `log_fn loginfo` argument.
     +    The behaviour of callers in `daemon.c` remains the same (save one extra
     +    NULL check)  however as a pointer to `loginfo` is always passed.
     +
          Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
      
       ## daemon-utils.c ##
     @@ daemon-utils.c: void socksetup(struct string_list *listen_addr, int listen_port,
      +	struct child *newborn, **cradle;
      +
      +	CALLOC_ARRAY(newborn, 1);
     -+	live_children++;
     ++	(*live_children)++;
      +	memcpy(&newborn->cld, cld, sizeof(*cld));
      +	memcpy(&newborn->address, addr, addrlen);
      +	for (cradle = &firstborn; *cradle; cradle = &(*cradle)->next)
     @@ daemon-utils.c: void socksetup(struct string_list *listen_addr, int listen_port,
      +
      +			/* remove the child */
      +			*cradle = blanket->next;
     -+			live_children--;
     ++			(*live_children)--;
      +			child_process_clear(&blanket->cld);
      +			free(blanket);
      +		} else
     @@ daemon-utils.h: void socksetup(struct string_list *listen_addr, int listen_port,
      +	struct sockaddr_storage address;
      +};
      +
     ++/*
     ++ * Add the child_process to the set of children and increment the number of
     ++ * live children.
     ++ */
      +void add_child(struct child_process *cld, struct sockaddr *addr, socklen_t addrlen,
      +	       struct child *firstborn, unsigned int *live_children);
      +
     ++/*
     ++ * Kill the newest connection from a duplicate IP.
     ++ *
     ++ * This function should be called if the number of connections grows
     ++ * past the maximum number of allowed connections.
     ++ */
      +void kill_some_child(struct child *firstborn);
      +
     ++/*
     ++ * Check for children that have disconnected and remove them from the
     ++ * active set, decrementing the number of live children.
     ++ *
     ++ * Optionally log the child PID that disconnected by passing a loginfo
     ++ * function.
     ++ */
      +void check_dead_children(struct child *firstborn, unsigned int *live_children,
      +			 log_fn loginfo);
      +
  3:  8f176d5955d !  3:  9967401c972 daemon: rename some esoteric/laboured terminology
     @@ Commit message
          processes. The existing names are esoteric; stretching an analogy too
          far to the point of being confusing to understand.
      
     -    Rename "firstborn" to simply "first", "newborn" to "new_cld", "blanket"
     +    Rename "firstborn" to "first_child", "newborn" to "new_cld", "blanket"
          to "current" and "cradle" to "ptr".
      
          Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
     @@ daemon-utils.c: static int addrcmp(const struct sockaddr_storage *s1,
       
       void add_child(struct child_process *cld, struct sockaddr *addr, socklen_t addrlen,
      -	       struct child *firstborn , unsigned int *live_children)
     -+	       struct child *first, unsigned int *live_children)
     ++	       struct child *first_child, unsigned int *live_children)
       {
      -	struct child *newborn, **cradle;
      +	struct child *new_cld, **current;
       
      -	CALLOC_ARRAY(newborn, 1);
      +	CALLOC_ARRAY(new_cld, 1);
     - 	live_children++;
     + 	(*live_children)++;
      -	memcpy(&newborn->cld, cld, sizeof(*cld));
      -	memcpy(&newborn->address, addr, addrlen);
      -	for (cradle = &firstborn; *cradle; cradle = &(*cradle)->next)
      -		if (!addrcmp(&(*cradle)->address, &newborn->address))
      +	memcpy(&new_cld->cld, cld, sizeof(*cld));
      +	memcpy(&new_cld->address, addr, addrlen);
     -+	for (current = &first; *current; current = &(*current)->next)
     ++	for (current = &first_child; *current; current = &(*current)->next)
      +		if (!addrcmp(&(*current)->address, &new_cld->address))
       			break;
      -	newborn->next = *cradle;
     @@ daemon-utils.c: static int addrcmp(const struct sockaddr_storage *s1,
       }
       
      -void kill_some_child(struct child *firstborn)
     -+void kill_some_child(struct child *first)
     ++void kill_some_child(struct child *first_child)
       {
      -	const struct child *blanket, *next;
      +	const struct child *current, *next;
       
      -	if (!(blanket = firstborn))
     -+	if (!(current = first))
     ++	if (!(current = first_child))
       		return;
       
      -	for (; (next = blanket->next); blanket = next)
     @@ daemon-utils.c: static int addrcmp(const struct sockaddr_storage *s1,
       }
       
      -void check_dead_children(struct child *firstborn, unsigned int *live_children,
     -+void check_dead_children(struct child *first, unsigned int *live_children,
     ++void check_dead_children(struct child *first_child, unsigned int *live_children,
       			 log_fn loginfo)
       {
       	int status;
     @@ daemon-utils.c: static int addrcmp(const struct sockaddr_storage *s1,
      -	for (cradle = &firstborn; (blanket = *cradle);)
      -		if ((pid = waitpid(blanket->cld.pid, &status, WNOHANG)) > 1) {
      +	struct child **ptr, *current;
     -+	for (ptr = &first; (current = *ptr);)
     ++	for (ptr = &first_child; (current = *ptr);)
      +		if ((pid = waitpid(current->cld.pid, &status, WNOHANG)) > 1) {
       			if (loginfo) {
       				const char *dead = "";
     @@ daemon-utils.c: void check_dead_children(struct child *firstborn, unsigned int *
       			/* remove the child */
      -			*cradle = blanket->next;
      +			*ptr = current->next;
     - 			live_children--;
     + 			(*live_children)--;
      -			child_process_clear(&blanket->cld);
      -			free(blanket);
      +			child_process_clear(&current->cld);
     @@ daemon-utils.c: void check_dead_children(struct child *firstborn, unsigned int *
      
       ## daemon-utils.h ##
      @@ daemon-utils.h: struct child {
     - };
     - 
     +  * live children.
     +  */
       void add_child(struct child_process *cld, struct sockaddr *addr, socklen_t addrlen,
      -	       struct child *firstborn, unsigned int *live_children);
     -+	       struct child *first, unsigned int *live_children);
     - 
     ++	       struct child *first_child, unsigned int *live_children);
     + 
     + /*
     +  * Kill the newest connection from a duplicate IP.
     +@@ daemon-utils.h: void add_child(struct child_process *cld, struct sockaddr *addr, socklen_t addrl
     +  * This function should be called if the number of connections grows
     +  * past the maximum number of allowed connections.
     +  */
      -void kill_some_child(struct child *firstborn);
     -+void kill_some_child(struct child *first);
     - 
     ++void kill_some_child(struct child *first_child);
     + 
     + /*
     +  * Check for children that have disconnected and remove them from the
     +@@ daemon-utils.h: void kill_some_child(struct child *firstborn);
     +  * Optionally log the child PID that disconnected by passing a loginfo
     +  * function.
     +  */
      -void check_dead_children(struct child *firstborn, unsigned int *live_children,
     -+void check_dead_children(struct child *first, unsigned int *live_children,
     ++void check_dead_children(struct child *first_child, unsigned int *live_children,
       			 log_fn loginfo);
       
       #endif
  4:  706fb3781bd =  4:  d6e5e8825e8 test-http-server: add stub HTTP server test helper
  -:  ----------- >  5:  79805f042b9 test-http-server: add HTTP error response function
  5:  6f66bf146b4 !  6:  252098db219 test-http-server: add HTTP error response function
     @@ Metadata
      Author: Matthew John Cheetham <mjcheetham@outlook.com>
      
       ## Commit message ##
     -    test-http-server: add HTTP error response function
     +    test-http-server: add HTTP request parsing
      
     -    Introduce a function to the test-http-server test helper to write more
     -    full and valid HTTP error responses, including all the standard response
     -    headers like `Server` and `Date`.
     +    Add ability to parse HTTP requests to the test-http-server test helper.
      
          Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
      
     @@ t/helper/test-http-server.c: enum worker_result {
      +	string_list_clear(&req->header_list, 0);
      +}
      +
     -+static enum worker_result send_http_error(
     -+	int fd,
     -+	int http_code, const char *http_code_name,
     -+	int retry_after_seconds, struct string_list *response_headers,
     -+	enum worker_result wr_in)
     -+{
     -+	struct strbuf response_header = STRBUF_INIT;
     -+	struct strbuf response_content = STRBUF_INIT;
     -+	struct string_list_item *h;
     -+	enum worker_result wr;
     -+
     -+	strbuf_addf(&response_content, "Error: %d %s\r\n",
     -+		    http_code, http_code_name);
     -+	if (retry_after_seconds > 0)
     -+		strbuf_addf(&response_content, "Retry-After: %d\r\n",
     -+			    retry_after_seconds);
     -+
     -+	strbuf_addf  (&response_header, "HTTP/1.1 %d %s\r\n", http_code, http_code_name);
     -+	strbuf_addstr(&response_header, "Cache-Control: private\r\n");
     -+	strbuf_addstr(&response_header,	"Content-Type: text/plain\r\n");
     -+	strbuf_addf  (&response_header,	"Content-Length: %d\r\n", (int)response_content.len);
     -+	if (retry_after_seconds > 0)
     -+		strbuf_addf(&response_header, "Retry-After: %d\r\n", retry_after_seconds);
     -+	strbuf_addf(  &response_header,	"Server: test-http-server/%s\r\n", git_version_string);
     -+	strbuf_addf(  &response_header, "Date: %s\r\n", show_date(time(NULL), 0, DATE_MODE(RFC2822)));
     -+	if (response_headers)
     -+		for_each_string_list_item(h, response_headers)
     -+			strbuf_addf(&response_header, "%s\r\n", h->string);
     -+	strbuf_addstr(&response_header, "\r\n");
     -+
     -+	if (write_in_full(fd, response_header.buf, response_header.len) < 0) {
     -+		logerror("unable to write response header");
     -+		wr = WR_IO_ERROR;
     -+		goto done;
     -+	}
     -+
     -+	if (write_in_full(fd, response_content.buf, response_content.len) < 0) {
     -+		logerror("unable to write response content body");
     -+		wr = WR_IO_ERROR;
     -+		goto done;
     -+	}
     -+
     -+	wr = wr_in;
     -+
     -+done:
     -+	strbuf_release(&response_header);
     -+	strbuf_release(&response_content);
     -+
     -+	return wr;
     -+}
     -+
     + static enum worker_result send_http_error(
     + 	int fd,
     + 	int http_code, const char *http_code_name,
     +@@ t/helper/test-http-server.c: done:
     + 	return wr;
     + }
     + 
      +/*
      + * Read the HTTP request up to the start of the optional message-body.
      + * We do this byte-by-byte because we have keep-alive turned on and
     @@ t/helper/test-http-server.c: enum worker_result {
      +	return result;
      +}
      +
     -+static int is_git_request(struct req *req)
     -+{
     -+	static regex_t *smart_http_regex;
     -+	static int initialized;
     -+
     -+	if (!initialized) {
     -+		smart_http_regex = xmalloc(sizeof(*smart_http_regex));
     -+		/*
     -+		 * This regular expression matches all dumb and smart HTTP
     -+		 * requests that are currently in use, and defined in
     -+		 * Documentation/gitprotocol-http.txt.
     -+		 *
     -+		 */
     -+		if (regcomp(smart_http_regex, "^/(HEAD|info/refs|"
     -+			    "objects/info/[^/]+|git-(upload|receive)-pack)$",
     -+			    REG_EXTENDED)) {
     -+			warning("could not compile smart HTTP regex");
     -+			smart_http_regex = NULL;
     -+		}
     -+		initialized = 1;
     -+	}
     -+
     -+	return smart_http_regex &&
     -+		!regexec(smart_http_regex, req->uri_path.buf, 0, NULL, 0);
     -+}
     -+
     -+static enum worker_result do__git(struct req *req)
     -+{
     -+	const char *ok = "HTTP/1.1 200 OK\r\n";
     -+	struct child_process cp = CHILD_PROCESS_INIT;
     -+	int res;
     -+
     -+	/*
     -+	 * Note that we always respond with a 200 OK response even if the
     -+	 * http-backend process exits with an error. This helper is intended
     -+	 * only to be used to exercise the HTTP auth handling in the Git client,
     -+	 * and specifically around authentication (not handled by http-backend).
     -+	 *
     -+	 * If we wanted to respond with a more 'valid' HTTP response status then
     -+	 * we'd need to buffer the output of http-backend, wait for and grok the
     -+	 * exit status of the process, then write the HTTP status line followed
     -+	 * by the http-backend output. This is outside of the scope of this test
     -+	 * helper's use at time of writing.
     -+	 *
     -+	 * The important auth responses (401) we are handling prior to getting
     -+	 * to this point.
     -+	 */
     -+	if (write(STDOUT_FILENO, ok, strlen(ok)) < 0)
     -+		return error(_("could not send '%s'"), ok);
     -+
     -+	strvec_pushf(&cp.env, "REQUEST_METHOD=%s", req->method);
     -+	strvec_pushf(&cp.env, "PATH_TRANSLATED=%s",
     -+			req->uri_path.buf);
     -+	strvec_push(&cp.env, "SERVER_PROTOCOL=HTTP/1.1");
     -+	if (req->query_args.len)
     -+		strvec_pushf(&cp.env, "QUERY_STRING=%s",
     -+				req->query_args.buf);
     -+	if (req->content_type)
     -+		strvec_pushf(&cp.env, "CONTENT_TYPE=%s",
     -+				req->content_type);
     -+	if (req->content_length >= 0)
     -+		strvec_pushf(&cp.env, "CONTENT_LENGTH=%" PRIdMAX,
     -+				(intmax_t)req->content_length);
     -+	cp.git_cmd = 1;
     -+	strvec_push(&cp.args, "http-backend");
     -+	res = run_command(&cp);
     -+	close(STDOUT_FILENO);
     -+	close(STDIN_FILENO);
     -+	return !!res;
     -+}
     -+
      +static enum worker_result dispatch(struct req *req)
      +{
     -+	if (is_git_request(req))
     -+		return do__git(req);
     -+
      +	return send_http_error(STDOUT_FILENO, 501, "Not Implemented", -1, NULL,
      +			       WR_OK | WR_HANGUP);
      +}
      +
       static enum worker_result worker(void)
       {
     --	const char *response = "HTTP/1.1 501 Not Implemented\r\n";
      +	struct req req = REQ__INIT;
       	char *client_addr = getenv("REMOTE_ADDR");
       	char *client_port = getenv("REMOTE_PORT");
     @@ t/helper/test-http-server.c: static enum worker_result worker(void)
       	set_keep_alive(0, logerror);
       
       	while (1) {
     --		if (write_in_full(STDOUT_FILENO, response, strlen(response)) < 0) {
     --			logerror("unable to write response");
     --			wr = WR_IO_ERROR;
     --		}
     +-		wr = send_http_error(STDOUT_FILENO, 501, "Not Implemented", -1,
     +-				     NULL, WR_OK | WR_HANGUP);
      +		req__release(&req);
      +
      +		alarm(timeout);
     @@ t/helper/test-http-server.c: static enum worker_result worker(void)
       		if (wr != WR_OK)
       			break;
       	}
     -
     - ## t/t5556-http-auth.sh (new) ##
     -@@
     -+#!/bin/sh
     -+
     -+test_description='test http auth header and credential helper interop'
     -+
     -+TEST_NO_CREATE_REPO=1
     -+. ./test-lib.sh
     -+
     -+test_set_port GIT_TEST_HTTP_PROTOCOL_PORT
     -+
     -+# Setup a repository
     -+#
     -+REPO_DIR="$TRASH_DIRECTORY"/repo
     -+
     -+# Setup some lookback URLs where test-http-server will be listening.
     -+# We will spawn it directly inside the repo directory, so we avoid
     -+# any need to configure directory mappings etc - we only serve this
     -+# repository from the root '/' of the server.
     -+#
     -+HOST_PORT=127.0.0.1:$GIT_TEST_HTTP_PROTOCOL_PORT
     -+ORIGIN_URL=http://$HOST_PORT/
     -+
     -+# The pid-file is created by test-http-server when it starts.
     -+# The server will shutdown if/when we delete it (this is easier than
     -+# killing it by PID).
     -+#
     -+PID_FILE="$TRASH_DIRECTORY"/pid-file.pid
     -+SERVER_LOG="$TRASH_DIRECTORY"/OUT.server.log
     -+
     -+PATH="$GIT_BUILD_DIR/t/helper/:$PATH" && export PATH
     -+
     -+test_expect_success 'setup repos' '
     -+	test_create_repo "$REPO_DIR" &&
     -+	git -C "$REPO_DIR" branch -M main
     -+'
     -+
     -+stop_http_server () {
     -+	if ! test -f "$PID_FILE"
     -+	then
     -+		return 0
     -+	fi
     -+	#
     -+	# The server will shutdown automatically when we delete the pid-file.
     -+	#
     -+	rm -f "$PID_FILE"
     -+	#
     -+	# Give it a few seconds to shutdown (mainly to completely release the
     -+	# port before the next test start another instance and it attempts to
     -+	# bind to it).
     -+	#
     -+	for k in 0 1 2 3 4
     -+	do
     -+		if grep -q "Starting graceful shutdown" "$SERVER_LOG"
     -+		then
     -+			return 0
     -+		fi
     -+		sleep 1
     -+	done
     -+
     -+	echo "stop_http_server: timeout waiting for server shutdown"
     -+	return 1
     -+}
     -+
     -+start_http_server () {
     -+	#
     -+	# Launch our server into the background in repo_dir.
     -+	#
     -+	(
     -+		cd "$REPO_DIR"
     -+		test-http-server --verbose \
     -+			--listen=127.0.0.1 \
     -+			--port=$GIT_TEST_HTTP_PROTOCOL_PORT \
     -+			--reuseaddr \
     -+			--pid-file="$PID_FILE" \
     -+			"$@" \
     -+			2>"$SERVER_LOG" &
     -+	)
     -+	#
     -+	# Give it a few seconds to get started.
     -+	#
     -+	for k in 0 1 2 3 4
     -+	do
     -+		if test -f "$PID_FILE"
     -+		then
     -+			return 0
     -+		fi
     -+		sleep 1
     -+	done
     -+
     -+	echo "start_http_server: timeout waiting for server startup"
     -+	return 1
     -+}
     -+
     -+per_test_cleanup () {
     -+	stop_http_server &&
     -+	rm -f OUT.*
     -+}
     -+
     -+test_expect_success 'http auth anonymous no challenge' '
     -+	test_when_finished "per_test_cleanup" &&
     -+	start_http_server &&
     -+
     -+	# Attempt to read from a protected repository
     -+	git ls-remote $ORIGIN_URL
     -+'
     -+
     -+test_done
  -:  ----------- >  7:  ab06ac9b965 test-http-server: pass Git requests to http-backend
  6:  c3c3d17a688 !  8:  a1ff55dd6e2 test-http-server: add simple authentication
     @@ Commit message
          tokens and only approved if a matching token is found, or if no auth
          was provided and anonymous auth is enabled.
      
     +    Configuration for auth includes a simple set of three options:
     +
     +    [auth]
     +            challenge = <scheme>[:<challenge_params>]
     +            token = <scheme>:[<token>]*
     +            allowAnonymous = <bool>
     +
     +    `auth.challenge` allows you define what authentication schemes, and
     +    optional challenge parameters the server should use. Scheme names are
     +    unique and subsequently specified challenge parameters in the config
     +    file will replace previously specified ones.
     +
     +    `auth.token` allows you to define the set of value token values for an
     +    authentication scheme. This is a multi-var and each entry in the
     +    config file will append to the set of valid tokens for that scheme.
     +    Specifying an empty token value will clear the list of tokens so far for
     +    that scheme, i.e. `token = <scheme>:`.
     +
     +    `auth.allowAnonymous` controls whether or not unauthenticated requests
     +    (those without any `Authorization` headers) should succeed or not, and
     +    trigger a 401 Unauthorized response.
     +
          Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
      
       ## t/helper/test-http-server.c ##
     @@ t/helper/test-http-server.c: static int is_git_request(struct req *req)
       	const char *ok = "HTTP/1.1 200 OK\r\n";
       	struct child_process cp = CHILD_PROCESS_INIT;
      @@ t/helper/test-http-server.c: static enum worker_result do__git(struct req *req)
     + 	 * exit status of the process, then write the HTTP status line followed
     + 	 * by the http-backend output. This is outside of the scope of this test
     + 	 * helper's use at time of writing.
     ++	 *
     ++	 * The important auth responses (401) we are handling prior to getting
     ++	 * to this point.
     + 	 */
       	if (write(STDOUT_FILENO, ok, strlen(ok)) < 0)
       		return error(_("could not send '%s'"), ok);
       
     @@ t/helper/test-http-server.c: static enum worker_result do__git(struct req *req)
      +static struct auth_module **auth_modules = NULL;
      +static size_t auth_modules_nr = 0;
      +static size_t auth_modules_alloc = 0;
     -+static struct strvec extra_headers = STRVEC_INIT;
      +
     -+static struct auth_module *create_auth_module(const char *scheme,
     -+					      const char *challenge)
     -+{
     -+	struct auth_module *mod = xmalloc(sizeof(struct auth_module));
     -+	mod->scheme = xstrdup(scheme);
     -+	mod->challenge_params = challenge ? xstrdup(challenge) : NULL;
     -+	CALLOC_ARRAY(mod->tokens, 1);
     -+	string_list_init_dup(mod->tokens);
     -+	return mod;
     -+}
     -+
     -+static struct auth_module *get_auth_module(const char *scheme)
     ++static struct auth_module *get_auth_module(const char *scheme, int create)
      +{
      +	int i;
      +	struct auth_module *mod;
     @@ t/helper/test-http-server.c: static enum worker_result do__git(struct req *req)
      +			return mod;
      +	}
      +
     -+	return NULL;
     -+}
     ++	if (create) {
     ++		struct auth_module *mod = xmalloc(sizeof(struct auth_module));
     ++		mod->scheme = xstrdup(scheme);
     ++		mod->challenge_params = NULL;
     ++		CALLOC_ARRAY(mod->tokens, 1);
     ++		string_list_init_dup(mod->tokens);
      +
     -+static int add_auth_module(struct auth_module *mod)
     -+{
     -+	if (get_auth_module(mod->scheme))
     -+		return error("duplicate auth scheme '%s'\n", mod->scheme);
     ++		ALLOC_GROW(auth_modules, auth_modules_nr + 1, auth_modules_alloc);
     ++		auth_modules[auth_modules_nr++] = mod;
      +
     -+	ALLOC_GROW(auth_modules, auth_modules_nr + 1, auth_modules_alloc);
     -+	auth_modules[auth_modules_nr++] = mod;
     ++		return mod;
     ++	}
      +
     -+	return 0;
     ++	return NULL;
      +}
      +
      +static int is_authed(struct req *req, const char **user, enum worker_result *wr)
     @@ t/helper/test-http-server.c: static enum worker_result do__git(struct req *req)
      +			/* trim trailing space ' ' */
      +			strbuf_setlen(split[0], split[0]->len - 1);
      +
     -+			mod = get_auth_module(split[0]->buf);
     ++			mod = get_auth_module(split[0]->buf, 0);
      +			if (mod) {
      +				result = AUTH_DENY;
      +
     @@ t/helper/test-http-server.c: static enum worker_result do__git(struct req *req)
      +			string_list_append(&hdrs, challenge);
      +		}
      +
     -+		for (i = 0; i < extra_headers.nr; i++)
     -+			string_list_append(&hdrs, extra_headers.v[i]);
     -+
      +		*wr = send_http_error(STDOUT_FILENO, 401, "Unauthorized", -1,
      +				      &hdrs, *wr);
      +	}
     @@ t/helper/test-http-server.c: static enum worker_result do__git(struct req *req)
      +	      (result == AUTH_UNKNOWN && allow_anonymous);
      +}
      +
     -+static int split_auth_param(const char *str, char **scheme, char **val, int required_val)
     ++static int split_auth_param(const char *str, char **scheme, char **val)
      +{
      +	struct strbuf **p = strbuf_split_str(str, ':', 2);
      +
     @@ t/helper/test-http-server.c: static enum worker_result do__git(struct req *req)
      +		return -1;
      +
      +	/* trim trailing ':' */
     -+	if (p[1])
     ++	if (p[0]->len > 0 && p[0]->buf[p[0]->len - 1] == ':')
      +		strbuf_setlen(p[0], p[0]->len - 1);
      +
     -+	if (required_val && !p[1])
     -+		return -1;
     -+
      +	*scheme = strbuf_detach(p[0], NULL);
      +
      +	if (p[1])
     @@ t/helper/test-http-server.c: static enum worker_result do__git(struct req *req)
      +	struct auth_module *mod = NULL;
      +
      +	if (!strcmp(name, "auth.challenge")) {
     -+		if (split_auth_param(val, &scheme, &challenge, 0)) {
     ++		if (split_auth_param(val, &scheme, &challenge)) {
      +			ret = error("invalid auth challenge '%s'", val);
      +			goto cleanup;
      +		}
      +
     -+		mod = create_auth_module(scheme, challenge);
     -+		if (add_auth_module(mod)) {
     -+			ret = error("failed to add auth module '%s'", val);
     -+			goto cleanup;
     -+		}
     -+	}
     -+	if (!strcmp(name, "auth.token")) {
     -+		if (split_auth_param(val, &scheme, &token, 1)) {
     -+			ret = error("invalid auth token '%s'", val);
     -+			goto cleanup;
     -+		}
     ++		mod = get_auth_module(scheme, 1);
      +
     -+		mod = get_auth_module(scheme);
     -+		if (!mod) {
     -+			ret = error("auth scheme not defined '%s'\n", scheme);
     ++		/* Replace any existing challenge parameters */
     ++		free(mod->challenge_params);
     ++		mod->challenge_params = challenge ? xstrdup(challenge) : NULL;
     ++	} else if (!strcmp(name, "auth.token")) {
     ++		if (split_auth_param(val, &scheme, &token)) {
     ++			ret = error("invalid auth token '%s'", val);
      +			goto cleanup;
      +		}
      +
     -+		string_list_append(mod->tokens, token);
     -+	}
     -+	if (!strcmp(name, "auth.allowanonymous")) {
     ++		mod = get_auth_module(scheme, 1);
     ++
     ++		/*
     ++		 * Append to set of valid tokens unless an empty token value
     ++		 * is provided, then clear the existing list.
     ++		 */
     ++		if (token)
     ++			string_list_append(mod->tokens, token);
     ++		else
     ++			string_list_clear(mod->tokens, 1);
     ++	} else if (!strcmp(name, "auth.allowanonymous")) {
      +		allow_anonymous = git_config_bool(name, val);
     -+	}
     -+	if (!strcmp(name, "auth.extraheader")) {
     -+		strvec_push(&extra_headers, val);
     ++	} else {
     ++		warning("unknown auth config '%s'", name);
      +	}
      +
      +cleanup:
     @@ t/helper/test-http-server.c: int cmd_main(int argc, const char **argv)
       
       		fprintf(stderr, "error: unknown argument '%s'\n", arg);
       		usage(test_http_auth_usage);
     +
     + ## t/t5556-http-auth.sh ##
     +@@ t/t5556-http-auth.sh: per_test_cleanup () {
     + 	rm -f OUT.*
     + }
     + 
     ++test_expect_success CURL 'http auth server auth config' '
     ++	#test_when_finished "per_test_cleanup" &&
     ++
     ++	cat >auth.config <<-EOF &&
     ++	[auth]
     ++		challenge = no-params
     ++		challenge = with-params:foo=\"bar\" p=1
     ++		challenge = with-params:foo=\"replaced\" q=1
     ++
     ++		token = no-explicit-challenge:valid-token
     ++		token = no-explicit-challenge:also-valid
     ++		token = reset-tokens:these-tokens
     ++		token = reset-tokens:will-be-reset
     ++		token = reset-tokens:
     ++		token = reset-tokens:the-only-valid-one
     ++
     ++		allowAnonymous = false
     ++	EOF
     ++
     ++	cat >OUT.expected <<-EOF &&
     ++	WWW-Authenticate: no-params
     ++	WWW-Authenticate: with-params foo="replaced" q=1
     ++	WWW-Authenticate: no-explicit-challenge
     ++	WWW-Authenticate: reset-tokens
     ++
     ++	Error: 401 Unauthorized
     ++	EOF
     ++
     ++	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
     ++
     ++	curl --include $ORIGIN_URL >OUT.curl &&
     ++	tr -d "\r" <OUT.curl | sed -n "/WWW-Authenticate/,\$p" >OUT.actual &&
     ++
     ++	test_cmp OUT.expected OUT.actual
     ++'
     ++
     + test_expect_success 'http auth anonymous no challenge' '
     + 	test_when_finished "per_test_cleanup" &&
     + 
     +-	start_http_server &&
     ++	cat >auth.config <<-EOF &&
     ++	[auth]
     ++		allowAnonymous = true
     ++	EOF
     ++
     ++	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
     + 
     + 	# Attempt to read from a protected repository
     + 	git ls-remote $ORIGIN_URL
  -:  ----------- >  9:  76125cdf239 test-http-server: add sending of arbitrary headers
  7:  9c4d25945dd = 10:  cc9a220ed1f http: replace unsafe size_t multiplication with st_mult
  8:  65a620b08ef <  -:  ----------- strvec: expose strvec_push_nodup for external use
  9:  bcfec529d95 ! 11:  bc1ac8d3eb3 http: read HTTP WWW-Authenticate response headers
     @@ http.c: size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buff
      +		if (!values->nr) {
      +			BUG("should have at least one existing header value");
      +		} else if (buf.len) {
     -+			const char *prev = values->v[values->nr - 1];
     -+			struct strbuf append = STRBUF_INIT;
     -+			strbuf_addstr(&append, prev);
     ++			char *prev = xstrdup(values->v[values->nr - 1]);
      +
      +			/* Join two non-empty values with a single space. */
     -+			if (append.len)
     -+				strbuf_addch(&append, ' ');
     -+
     -+			strbuf_addbuf(&append, &buf);
     ++			const char *const sp = *prev ? " " : "";
      +
      +			strvec_pop(values);
     -+			strvec_push_nodup(values, strbuf_detach(&append, NULL));
     ++			strvec_pushf(values, "%s%s%s", prev, sp, buf.buf);
     ++			free(prev);
      +		}
      +
      +		goto exit;
 10:  af66d2d2ede ! 12:  7c8229f0b11 credential: add WWW-Authenticate header to cred requests
     @@ credential.c: static void credential_write_item(FILE *fp, const char *key, const
      +static void credential_write_strvec(FILE *fp, const char *key,
      +				    const struct strvec *vec)
      +{
     -+	int i = 0;
     -+	const char *full_key = xstrfmt("%s[]", key);
     -+	for (; i < vec->nr; i++) {
     ++	char *full_key = xstrfmt("%s[]", key);
     ++	for (size_t i = 0; i < vec->nr; i++) {
      +		credential_write_item(fp, full_key, vec->v[i], 0);
      +	}
     -+	free((void*)full_key);
     ++	free(full_key);
      +}
      +
       void credential_write(const struct credential *c, FILE *fp)
     @@ credential.c: void credential_write(const struct credential *c, FILE *fp)
       
       static int run_credential_helper(struct credential *c,
      
     - ## t/helper/test-credential-helper-replay.sh (new) ##
     + ## t/lib-credential-helper.sh (new) ##
      @@
     -+cmd=$1
     -+teefile=$cmd-actual.cred
     -+catfile=$cmd-response.cred
     -+rm -f $teefile
     -+while read line;
     -+do
     -+	if test -z "$line"; then
     -+		break;
     -+	fi
     -+	echo "$line" >> $teefile
     -+done
     -+if test "$cmd" = "get"; then
     -+	cat $catfile
     -+fi
     ++setup_credential_helper() {
     ++	test_expect_success 'setup credential helper' '
     ++		CREDENTIAL_HELPER="$TRASH_DIRECTORY/credential-helper.sh" &&
     ++		export CREDENTIAL_HELPER &&
     ++		echo $CREDENTIAL_HELPER &&
     ++
     ++		write_script "$CREDENTIAL_HELPER" <<-\EOF
     ++		cmd=$1
     ++		teefile=$cmd-query.cred
     ++		catfile=$cmd-reply.cred
     ++		sed -n -e "/^$/q" -e "p" >> $teefile
     ++		if test "$cmd" = "get"; then
     ++			cat $catfile
     ++		fi
     ++		EOF
     ++	'
     ++}
     ++
     ++set_credential_reply() {
     ++	cat >"$TRASH_DIRECTORY/$1-reply.cred"
     ++}
     ++
     ++expect_credential_query() {
     ++	cat >"$TRASH_DIRECTORY/$1-expect.cred" &&
     ++	test_cmp "$TRASH_DIRECTORY/$1-expect.cred" \
     ++		 "$TRASH_DIRECTORY/$1-query.cred"
     ++}
      
       ## t/t5556-http-auth.sh ##
     -@@ t/t5556-http-auth.sh: PID_FILE="$TRASH_DIRECTORY"/pid-file.pid
     - SERVER_LOG="$TRASH_DIRECTORY"/OUT.server.log
     +@@ t/t5556-http-auth.sh: test_description='test http auth header and credential helper interop'
     + 
     + TEST_NO_CREATE_REPO=1
     + . ./test-lib.sh
     ++. "$TEST_DIRECTORY"/lib-credential-helper.sh
       
     - PATH="$GIT_BUILD_DIR/t/helper/:$PATH" && export PATH
     -+CREDENTIAL_HELPER="$GIT_BUILD_DIR/t/helper/test-credential-helper-replay.sh" \
     -+	&& export CREDENTIAL_HELPER
     + test_set_port GIT_TEST_HTTP_PROTOCOL_PORT
       
     - test_expect_success 'setup repos' '
     - 	test_create_repo "$REPO_DIR" &&
     +@@ t/t5556-http-auth.sh: test_expect_success 'setup repos' '
     + 	git -C "$REPO_DIR" branch -M main
     + '
     + 
     ++setup_credential_helper
     ++
     + stop_http_server () {
     + 	if ! test -f "$PID_FILE"
     + 	then
      @@ t/t5556-http-auth.sh: start_http_server () {
       
       per_test_cleanup () {
     @@ t/t5556-http-auth.sh: start_http_server () {
      +	rm -f auth.config
       }
       
     - test_expect_success 'http auth anonymous no challenge' '
     - 	test_when_finished "per_test_cleanup" &&
     --	start_http_server &&
     -+
     -+	cat >auth.config <<-EOF &&
     -+	[auth]
     -+	    allowAnonymous = true
     -+	EOF
     -+
     -+	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
     - 
     - 	# Attempt to read from a protected repository
     + test_expect_success CURL 'http auth server auth config' '
     +@@ t/t5556-http-auth.sh: test_expect_success 'http auth anonymous no challenge' '
       	git ls-remote $ORIGIN_URL
       '
       
     @@ t/t5556-http-auth.sh: start_http_server () {
      +
      +	cat >auth.config <<-EOF &&
      +	[auth]
     -+	    challenge = basic:realm=\"example.com\"
     -+	    token = basic:$USERPASS64
     ++		challenge = basic:realm=\"example.com\"
     ++		token = basic:$USERPASS64
      +	EOF
      +
      +	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
      +
     -+	cat >get-expected.cred <<-EOF &&
     ++	set_credential_reply get <<-EOF &&
      +	protocol=http
      +	host=$HOST_PORT
     -+	wwwauth[]=basic realm="example.com"
     ++	username=alice
     ++	password=secret-passwd
      +	EOF
      +
     -+	cat >store-expected.cred <<-EOF &&
     ++	git -c "credential.helper=!\"$CREDENTIAL_HELPER\"" ls-remote $ORIGIN_URL &&
     ++
     ++	expect_credential_query get <<-EOF &&
      +	protocol=http
      +	host=$HOST_PORT
     -+	username=alice
     -+	password=secret-passwd
     ++	wwwauth[]=basic realm="example.com"
      +	EOF
      +
     -+	cat >get-response.cred <<-EOF &&
     ++	expect_credential_query store <<-EOF
      +	protocol=http
      +	host=$HOST_PORT
      +	username=alice
      +	password=secret-passwd
      +	EOF
     -+
     -+	git -c credential.helper="$CREDENTIAL_HELPER" ls-remote $ORIGIN_URL &&
     -+
     -+	test_cmp get-expected.cred get-actual.cred &&
     -+	test_cmp store-expected.cred store-actual.cred
      +'
      +
      +test_expect_success 'http auth www-auth headers to credential helper ignore case valid' '
     @@ t/t5556-http-auth.sh: start_http_server () {
      +
      +	cat >auth.config <<-EOF &&
      +	[auth]
     -+	    challenge = basic:realm=\"example.com\"
     -+	    token = basic:$USERPASS64
     -+	    extraHeader = wWw-aUtHeNtIcAtE: bEaRer auThoRiTy=\"id.example.com\"
     ++		challenge = basic:realm=\"example.com\"
     ++		token = basic:$USERPASS64
     ++		extraHeader = wWw-aUtHeNtIcAtE: bEaRer auThoRiTy=\"id.example.com\"
      +	EOF
      +
      +	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
      +
     -+	cat >get-expected.cred <<-EOF &&
     ++	set_credential_reply get <<-EOF &&
      +	protocol=http
      +	host=$HOST_PORT
     -+	wwwauth[]=basic realm="example.com"
     -+	wwwauth[]=bEaRer auThoRiTy="id.example.com"
     ++	username=alice
     ++	password=secret-passwd
      +	EOF
      +
     -+	cat >store-expected.cred <<-EOF &&
     ++	git -c "credential.helper=!\"$CREDENTIAL_HELPER\"" ls-remote $ORIGIN_URL &&
     ++
     ++	expect_credential_query get <<-EOF &&
      +	protocol=http
      +	host=$HOST_PORT
     -+	username=alice
     -+	password=secret-passwd
     ++	wwwauth[]=basic realm="example.com"
     ++	wwwauth[]=bEaRer auThoRiTy="id.example.com"
      +	EOF
      +
     -+	cat >get-response.cred <<-EOF &&
     ++	expect_credential_query store <<-EOF
      +	protocol=http
      +	host=$HOST_PORT
      +	username=alice
      +	password=secret-passwd
      +	EOF
     -+
     -+	git -c credential.helper="$CREDENTIAL_HELPER" ls-remote $ORIGIN_URL &&
     -+
     -+	test_cmp get-expected.cred get-actual.cred &&
     -+	test_cmp store-expected.cred store-actual.cred
      +'
      +
      +test_expect_success 'http auth www-auth headers to credential helper continuation hdr' '
     @@ t/t5556-http-auth.sh: start_http_server () {
      +
      +	cat >auth.config <<-EOF &&
      +	[auth]
     -+	    challenge = "bearer:authority=\"id.example.com\"\\n    q=1\\n \\t p=0"
     -+	    challenge = basic:realm=\"example.com\"
     -+	    token = basic:$USERPASS64
     ++		challenge = "bearer:authority=\"id.example.com\"\\n    q=1\\n \\t p=0"
     ++		challenge = basic:realm=\"example.com\"
     ++		token = basic:$USERPASS64
      +	EOF
      +
      +	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
      +
     -+	cat >get-expected.cred <<-EOF &&
     ++	set_credential_reply get <<-EOF &&
      +	protocol=http
      +	host=$HOST_PORT
     -+	wwwauth[]=bearer authority="id.example.com" q=1 p=0
     -+	wwwauth[]=basic realm="example.com"
     ++	username=alice
     ++	password=secret-passwd
      +	EOF
      +
     -+	cat >store-expected.cred <<-EOF &&
     ++	git -c "credential.helper=!\"$CREDENTIAL_HELPER\"" ls-remote $ORIGIN_URL &&
     ++
     ++	expect_credential_query get <<-EOF &&
      +	protocol=http
      +	host=$HOST_PORT
     -+	username=alice
     -+	password=secret-passwd
     ++	wwwauth[]=bearer authority="id.example.com" q=1 p=0
     ++	wwwauth[]=basic realm="example.com"
      +	EOF
      +
     -+	cat >get-response.cred <<-EOF &&
     ++	expect_credential_query store <<-EOF
      +	protocol=http
      +	host=$HOST_PORT
      +	username=alice
      +	password=secret-passwd
      +	EOF
     -+
     -+	git -c credential.helper="$CREDENTIAL_HELPER" ls-remote $ORIGIN_URL &&
     -+
     -+	test_cmp get-expected.cred get-actual.cred &&
     -+	test_cmp store-expected.cred store-actual.cred
      +'
      +
      +test_expect_success 'http auth www-auth headers to credential helper empty continuation hdrs' '
     @@ t/t5556-http-auth.sh: start_http_server () {
      +
      +	cat >auth.config <<-EOF &&
      +	[auth]
     -+	    challenge = basic:realm=\"example.com\"
     -+	    token = basic:$USERPASS64
     -+	    extraheader = "WWW-Authenticate:"
     -+	    extraheader = " "
     -+	    extraheader = " bearer authority=\"id.example.com\""
     ++		challenge = basic:realm=\"example.com\"
     ++		token = basic:$USERPASS64
     ++		extraheader = "WWW-Authenticate:"
     ++		extraheader = " "
     ++		extraheader = " bearer authority=\"id.example.com\""
      +	EOF
      +
      +	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
      +
     -+	cat >get-expected.cred <<-EOF &&
     ++	set_credential_reply get <<-EOF &&
      +	protocol=http
      +	host=$HOST_PORT
     -+	wwwauth[]=basic realm="example.com"
     -+	wwwauth[]=bearer authority="id.example.com"
     ++	username=alice
     ++	password=secret-passwd
      +	EOF
      +
     -+	cat >store-expected.cred <<-EOF &&
     ++	git -c "credential.helper=!\"$CREDENTIAL_HELPER\"" ls-remote $ORIGIN_URL &&
     ++
     ++	expect_credential_query get <<-EOF &&
      +	protocol=http
      +	host=$HOST_PORT
     -+	username=alice
     -+	password=secret-passwd
     ++	wwwauth[]=basic realm="example.com"
     ++	wwwauth[]=bearer authority="id.example.com"
      +	EOF
      +
     -+	cat >get-response.cred <<-EOF &&
     ++	expect_credential_query store <<-EOF
      +	protocol=http
      +	host=$HOST_PORT
      +	username=alice
      +	password=secret-passwd
      +	EOF
     -+
     -+	git -c credential.helper="$CREDENTIAL_HELPER" ls-remote $ORIGIN_URL &&
     -+
     -+	test_cmp get-expected.cred get-actual.cred &&
     -+	test_cmp store-expected.cred store-actual.cred
      +'
      +
      +test_expect_success 'http auth www-auth headers to credential helper custom schemes' '
     @@ t/t5556-http-auth.sh: start_http_server () {
      +
      +	cat >auth.config <<-EOF &&
      +	[auth]
     -+	    challenge = "foobar:alg=test widget=1"
     -+	    challenge = "bearer:authority=\"id.example.com\" q=1 p=0"
     -+	    challenge = basic:realm=\"example.com\"
     -+	    token = basic:$USERPASS64
     ++		challenge = "foobar:alg=test widget=1"
     ++		challenge = "bearer:authority=\"id.example.com\" q=1 p=0"
     ++		challenge = basic:realm=\"example.com\"
     ++		token = basic:$USERPASS64
      +	EOF
      +
      +	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
      +
     -+	cat >get-expected.cred <<-EOF &&
     ++	set_credential_reply get <<-EOF &&
      +	protocol=http
      +	host=$HOST_PORT
     -+	wwwauth[]=foobar alg=test widget=1
     -+	wwwauth[]=bearer authority="id.example.com" q=1 p=0
     -+	wwwauth[]=basic realm="example.com"
     ++	username=alice
     ++	password=secret-passwd
      +	EOF
      +
     -+	cat >store-expected.cred <<-EOF &&
     ++	git -c "credential.helper=!\"$CREDENTIAL_HELPER\"" ls-remote $ORIGIN_URL &&
     ++
     ++	expect_credential_query get <<-EOF &&
      +	protocol=http
      +	host=$HOST_PORT
     -+	username=alice
     -+	password=secret-passwd
     ++	wwwauth[]=foobar alg=test widget=1
     ++	wwwauth[]=bearer authority="id.example.com" q=1 p=0
     ++	wwwauth[]=basic realm="example.com"
      +	EOF
      +
     -+	cat >get-response.cred <<-EOF &&
     ++	expect_credential_query store <<-EOF
      +	protocol=http
      +	host=$HOST_PORT
      +	username=alice
      +	password=secret-passwd
      +	EOF
     -+
     -+	git -c credential.helper="$CREDENTIAL_HELPER" ls-remote $ORIGIN_URL &&
     -+
     -+	test_cmp get-expected.cred get-actual.cred &&
     -+	test_cmp store-expected.cred store-actual.cred
      +'
      +
      +test_expect_success 'http auth www-auth headers to credential helper invalid' '
     @@ t/t5556-http-auth.sh: start_http_server () {
      +
      +	cat >auth.config <<-EOF &&
      +	[auth]
     -+	    challenge = "bearer:authority=\"id.example.com\" q=1 p=0"
     -+	    challenge = basic:realm=\"example.com\"
     -+	    token = basic:$USERPASS64
     ++		challenge = "bearer:authority=\"id.example.com\" q=1 p=0"
     ++		challenge = basic:realm=\"example.com\"
     ++		token = basic:$USERPASS64
      +	EOF
      +
      +	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
      +
     -+	cat >get-expected.cred <<-EOF &&
     ++	set_credential_reply get <<-EOF &&
      +	protocol=http
      +	host=$HOST_PORT
     -+	wwwauth[]=bearer authority="id.example.com" q=1 p=0
     -+	wwwauth[]=basic realm="example.com"
     ++	username=alice
     ++	password=invalid-passwd
      +	EOF
      +
     -+	cat >erase-expected.cred <<-EOF &&
     ++	test_must_fail git -c "credential.helper=!\"$CREDENTIAL_HELPER\"" ls-remote $ORIGIN_URL &&
     ++
     ++	expect_credential_query get <<-EOF &&
      +	protocol=http
      +	host=$HOST_PORT
     -+	username=alice
     -+	password=invalid-passwd
      +	wwwauth[]=bearer authority="id.example.com" q=1 p=0
      +	wwwauth[]=basic realm="example.com"
      +	EOF
      +
     -+	cat >get-response.cred <<-EOF &&
     ++	expect_credential_query erase <<-EOF
      +	protocol=http
      +	host=$HOST_PORT
      +	username=alice
      +	password=invalid-passwd
     ++	wwwauth[]=bearer authority="id.example.com" q=1 p=0
     ++	wwwauth[]=basic realm="example.com"
      +	EOF
     -+
     -+	test_must_fail git -c credential.helper="$CREDENTIAL_HELPER" ls-remote $ORIGIN_URL &&
     -+
     -+	test_cmp get-expected.cred get-actual.cred &&
     -+	test_cmp erase-expected.cred erase-actual.cred
      +'
      +
       test_done

-- 
gitgitgadget
