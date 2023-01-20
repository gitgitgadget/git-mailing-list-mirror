Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DF6C05027
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 22:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjATWJD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 17:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjATWI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 17:08:59 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA7BA19AC
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 14:08:54 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id z5so6009299wrt.6
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 14:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4E/B0D3u24nmfKhTdqPh7Y9i39PzOjtgzUikdfN+bIw=;
        b=jqfQSwbLT6o3Y+1XE8Bl7EcoBAEcsU+RRxXOunHLcQRKd59vWOclHsnEsNilxF6Tn5
         Z1YLIgmnmv+5SrZIzt8kAIjBqohOTEFmL6cgk7ajpbrS7KxI3wVrcPmAblpWNQEEpac/
         j4CwnMq7k7TTw7vJ7uajZQHVY1RyfS5xoUJ3WBuD2zKbSGn5StUz/R9gMaUNtt1Fn1aO
         HHRKTW/u9lKXGg7nbo9eBwomUHbDGkj+uSiNtQzyDG1i6xyHO6PWsy7jdo5t3YULoUNN
         m0Jccj6ykK0cRtlPp3dzVWulWdakyvjhBLd/EPW2bTetVvFSRgFCzzllbPpxcNzYjp5X
         /nyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4E/B0D3u24nmfKhTdqPh7Y9i39PzOjtgzUikdfN+bIw=;
        b=ekmc6r5stvZ3foHnqyzwOvjLk0mVtrNDbmmafEs7Cp5HRx3+zGBJd3oa9Di+IFjuzj
         cton8YAysa4PFWE1VBl61zTzxyXvc8izwo8WUfJ8zw++/KpDLCogAQ6EzmMAvz1IytU9
         RRa/dUbumcr5MCmXSBHskJArah7Wze484uJ9w/pZOaoLX14geyr5AoYx4vhAF3ZQrR9E
         cV1YaCF3O3jZY8lsV4SB+36bkVsO1dNPQccRADGsqvISUv0KiuZSCeuygVgdWMeIXfe4
         bntisWRNEnL62ERrOJnerFIwB2Adn0xo8MM3oiLOFX0bwJtxPk43bjovf09/HMm1DpXZ
         UbZg==
X-Gm-Message-State: AFqh2kqn/xP4wGm5fGmAREPm8RJjzXCUGeYaHQm5/3UQwtAiRU6LkCv+
        Pxl5YxUS1sJE/vFU9DwpaR8Qkz1gTZE=
X-Google-Smtp-Source: AMrXdXu1vOsoiymtgSeaHoq1DqMMQjtEhrWHGSdasoaGN8NCJtIx+Sf8ctSTAx4fMMStTJYFdS6Buw==
X-Received: by 2002:a05:6000:98d:b0:242:809e:1428 with SMTP id by13-20020a056000098d00b00242809e1428mr15878328wrb.5.1674252532652;
        Fri, 20 Jan 2023 14:08:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ba29-20020a0560001c1d00b002b065272da2sm15973296wrb.13.2023.01.20.14.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 14:08:52 -0800 (PST)
Message-Id: <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Jan 2023 22:08:38 +0000
Subject: [PATCH v7 00/12] Enhance credential helper protocol to include auth headers
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
        <avarab@gmail.com>, Matthew John Cheetham <mjcheetham@outlook.com>
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


Updates in v7
=============

 * Address several whitespace and arg/param list alignment issues.

 * Rethink the test-http-helper worker-mode error and result enum to be more
   simple and more informative to the nature of the error.

 * Use uintmax_t to store the Content-Length of a request in the helper
   test-http-server. Maintain a bit flag to store if we received such a
   header.

 * Return a "400 Bad Request" HTTP response if we fail to parse the request
   in the test-http-server.

 * Add test case to cover request message parsing in test-http-server.

 * Use size_t and ALLOC_ARRAY over int and CALLOC_ARRAY respectively in
   get_auth_module.

 * Correctly free the split strbufs created in the header parsing loop in
   test-http-server.

 * Avoid needless comparison > 0 for unsigned types.

 * Always set optional outputs to NULL if not present in test helper config
   value handling.

 * Remove an accidentally commented-out test cleanup line for one test case
   in t5556.

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
 daemon.c                            | 306 +--------
 http.c                              |  98 ++-
 t/helper/.gitignore                 |   1 +
 t/helper/test-http-server.c         | 943 ++++++++++++++++++++++++++++
 t/lib-credential-helper.sh          |  27 +
 t/t5556-http-auth.sh                | 463 ++++++++++++++
 13 files changed, 1936 insertions(+), 302 deletions(-)
 create mode 100644 daemon-utils.c
 create mode 100644 daemon-utils.h
 create mode 100644 t/helper/test-http-server.c
 create mode 100644 t/lib-credential-helper.sh
 create mode 100755 t/t5556-http-auth.sh


base-commit: c48035d29b4e524aed3a32f0403676f0d9128863
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1352%2Fmjcheetham%2Femu-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1352/mjcheetham/emu-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/1352

Range-diff vs v6:

  1:  74b0de14185 =  1:  74b0de14185 daemon: libify socket setup and option functions
  2:  b6ba344a671 =  2:  b6ba344a671 daemon: libify child process handling functions
  3:  9967401c972 =  3:  9967401c972 daemon: rename some esoteric/laboured terminology
  4:  d6e5e8825e8 !  4:  17c890ee108 test-http-server: add stub HTTP server test helper
     @@ t/helper/test-http-server.c (new)
      +
      +/*
      + * The code in this section is used by "worker" instances to service
     -+ * a single connection from a client.  The worker talks to the client
     -+ * on 0 and 1.
     ++ * a single connection from a client. The worker talks to the client
     ++ * on stdin and stdout.
      + */
      +
      +enum worker_result {
     @@ t/helper/test-http-server.c (new)
      +	 * Operation successful.
      +	 * Caller *might* keep the socket open and allow keep-alive.
      +	 */
     -+	WR_OK       = 0,
     ++	WR_OK = 0,
      +
      +	/*
     -+	 * Various errors while processing the request and/or the response.
     ++	 * Fatal error that is not recoverable.
      +	 * Close the socket and clean up.
      +	 * Exit child-process with non-zero status.
      +	 */
     -+	WR_IO_ERROR = 1<<0,
     -+
     -+	/*
     -+	 * Close the socket and clean up.  Does not imply an error.
     -+	 */
     -+	WR_HANGUP   = 1<<1,
     ++	WR_FATAL_ERROR = 1,
      +};
      +
      +static enum worker_result worker(void)
     @@ t/helper/test-http-server.c (new)
      +	while (1) {
      +		if (write_in_full(STDOUT_FILENO, response, strlen(response)) < 0) {
      +			logerror("unable to write response");
     -+			wr = WR_IO_ERROR;
     ++			wr = WR_FATAL_ERROR;
      +		}
      +
      +		if (wr != WR_OK)
     @@ t/helper/test-http-server.c (new)
      +	close(STDIN_FILENO);
      +	close(STDOUT_FILENO);
      +
     -+	return !!(wr & WR_IO_ERROR);
     ++	/* Only WR_OK should result in a non-zero exit code */
     ++	return wr != WR_OK;
      +}
      +
      +static int max_connections = 32;
  5:  79805f042b9 !  5:  6e70e304cfe test-http-server: add HTTP error response function
     @@ Commit message
      
       ## t/helper/test-http-server.c ##
      @@ t/helper/test-http-server.c: enum worker_result {
     - 	WR_HANGUP   = 1<<1,
     + 	 * Exit child-process with non-zero status.
     + 	 */
     + 	WR_FATAL_ERROR = 1,
     ++
     ++	/*
     ++	 * Close the socket and clean up. Does not imply an error.
     ++	 */
     ++	WR_HANGUP = 2,
       };
       
     -+static enum worker_result send_http_error(
     -+	int fd,
     -+	int http_code, const char *http_code_name,
     -+	int retry_after_seconds, struct string_list *response_headers,
     -+	enum worker_result wr_in)
     ++static enum worker_result send_http_error(int fd, int http_code,
     ++					  const char *http_code_name,
     ++					  int retry_after_seconds,
     ++					  struct string_list *response_headers,
     ++					  enum worker_result wr_in)
      +{
      +	struct strbuf response_header = STRBUF_INIT;
      +	struct strbuf response_content = STRBUF_INIT;
      +	struct string_list_item *h;
      +	enum worker_result wr;
      +
     -+	strbuf_addf(&response_content, "Error: %d %s\r\n",
     -+		    http_code, http_code_name);
     ++	strbuf_addf(&response_content, "Error: %d %s\r\n", http_code,
     ++		    http_code_name);
     ++
      +	if (retry_after_seconds > 0)
      +		strbuf_addf(&response_content, "Retry-After: %d\r\n",
      +			    retry_after_seconds);
      +
     -+	strbuf_addf  (&response_header, "HTTP/1.1 %d %s\r\n", http_code, http_code_name);
     ++	strbuf_addf(&response_header, "HTTP/1.1 %d %s\r\n", http_code,
     ++		    http_code_name);
      +	strbuf_addstr(&response_header, "Cache-Control: private\r\n");
     -+	strbuf_addstr(&response_header,	"Content-Type: text/plain\r\n");
     -+	strbuf_addf  (&response_header,	"Content-Length: %d\r\n", (int)response_content.len);
     ++	strbuf_addstr(&response_header, "Content-Type: text/plain\r\n");
     ++	strbuf_addf(&response_header, "Content-Length: %"PRIuMAX"\r\n",
     ++		    (uintmax_t)response_content.len);
     ++
      +	if (retry_after_seconds > 0)
     -+		strbuf_addf(&response_header, "Retry-After: %d\r\n", retry_after_seconds);
     -+	strbuf_addf(  &response_header,	"Server: test-http-server/%s\r\n", git_version_string);
     -+	strbuf_addf(  &response_header, "Date: %s\r\n", show_date(time(NULL), 0, DATE_MODE(RFC2822)));
     ++		strbuf_addf(&response_header, "Retry-After: %d\r\n",
     ++			    retry_after_seconds);
     ++
     ++	strbuf_addf(&response_header, "Server: test-http-server/%s\r\n",
     ++		    git_version_string);
     ++	strbuf_addf(&response_header, "Date: %s\r\n", show_date(time(NULL), 0,
     ++		    DATE_MODE(RFC2822)));
     ++
      +	if (response_headers)
      +		for_each_string_list_item(h, response_headers)
      +			strbuf_addf(&response_header, "%s\r\n", h->string);
     @@ t/helper/test-http-server.c: enum worker_result {
      +
      +	if (write_in_full(fd, response_header.buf, response_header.len) < 0) {
      +		logerror("unable to write response header");
     -+		wr = WR_IO_ERROR;
     ++		wr = WR_FATAL_ERROR;
      +		goto done;
      +	}
      +
      +	if (write_in_full(fd, response_content.buf, response_content.len) < 0) {
      +		logerror("unable to write response content body");
     -+		wr = WR_IO_ERROR;
     ++		wr = WR_FATAL_ERROR;
      +		goto done;
      +	}
      +
     @@ t/helper/test-http-server.c: static enum worker_result worker(void)
       	while (1) {
      -		if (write_in_full(STDOUT_FILENO, response, strlen(response)) < 0) {
      -			logerror("unable to write response");
     --			wr = WR_IO_ERROR;
     +-			wr = WR_FATAL_ERROR;
      -		}
      +		wr = send_http_error(STDOUT_FILENO, 501, "Not Implemented", -1,
     -+				     NULL, WR_OK | WR_HANGUP);
     ++				     NULL, WR_HANGUP);
       
       		if (wr != WR_OK)
       			break;
     +@@ t/helper/test-http-server.c: static enum worker_result worker(void)
     + 	close(STDIN_FILENO);
     + 	close(STDOUT_FILENO);
     + 
     +-	/* Only WR_OK should result in a non-zero exit code */
     +-	return wr != WR_OK;
     ++	/* Only WR_OK and WR_HANGUP should result in a non-zero exit code */
     ++	return wr != WR_OK && wr != WR_HANGUP;
     + }
     + 
     + static int max_connections = 32;
  6:  252098db219 !  6:  43f1cdcbb82 test-http-server: add HTTP request parsing
     @@ Commit message
          test-http-server: add HTTP request parsing
      
          Add ability to parse HTTP requests to the test-http-server test helper.
     +    Introduce `struct req` to store request information including:
     +
     +     * HTTP method & version
     +     * Request path and query parameters
     +     * Headers
     +     * Content type and length (from `Content-Type` and `-Length` headers)
     +
     +    Failure to parse the request results in a 400 Bad Request response to
     +    the client. Note that we're not trying to support all possible requests
     +    here, but just enough to exercise all code under test.
      
          Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
      
       ## t/helper/test-http-server.c ##
      @@ t/helper/test-http-server.c: enum worker_result {
     - 	WR_HANGUP   = 1<<1,
     - };
     - 
     + 	 * Close the socket and clean up. Does not imply an error.
     + 	 */
     + 	WR_HANGUP = 2,
     ++
     ++	/*
     ++	 * Unexpected request message or error in request parsing.
     ++	 * Respond with an 400 error. Close the socket and cleanup.
     ++	 * Exit child-process with a non-zero status.
     ++	 */
     ++	WR_CLIENT_ERROR = 3,
     ++};
     ++
      +/*
      + * Fields from a parsed HTTP request.
      + */
     @@ t/helper/test-http-server.c: enum worker_result {
      +
      +	struct string_list header_list;
      +	const char *content_type;
     -+	ssize_t content_length;
     -+};
     -+
     ++	uintmax_t content_length;
     ++	unsigned has_content_length:1;
     + };
     + 
      +#define REQ__INIT { \
      +	.start_line = STRBUF_INIT, \
      +	.uri_path = STRBUF_INIT, \
      +	.query_args = STRBUF_INIT, \
      +	.header_list = STRING_LIST_INIT_NODUP, \
      +	.content_type = NULL, \
     -+	.content_length = -1 \
     -+	}
     ++	.content_length = 0, \
     ++	.has_content_length = 0, \
     ++}
      +
      +static void req__release(struct req *req)
      +{
     @@ t/helper/test-http-server.c: enum worker_result {
      +	string_list_clear(&req->header_list, 0);
      +}
      +
     - static enum worker_result send_http_error(
     - 	int fd,
     - 	int http_code, const char *http_code_name,
     + static enum worker_result send_http_error(int fd, int http_code,
     + 					  const char *http_code_name,
     + 					  int retry_after_seconds,
      @@ t/helper/test-http-server.c: done:
       	return wr;
       }
     @@ t/helper/test-http-server.c: done:
      +	 *
      +	 */
      +	if (strbuf_getwholeline_fd(&req->start_line, fd, '\n') == EOF) {
     -+		result = WR_OK | WR_HANGUP;
     ++		result = WR_HANGUP;
      +		goto done;
      +	}
      +
     @@ t/helper/test-http-server.c: done:
      +	if (nr_start_line_fields != 3) {
      +		logerror("could not parse request start-line '%s'",
      +			 req->start_line.buf);
     -+		result = WR_IO_ERROR;
     ++		result = WR_CLIENT_ERROR;
      +		goto done;
      +	}
      +
     @@ t/helper/test-http-server.c: done:
      +	if (strcmp(req->http_version, "HTTP/1.1")) {
      +		logerror("unsupported version '%s' (expecting HTTP/1.1)",
      +			 req->http_version);
     -+		result = WR_IO_ERROR;
     ++		result = WR_CLIENT_ERROR;
      +		goto done;
      +	}
      +
     @@ t/helper/test-http-server.c: done:
      +		string_list_append(&req->header_list, hp);
      +
      +		/* also store common request headers as struct req members */
     -+		if (skip_prefix(hp, "Content-Type: ", &hv)) {
     ++		if (skip_iprefix(hp, "Content-Type: ", &hv)) {
      +			req->content_type = hv;
     -+		} else if (skip_prefix(hp, "Content-Length: ", &hv)) {
     -+			req->content_length = strtol(hv, &hp, 10);
     ++		} else if (skip_iprefix(hp, "Content-Length: ", &hv)) {
     ++			/*
     ++			 * Content-Length is always non-negative, but has no
     ++			 * upper bound according to RFC 7230 (§3.3.2).
     ++			 */
     ++			intmax_t len = 0;
     ++			if (sscanf(hv, "%"PRIdMAX, &len) != 1 || len < 0 ||
     ++			    len == INTMAX_MAX) {
     ++				logerror("invalid content-length: '%s'", hv);
     ++				result = WR_CLIENT_ERROR;
     ++				goto done;
     ++			}
     ++
     ++			req->content_length = (uintmax_t)len;
     ++			req->has_content_length = 1;
      +		}
      +	}
      +
     @@ t/helper/test-http-server.c: done:
      +		trace2_printf("%s: hmth: %s", TR2_CAT, req->method);
      +		trace2_printf("%s: path: %s", TR2_CAT, req->uri_path.buf);
      +		trace2_printf("%s: qury: %s", TR2_CAT, req->query_args.buf);
     -+		if (req->content_length >= 0)
     -+			trace2_printf("%s: clen: %d", TR2_CAT, req->content_length);
     ++		if (req->has_content_length)
     ++			trace2_printf("%s: clen: %"PRIuMAX, TR2_CAT,
     ++				      req->content_length);
      +		if (req->content_type)
      +			trace2_printf("%s: ctyp: %s", TR2_CAT, req->content_type);
      +		for_each_string_list_item(item, &req->header_list)
     @@ t/helper/test-http-server.c: done:
      +static enum worker_result dispatch(struct req *req)
      +{
      +	return send_http_error(STDOUT_FILENO, 501, "Not Implemented", -1, NULL,
     -+			       WR_OK | WR_HANGUP);
     ++			       WR_HANGUP);
      +}
      +
       static enum worker_result worker(void)
     @@ t/helper/test-http-server.c: static enum worker_result worker(void)
       
       	while (1) {
      -		wr = send_http_error(STDOUT_FILENO, 501, "Not Implemented", -1,
     --				     NULL, WR_OK | WR_HANGUP);
     +-				     NULL, WR_HANGUP);
      +		req__release(&req);
      +
      +		alarm(timeout);
      +		wr = req__read(&req, 0);
      +		alarm(0);
      +
     ++		if (wr == WR_CLIENT_ERROR)
     ++			wr = send_http_error(STDOUT_FILENO, 400, "Bad Request",
     ++					     -1, NULL, wr);
     ++
      +		if (wr != WR_OK)
      +			break;
       
     @@ t/helper/test-http-server.c: static enum worker_result worker(void)
       		if (wr != WR_OK)
       			break;
       	}
     +
     + ## t/t5556-http-auth.sh (new) ##
     +@@
     ++#!/bin/sh
     ++
     ++test_description='test http auth header and credential helper interop'
     ++
     ++TEST_NO_CREATE_REPO=1
     ++. ./test-lib.sh
     ++
     ++# Setup a repository
     ++#
     ++REPO_DIR="$TRASH_DIRECTORY"/repo
     ++
     ++SERVER_LOG="$TRASH_DIRECTORY"/OUT.server.log
     ++
     ++PATH="$GIT_BUILD_DIR/t/helper/:$PATH" && export PATH
     ++
     ++test_expect_success 'setup repos' '
     ++	test_create_repo "$REPO_DIR" &&
     ++	git -C "$REPO_DIR" branch -M main
     ++'
     ++
     ++run_http_server_worker() {
     ++	(
     ++		cd "$REPO_DIR"
     ++		test-http-server --worker "$@" 2>"$SERVER_LOG" | tr -d "\r"
     ++	)
     ++}
     ++
     ++per_test_cleanup () {
     ++	rm -f OUT.* &&
     ++	rm -f IN.* &&
     ++}
     ++
     ++test_expect_success 'http auth server request parsing' '
     ++	test_when_finished "per_test_cleanup" &&
     ++
     ++	cat >auth.config <<-EOF &&
     ++	[auth]
     ++		allowAnonymous = true
     ++	EOF
     ++
     ++	echo "HTTP/1.1 400 Bad Request" >OUT.http400 &&
     ++	echo "HTTP/1.1 200 OK" >OUT.http200 &&
     ++
     ++	cat >IN.http.valid <<-EOF &&
     ++	GET /info/refs HTTP/1.1
     ++	Content-Length: 0
     ++	EOF
     ++
     ++	cat >IN.http.badfirstline <<-EOF &&
     ++	/info/refs GET HTTP
     ++	EOF
     ++
     ++	cat >IN.http.badhttpver <<-EOF &&
     ++	GET /info/refs HTTP/999.9
     ++	EOF
     ++
     ++	cat >IN.http.ltzlen <<-EOF &&
     ++	GET /info/refs HTTP/1.1
     ++	Content-Length: -1
     ++	EOF
     ++
     ++	cat >IN.http.badlen <<-EOF &&
     ++	GET /info/refs HTTP/1.1
     ++	Content-Length: not-a-number
     ++	EOF
     ++
     ++	cat >IN.http.overlen <<-EOF &&
     ++	GET /info/refs HTTP/1.1
     ++	Content-Length: 9223372036854775807
     ++	EOF
     ++
     ++	run_http_server_worker \
     ++		--auth-config="$TRASH_DIRECTORY/auth.config" <IN.http.valid \
     ++		| head -n1 >OUT.actual &&
     ++	test_cmp OUT.http200 OUT.actual &&
     ++
     ++	run_http_server_worker <IN.http.badfirstline | head -n1 >OUT.actual &&
     ++	test_cmp OUT.http400 OUT.actual &&
     ++
     ++	run_http_server_worker <IN.http.ltzlen | head -n1 >OUT.actual &&
     ++	test_cmp OUT.http400 OUT.actual &&
     ++
     ++	run_http_server_worker <IN.http.badlen | head -n1 >OUT.actual &&
     ++	test_cmp OUT.http400 OUT.actual &&
     ++
     ++	run_http_server_worker <IN.http.overlen | head -n1 >OUT.actual &&
     ++	test_cmp OUT.http400 OUT.actual
     ++'
     ++
     ++test_done
  7:  ab06ac9b965 !  7:  ca9c2787248 test-http-server: pass Git requests to http-backend
     @@ t/helper/test-http-server.c: done:
      +		return error(_("could not send '%s'"), ok);
      +
      +	strvec_pushf(&cp.env, "REQUEST_METHOD=%s", req->method);
     -+	strvec_pushf(&cp.env, "PATH_TRANSLATED=%s",
     -+			req->uri_path.buf);
     ++	strvec_pushf(&cp.env, "PATH_TRANSLATED=%s", req->uri_path.buf);
      +	strvec_push(&cp.env, "SERVER_PROTOCOL=HTTP/1.1");
      +	if (req->query_args.len)
     -+		strvec_pushf(&cp.env, "QUERY_STRING=%s",
     -+				req->query_args.buf);
     ++		strvec_pushf(&cp.env, "QUERY_STRING=%s", req->query_args.buf);
      +	if (req->content_type)
     -+		strvec_pushf(&cp.env, "CONTENT_TYPE=%s",
     -+				req->content_type);
     -+	if (req->content_length >= 0)
     -+		strvec_pushf(&cp.env, "CONTENT_LENGTH=%" PRIdMAX,
     -+				(intmax_t)req->content_length);
     ++		strvec_pushf(&cp.env, "CONTENT_TYPE=%s", req->content_type);
     ++	if (req->has_content_length)
     ++		strvec_pushf(&cp.env, "CONTENT_LENGTH=%" PRIuMAX,
     ++			(uintmax_t)req->content_length);
      +	cp.git_cmd = 1;
      +	strvec_push(&cp.args, "http-backend");
      +	res = run_command(&cp);
     @@ t/helper/test-http-server.c: done:
      +		return do__git(req);
      +
       	return send_http_error(STDOUT_FILENO, 501, "Not Implemented", -1, NULL,
     - 			       WR_OK | WR_HANGUP);
     + 			       WR_HANGUP);
       }
      
     - ## t/t5556-http-auth.sh (new) ##
     -@@
     -+#!/bin/sh
     -+
     -+test_description='test http auth header and credential helper interop'
     -+
     -+TEST_NO_CREATE_REPO=1
     -+. ./test-lib.sh
     -+
     + ## t/t5556-http-auth.sh ##
     +@@ t/t5556-http-auth.sh: test_description='test http auth header and credential helper interop'
     + TEST_NO_CREATE_REPO=1
     + . ./test-lib.sh
     + 
      +test_set_port GIT_TEST_HTTP_PROTOCOL_PORT
      +
     -+# Setup a repository
     -+#
     -+REPO_DIR="$TRASH_DIRECTORY"/repo
     -+
     + # Setup a repository
     + #
     + REPO_DIR="$TRASH_DIRECTORY"/repo
     + 
      +# Setup some lookback URLs where test-http-server will be listening.
      +# We will spawn it directly inside the repo directory, so we avoid
      +# any need to configure directory mappings etc - we only serve this
     @@ t/t5556-http-auth.sh (new)
      +# killing it by PID).
      +#
      +PID_FILE="$TRASH_DIRECTORY"/pid-file.pid
     -+SERVER_LOG="$TRASH_DIRECTORY"/OUT.server.log
     -+
     -+PATH="$GIT_BUILD_DIR/t/helper/:$PATH" && export PATH
     -+
     -+test_expect_success 'setup repos' '
     -+	test_create_repo "$REPO_DIR" &&
     -+	git -C "$REPO_DIR" branch -M main
     -+'
     -+
     + SERVER_LOG="$TRASH_DIRECTORY"/OUT.server.log
     + 
     + PATH="$GIT_BUILD_DIR/t/helper/:$PATH" && export PATH
     +@@ t/t5556-http-auth.sh: run_http_server_worker() {
     + 	)
     + }
     + 
      +stop_http_server () {
      +	if ! test -f "$PID_FILE"
      +	then
     @@ t/t5556-http-auth.sh (new)
      +	return 1
      +}
      +
     -+per_test_cleanup () {
     + per_test_cleanup () {
      +	stop_http_server &&
     -+	rm -f OUT.*
     -+}
     + 	rm -f OUT.* &&
     + 	rm -f IN.* &&
     + }
     +@@ t/t5556-http-auth.sh: test_expect_success 'http auth server request parsing' '
     + 	test_cmp OUT.http400 OUT.actual
     + '
     + 
      +
      +test_expect_success 'http auth anonymous no challenge' '
      +	test_when_finished "per_test_cleanup" &&
     @@ t/t5556-http-auth.sh (new)
      +	git ls-remote $ORIGIN_URL
      +'
      +
     -+test_done
     + test_done
  8:  a1ff55dd6e2 !  8:  b8d3e81b553 test-http-server: add simple authentication
     @@ t/helper/test-http-server.c: static enum worker_result do__git(struct req *req)
      +		strvec_pushf(&cp.env, "REMOTE_USER=%s", user);
      +
       	strvec_pushf(&cp.env, "REQUEST_METHOD=%s", req->method);
     - 	strvec_pushf(&cp.env, "PATH_TRANSLATED=%s",
     - 			req->uri_path.buf);
     + 	strvec_pushf(&cp.env, "PATH_TRANSLATED=%s", req->uri_path.buf);
     + 	strvec_push(&cp.env, "SERVER_PROTOCOL=HTTP/1.1");
      @@ t/helper/test-http-server.c: static enum worker_result do__git(struct req *req)
       	return !!res;
       }
     @@ t/helper/test-http-server.c: static enum worker_result do__git(struct req *req)
      +
      +static struct auth_module *get_auth_module(const char *scheme, int create)
      +{
     -+	int i;
      +	struct auth_module *mod;
     -+	for (i = 0; i < auth_modules_nr; i++) {
     ++	for (size_t i = 0; i < auth_modules_nr; i++) {
      +		mod = auth_modules[i];
      +		if (!strcasecmp(mod->scheme, scheme))
      +			return mod;
     @@ t/helper/test-http-server.c: static enum worker_result do__git(struct req *req)
      +		struct auth_module *mod = xmalloc(sizeof(struct auth_module));
      +		mod->scheme = xstrdup(scheme);
      +		mod->challenge_params = NULL;
     -+		CALLOC_ARRAY(mod->tokens, 1);
     ++		ALLOC_ARRAY(mod->tokens, 1);
      +		string_list_init_dup(mod->tokens);
      +
      +		ALLOC_GROW(auth_modules, auth_modules_nr + 1, auth_modules_alloc);
     @@ t/helper/test-http-server.c: static enum worker_result do__git(struct req *req)
      +	for_each_string_list_item(hdr, &req->header_list) {
      +		if (skip_iprefix(hdr->string, "Authorization: ", &v)) {
      +			split = strbuf_split_str(v, ' ', 2);
     -+			if (!split[0] || !split[1]) continue;
     -+
     -+			/* trim trailing space ' ' */
     -+			strbuf_setlen(split[0], split[0]->len - 1);
     -+
     -+			mod = get_auth_module(split[0]->buf, 0);
     -+			if (mod) {
     -+				result = AUTH_DENY;
     -+
     -+				for_each_string_list_item(token, mod->tokens) {
     -+					if (!strcmp(split[1]->buf, token->string)) {
     -+						result = AUTH_ALLOW;
     -+						break;
     ++			if (split[0] && split[1]) {
     ++				/* trim trailing space ' ' */
     ++				strbuf_rtrim(split[0]);
     ++
     ++				mod = get_auth_module(split[0]->buf, 0);
     ++				if (mod) {
     ++					result = AUTH_DENY;
     ++
     ++					for_each_string_list_item(token, mod->tokens) {
     ++						if (!strcmp(split[1]->buf, token->string)) {
     ++							result = AUTH_ALLOW;
     ++							break;
     ++						}
      +					}
     -+				}
      +
     -+				goto done;
     ++					strbuf_list_free(split);
     ++					goto done;
     ++				}
      +			}
     ++
     ++			strbuf_list_free(split);
      +		}
      +	}
      +
     @@ t/helper/test-http-server.c: static enum worker_result do__git(struct req *req)
      +				      &hdrs, *wr);
      +	}
      +
     -+	strbuf_list_free(split);
      +	string_list_clear(&hdrs, 0);
      +
      +	return result == AUTH_ALLOW ||
     @@ t/helper/test-http-server.c: static enum worker_result do__git(struct req *req)
      +		return -1;
      +
      +	/* trim trailing ':' */
     -+	if (p[0]->len > 0 && p[0]->buf[p[0]->len - 1] == ':')
     ++	if (p[0]->len && p[0]->buf[p[0]->len - 1] == ':')
      +		strbuf_setlen(p[0], p[0]->len - 1);
      +
      +	*scheme = strbuf_detach(p[0], NULL);
     -+
     -+	if (p[1])
     -+		*val = strbuf_detach(p[1], NULL);
     ++	*val = p[1] ? strbuf_detach(p[1], NULL) : NULL;
      +
      +	strbuf_list_free(p);
      +	return 0;
     @@ t/helper/test-http-server.c: static enum worker_result do__git(struct req *req)
      +	char *scheme = NULL;
      +	char *token = NULL;
      +	char *challenge = NULL;
     -+	struct auth_module *mod = NULL;
     ++	struct auth_module *mod;
      +
      +	if (!strcmp(name, "auth.challenge")) {
      +		if (split_auth_param(val, &scheme, &challenge)) {
     @@ t/helper/test-http-server.c: static enum worker_result do__git(struct req *req)
      +		return do__git(req, user);
       
       	return send_http_error(STDOUT_FILENO, 501, "Not Implemented", -1, NULL,
     - 			       WR_OK | WR_HANGUP);
     + 			       WR_HANGUP);
      @@ t/helper/test-http-server.c: int cmd_main(int argc, const char **argv)
       			pid_file = v;
       			continue;
     @@ t/helper/test-http-server.c: int cmd_main(int argc, const char **argv)
      
       ## t/t5556-http-auth.sh ##
      @@ t/t5556-http-auth.sh: per_test_cleanup () {
     - 	rm -f OUT.*
     + 	stop_http_server &&
     + 	rm -f OUT.* &&
     + 	rm -f IN.* &&
     ++	rm -f auth.config
       }
       
     + test_expect_success 'http auth server request parsing' '
     +@@ t/t5556-http-auth.sh: test_expect_success 'http auth server request parsing' '
     + 	test_cmp OUT.http400 OUT.actual
     + '
     + 
      +test_expect_success CURL 'http auth server auth config' '
     -+	#test_when_finished "per_test_cleanup" &&
     ++	test_when_finished "per_test_cleanup" &&
      +
      +	cat >auth.config <<-EOF &&
      +	[auth]
     @@ t/t5556-http-auth.sh: per_test_cleanup () {
      +
      +	test_cmp OUT.expected OUT.actual
      +'
     -+
     + 
       test_expect_success 'http auth anonymous no challenge' '
       	test_when_finished "per_test_cleanup" &&
       
  9:  76125cdf239 =  9:  2f97c94f679 test-http-server: add sending of arbitrary headers
 10:  cc9a220ed1f = 10:  4b1635b3f69 http: replace unsafe size_t multiplication with st_mult
 11:  bc1ac8d3eb3 = 11:  5f5e46038cf http: read HTTP WWW-Authenticate response headers
 12:  7c8229f0b11 ! 12:  09164f77d56 credential: add WWW-Authenticate header to cred requests
     @@ t/t5556-http-auth.sh: test_expect_success 'setup repos' '
       
      +setup_credential_helper
      +
     - stop_http_server () {
     - 	if ! test -f "$PID_FILE"
     - 	then
     -@@ t/t5556-http-auth.sh: start_http_server () {
     - 
     - per_test_cleanup () {
     + run_http_server_worker() {
     + 	(
     + 		cd "$REPO_DIR"
     +@@ t/t5556-http-auth.sh: per_test_cleanup () {
       	stop_http_server &&
     --	rm -f OUT.*
     -+	rm -f OUT.* &&
     + 	rm -f OUT.* &&
     + 	rm -f IN.* &&
      +	rm -f *.cred &&
     -+	rm -f auth.config
     + 	rm -f auth.config
       }
       
     - test_expect_success CURL 'http auth server auth config' '
      @@ t/t5556-http-auth.sh: test_expect_success 'http auth anonymous no challenge' '
       	git ls-remote $ORIGIN_URL
       '

-- 
gitgitgadget
