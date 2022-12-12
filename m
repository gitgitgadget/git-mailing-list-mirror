Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C6BC4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 21:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbiLLVgd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 16:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbiLLVga (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 16:36:30 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143EF65A1
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:36:28 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m19so6787031wms.5
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WaKTHBJOCGIbUmOdY0wXiI/RqZgoSBOv+65cBPezmX8=;
        b=qMYwdeTBjPoRV5VjzTvdmp2gdtBXPgvpAPmYycxoNxI3JN4jMtrM7/mafu5rHGnhFc
         3JYL30eMQOvgpAS4A7Smz2Qe3F3Aue5TPW5AcXdBY/lxoAgm0ilz2qC5ayrGG/yBIyPC
         AT6PaVtDZCKSkjsj9bHQbOvthC9izvy8K/P0czzBlrEsIO9qaHHN6gXMwImSJiwAk1jz
         tUQCvd40brMlIH/RdIP3TmQOkbFalWaly+ObmN1AgZTSe9Vb44leaEA8lDMCE09HjNjs
         0dsCy/YixcYM4ni3PQu04G6ltAM0JJeLqqN2v3b2xNOglBTcov+bo9TO2hwWFo1h0bEG
         VaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WaKTHBJOCGIbUmOdY0wXiI/RqZgoSBOv+65cBPezmX8=;
        b=GuAANrYmLeWFFQPgJ8WE80uthmdk5n6AQfTnQDiAJpofOoQheV9ngPH5gVbGjwT7pd
         E8Ma5Ogqm+rYlRmFvp3BUMycBhNFmF/FI8pOaa7UURmcmG3je2MZpg96v9jC3BeTfW+r
         FxV8zpGLuk4uil5YoZHgs8HDVmcGU6wdhyNsub8a4nnb5Ph31T15etYzsLa5yP47C/kf
         nkqYs0k7DlXmi8UAtU8O2KV5zG9N003wJuEHKiSQeYbcYiOrINzKa+2VbD3sZCByHv+x
         yQoyIJVZ+bori8NwMG/1v3wo2rSgAtwfLhyu9rrV80iycSvfszyVTWIRpssp5KnNrvTK
         F9+A==
X-Gm-Message-State: ANoB5plSdp8p6grY7rbKcQdIriPX5D3PynswjnzPzU1G4ubIEDdmlr6k
        15o/UVytiZrfDYVVT6IUl96tVfV9V3s=
X-Google-Smtp-Source: AA0mqf5OWZu9WmHgcs0ClGB1KlGloQmfOPzqZqt4pvn/jVS8lnceSyym+M/wRltg0FhHNvpxJzGRyQ==
X-Received: by 2002:a05:600c:4f08:b0:3d1:d746:d95b with SMTP id l8-20020a05600c4f0800b003d1d746d95bmr13425618wmq.41.1670880986068;
        Mon, 12 Dec 2022 13:36:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg16-20020a05600c3c9000b003c7087f6c9asm12205890wmb.32.2022.12.12.13.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 13:36:25 -0800 (PST)
Message-Id: <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
References: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Dec 2022 21:36:15 +0000
Subject: [PATCH v4 0/8] Enhance credential helper protocol to include auth headers
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
        Matthew John Cheetham <mjcheetham@github.com>
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
that acts as a frontend to git-http-backend; a mini HTTP server based
heavily on git-daemon, with simple authentication configurable by command
line args.


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

Matthew John Cheetham (8):
  http: read HTTP WWW-Authenticate response headers
  credential: add WWW-Authenticate header to cred requests
  test-http-server: add stub HTTP server test helper
  test-http-server: add HTTP error response function
  test-http-server: add HTTP request parsing
  test-http-server: pass Git requests to http-backend
  test-http-server: add simple authentication
  t5556: add HTTP authentication tests

 Documentation/git-credential.txt          |   18 +-
 Makefile                                  |    2 +
 contrib/buildsystems/CMakeLists.txt       |   13 +
 credential.c                              |   13 +
 credential.h                              |   15 +
 http.c                                    |   78 ++
 t/helper/.gitignore                       |    1 +
 t/helper/test-credential-helper-replay.sh |   14 +
 t/helper/test-http-server.c               | 1146 +++++++++++++++++++++
 t/t5556-http-auth.sh                      |  223 ++++
 10 files changed, 1522 insertions(+), 1 deletion(-)
 create mode 100755 t/helper/test-credential-helper-replay.sh
 create mode 100644 t/helper/test-http-server.c
 create mode 100755 t/t5556-http-auth.sh


base-commit: c48035d29b4e524aed3a32f0403676f0d9128863
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1352%2Fmjcheetham%2Femu-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1352/mjcheetham/emu-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1352

Range-diff vs v3:

  1:  f297c78f60a =  1:  b5b56ccd941 http: read HTTP WWW-Authenticate response headers
  2:  e45e23406a5 !  2:  d02875dda7c credential: add WWW-Authenticate header to cred requests
     @@ Documentation/git-credential.txt: empty string.
      +	to credential helpers.
      +	Each 'WWW-Authenticate' header value is passed as a multi-valued
      +	attribute 'wwwauth[]', where the order of the attributes is the same as
     -+	they appear in the HTTP response.
     ++	they appear in the HTTP response. This attribute is 'one-way' from Git
     ++	to pass additional information to credential helpers.
      +
     + Unrecognised attributes are silently discarded.
     + 
       GIT
     - ---
     - Part of the linkgit:git[1] suite
      
       ## credential.c ##
      @@ credential.c: static void credential_write_item(FILE *fp, const char *key, const char *value,
  3:  65ac638b8a0 <  -:  ----------- http: store all request headers on active_request_slot
  4:  4d75ca29cc5 <  -:  ----------- http: move proactive auth to first slot creation
  5:  2f38427aa8d <  -:  ----------- http: set specific auth scheme depending on credential
  6:  4947e81546a =  3:  07a1845ea56 test-http-server: add stub HTTP server test helper
  7:  93bdf1d7060 =  4:  98dd286db7c test-http-server: add HTTP error response function
  8:  b3e9156755f =  5:  5c4e36e23ee test-http-server: add HTTP request parsing
  9:  5fb248c074a =  6:  0a0f4fd10c8 test-http-server: pass Git requests to http-backend
 10:  192f09b9de4 =  7:  794256754c1 test-http-server: add simple authentication
 11:  b64d2f2c473 !  8:  8ecf6383522 t5556: add HTTP authentication tests
     @@ Commit message
          t5556: add HTTP authentication tests
      
          Add a series of tests to exercise the HTTP authentication header parsing
     -    and the interop with credential helpers. Credential helpers can respond
     -    to requests that contain WWW-Authenticate information with the ability
     -    to select the response Authenticate header scheme.
     +    and the interop with credential helpers. Credential helpers will receive
     +    WWW-Authenticate information in credential requests.
      
          Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
      
     @@ t/t5556-http-auth.sh: test_expect_success 'http auth anonymous no challenge' '
       	git ls-remote $ORIGIN_URL
       '
       
     -+test_expect_success 'http auth www-auth headers to credential helper bearer valid' '
     -+	test_when_finished "per_test_cleanup" &&
     -+	start_http_server \
     -+		--auth=bearer:authority=\"id.example.com\"\ q=1\ p=0 \
     -+		--auth=basic:realm=\"example.com\" \
     -+		--auth-token=bearer:secret-token &&
     -+
     -+	cat >get-expected.cred <<-EOF &&
     -+	protocol=http
     -+	host=$HOST_PORT
     -+	wwwauth[]=bearer authority="id.example.com" q=1 p=0
     -+	wwwauth[]=basic realm="example.com"
     -+	EOF
     -+
     -+	cat >store-expected.cred <<-EOF &&
     -+	protocol=http
     -+	host=$HOST_PORT
     -+	username=alice
     -+	password=secret-token
     -+	authtype=bearer
     -+	EOF
     -+
     -+	cat >get-response.cred <<-EOF &&
     -+	protocol=http
     -+	host=$HOST_PORT
     -+	username=alice
     -+	password=secret-token
     -+	authtype=bearer
     -+	EOF
     -+
     -+	git -c credential.helper="$CREDENTIAL_HELPER" ls-remote $ORIGIN_URL &&
     -+
     -+	test_cmp get-expected.cred get-actual.cred &&
     -+	test_cmp store-expected.cred store-actual.cred
     -+'
     -+
      +test_expect_success 'http auth www-auth headers to credential helper basic valid' '
      +	test_when_finished "per_test_cleanup" &&
      +	# base64("alice:secret-passwd")
     @@ t/t5556-http-auth.sh: test_expect_success 'http auth anonymous no challenge' '
      +	export USERPASS64 &&
      +
      +	start_http_server \
     -+		--auth=bearer:authority=\"id.example.com\"\ q=1\ p=0 \
      +		--auth=basic:realm=\"example.com\" \
      +		--auth-token=basic:$USERPASS64 &&
      +
      +	cat >get-expected.cred <<-EOF &&
      +	protocol=http
      +	host=$HOST_PORT
     -+	wwwauth[]=bearer authority="id.example.com" q=1 p=0
      +	wwwauth[]=basic realm="example.com"
      +	EOF
      +
     @@ t/t5556-http-auth.sh: test_expect_success 'http auth anonymous no challenge' '
      +	host=$HOST_PORT
      +	username=alice
      +	password=secret-passwd
     -+	authtype=basic
      +	EOF
      +
      +	cat >get-response.cred <<-EOF &&
     @@ t/t5556-http-auth.sh: test_expect_success 'http auth anonymous no challenge' '
      +	host=$HOST_PORT
      +	username=alice
      +	password=secret-passwd
     -+	authtype=basic
      +	EOF
      +
      +	git -c credential.helper="$CREDENTIAL_HELPER" ls-remote $ORIGIN_URL &&
     @@ t/t5556-http-auth.sh: test_expect_success 'http auth anonymous no challenge' '
      +	test_cmp store-expected.cred store-actual.cred
      +'
      +
     -+test_expect_success 'http auth www-auth headers to credential helper custom scheme' '
     ++test_expect_success 'http auth www-auth headers to credential helper custom schemes' '
      +	test_when_finished "per_test_cleanup" &&
     ++	# base64("alice:secret-passwd")
     ++	USERPASS64=YWxpY2U6c2VjcmV0LXBhc3N3ZA== &&
     ++	export USERPASS64 &&
     ++
      +	start_http_server \
      +		--auth=foobar:alg=test\ widget=1 \
      +		--auth=bearer:authority=\"id.example.com\"\ q=1\ p=0 \
      +		--auth=basic:realm=\"example.com\" \
     -+		--auth-token=foobar:SECRET-FOOBAR-VALUE &&
     ++		--auth-token=basic:$USERPASS64 &&
      +
      +	cat >get-expected.cred <<-EOF &&
      +	protocol=http
     @@ t/t5556-http-auth.sh: test_expect_success 'http auth anonymous no challenge' '
      +	protocol=http
      +	host=$HOST_PORT
      +	username=alice
     -+	password=SECRET-FOOBAR-VALUE
     -+	authtype=foobar
     ++	password=secret-passwd
      +	EOF
      +
      +	cat >get-response.cred <<-EOF &&
      +	protocol=http
      +	host=$HOST_PORT
      +	username=alice
     -+	password=SECRET-FOOBAR-VALUE
     -+	authtype=foobar
     ++	password=secret-passwd
      +	EOF
      +
      +	git -c credential.helper="$CREDENTIAL_HELPER" ls-remote $ORIGIN_URL &&
     @@ t/t5556-http-auth.sh: test_expect_success 'http auth anonymous no challenge' '
      +
      +test_expect_success 'http auth www-auth headers to credential helper invalid' '
      +	test_when_finished "per_test_cleanup" &&
     ++	# base64("alice:secret-passwd")
     ++	USERPASS64=YWxpY2U6c2VjcmV0LXBhc3N3ZA== &&
     ++	export USERPASS64 &&
      +	start_http_server \
      +		--auth=bearer:authority=\"id.example.com\"\ q=1\ p=0 \
      +		--auth=basic:realm=\"example.com\" \
     -+		--auth-token=bearer:secret-token &&
     ++		--auth-token=basic:$USERPASS64 &&
      +
      +	cat >get-expected.cred <<-EOF &&
      +	protocol=http
     @@ t/t5556-http-auth.sh: test_expect_success 'http auth anonymous no challenge' '
      +	protocol=http
      +	host=$HOST_PORT
      +	username=alice
     -+	password=invalid-token
     -+	authtype=bearer
     ++	password=invalid-passwd
      +	wwwauth[]=bearer authority="id.example.com" q=1 p=0
      +	wwwauth[]=basic realm="example.com"
      +	EOF
     @@ t/t5556-http-auth.sh: test_expect_success 'http auth anonymous no challenge' '
      +	protocol=http
      +	host=$HOST_PORT
      +	username=alice
     -+	password=invalid-token
     -+	authtype=bearer
     ++	password=invalid-passwd
      +	EOF
      +
      +	test_must_fail git -c credential.helper="$CREDENTIAL_HELPER" ls-remote $ORIGIN_URL &&

-- 
gitgitgadget
