Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D93C05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 19:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjBFTaH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 14:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjBFT37 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 14:29:59 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F031565B6
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 11:29:53 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso9703392wms.4
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 11:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zo9+QFI1Et/gmUexj38TvKGiNJRQSqSho/OeED/+BRg=;
        b=RJUexqFPHs3KnLIq24T5zeZQdtl5fcFtzhMdRUO+g9VG2arjjelHcEVCg8FLCRL7G9
         yprUdgKHU0X93ko6yiTmlMqUM7Pq31fasEVTbCaocGqUXoqLaoFGev2PkjKru6rtQvP5
         DrMli8JCLuk4jx8+xYGT5zZWFXLhnEuURf3bpiswjcDAVimvpzjxGjfKTRdX7uRV/W+b
         kSFbNfK7ENbxlwb/7HvJiGlba2bkbYfX/HLkLzO59cjVkT5kiNvPl3Q/gq6KrfX+ju1M
         NeJXxuiD9u2gK/NSX9v+98ghMH+1iy5R+ZHzJp4tkxrD/DnxE6rvNmQWHNGa5BirzaLx
         uyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zo9+QFI1Et/gmUexj38TvKGiNJRQSqSho/OeED/+BRg=;
        b=YpfEbVP6G8v4AWCYvkIpBsZkXvXQ1IPT3ADeTAh7AWHtrdOG4Si3Axl5FfKAOd4JAx
         Wez0sJ4vAAbLbS7CEIiREl5dM9Z5TDBvSC0ohoXlUayzZ0nBjFnB73qQiceZh/+/SLDi
         yZ7l9JWvdJqHrq3uKhpGHE7VrDly9o8nEs3iUlMhtR6EbajJ5WbZ/nQCCv7upsuJcUwc
         hqwnweWY1rpaJirB7s2S88zd+y0G1ptLoDsmff6bHJ2H58Y5khbrVNhRASv5C6/0n92F
         /1kchS/0Tvme3kqqPYhljrM9TzcvdrAgq7PSUVZEIW5ff6t7ExCn+RVWcD0yoKAnjC5S
         LXQg==
X-Gm-Message-State: AO0yUKVD8ImL+06BqE+6WTVLChzh+OaaW3/zgvejR35yhXRioqMMGUJ9
        CPV3+YJWbIubAj33zXxFFfs9b2LduKQ=
X-Google-Smtp-Source: AK7set805/5KIc85AfjbiTs958ltGhzFun6QoMkdBHHpqtWSWzG+dmLheQmUmSjbRSNQJBxgSzkehA==
X-Received: by 2002:a05:600c:a287:b0:3df:fff4:5f6f with SMTP id hu7-20020a05600ca28700b003dffff45f6fmr735085wmb.36.1675711791508;
        Mon, 06 Feb 2023 11:29:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l16-20020a1c7910000000b003dc1d668866sm16406204wme.10.2023.02.06.11.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 11:29:51 -0800 (PST)
Message-Id: <pull.1352.v8.git.1675711789.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
References: <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Feb 2023 19:29:46 +0000
Subject: [PATCH v8 0/3] Enhance credential helper protocol to include auth headers
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
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matthew John Cheetham <mjcheetham@outlook.com>
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

Testing these new additions, I use a small CGI shell script that acts as a
frontend to git-http-backend; simple authentication is configurable by
files.


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


Updates in v8
=============

 * Drop custom HTTP test helper tool in favour of using a CGI shell script
   and Apache; avoiding the need to implement an HTTP server.

 * Avoid allocations in header reading callback unless we have a header we
   care about; act on the char* from libcurl directly rather than create a
   strbuf for each header.

 * Drop st_mult overflow guarding function in curl callback functions; we're
   not allocating memory based on the resulting value and just adds to
   potential confusion in the future.

Matthew John Cheetham (3):
  t5563: add tests for basic and anoymous HTTP access
  http: read HTTP WWW-Authenticate response headers
  credential: add WWW-Authenticate header to cred requests

 Documentation/git-credential.txt |  19 +-
 credential.c                     |  12 ++
 credential.h                     |  15 ++
 git-compat-util.h                |  22 +++
 http.c                           | 120 ++++++++++++
 t/lib-httpd.sh                   |   1 +
 t/lib-httpd/apache.conf          |   6 +
 t/lib-httpd/nph-custom-auth.sh   |  42 ++++
 t/t5563-simple-http-auth.sh      | 322 +++++++++++++++++++++++++++++++
 9 files changed, 558 insertions(+), 1 deletion(-)
 create mode 100755 t/lib-httpd/nph-custom-auth.sh
 create mode 100755 t/t5563-simple-http-auth.sh


base-commit: c48035d29b4e524aed3a32f0403676f0d9128863
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1352%2Fmjcheetham%2Femu-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1352/mjcheetham/emu-v8
Pull-Request: https://github.com/gitgitgadget/git/pull/1352

Range-diff vs v7:

  1:  74b0de14185 <  -:  ----------- daemon: libify socket setup and option functions
  2:  b6ba344a671 <  -:  ----------- daemon: libify child process handling functions
  3:  9967401c972 <  -:  ----------- daemon: rename some esoteric/laboured terminology
  4:  17c890ee108 <  -:  ----------- test-http-server: add stub HTTP server test helper
  5:  6e70e304cfe <  -:  ----------- test-http-server: add HTTP error response function
  6:  43f1cdcbb82 !  1:  d362f7016d3 test-http-server: add HTTP request parsing
     @@ Metadata
      Author: Matthew John Cheetham <mjcheetham@outlook.com>
      
       ## Commit message ##
     -    test-http-server: add HTTP request parsing
     +    t5563: add tests for basic and anoymous HTTP access
      
     -    Add ability to parse HTTP requests to the test-http-server test helper.
     -    Introduce `struct req` to store request information including:
     +    Add a test showing simple anoymous HTTP access to an unprotected
     +    repository, that results in no credential helper invocations.
     +    Also add a test demonstrating simple basic authentication with
     +    simple credential helper support.
      
     -     * HTTP method & version
     -     * Request path and query parameters
     -     * Headers
     -     * Content type and length (from `Content-Type` and `-Length` headers)
     -
     -    Failure to parse the request results in a 400 Bad Request response to
     -    the client. Note that we're not trying to support all possible requests
     -    here, but just enough to exercise all code under test.
     +    Leverage a no-parsed headers (NPH) CGI script so that we can directly
     +    control the HTTP responses to simulate a multitude of good, bad and ugly
     +    remote server implementations around auth.
      
          Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
      
     - ## t/helper/test-http-server.c ##
     -@@ t/helper/test-http-server.c: enum worker_result {
     - 	 * Close the socket and clean up. Does not imply an error.
     - 	 */
     - 	WR_HANGUP = 2,
     -+
     -+	/*
     -+	 * Unexpected request message or error in request parsing.
     -+	 * Respond with an 400 error. Close the socket and cleanup.
     -+	 * Exit child-process with a non-zero status.
     -+	 */
     -+	WR_CLIENT_ERROR = 3,
     -+};
     -+
     -+/*
     -+ * Fields from a parsed HTTP request.
     -+ */
     -+struct req {
     -+	struct strbuf start_line;
     -+
     -+	const char *method;
     -+	const char *http_version;
     -+
     -+	struct strbuf uri_path;
     -+	struct strbuf query_args;
     -+
     -+	struct string_list header_list;
     -+	const char *content_type;
     -+	uintmax_t content_length;
     -+	unsigned has_content_length:1;
     - };
     + ## t/lib-httpd.sh ##
     +@@ t/lib-httpd.sh: prepare_httpd() {
     + 	install_script error-smart-http.sh
     + 	install_script error.sh
     + 	install_script apply-one-time-perl.sh
     ++	install_script nph-custom-auth.sh
       
     -+#define REQ__INIT { \
     -+	.start_line = STRBUF_INIT, \
     -+	.uri_path = STRBUF_INIT, \
     -+	.query_args = STRBUF_INIT, \
     -+	.header_list = STRING_LIST_INIT_NODUP, \
     -+	.content_type = NULL, \
     -+	.content_length = 0, \
     -+	.has_content_length = 0, \
     -+}
     -+
     -+static void req__release(struct req *req)
     -+{
     -+	strbuf_release(&req->start_line);
     -+
     -+	strbuf_release(&req->uri_path);
     -+	strbuf_release(&req->query_args);
     -+
     -+	string_list_clear(&req->header_list, 0);
     -+}
     -+
     - static enum worker_result send_http_error(int fd, int http_code,
     - 					  const char *http_code_name,
     - 					  int retry_after_seconds,
     -@@ t/helper/test-http-server.c: done:
     - 	return wr;
     - }
     - 
     -+/*
     -+ * Read the HTTP request up to the start of the optional message-body.
     -+ * We do this byte-by-byte because we have keep-alive turned on and
     -+ * cannot rely on an EOF.
     -+ *
     -+ * https://tools.ietf.org/html/rfc7230
     -+ *
     -+ * We cannot call die() here because our caller needs to properly
     -+ * respond to the client and/or close the socket before this
     -+ * child exits so that the client doesn't get a connection reset
     -+ * by peer error.
     -+ */
     -+static enum worker_result req__read(struct req *req, int fd)
     -+{
     -+	struct strbuf h = STRBUF_INIT;
     -+	struct string_list start_line_fields = STRING_LIST_INIT_DUP;
     -+	int nr_start_line_fields;
     -+	const char *uri_target;
     -+	const char *query;
     -+	char *hp;
     -+	const char *hv;
     -+
     -+	enum worker_result result = WR_OK;
     -+
     -+	/*
     -+	 * Read line 0 of the request and split it into component parts:
     -+	 *
     -+	 *    <method> SP <uri-target> SP <HTTP-version> CRLF
     -+	 *
     -+	 */
     -+	if (strbuf_getwholeline_fd(&req->start_line, fd, '\n') == EOF) {
     -+		result = WR_HANGUP;
     -+		goto done;
     -+	}
     -+
     -+	strbuf_trim_trailing_newline(&req->start_line);
     -+
     -+	nr_start_line_fields = string_list_split(&start_line_fields,
     -+						 req->start_line.buf,
     -+						 ' ', -1);
     -+	if (nr_start_line_fields != 3) {
     -+		logerror("could not parse request start-line '%s'",
     -+			 req->start_line.buf);
     -+		result = WR_CLIENT_ERROR;
     -+		goto done;
     -+	}
     -+
     -+	req->method = xstrdup(start_line_fields.items[0].string);
     -+	req->http_version = xstrdup(start_line_fields.items[2].string);
     -+
     -+	uri_target = start_line_fields.items[1].string;
     -+
     -+	if (strcmp(req->http_version, "HTTP/1.1")) {
     -+		logerror("unsupported version '%s' (expecting HTTP/1.1)",
     -+			 req->http_version);
     -+		result = WR_CLIENT_ERROR;
     -+		goto done;
     -+	}
     -+
     -+	query = strchr(uri_target, '?');
     -+
     -+	if (query) {
     -+		strbuf_add(&req->uri_path, uri_target, (query - uri_target));
     -+		strbuf_trim_trailing_dir_sep(&req->uri_path);
     -+		strbuf_addstr(&req->query_args, query + 1);
     -+	} else {
     -+		strbuf_addstr(&req->uri_path, uri_target);
     -+		strbuf_trim_trailing_dir_sep(&req->uri_path);
     -+	}
     -+
     -+	/*
     -+	 * Read the set of HTTP headers into a string-list.
     -+	 */
     -+	while (1) {
     -+		if (strbuf_getwholeline_fd(&h, fd, '\n') == EOF)
     -+			goto done;
     -+		strbuf_trim_trailing_newline(&h);
     -+
     -+		if (!h.len)
     -+			goto done; /* a blank line ends the header */
     -+
     -+		hp = strbuf_detach(&h, NULL);
     -+		string_list_append(&req->header_list, hp);
     -+
     -+		/* also store common request headers as struct req members */
     -+		if (skip_iprefix(hp, "Content-Type: ", &hv)) {
     -+			req->content_type = hv;
     -+		} else if (skip_iprefix(hp, "Content-Length: ", &hv)) {
     -+			/*
     -+			 * Content-Length is always non-negative, but has no
     -+			 * upper bound according to RFC 7230 (§3.3.2).
     -+			 */
     -+			intmax_t len = 0;
     -+			if (sscanf(hv, "%"PRIdMAX, &len) != 1 || len < 0 ||
     -+			    len == INTMAX_MAX) {
     -+				logerror("invalid content-length: '%s'", hv);
     -+				result = WR_CLIENT_ERROR;
     -+				goto done;
     -+			}
     -+
     -+			req->content_length = (uintmax_t)len;
     -+			req->has_content_length = 1;
     -+		}
     -+	}
     -+
     -+	/*
     -+	 * We do not attempt to read the <message-body>, if it exists.
     -+	 * We let our caller read/chunk it in as appropriate.
     -+	 */
     -+
     -+done:
     -+	string_list_clear(&start_line_fields, 0);
     -+
     -+	/*
     -+	 * This is useful for debugging the request, but very noisy.
     -+	 */
     -+	if (trace2_is_enabled()) {
     -+		struct string_list_item *item;
     -+		trace2_printf("%s: %s", TR2_CAT, req->start_line.buf);
     -+		trace2_printf("%s: hver: %s", TR2_CAT, req->http_version);
     -+		trace2_printf("%s: hmth: %s", TR2_CAT, req->method);
     -+		trace2_printf("%s: path: %s", TR2_CAT, req->uri_path.buf);
     -+		trace2_printf("%s: qury: %s", TR2_CAT, req->query_args.buf);
     -+		if (req->has_content_length)
     -+			trace2_printf("%s: clen: %"PRIuMAX, TR2_CAT,
     -+				      req->content_length);
     -+		if (req->content_type)
     -+			trace2_printf("%s: ctyp: %s", TR2_CAT, req->content_type);
     -+		for_each_string_list_item(item, &req->header_list)
     -+			trace2_printf("%s: hdrs: %s", TR2_CAT, item->string);
     -+	}
     -+
     -+	return result;
     -+}
     -+
     -+static enum worker_result dispatch(struct req *req)
     -+{
     -+	return send_http_error(STDOUT_FILENO, 501, "Not Implemented", -1, NULL,
     -+			       WR_HANGUP);
     -+}
     -+
     - static enum worker_result worker(void)
     - {
     -+	struct req req = REQ__INIT;
     - 	char *client_addr = getenv("REMOTE_ADDR");
     - 	char *client_port = getenv("REMOTE_PORT");
     - 	enum worker_result wr = WR_OK;
     -@@ t/helper/test-http-server.c: static enum worker_result worker(void)
     - 	set_keep_alive(0, logerror);
     + 	ln -s "$LIB_HTTPD_MODULE_PATH" "$HTTPD_ROOT_PATH/modules"
       
     - 	while (1) {
     --		wr = send_http_error(STDOUT_FILENO, 501, "Not Implemented", -1,
     --				     NULL, WR_HANGUP);
     -+		req__release(&req);
     +
     + ## t/lib-httpd/apache.conf ##
     +@@ t/lib-httpd/apache.conf: Alias /auth/dumb/ www/auth/dumb/
     + 	SetEnv GIT_HTTP_EXPORT_ALL
     + 	SetEnv GIT_PROTOCOL
     + </LocationMatch>
     ++<LocationMatch /custom_auth/>
     ++	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
     ++	SetEnv GIT_HTTP_EXPORT_ALL
     ++	CGIPassAuth on
     ++</LocationMatch>
     + ScriptAlias /smart/incomplete_length/git-upload-pack incomplete-length-upload-pack-v2-http.sh/
     + ScriptAlias /smart/incomplete_body/git-upload-pack incomplete-body-upload-pack-v2-http.sh/
     + ScriptAlias /smart/no_report/git-receive-pack error-no-report.sh/
     +@@ t/lib-httpd/apache.conf: ScriptAlias /broken_smart/ broken-smart-http.sh/
     + ScriptAlias /error_smart/ error-smart-http.sh/
     + ScriptAlias /error/ error.sh/
     + ScriptAliasMatch /one_time_perl/(.*) apply-one-time-perl.sh/$1
     ++ScriptAliasMatch /custom_auth/(.*) nph-custom-auth.sh/$1
     + <Directory ${GIT_EXEC_PATH}>
     + 	Options FollowSymlinks
     + </Directory>
     +
     + ## t/lib-httpd/nph-custom-auth.sh (new) ##
     +@@
     ++#!/bin/sh
      +
     -+		alarm(timeout);
     -+		wr = req__read(&req, 0);
     -+		alarm(0);
     ++VALID_CREDS_FILE=custom-auth.valid
     ++CHALLENGE_FILE=custom-auth.challenge
     ++ANONYMOUS_FILE=custom-auth.anonymous
      +
     -+		if (wr == WR_CLIENT_ERROR)
     -+			wr = send_http_error(STDOUT_FILENO, 400, "Bad Request",
     -+					     -1, NULL, wr);
     ++#
     ++# If $ANONYMOUS_FILE exists in $HTTPD_ROOT_PATH, allow anonymous access.
     ++#
     ++# If $VALID_CREDS_FILE exists in $HTTPD_ROOT_PATH, consider each line as a valid
     ++# credential for the current request. Each line in the file is considered a
     ++# valid HTTP Authorization header value. For example:
     ++#
     ++# Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
     ++#
     ++# If $CHALLENGE_FILE exists in $HTTPD_ROOT_PATH, output the contents as headers
     ++# in a 401 response if no valid authentication credentials were included in the
     ++# request. For example:
     ++#
     ++# WWW-Authenticate: Bearer authorize_uri="id.example.com" p=1 q=0
     ++# WWW-Authenticate: Basic realm="example.com"
     ++#
      +
     -+		if (wr != WR_OK)
     -+			break;
     - 
     -+		wr = dispatch(&req);
     - 		if (wr != WR_OK)
     - 			break;
     - 	}
     ++if test -f "$ANONYMOUS_FILE" || (test -f "$VALID_CREDS_FILE" && \
     ++	grep -qi "^${HTTP_AUTHORIZATION:-nopenopnope}$" "$VALID_CREDS_FILE")
     ++then
     ++	# Note that although git-http-backend returns a status line, it
     ++	# does so using a CGI 'Status' header. Because this script is an
     ++	# No Parsed Headers (NPH) script, we must return a real HTTP
     ++	# status line.
     ++	# This is only a test script, so we don't bother to check for
     ++	# the actual status from git-http-backend and always return 200.
     ++	echo 'HTTP/1.1 200 OK'
     ++	exec "$GIT_EXEC_PATH"/git-http-backend
     ++fi
     ++
     ++echo 'HTTP/1.1 401 Authorization Required'
     ++if test -f "$CHALLENGE_FILE"
     ++then
     ++	cat "$CHALLENGE_FILE"
     ++fi
     ++echo
      
     - ## t/t5556-http-auth.sh (new) ##
     + ## t/t5563-simple-http-auth.sh (new) ##
      @@
      +#!/bin/sh
      +
      +test_description='test http auth header and credential helper interop'
      +
     -+TEST_NO_CREATE_REPO=1
      +. ./test-lib.sh
     -+
     -+# Setup a repository
     -+#
     -+REPO_DIR="$TRASH_DIRECTORY"/repo
     -+
     -+SERVER_LOG="$TRASH_DIRECTORY"/OUT.server.log
     -+
     -+PATH="$GIT_BUILD_DIR/t/helper/:$PATH" && export PATH
     -+
     -+test_expect_success 'setup repos' '
     -+	test_create_repo "$REPO_DIR" &&
     -+	git -C "$REPO_DIR" branch -M main
     ++. "$TEST_DIRECTORY"/lib-httpd.sh
     ++
     ++start_httpd
     ++
     ++test_expect_success 'setup_credential_helper' '
     ++	mkdir -p "$TRASH_DIRECTORY/bin" &&
     ++	PATH=$PATH:"$TRASH_DIRECTORY/bin" &&
     ++	export PATH &&
     ++
     ++	CREDENTIAL_HELPER="$TRASH_DIRECTORY/bin/git-credential-test-helper" &&
     ++	write_script "$CREDENTIAL_HELPER" <<-\EOF
     ++	cmd=$1
     ++	teefile=$cmd-query.cred
     ++	catfile=$cmd-reply.cred
     ++	sed -n -e "/^$/q" -e "p" >> $teefile
     ++	if test "$cmd" = "get"; then
     ++		cat $catfile
     ++	fi
     ++	EOF
      +'
      +
     -+run_http_server_worker() {
     -+	(
     -+		cd "$REPO_DIR"
     -+		test-http-server --worker "$@" 2>"$SERVER_LOG" | tr -d "\r"
     -+	)
     ++set_credential_reply() {
     ++	cat >"$TRASH_DIRECTORY/$1-reply.cred"
     ++}
     ++
     ++expect_credential_query() {
     ++	cat >"$TRASH_DIRECTORY/$1-expect.cred" &&
     ++	test_cmp "$TRASH_DIRECTORY/$1-expect.cred" \
     ++		 "$TRASH_DIRECTORY/$1-query.cred"
      +}
      +
      +per_test_cleanup () {
     -+	rm -f OUT.* &&
     -+	rm -f IN.* &&
     ++	rm -f *.cred &&
     ++	rm -f "$HTTPD_ROOT_PATH"/custom-auth.*
      +}
      +
     -+test_expect_success 'http auth server request parsing' '
     -+	test_when_finished "per_test_cleanup" &&
     ++test_expect_success 'setup repository' '
     ++	test_commit foo &&
     ++	git init --bare "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
     ++	git push --mirror "$HTTPD_DOCUMENT_ROOT_PATH/repo.git"
     ++'
      +
     -+	cat >auth.config <<-EOF &&
     -+	[auth]
     -+		allowAnonymous = true
     -+	EOF
     ++test_expect_success 'access anonymous no challenge' '
     ++	test_when_finished "per_test_cleanup" &&
     ++	touch "$HTTPD_ROOT_PATH/custom-auth.anonymous" &&
     ++	git ls-remote "$HTTPD_URL/custom_auth/repo.git"
     ++'
      +
     -+	echo "HTTP/1.1 400 Bad Request" >OUT.http400 &&
     -+	echo "HTTP/1.1 200 OK" >OUT.http200 &&
     ++test_expect_success 'access using basic auth' '
     ++	test_when_finished "per_test_cleanup" &&
      +
     -+	cat >IN.http.valid <<-EOF &&
     -+	GET /info/refs HTTP/1.1
     -+	Content-Length: 0
     ++	set_credential_reply get <<-EOF &&
     ++	username=alice
     ++	password=secret-passwd
      +	EOF
      +
     -+	cat >IN.http.badfirstline <<-EOF &&
     -+	/info/refs GET HTTP
     ++	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
     ++	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
      +	EOF
      +
     -+	cat >IN.http.badhttpver <<-EOF &&
     -+	GET /info/refs HTTP/999.9
     ++	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
     ++	WWW-Authenticate: Basic realm="example.com"
      +	EOF
      +
     -+	cat >IN.http.ltzlen <<-EOF &&
     -+	GET /info/refs HTTP/1.1
     -+	Content-Length: -1
     -+	EOF
     ++	test_config_global credential.helper test-helper &&
     ++	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
      +
     -+	cat >IN.http.badlen <<-EOF &&
     -+	GET /info/refs HTTP/1.1
     -+	Content-Length: not-a-number
     ++	expect_credential_query get <<-EOF &&
     ++	protocol=http
     ++	host=$HTTPD_DEST
      +	EOF
      +
     -+	cat >IN.http.overlen <<-EOF &&
     -+	GET /info/refs HTTP/1.1
     -+	Content-Length: 9223372036854775807
     ++	expect_credential_query store <<-EOF
     ++	protocol=http
     ++	host=$HTTPD_DEST
     ++	username=alice
     ++	password=secret-passwd
      +	EOF
     -+
     -+	run_http_server_worker \
     -+		--auth-config="$TRASH_DIRECTORY/auth.config" <IN.http.valid \
     -+		| head -n1 >OUT.actual &&
     -+	test_cmp OUT.http200 OUT.actual &&
     -+
     -+	run_http_server_worker <IN.http.badfirstline | head -n1 >OUT.actual &&
     -+	test_cmp OUT.http400 OUT.actual &&
     -+
     -+	run_http_server_worker <IN.http.ltzlen | head -n1 >OUT.actual &&
     -+	test_cmp OUT.http400 OUT.actual &&
     -+
     -+	run_http_server_worker <IN.http.badlen | head -n1 >OUT.actual &&
     -+	test_cmp OUT.http400 OUT.actual &&
     -+
     -+	run_http_server_worker <IN.http.overlen | head -n1 >OUT.actual &&
     -+	test_cmp OUT.http400 OUT.actual
      +'
      +
      +test_done
  7:  ca9c2787248 <  -:  ----------- test-http-server: pass Git requests to http-backend
  8:  b8d3e81b553 <  -:  ----------- test-http-server: add simple authentication
  9:  2f97c94f679 <  -:  ----------- test-http-server: add sending of arbitrary headers
 10:  4b1635b3f69 <  -:  ----------- http: replace unsafe size_t multiplication with st_mult
 11:  5f5e46038cf !  2:  cd9a02ba94e http: read HTTP WWW-Authenticate response headers
     @@ credential.h: struct credential {
       
       /* Initialize a credential structure, setting all fields to empty. */
      
     + ## git-compat-util.h ##
     +@@ git-compat-util.h: static inline int skip_iprefix(const char *str, const char *prefix,
     + 	return 0;
     + }
     + 
     ++/*
     ++ * Like skip_prefix_mem, but compare case-insensitively. Note that the
     ++ * comparison is done via tolower(), so it is strictly ASCII (no multi-byte
     ++ * characters or locale-specific conversions).
     ++ */
     ++static inline int skip_iprefix_mem(const char *buf, size_t len,
     ++				   const char *prefix,
     ++				   const char **out, size_t *outlen)
     ++{
     ++	size_t prefix_len = strlen(prefix);
     ++	if (len < prefix_len)
     ++		return 0;
     ++
     ++	if (!strncasecmp(buf, prefix, prefix_len)){
     ++		*out = buf + prefix_len;
     ++		*outlen = len - prefix_len;
     ++		return 1;
     ++	}
     ++
     ++	return 0;
     ++}
     ++
     + static inline int strtoul_ui(char const *s, int base, unsigned int *result)
     + {
     + 	unsigned long ul;
     +
       ## http.c ##
      @@ http.c: size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
       	return nmemb;
       }
       
     ++/*
     ++ * A folded header continuation line starts with at least one single whitespace
     ++ * character. It is not a continuation line if the line is *just* a newline.
     ++ * The RFC for HTTP states that CRLF is the header field line ending, but some
     ++ * servers may use LF only; we accept both.
     ++ */
     ++static inline int is_hdr_continuation(const char *ptr, const size_t size)
     ++{
     ++	/* totally empty line or normal header */
     ++	if (!size || !isspace(*ptr))
     ++		return 0;
     ++
     ++	/* empty line with LF line ending */
     ++	if (size == 1 && ptr[0] == '\n')
     ++		return 0;
     ++
     ++	/* empty line with CRLF line ending */
     ++	if (size == 2 && ptr[0] == '\r' && ptr[1] == '\n')
     ++		return 0;
     ++
     ++	return 1;
     ++}
     ++
      +static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p)
      +{
     -+	size_t size = st_mult(eltsize, nmemb);
     ++	size_t size = eltsize * nmemb;
      +	struct strvec *values = &http_auth.wwwauth_headers;
      +	struct strbuf buf = STRBUF_INIT;
      +	const char *val;
     ++	size_t val_len;
      +
      +	/*
      +	 * Header lines may not come NULL-terminated from libcurl so we must
     @@ http.c: size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buff
      +	 *                    of token, separators, and quoted-string>
      +	 */
      +
     -+	strbuf_add(&buf, ptr, size);
     -+
     -+	/* Strip the CRLF that should be present at the end of each field */
     -+	strbuf_trim_trailing_newline(&buf);
     -+
      +	/* Start of a new WWW-Authenticate header */
     -+	if (skip_iprefix(buf.buf, "www-authenticate:", &val)) {
     -+		while (isspace(*val))
     -+			val++;
     ++	if (skip_iprefix_mem(ptr, size, "www-authenticate:", &val, &val_len)) {
     ++		strbuf_add(&buf, val, val_len);
      +
     -+		strvec_push(values, val);
     ++		/*
     ++		 * Strip the CRLF that should be present at the end of each
     ++		 * field as well as any trailing or leading whitespace from the
     ++		 * value.
     ++		 */
     ++		strbuf_trim(&buf);
     ++
     ++		strvec_push(values, buf.buf);
      +		http_auth.header_is_last_match = 1;
      +		goto exit;
      +	}
     @@ http.c: size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buff
      +	 * This line could be a continuation of the previously matched header
      +	 * field. If this is the case then we should append this value to the
      +	 * end of the previously consumed value.
     -+	 * Continuation lines start with at least one whitespace, maybe more,
     -+	 * so we should collapse these down to a single SP (valid per the spec).
      +	 */
     -+	if (http_auth.header_is_last_match && isspace(*buf.buf)) {
     -+		/* Trim leading whitespace from this continuation hdr line. */
     -+		strbuf_ltrim(&buf);
     ++	if (http_auth.header_is_last_match && is_hdr_continuation(ptr, size)) {
     ++		/*
     ++		 * Trim the CRLF and any leading or trailing from this line.
     ++		 */
     ++		strbuf_add(&buf, ptr, size);
     ++		strbuf_trim(&buf);
      +
      +		/*
      +		 * At this point we should always have at least one existing
     @@ http.c: size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buff
      +	 * We only care about the last HTTP request response's headers so clear
      +	 * the existing array.
      +	 */
     -+	if (istarts_with(buf.buf, "http/"))
     ++	if (!strncasecmp(ptr, "http/", 5))
      +		strvec_clear(values);
      +
      +exit:
 12:  09164f77d56 !  3:  149aedf5501 credential: add WWW-Authenticate header to cred requests
     @@ credential.c: void credential_write(const struct credential *c, FILE *fp)
       
       static int run_credential_helper(struct credential *c,
      
     - ## t/lib-credential-helper.sh (new) ##
     -@@
     -+setup_credential_helper() {
     -+	test_expect_success 'setup credential helper' '
     -+		CREDENTIAL_HELPER="$TRASH_DIRECTORY/credential-helper.sh" &&
     -+		export CREDENTIAL_HELPER &&
     -+		echo $CREDENTIAL_HELPER &&
     -+
     -+		write_script "$CREDENTIAL_HELPER" <<-\EOF
     -+		cmd=$1
     -+		teefile=$cmd-query.cred
     -+		catfile=$cmd-reply.cred
     -+		sed -n -e "/^$/q" -e "p" >> $teefile
     -+		if test "$cmd" = "get"; then
     -+			cat $catfile
     -+		fi
     -+		EOF
     -+	'
     -+}
     + ## t/t5563-simple-http-auth.sh ##
     +@@ t/t5563-simple-http-auth.sh: test_expect_success 'access using basic auth' '
     + 	expect_credential_query get <<-EOF &&
     + 	protocol=http
     + 	host=$HTTPD_DEST
     ++	wwwauth[]=Basic realm="example.com"
     ++	EOF
      +
     -+set_credential_reply() {
     -+	cat >"$TRASH_DIRECTORY/$1-reply.cred"
     -+}
     ++	expect_credential_query store <<-EOF
     ++	protocol=http
     ++	host=$HTTPD_DEST
     ++	username=alice
     ++	password=secret-passwd
     ++	EOF
     ++'
      +
     -+expect_credential_query() {
     -+	cat >"$TRASH_DIRECTORY/$1-expect.cred" &&
     -+	test_cmp "$TRASH_DIRECTORY/$1-expect.cred" \
     -+		 "$TRASH_DIRECTORY/$1-query.cred"
     -+}
     -
     - ## t/t5556-http-auth.sh ##
     -@@ t/t5556-http-auth.sh: test_description='test http auth header and credential helper interop'
     - 
     - TEST_NO_CREATE_REPO=1
     - . ./test-lib.sh
     -+. "$TEST_DIRECTORY"/lib-credential-helper.sh
     - 
     - test_set_port GIT_TEST_HTTP_PROTOCOL_PORT
     - 
     -@@ t/t5556-http-auth.sh: test_expect_success 'setup repos' '
     - 	git -C "$REPO_DIR" branch -M main
     - '
     - 
     -+setup_credential_helper
     -+
     - run_http_server_worker() {
     - 	(
     - 		cd "$REPO_DIR"
     -@@ t/t5556-http-auth.sh: per_test_cleanup () {
     - 	stop_http_server &&
     - 	rm -f OUT.* &&
     - 	rm -f IN.* &&
     -+	rm -f *.cred &&
     - 	rm -f auth.config
     - }
     - 
     -@@ t/t5556-http-auth.sh: test_expect_success 'http auth anonymous no challenge' '
     - 	git ls-remote $ORIGIN_URL
     - '
     - 
     -+test_expect_success 'http auth www-auth headers to credential helper basic valid' '
     ++test_expect_success 'access using basic auth invalid credentials' '
      +	test_when_finished "per_test_cleanup" &&
     -+	# base64("alice:secret-passwd")
     -+	USERPASS64=YWxpY2U6c2VjcmV0LXBhc3N3ZA== &&
     -+	export USERPASS64 &&
     -+
     -+	cat >auth.config <<-EOF &&
     -+	[auth]
     -+		challenge = basic:realm=\"example.com\"
     -+		token = basic:$USERPASS64
     ++
     ++	set_credential_reply get <<-EOF &&
     ++	username=baduser
     ++	password=wrong-passwd
      +	EOF
      +
     -+	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
     ++	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
     ++	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
     ++	EOF
      +
     -+	set_credential_reply get <<-EOF &&
     -+	protocol=http
     -+	host=$HOST_PORT
     -+	username=alice
     -+	password=secret-passwd
     ++	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
     ++	WWW-Authenticate: Basic realm="example.com"
      +	EOF
      +
     -+	git -c "credential.helper=!\"$CREDENTIAL_HELPER\"" ls-remote $ORIGIN_URL &&
     ++	test_config_global credential.helper test-helper &&
     ++	test_must_fail git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
      +
      +	expect_credential_query get <<-EOF &&
      +	protocol=http
     -+	host=$HOST_PORT
     -+	wwwauth[]=basic realm="example.com"
     ++	host=$HTTPD_DEST
     ++	wwwauth[]=Basic realm="example.com"
      +	EOF
      +
     -+	expect_credential_query store <<-EOF
     ++	expect_credential_query erase <<-EOF
      +	protocol=http
     -+	host=$HOST_PORT
     -+	username=alice
     -+	password=secret-passwd
     ++	host=$HTTPD_DEST
     ++	username=baduser
     ++	password=wrong-passwd
     ++	wwwauth[]=Basic realm="example.com"
      +	EOF
      +'
      +
     -+test_expect_success 'http auth www-auth headers to credential helper ignore case valid' '
     ++test_expect_success 'access using basic auth with extra challenges' '
      +	test_when_finished "per_test_cleanup" &&
     -+	# base64("alice:secret-passwd")
     -+	USERPASS64=YWxpY2U6c2VjcmV0LXBhc3N3ZA== &&
     -+	export USERPASS64 &&
     -+
     -+	cat >auth.config <<-EOF &&
     -+	[auth]
     -+		challenge = basic:realm=\"example.com\"
     -+		token = basic:$USERPASS64
     -+		extraHeader = wWw-aUtHeNtIcAtE: bEaRer auThoRiTy=\"id.example.com\"
     -+	EOF
     -+
     -+	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
      +
      +	set_credential_reply get <<-EOF &&
     -+	protocol=http
     -+	host=$HOST_PORT
      +	username=alice
      +	password=secret-passwd
      +	EOF
      +
     -+	git -c "credential.helper=!\"$CREDENTIAL_HELPER\"" ls-remote $ORIGIN_URL &&
     ++	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
     ++	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
     ++	EOF
     ++
     ++	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
     ++	WWW-Authenticate: FooBar param1="value1" param2="value2"
     ++	WWW-Authenticate: Bearer authorize_uri="id.example.com" p=1 q=0
     ++	WWW-Authenticate: Basic realm="example.com"
     ++	EOF
     ++
     ++	test_config_global credential.helper test-helper &&
     ++	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
      +
      +	expect_credential_query get <<-EOF &&
      +	protocol=http
     -+	host=$HOST_PORT
     -+	wwwauth[]=basic realm="example.com"
     -+	wwwauth[]=bEaRer auThoRiTy="id.example.com"
     ++	host=$HTTPD_DEST
     ++	wwwauth[]=FooBar param1="value1" param2="value2"
     ++	wwwauth[]=Bearer authorize_uri="id.example.com" p=1 q=0
     ++	wwwauth[]=Basic realm="example.com"
      +	EOF
      +
      +	expect_credential_query store <<-EOF
      +	protocol=http
     -+	host=$HOST_PORT
     ++	host=$HTTPD_DEST
      +	username=alice
      +	password=secret-passwd
      +	EOF
      +'
      +
     -+test_expect_success 'http auth www-auth headers to credential helper continuation hdr' '
     ++test_expect_success 'access using basic auth mixed-case wwwauth header name' '
      +	test_when_finished "per_test_cleanup" &&
     -+	# base64("alice:secret-passwd")
     -+	USERPASS64=YWxpY2U6c2VjcmV0LXBhc3N3ZA== &&
     -+	export USERPASS64 &&
     -+
     -+	cat >auth.config <<-EOF &&
     -+	[auth]
     -+		challenge = "bearer:authority=\"id.example.com\"\\n    q=1\\n \\t p=0"
     -+		challenge = basic:realm=\"example.com\"
     -+		token = basic:$USERPASS64
     -+	EOF
     -+
     -+	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
      +
      +	set_credential_reply get <<-EOF &&
     -+	protocol=http
     -+	host=$HOST_PORT
      +	username=alice
      +	password=secret-passwd
      +	EOF
      +
     -+	git -c "credential.helper=!\"$CREDENTIAL_HELPER\"" ls-remote $ORIGIN_URL &&
     ++	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
     ++	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
     ++	EOF
     ++
     ++	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
     ++	www-authenticate: foobar param1="value1" param2="value2"
     ++	WWW-AUTHENTICATE: BEARER authorize_uri="id.example.com" p=1 q=0
     ++	WwW-aUtHeNtIcAtE: baSiC realm="example.com"
     ++	EOF
     ++
     ++	test_config_global credential.helper test-helper &&
     ++	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
      +
      +	expect_credential_query get <<-EOF &&
      +	protocol=http
     -+	host=$HOST_PORT
     -+	wwwauth[]=bearer authority="id.example.com" q=1 p=0
     -+	wwwauth[]=basic realm="example.com"
     ++	host=$HTTPD_DEST
     ++	wwwauth[]=foobar param1="value1" param2="value2"
     ++	wwwauth[]=BEARER authorize_uri="id.example.com" p=1 q=0
     ++	wwwauth[]=baSiC realm="example.com"
      +	EOF
      +
      +	expect_credential_query store <<-EOF
      +	protocol=http
     -+	host=$HOST_PORT
     ++	host=$HTTPD_DEST
      +	username=alice
      +	password=secret-passwd
      +	EOF
      +'
      +
     -+test_expect_success 'http auth www-auth headers to credential helper empty continuation hdrs' '
     ++test_expect_success 'access using basic auth with wwwauth header continuations' '
      +	test_when_finished "per_test_cleanup" &&
     -+	# base64("alice:secret-passwd")
     -+	USERPASS64=YWxpY2U6c2VjcmV0LXBhc3N3ZA== &&
     -+	export USERPASS64 &&
     -+
     -+	cat >auth.config <<-EOF &&
     -+	[auth]
     -+		challenge = basic:realm=\"example.com\"
     -+		token = basic:$USERPASS64
     -+		extraheader = "WWW-Authenticate:"
     -+		extraheader = " "
     -+		extraheader = " bearer authority=\"id.example.com\""
     -+	EOF
     -+
     -+	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
      +
      +	set_credential_reply get <<-EOF &&
     -+	protocol=http
     -+	host=$HOST_PORT
      +	username=alice
      +	password=secret-passwd
      +	EOF
      +
     -+	git -c "credential.helper=!\"$CREDENTIAL_HELPER\"" ls-remote $ORIGIN_URL &&
     ++	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
     ++	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
     ++	EOF
     ++
     ++	# Note that leading and trailing whitespace is important to correctly
     ++	# simulate a continuation/folded header.
     ++	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
     ++	WWW-Authenticate: FooBar param1="value1"
     ++	 param2="value2"
     ++	WWW-Authenticate: Bearer authorize_uri="id.example.com"
     ++	 p=1
     ++	 q=0
     ++	WWW-Authenticate: Basic realm="example.com"
     ++	EOF
     ++
     ++	test_config_global credential.helper test-helper &&
     ++	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
      +
      +	expect_credential_query get <<-EOF &&
      +	protocol=http
     -+	host=$HOST_PORT
     -+	wwwauth[]=basic realm="example.com"
     -+	wwwauth[]=bearer authority="id.example.com"
     ++	host=$HTTPD_DEST
     ++	wwwauth[]=FooBar param1="value1" param2="value2"
     ++	wwwauth[]=Bearer authorize_uri="id.example.com" p=1 q=0
     ++	wwwauth[]=Basic realm="example.com"
      +	EOF
      +
      +	expect_credential_query store <<-EOF
      +	protocol=http
     -+	host=$HOST_PORT
     ++	host=$HTTPD_DEST
      +	username=alice
      +	password=secret-passwd
      +	EOF
      +'
      +
     -+test_expect_success 'http auth www-auth headers to credential helper custom schemes' '
     ++test_expect_success 'access using basic auth with wwwauth header empty continuations' '
      +	test_when_finished "per_test_cleanup" &&
     -+	# base64("alice:secret-passwd")
     -+	USERPASS64=YWxpY2U6c2VjcmV0LXBhc3N3ZA== &&
     -+	export USERPASS64 &&
     -+
     -+	cat >auth.config <<-EOF &&
     -+	[auth]
     -+		challenge = "foobar:alg=test widget=1"
     -+		challenge = "bearer:authority=\"id.example.com\" q=1 p=0"
     -+		challenge = basic:realm=\"example.com\"
     -+		token = basic:$USERPASS64
     -+	EOF
     -+
     -+	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
      +
      +	set_credential_reply get <<-EOF &&
     -+	protocol=http
     -+	host=$HOST_PORT
      +	username=alice
      +	password=secret-passwd
      +	EOF
      +
     -+	git -c "credential.helper=!\"$CREDENTIAL_HELPER\"" ls-remote $ORIGIN_URL &&
     ++	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
     ++	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
     ++	EOF
     ++
     ++	CHALLENGE="$HTTPD_ROOT_PATH/custom-auth.challenge" &&
     ++
     ++	# Note that leading and trailing whitespace is important to correctly
     ++	# simulate a continuation/folded header.
     ++	printf "">$CHALLENGE &&
     ++	printf "WWW-Authenticate: FooBar param1=\"value1\"\r\n" >$CHALLENGE &&
     ++	printf " \r\n" >>$CHALLENGE &&
     ++	printf " param2=\"value2\"\r\n" >>$CHALLENGE &&
     ++	printf "WWW-Authenticate: Bearer authorize_uri=\"id.example.com\"\r\n" >>$CHALLENGE &&
     ++	printf " p=1\r\n" >>$CHALLENGE &&
     ++	printf " \r\n" >>$CHALLENGE &&
     ++	printf " q=0\r\n" >>$CHALLENGE &&
     ++	printf "WWW-Authenticate: Basic realm=\"example.com\"\r\n" >>$CHALLENGE &&
     ++
     ++	test_config_global credential.helper test-helper &&
     ++	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
      +
      +	expect_credential_query get <<-EOF &&
      +	protocol=http
     -+	host=$HOST_PORT
     -+	wwwauth[]=foobar alg=test widget=1
     -+	wwwauth[]=bearer authority="id.example.com" q=1 p=0
     -+	wwwauth[]=basic realm="example.com"
     ++	host=$HTTPD_DEST
     ++	wwwauth[]=FooBar param1="value1" param2="value2"
     ++	wwwauth[]=Bearer authorize_uri="id.example.com" p=1 q=0
     ++	wwwauth[]=Basic realm="example.com"
      +	EOF
      +
      +	expect_credential_query store <<-EOF
      +	protocol=http
     -+	host=$HOST_PORT
     ++	host=$HTTPD_DEST
      +	username=alice
      +	password=secret-passwd
      +	EOF
      +'
      +
     -+test_expect_success 'http auth www-auth headers to credential helper invalid' '
     ++test_expect_success 'access using basic auth with wwwauth header mixed line-endings' '
      +	test_when_finished "per_test_cleanup" &&
     -+	# base64("alice:secret-passwd")
     -+	USERPASS64=YWxpY2U6c2VjcmV0LXBhc3N3ZA== &&
     -+	export USERPASS64 &&
     -+
     -+	cat >auth.config <<-EOF &&
     -+	[auth]
     -+		challenge = "bearer:authority=\"id.example.com\" q=1 p=0"
     -+		challenge = basic:realm=\"example.com\"
     -+		token = basic:$USERPASS64
     -+	EOF
     -+
     -+	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
      +
      +	set_credential_reply get <<-EOF &&
     -+	protocol=http
     -+	host=$HOST_PORT
      +	username=alice
     -+	password=invalid-passwd
     ++	password=secret-passwd
      +	EOF
      +
     -+	test_must_fail git -c "credential.helper=!\"$CREDENTIAL_HELPER\"" ls-remote $ORIGIN_URL &&
     -+
     -+	expect_credential_query get <<-EOF &&
     -+	protocol=http
     -+	host=$HOST_PORT
     -+	wwwauth[]=bearer authority="id.example.com" q=1 p=0
     -+	wwwauth[]=basic realm="example.com"
     ++	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
     ++	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
      +	EOF
      +
     -+	expect_credential_query erase <<-EOF
     -+	protocol=http
     -+	host=$HOST_PORT
     -+	username=alice
     -+	password=invalid-passwd
     -+	wwwauth[]=bearer authority="id.example.com" q=1 p=0
     -+	wwwauth[]=basic realm="example.com"
     -+	EOF
     -+'
     ++	CHALLENGE="$HTTPD_ROOT_PATH/custom-auth.challenge" &&
     ++
     ++	# Note that leading and trailing whitespace is important to correctly
     ++	# simulate a continuation/folded header.
     ++	printf "">$CHALLENGE &&
     ++	printf "WWW-Authenticate: FooBar param1=\"value1\"\r\n" >$CHALLENGE &&
     ++	printf " \r\n" >>$CHALLENGE &&
     ++	printf "\tparam2=\"value2\"\r\n" >>$CHALLENGE &&
     ++	printf "WWW-Authenticate: Basic realm=\"example.com\"" >>$CHALLENGE &&
      +
     - test_done
     ++	test_config_global credential.helper test-helper &&
     ++	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
     ++
     ++	expect_credential_query get <<-EOF &&
     ++	protocol=http
     ++	host=$HTTPD_DEST
     ++	wwwauth[]=FooBar param1="value1" param2="value2"
     ++	wwwauth[]=Basic realm="example.com"
     + 	EOF
     + 
     + 	expect_credential_query store <<-EOF

-- 
gitgitgadget
