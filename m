Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F01BC433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 17:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiJURIM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 13:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiJURIL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 13:08:11 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02D327D4C6
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 10:08:08 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n12so5902867wrp.10
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 10:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxynSPN3ScvJ1KjrD9IP5dfPyhMss0XSuvebfHpvVds=;
        b=VDZ/UVwqN6q2YYPzvU0FhKc4FTQO7h3z+ecndYLAw6PhL7H8xIsafiv6srXOv4c3fA
         GYITiOxf2+1gTpX6E2NHmk64JxIsYHE1jpbcrXgyPm/PudPXSXi4TBQDjKDvIIeA0Lgv
         3+f/oYktmqahYHrf+m/mqo4Ur9bqRNCaadfNJliW1yNM63dPx7vK6C9HZr27iuvGCilY
         O17qJcvUYjuhVCQ/LHFD6LhU+fnmaF1enDUt8Pt1TcuK4CC0DoW7YMVRP5ZckQG1XCyT
         MoIEHO565vK5jCDktReI5lVHUlhzpJ9pZNlGv+pymGiO8LAW5D9qElT7xcDEfNZZeAmD
         h7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxynSPN3ScvJ1KjrD9IP5dfPyhMss0XSuvebfHpvVds=;
        b=RcQYZbtaUbWbPNEEiqRTmGEcYpxtX0MDqW+7e5zmPQuubSbrN3e+l94qOBX6m91w3e
         CRuWVCEG82CMQi6zfKZLM63yQOWXebnltxAosgER8tJ3GtngA4x3XB7qBUngYG64pDi/
         i0TFT6W8qRLQLqM3d637hTbIFo2DlrFOYslQlwYBsayYXhhAGuWaja+O3s9u/846fIoL
         HsEfMCstfK8NcnIjKPG0O3XoDr3C29pkUqb4ThSDmGYg5XvALUjW2Y3mYUG1szwFkPyk
         OhHBKPNxjql0itfJH+6nsSicaMH1pcE21Jp7h6oYy8fB5m8syqH9/fMXFiEMZYnajyI6
         VoMg==
X-Gm-Message-State: ACrzQf2kwPBx1I8nt2G7XnEg+FWNGn1k/9jz7zDbeckfYgYeprTAfsjJ
        fi8GmsLVZBmCtSRxHiy3TKO7t6eY6C8=
X-Google-Smtp-Source: AMsMyM4+jFMXg342R6tftergH4+rJ5ZgVAVFXfSK1tC2hWtWJJqg3M8XfduQKc8SJ3N2QieJD7Oy+A==
X-Received: by 2002:adf:ba01:0:b0:22e:7318:4e94 with SMTP id o1-20020adfba01000000b0022e73184e94mr13311289wrg.330.1666372086591;
        Fri, 21 Oct 2022 10:08:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c4e8800b003b435c41103sm278287wmq.0.2022.10.21.10.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 10:08:05 -0700 (PDT)
Message-Id: <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
References: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 17:07:57 +0000
Subject: [PATCH v2 0/6] Enhance credential helper protocol to include auth headers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
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
   
   * Leverage newest identity standards, enhancements, and threat
     mitigations - all without updating Git.
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

 3. Teach Git to specify authentication schemes other than Basic in
    subsequent HTTP requests based on credential helper responses.


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



Future flexibility
==================

By allowing the credential helpers decide the best authentication scheme, we
can allow the remote Git server to both offer new schemes (or remove old
ones) that enlightened credential helpers could take immediate advantage of,
and to use credentials that are much more tightly scoped and bound to the
specific request.

For example imagine a new "FooBar" authentication scheme that is surfaced in
the following response:

HTTP/1.1 401 Unauthorized
WWW-Authenticate: FooBar realm="login.example", algs="ES256 PS256"


With support for arbitrary authentication schemes, Git would call credential
helpers with the following over standard input:

protocol=https
host=example.com
wwwauth[]=FooBar realm="login.example", algs="ES256 PS256", nonce="abc123"


And then an enlightened credential helper would return over standard output:

protocol=https
host=example.com
authtype=FooBar
username=bob@id.example.com
password=<FooBar credential>


Git would be expected to attach this authorization header to the next
request:

GET /info/refs?service=git-upload-pack HTTP/1.1
Host: git.example
Git-Protocol: version=2
Authorization: FooBar <FooBar credential>



Should Git not control the set of authentication schemes?
=========================================================

One concern that the reader may have regarding these changes is in allowing
helpers to select the authentication mechanism to use, it may be possible
that a weaker form of authentication is used.

Take for example a Git remote server that responds with the following
authentication schemes:

HTTP/1.1 401 Unauthorized
WWW-Authenticate: Negotiate ...
WWW-Authenticate: Basic ...


Today Git (and libcurl) prefer to Negotiate over Basic authentication [13].
If a helper responded with authtype=basic Git would now be using a "less
secure" mechanism.

The reason we still propose the credential helper decide on the
authentication scheme is that Git is not the best placed entity to decide
what type of authentication should be used for a particular request (see
Design Principle 3).

OAuth Bearer tokens are often bundled in Basic Authorization headers [14],
but given that the tokens are/can be short-lived and have a highly scoped
set of permissions, this solution could be argued as being more secure than
something like NTLM [15]. Similarly, the user may wish to be consulted on
selecting a particular user account, or directly selecting an authentication
mechanism for a request that otherwise they would not be able to use.

Also, as new authentication protocols appear Git does not need to be
modified or updated for the user to take advantage of them; the credential
helpers take on the responsibility of learning and selecting the "best"
option.


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

 * [13] libcurl http.c pickoneauth Function
   https://github.com/curl/curl/blob/c495dcd02e885fc3f35164b1c3c5f72fa4b60c46/lib/http.c#L381-L416

 * [14] Git Credential Manager GitHub Host Provider (using PAT as password)
   https://github.com/GitCredentialManager/git-credential-manager/blob/f77b766f6875b90251249f2aa1702b921309cf00/src/shared/GitHub/GitHubHostProvider.cs#L157

 * [15] NT LAN Manager (NTLM) Authentication Protocol
   https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-nlmp/b38c36ed-2804-4868-a9ff-8dd3182128e4


Updates from RFC
================

 * Submitted first three patches as separate submission:
   https://lore.kernel.org/git/pull.1363.git.1663865974.gitgitgadget@gmail.com/

 * Various style fixes and updates to- and addition of comments.

 * Drop the explicit integer index in new 'array' style credential helper
   attrbiutes ("key[n]=value" becomes just "key[]=value").

 * Added test helper; a mini HTTP server, and several tests.

Matthew John Cheetham (6):
  http: read HTTP WWW-Authenticate response headers
  credential: add WWW-Authenticate header to cred requests
  http: store all request headers on active_request_slot
  http: move proactive auth to first slot creation
  http: set specific auth scheme depending on credential
  t5556-http-auth: add test for HTTP auth hdr logic

 Documentation/git-credential.txt          |   18 +
 Makefile                                  |    2 +
 contrib/buildsystems/CMakeLists.txt       |   13 +
 credential.c                              |   18 +
 credential.h                              |   16 +
 git-curl-compat.h                         |   10 +
 http-push.c                               |  103 +-
 http-walker.c                             |    2 +-
 http.c                                    |  200 +++-
 http.h                                    |    4 +-
 remote-curl.c                             |   36 +-
 t/helper/.gitignore                       |    1 +
 t/helper/test-credential-helper-replay.sh |   14 +
 t/helper/test-http-server.c               | 1134 +++++++++++++++++++++
 t/t5556-http-auth.sh                      |  260 +++++
 15 files changed, 1695 insertions(+), 136 deletions(-)
 create mode 100755 t/helper/test-credential-helper-replay.sh
 create mode 100644 t/helper/test-http-server.c
 create mode 100755 t/t5556-http-auth.sh


base-commit: 9c32cfb49c60fa8173b9666db02efe3b45a8522f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1352%2Fmjcheetham%2Femu-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1352/mjcheetham/emu-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1352

Range-diff vs v1:

 1:  6426f9c3954 < -:  ----------- wincred: ignore unknown lines (do not die)
 2:  ae5c1bfc092 < -:  ----------- netrc: ignore unknown lines (do not die)
 3:  2ece562a595 < -:  ----------- osxkeychain: clarify that we ignore unknown lines
 4:  78e66d56605 ! 1:  f297c78f60a http: read HTTP WWW-Authenticate response headers
     @@ credential.h: struct credential {
      +	 * in the order they were received in the response.
      +	 */
      +	struct strvec wwwauth_headers;
     ++
     ++	/**
     ++	 * Internal use only. Used to keep track of split header fields
     ++	 * in order to fold multiple lines into one value.
     ++	 */
      +	unsigned header_is_last_match:1;
      +
       	unsigned approved:1,
     @@ http.c: size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buff
      +
      +	/* Start of a new WWW-Authenticate header */
      +	if (skip_iprefix(buf.buf, "www-authenticate:", &val)) {
     -+		while (isspace(*val)) val++;
     ++		while (isspace(*val))
     ++			val++;
      +
      +		strvec_push(values, val);
      +		http_auth.header_is_last_match = 1;
 5:  936545004b8 ! 2:  0838d992744 credential: add WWW-Authenticate header to cred requests
     @@ Commit message
          Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
      
       ## Documentation/git-credential.txt ##
     -@@ Documentation/git-credential.txt: Git understands the following attributes:
     - 	were read (e.g., `url=https://example.com` would behave as if
     - 	`protocol=https` and `host=example.com` had been provided). This
     - 	can help callers avoid parsing URLs themselves.
     -+
     -+`wwwauth[n]`::
     +@@ Documentation/git-credential.txt: empty string.
     + Components which are missing from the URL (e.g., there is no
     + username in the example above) will be left unset.
     + 
     ++`wwwauth[]`::
      +
      +	When an HTTP response is received that includes one or more
      +	'WWW-Authenticate' authentication headers, these can be passed to Git
      +	(and subsequent credential helpers) with these attributes.
      +	Each 'WWW-Authenticate' header value should be passed as a separate
     -+	attribute 'wwwauth[n]' where 'n' is the zero-indexed order the headers
     -+	appear in the HTTP response.
     - +
     - Note that specifying a protocol is mandatory and if the URL
     - doesn't specify a hostname (e.g., "cert:///path/to/file") the
     ++	attribute 'wwwauth[]' where the order of the attributes is the same
     ++	as they appear in the HTTP response.
     ++
     + GIT
     + ---
     + Part of the linkgit:git[1] suite
      
       ## credential.c ##
      @@ credential.c: static void credential_write_item(FILE *fp, const char *key, const char *value,
     @@ credential.c: static void credential_write_item(FILE *fp, const char *key, const
      +				    const struct strvec *vec)
      +{
      +	int i = 0;
     ++	const char *full_key = xstrfmt("%s[]", key);
      +	for (; i < vec->nr; i++) {
     -+		const char *full_key = xstrfmt("%s[%d]", key, i);
      +		credential_write_item(fp, full_key, vec->v[i], 0);
     -+		free((void*)full_key);
      +	}
     ++	free((void*)full_key);
      +}
      +
       void credential_write(const struct credential *c, FILE *fp)
     @@ credential.c: void credential_write(const struct credential *c, FILE *fp)
       }
       
       static int run_credential_helper(struct credential *c,
     -
     - ## t/lib-httpd/apache.conf ##
     -@@ t/lib-httpd/apache.conf: SSLEngine On
     - 	Require valid-user
     - </LocationMatch>
     - 
     -+# Advertise two additional auth methods above "Basic".
     -+# Neither of them actually work but serve test cases showing these
     -+# additional auth headers are consumed correctly.
     -+<Location /auth-wwwauth/>
     -+	AuthType Basic
     -+	AuthName "git-auth"
     -+	AuthUserFile passwd
     -+	Require valid-user
     -+	SetEnvIf Authorization "^\S+" authz
     -+	Header always add WWW-Authenticate "Bearer authority=https://login.example.com" env=!authz
     -+	Header always add WWW-Authenticate "FooAuth foo=bar baz=1" env=!authz
     -+</Location>
     -+
     - RewriteCond %{QUERY_STRING} service=git-receive-pack [OR]
     - RewriteCond %{REQUEST_URI} /git-receive-pack$
     - RewriteRule ^/half-auth-complete/ - [E=AUTHREQUIRED:yes]
     -
     - ## t/t5551-http-fetch-smart.sh ##
     -@@ t/t5551-http-fetch-smart.sh: test_expect_success 'http auth forgets bogus credentials' '
     - 	expect_askpass both user@host
     - '
     - 
     -+test_expect_success 'http auth sends www-auth headers to credential helper' '
     -+	write_script git-credential-tee <<-\EOF &&
     -+		cmd=$1
     -+		teefile=credential-$cmd
     -+		if [ -f "$teefile" ]; then
     -+			rm $teefile
     -+		fi
     -+		(
     -+			while read line;
     -+			do
     -+				if [ -z "$line" ]; then
     -+					exit 0
     -+				fi
     -+				echo "$line" >> $teefile
     -+				echo $line
     -+			done
     -+		) | git credential-store $cmd
     -+	EOF
     -+
     -+	cat >expected-get <<-EOF &&
     -+	protocol=http
     -+	host=127.0.0.1:5551
     -+	wwwauth[0]=Bearer authority=https://login.example.com
     -+	wwwauth[1]=FooAuth foo=bar baz=1
     -+	wwwauth[2]=Basic realm="git-auth"
     -+	EOF
     -+
     -+	cat >expected-store <<-EOF &&
     -+	protocol=http
     -+	host=127.0.0.1:5551
     -+	username=user@host
     -+	password=pass@host
     -+	EOF
     -+
     -+	rm -f .git-credentials &&
     -+	test_config credential.helper tee &&
     -+	set_askpass user@host pass@host &&
     -+	(
     -+		PATH="$PWD:$PATH" &&
     -+		git ls-remote "$HTTPD_URL/auth-wwwauth/smart/repo.git"
     -+	) &&
     -+	expect_askpass both user@host &&
     -+	test_cmp expected-get credential-get &&
     -+	test_cmp expected-store credential-store
     -+'
     -+
     - test_expect_success 'client falls back from v2 to v0 to match server' '
     - 	GIT_TRACE_PACKET=$PWD/trace \
     - 	GIT_TEST_PROTOCOL_VERSION=2 \
 6:  20843e2051e = 3:  c62fef65f46 http: store all request headers on active_request_slot
 7:  cae7180bc37 = 4:  a790c01f9f2 http: move proactive auth to first slot creation
 8:  7f827067f55 ! 5:  b0b7cd7ee5e http: set specific auth scheme depending on credential
     @@ Commit message
          Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
      
       ## Documentation/git-credential.txt ##
     -@@ Documentation/git-credential.txt: Git understands the following attributes:
     - 	`protocol=https` and `host=example.com` had been provided). This
     - 	can help callers avoid parsing URLs themselves.
     +@@ Documentation/git-credential.txt: username in the example above) will be left unset.
     + 	attribute 'wwwauth[]' where the order of the attributes is the same
     + 	as they appear in the HTTP response.
       
      +`authtype`::
      +
     @@ Documentation/git-credential.txt: Git understands the following attributes:
      +	scheme for the `Authorization` header, and the `password` field is
      +	used as the raw unencoded authorization parameters of the same header.
      +
     - `wwwauth[n]`::
     - 
     - 	When an HTTP response is received that includes one or more
     + GIT
     + ---
     + Part of the linkgit:git[1] suite
      
       ## credential.c ##
      @@ credential.c: void credential_clear(struct credential *c)
     @@ git-curl-compat.h
       
      +/**
      + * CURLAUTH_BEARER was added in 7.61.0, released in July 2018.
     ++ * However, only 7.69.0 fixes a bug where Bearer headers were not
     ++ * actually sent with reused connections on subsequent transfers
     ++ * (curl/curl@dea17b519dc1).
      + */
     -+#if LIBCURL_VERSION_NUM >= 0x073D00
     ++#if LIBCURL_VERSION_NUM >= 0x074500
      +#define GIT_CURL_HAVE_CURLAUTH_BEARER
      +#endif
      +
 -:  ----------- > 6:  f3f13ed8c82 t5556-http-auth: add test for HTTP auth hdr logic

-- 
gitgitgadget
