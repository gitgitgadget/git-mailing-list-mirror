Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB89C43217
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 22:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiKBWJp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 18:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiKBWJi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 18:09:38 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB3530E
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 15:09:34 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id i5-20020a1c3b05000000b003cf47dcd316so2150567wma.4
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 15:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMVr80tK87my+hGfXNqdyWYklYdolvw3MspETBTuJpI=;
        b=oc/Sm71QafsFTQQcqxTEvc9zAgYFKFR9U3DndyGThez8Y1C4uiSlrMPVW4iYSqU+wF
         gtrBiCM9NcPYjRaC58Brtif3KfYDcbyjGM7XGiGSfIwlGhx7Nduwsz5rwTzhlUht98Pi
         QCNkLQqqItAyd+A0kNcOOBir8jUKsGdTde9fu4xM8TKiK6TzU/midspAOqif9Ot1DUFj
         kZjxnthm+h1z36erxS+y0G/VOimHaVWJkBzgjPy4MabFyILo0/oW0RnbgClzPxQnFbCI
         ETA/9PQGUFHjKKJM87pOZXISewZCLLRwjfvhxLfLJdyBuhObmL0rCBmkcQSfFDY0s/Zq
         BqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMVr80tK87my+hGfXNqdyWYklYdolvw3MspETBTuJpI=;
        b=j5xQ/FKanKGV6ouSVmPMC43oXdv/Xi1nlbtVXdd97XSY5eJ/eoX1YOhp3eHTDj55dq
         Un1oC121zdr33Mv2KWu28FwAM9QSYXMCYtqLmVKy8St8ZW+owcPz/3Bn1kz25UXXSEa+
         a3KQVLrirMzTWT1eMEpGd24VQ53QRO1QRvJrv4TkC5XtO+AAqae22mT2cYnLm/wU1xzg
         bIZpBo9kDaxNlAt5R54GCu/pKcQD7gyWgHvmRTdVafohJsy9zWa+Mpog6ex/Co93mYK1
         TdV6IBU8mkHw6zu9jpWctTbQo3olydK8JeLoEdIdFCDskMtItseeX5FmPLGj0a84TAmL
         rfVg==
X-Gm-Message-State: ACrzQf0YneVnTTVcVTe/0VPRC1a+EEJ3GPeWDndvYZJs/xXACdnVHx+4
        InVBESqDi049AweTXt+deOi6Lc5fFhw=
X-Google-Smtp-Source: AMsMyM5Z+TAJUYLvhkfOBO2SJsHIJMXdPeBZSPrZBNiaOUwATjzGJSEgfDSNIkGmk9jJY16YxlJsHw==
X-Received: by 2002:a05:600c:524c:b0:3cc:ed19:707 with SMTP id fc12-20020a05600c524c00b003cced190707mr17535221wmb.80.1667426971952;
        Wed, 02 Nov 2022 15:09:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v16-20020a05600c445000b003cf78aafdd7sm3604701wmn.39.2022.11.02.15.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 15:09:31 -0700 (PDT)
Message-Id: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
References: <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Nov 2022 22:09:18 +0000
Subject: [PATCH v3 00/11] Enhance credential helper protocol to include auth headers
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


Updates in v3
=============

 * Split final patch that added the test-http-server in to several, easier
   to review patches.

 * Updated wording in git-credential.txt to clarify which side of the
   credential helper protocol is sending/receiving the new wwwauth and
   authtype attributes.

Matthew John Cheetham (11):
  http: read HTTP WWW-Authenticate response headers
  credential: add WWW-Authenticate header to cred requests
  http: store all request headers on active_request_slot
  http: move proactive auth to first slot creation
  http: set specific auth scheme depending on credential
  test-http-server: add stub HTTP server test helper
  test-http-server: add HTTP error response function
  test-http-server: add HTTP request parsing
  test-http-server: pass Git requests to http-backend
  test-http-server: add simple authentication
  t5556: add HTTP authentication tests

 Documentation/git-credential.txt          |   29 +-
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
 t/helper/test-http-server.c               | 1146 +++++++++++++++++++++
 t/t5556-http-auth.sh                      |  260 +++++
 15 files changed, 1717 insertions(+), 137 deletions(-)
 create mode 100755 t/helper/test-credential-helper-replay.sh
 create mode 100644 t/helper/test-http-server.c
 create mode 100755 t/t5556-http-auth.sh


base-commit: 9c32cfb49c60fa8173b9666db02efe3b45a8522f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1352%2Fmjcheetham%2Femu-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1352/mjcheetham/emu-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1352

Range-diff vs v2:

  1:  f297c78f60a =  1:  f297c78f60a http: read HTTP WWW-Authenticate response headers
  2:  0838d992744 !  2:  e45e23406a5 credential: add WWW-Authenticate header to cred requests
     @@ Commit message
          C-style array syntax is used in the property name to denote multiple
          ordered values for the same property.
      
     -    In this case we send multiple `wwwauth[n]` properties where `n` is a
     -    zero-indexed number, reflecting the order the WWW-Authenticate headers
     -    appeared in the HTTP response.
     +    In this case we send multiple `wwwauth[]` properties where the order
     +    that the repeated attributes appear in the conversation reflects the
     +    order that the WWW-Authenticate headers appeared in the HTTP response.
      
          [1] https://datatracker.ietf.org/doc/html/rfc2616#section-14.47
      
          Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
      
       ## Documentation/git-credential.txt ##
     +@@ Documentation/git-credential.txt: separated by an `=` (equals) sign, followed by a newline.
     + The key may contain any bytes except `=`, newline, or NUL. The value may
     + contain any bytes except newline or NUL.
     + 
     +-In both cases, all bytes are treated as-is (i.e., there is no quoting,
     ++Attributes with keys that end with C-style array brackets `[]` can have
     ++multiple values. Each instance of a multi-valued attribute forms an
     ++ordered list of values - the order of the repeated attributes defines
     ++the order of the values. An empty multi-valued attribute (`key[]=\n`)
     ++acts to clear any previous entries and reset the list.
     ++
     ++In all cases, all bytes are treated as-is (i.e., there is no quoting,
     + and one cannot transmit a value with newline or NUL in it). The list of
     + attributes is terminated by a blank line or end-of-file.
     + 
      @@ Documentation/git-credential.txt: empty string.
       Components which are missing from the URL (e.g., there is no
       username in the example above) will be left unset.
       
      +`wwwauth[]`::
      +
     -+	When an HTTP response is received that includes one or more
     -+	'WWW-Authenticate' authentication headers, these can be passed to Git
     -+	(and subsequent credential helpers) with these attributes.
     -+	Each 'WWW-Authenticate' header value should be passed as a separate
     -+	attribute 'wwwauth[]' where the order of the attributes is the same
     -+	as they appear in the HTTP response.
     ++	When an HTTP response is received by Git that includes one or more
     ++	'WWW-Authenticate' authentication headers, these will be passed by Git
     ++	to credential helpers.
     ++	Each 'WWW-Authenticate' header value is passed as a multi-valued
     ++	attribute 'wwwauth[]', where the order of the attributes is the same as
     ++	they appear in the HTTP response.
      +
       GIT
       ---
  3:  c62fef65f46 =  3:  65ac638b8a0 http: store all request headers on active_request_slot
  4:  a790c01f9f2 =  4:  4d75ca29cc5 http: move proactive auth to first slot creation
  5:  b0b7cd7ee5e !  5:  2f38427aa8d http: set specific auth scheme depending on credential
     @@ Commit message
      
       ## Documentation/git-credential.txt ##
      @@ Documentation/git-credential.txt: username in the example above) will be left unset.
     - 	attribute 'wwwauth[]' where the order of the attributes is the same
     - 	as they appear in the HTTP response.
     + 	attribute 'wwwauth[]', where the order of the attributes is the same as
     + 	they appear in the HTTP response.
       
      +`authtype`::
      +
     -+	Indicates the type of authentication scheme used. If this is not
     -+	present the default is "Basic".
     ++	Indicates the type of authentication scheme that should be used by Git.
     ++	Credential helpers may reply to a request from Git with this attribute,
     ++	such that subsequent authenticated requests include the correct
     ++	`Authorization` header.
     ++	If this attribute is not present, the default value is "Basic".
      +	Known values include "Basic", "Digest", and "Bearer".
      +	If an unknown value is provided, this is taken as the authentication
      +	scheme for the `Authorization` header, and the `password` field is
  6:  f3f13ed8c82 !  6:  4947e81546a t5556-http-auth: add test for HTTP auth hdr logic
     @@ Metadata
      Author: Matthew John Cheetham <mjcheetham@outlook.com>
      
       ## Commit message ##
     -    t5556-http-auth: add test for HTTP auth hdr logic
     +    test-http-server: add stub HTTP server test helper
      
     -    Add a series of tests to exercise the HTTP authentication header parsing
     -    and the interop with credential helpers. Credential helpers can respond
     -    to requests that contain WWW-Authenticate information with the ability
     -    to select the response Authenticate header scheme.
     +    Introduce a mini HTTP server helper that in the future will be enhanced
     +    to provide a frontend for the git-http-backend, with support for
     +    arbitrary authentication schemes.
      
     -    Introduce a mini HTTP server helper that provides a frontend for the
     -    git-http-backend, with support for arbitrary authentication schemes.
     -    The test-http-server is based heavily on the git-daemon, and forwards
     -    all successfully authenticated requests to the http-backend.
     +    Right now, test-http-server is a pared-down copy of the git-daemon that
     +    always returns a 501 Not Implemented response to all callers.
      
          Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
      
     @@ t/helper/.gitignore
      @@
       /test-tool
       /test-fake-ssh
     -+test-http-server
     -
     - ## t/helper/test-credential-helper-replay.sh (new) ##
     -@@
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
     ++/test-http-server
      
       ## t/helper/test-http-server.c (new) ##
      @@
     @@ t/helper/test-http-server.c (new)
      +"           [--timeout=<n>] [--init-timeout=<n>] [--max-connections=<n>]\n"
      +"           [--reuseaddr] [--pid-file=<file>]\n"
      +"           [--listen=<host_or_ipaddr>]* [--port=<n>]\n"
     -+"           [--anonymous-allowed]\n"
     -+"           [--auth=<scheme>[:<params>] [--auth-token=<scheme>:<token>]]*\n"
      +;
      +
      +/* Timeout, and initial timeout */
     @@ t/helper/test-http-server.c (new)
      +	}
      +}
      +
     -+//////////////////////////////////////////////////////////////////
     -+// The code in this section is used by "worker" instances to service
     -+// a single connection from a client.  The worker talks to the client
     -+// on 0 and 1.
     -+//////////////////////////////////////////////////////////////////
     ++/*
     ++ * The code in this section is used by "worker" instances to service
     ++ * a single connection from a client.  The worker talks to the client
     ++ * on 0 and 1.
     ++ */
      +
      +enum worker_result {
      +	/*
     @@ t/helper/test-http-server.c (new)
      +	 * Caller *might* keep the socket open and allow keep-alive.
      +	 */
      +	WR_OK       = 0,
     ++
      +	/*
      +	 * Various errors while processing the request and/or the response.
      +	 * Close the socket and clean up.
      +	 * Exit child-process with non-zero status.
      +	 */
      +	WR_IO_ERROR = 1<<0,
     ++
      +	/*
      +	 * Close the socket and clean up.  Does not imply an error.
      +	 */
     @@ t/helper/test-http-server.c (new)
      +	WR_STOP_THE_MUSIC = (WR_IO_ERROR | WR_HANGUP),
      +};
      +
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
     -+	ssize_t content_length;
     -+};
     -+
     -+#define REQ__INIT { \
     -+	.start_line = STRBUF_INIT, \
     -+	.uri_path = STRBUF_INIT, \
     -+	.query_args = STRBUF_INIT, \
     -+	.header_list = STRING_LIST_INIT_NODUP, \
     -+	.content_type = NULL, \
     -+	.content_length = -1 \
     -+	}
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
     -+		strbuf_addf  (&response_header, "Retry-After: %d\r\n", retry_after_seconds);
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
     -+		result = WR_OK | WR_HANGUP;
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
     -+		result = WR_IO_ERROR;
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
     -+		result = WR_IO_ERROR;
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
     -+		/* store common request headers separately */
     -+		if (skip_prefix(hp, "Content-Type: ", &hv)) {
     -+			req->content_type = hv;
     -+		} else if (skip_prefix(hp, "Content-Length: ", &hv)) {
     -+			req->content_length = strtol(hv, &hp, 10);
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
     -+		if (req->content_length >= 0)
     -+			trace2_printf("%s: clen: %d", TR2_CAT, req->content_length);
     -+		if (req->content_type)
     -+			trace2_printf("%s: ctyp: %s", TR2_CAT, req->content_type);
     -+		for_each_string_list_item(item, &req->header_list)
     -+			trace2_printf("%s: hdrs: %s", TR2_CAT, item->string);
     -+	}
     -+
     -+	return result;
     -+}
     -+
     -+static int is_git_request(struct req *req)
     -+{
     -+	static regex_t *smart_http_regex;
     -+	static int initialized;
     -+
     -+	if (!initialized) {
     -+		smart_http_regex = xmalloc(sizeof(*smart_http_regex));
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
     -+static enum worker_result do__git(struct req *req, const char *user)
     -+{
     -+	const char *ok = "HTTP/1.1 200 OK\r\n";
     -+	struct child_process cp = CHILD_PROCESS_INIT;
     -+	int res;
     -+
     -+	if (write(1, ok, strlen(ok)) < 0)
     -+		return error(_("could not send '%s'"), ok);
     -+
     -+	if (user)
     -+		strvec_pushf(&cp.env, "REMOTE_USER=%s", user);
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
     -+	close(1);
     -+	close(0);
     -+	return !!res;
     -+}
     -+
     -+enum auth_result {
     -+	AUTH_UNKNOWN = 0,
     -+	AUTH_DENY = 1,
     -+	AUTH_ALLOW = 2,
     -+};
     -+
     -+struct auth_module {
     -+	const char *scheme;
     -+	const char *challenge_params;
     -+	struct string_list *tokens;
     -+};
     -+
     -+static int allow_anonymous;
     -+static struct auth_module **auth_modules = NULL;
     -+static size_t auth_modules_nr = 0;
     -+static size_t auth_modules_alloc = 0;
     -+
     -+static struct auth_module *get_auth_module(struct strbuf *scheme)
     -+{
     -+	int i;
     -+	struct auth_module *mod;
     -+	for (i = 0; i < auth_modules_nr; i++) {
     -+		mod = auth_modules[i];
     -+		if (!strcasecmp(mod->scheme, scheme->buf))
     -+			return mod;
     -+	}
     -+
     -+	return NULL;
     -+}
     -+
     -+static void add_auth_module(struct auth_module *mod)
     -+{
     -+	ALLOC_GROW(auth_modules, auth_modules_nr + 1, auth_modules_alloc);
     -+	auth_modules[auth_modules_nr++] = mod;
     -+}
     -+
     -+static int is_authed(struct req *req, const char **user, enum worker_result *wr)
     -+{
     -+	enum auth_result result = AUTH_UNKNOWN;
     -+	struct string_list hdrs = STRING_LIST_INIT_NODUP;
     -+	struct auth_module *mod;
     -+
     -+	struct string_list_item *hdr;
     -+	struct string_list_item *token;
     -+	const char *v;
     -+	struct strbuf **split = NULL;
     -+	int i;
     -+	char *challenge;
     -+
     -+	/* ask all auth modules to validate the request */
     -+	for_each_string_list_item(hdr, &req->header_list) {
     -+		if (skip_iprefix(hdr->string, "Authorization: ", &v)) {
     -+			split = strbuf_split_str(v, ' ', 2);
     -+			if (!split[0] || !split[1]) continue;
     -+
     -+			// trim trailing space ' '
     -+			strbuf_setlen(split[0], split[0]->len - 1);
     -+
     -+			mod = get_auth_module(split[0]);
     -+			if (mod) {
     -+
     -+				for_each_string_list_item(token, mod->tokens) {
     -+					if (!strcmp(split[1]->buf, token->string)) {
     -+						result = AUTH_ALLOW;
     -+						goto done;
     -+					}
     -+				}
     -+
     -+				if (result != AUTH_UNKNOWN)
     -+					goto done;
     -+			}
     -+		}
     -+	}
     -+
     -+done:
     -+	switch (result) {
     -+	case AUTH_ALLOW:
     -+		trace2_printf("%s: auth '%s' ALLOW", TR2_CAT, mod->scheme);
     -+		*user = "VALID_TEST_USER";
     -+		*wr = WR_OK;
     -+		break;
     -+
     -+	case AUTH_DENY:
     -+		trace2_printf("%s: auth '%s' DENY", TR2_CAT, mod->scheme);
     -+		/* fall-through */
     -+
     -+	case AUTH_UNKNOWN:
     -+		if (allow_anonymous)
     -+			break;
     -+		for (i = 0; i < auth_modules_nr; i++) {
     -+			mod = auth_modules[i];
     -+			if (mod->challenge_params)
     -+				challenge = xstrfmt("WWW-Authenticate: %s %s",
     -+						    mod->scheme,
     -+						    mod->challenge_params);
     -+			else
     -+				challenge = xstrfmt("WWW-Authenticate: %s",
     -+						    mod->scheme);
     -+			string_list_append(&hdrs, challenge);
     -+		}
     -+		*wr = send_http_error(1, 401, "Unauthorized", -1, &hdrs, *wr);
     -+	}
     -+
     -+	strbuf_list_free(split);
     -+	string_list_clear(&hdrs, 0);
     -+
     -+	return result == AUTH_ALLOW ||
     -+	      (result == AUTH_UNKNOWN && allow_anonymous);
     -+}
     -+
     -+static enum worker_result dispatch(struct req *req)
     -+{
     -+	enum worker_result wr = WR_OK;
     -+	const char *user = NULL;
     -+
     -+	if (!is_authed(req, &user, &wr))
     -+		return wr;
     -+
     -+	if (is_git_request(req))
     -+		return do__git(req, user);
     -+
     -+	return send_http_error(1, 501, "Not Implemented", -1, NULL,
     -+			       WR_OK | WR_HANGUP);
     -+}
     -+
      +static enum worker_result worker(void)
      +{
     -+	struct req req = REQ__INIT;
     ++	const char *response = "HTTP/1.1 501 Not Implemented\r\n";
      +	char *client_addr = getenv("REMOTE_ADDR");
      +	char *client_port = getenv("REMOTE_PORT");
      +	enum worker_result wr = WR_OK;
     @@ t/helper/test-http-server.c (new)
      +	set_keep_alive(0);
      +
      +	while (1) {
     -+		req__release(&req);
     -+
     -+		alarm(init_timeout ? init_timeout : timeout);
     -+		wr = req__read(&req, 0);
     -+		alarm(0);
     -+
     -+		if (wr & WR_STOP_THE_MUSIC)
     -+			break;
     ++		if (write_in_full(1, response, strlen(response)) < 0) {
     ++			logerror("unable to write response");
     ++			wr = WR_IO_ERROR;
     ++		}
      +
     -+		wr = dispatch(&req);
      +		if (wr & WR_STOP_THE_MUSIC)
      +			break;
      +	}
     @@ t/helper/test-http-server.c (new)
      +	return !!(wr & WR_IO_ERROR);
      +}
      +
     -+//////////////////////////////////////////////////////////////////
     -+// This section contains the listener and child-process management
     -+// code used by the primary instance to accept incoming connections
     -+// and dispatch them to async child process "worker" instances.
     -+//////////////////////////////////////////////////////////////////
     ++/*
     ++ * This section contains the listener and child-process management
     ++ * code used by the primary instance to accept incoming connections
     ++ * and dispatch them to async child process "worker" instances.
     ++ */
      +
      +static int addrcmp(const struct sockaddr_storage *s1,
      +		   const struct sockaddr_storage *s2)
     @@ t/helper/test-http-server.c (new)
      +
      +	set_keep_alive(sockfd);
      +
     -+	if ( bind(sockfd, (struct sockaddr *)&sin, sizeof sin) < 0 ) {
     ++	if (bind(sockfd, (struct sockaddr *)&sin, sizeof sin) < 0) {
      +		logerror("Could not bind to %s: %s",
      +			 ip2str(AF_INET, (struct sockaddr *)&sin, sizeof(sin)),
      +			 strerror(errno));
     @@ t/helper/test-http-server.c (new)
      +	return service_loop(&socklist);
      +}
      +
     -+//////////////////////////////////////////////////////////////////
     -+// This section is executed by both the primary instance and all
     -+// worker instances.  So, yes, each child-process re-parses the
     -+// command line argument and re-discovers how it should behave.
     -+//////////////////////////////////////////////////////////////////
     ++/*
     ++ * This section is executed by both the primary instance and all
     ++ * worker instances.  So, yes, each child-process re-parses the
     ++ * command line argument and re-discovers how it should behave.
     ++ */
      +
      +int cmd_main(int argc, const char **argv)
      +{
     @@ t/helper/test-http-server.c (new)
      +	struct string_list listen_addr = STRING_LIST_INIT_NODUP;
      +	int worker_mode = 0;
      +	int i;
     -+	struct auth_module *mod = NULL;
      +
      +	trace2_cmd_name("test-http-server");
      +	setup_git_directory_gently(NULL);
     @@ t/helper/test-http-server.c (new)
      +			pid_file = v;
      +			continue;
      +		}
     -+		if (skip_prefix(arg, "--allow-anonymous", &v)) {
     -+			allow_anonymous = 1;
     -+			continue;
     -+		}
     -+		if (skip_prefix(arg, "--auth=", &v)) {
     -+			struct strbuf **p = strbuf_split_str(v, ':', 2);
     -+
     -+			if (!p[0]) {
     -+				error("invalid argument '%s'", v);
     -+				usage(test_http_auth_usage);
     -+			}
     -+
     -+			// trim trailing ':'
     -+			if (p[1])
     -+				strbuf_setlen(p[0], p[0]->len - 1);
     -+
     -+			if (get_auth_module(p[0])) {
     -+				error("duplicate auth scheme '%s'\n", p[0]->buf);
     -+				usage(test_http_auth_usage);
     -+			}
     -+
     -+			mod = xmalloc(sizeof(struct auth_module));
     -+			mod->scheme = xstrdup(p[0]->buf);
     -+			mod->challenge_params = p[1] ? xstrdup(p[1]->buf) : NULL;
     -+			mod->tokens = xmalloc(sizeof(struct string_list));
     -+			string_list_init_dup(mod->tokens);
     -+
     -+			add_auth_module(mod);
     -+
     -+			strbuf_list_free(p);
     -+			continue;
     -+		}
     -+		if (skip_prefix(arg, "--auth-token=", &v)) {
     -+			struct strbuf **p = strbuf_split_str(v, ':', 2);
     -+			if (!p[0]) {
     -+				error("invalid argument '%s'", v);
     -+				usage(test_http_auth_usage);
     -+			}
     -+
     -+			if (!p[1]) {
     -+				error("missing token value '%s'\n", v);
     -+				usage(test_http_auth_usage);
     -+			}
     -+
     -+			// trim trailing ':'
     -+			strbuf_setlen(p[0], p[0]->len - 1);
     -+
     -+			mod = get_auth_module(p[0]);
     -+			if (!mod) {
     -+				error("auth scheme not defined '%s'\n", p[0]->buf);
     -+				usage(test_http_auth_usage);
     -+			}
     -+
     -+			string_list_append(mod->tokens, p[1]->buf);
     -+			strbuf_list_free(p);
     -+			continue;
     -+		}
      +
      +		fprintf(stderr, "error: unknown argument '%s'\n", arg);
      +		usage(test_http_auth_usage);
     @@ t/helper/test-http-server.c (new)
      +	 */
      +	return serve(&listen_addr, listen_port);
      +}
     -
     - ## t/t5556-http-auth.sh (new) ##
     -@@
     -+#!/bin/sh
     -+
     -+test_description='test http auth header and credential helper interop'
     -+
     -+. ./test-lib.sh
     -+
     -+test_set_port GIT_TEST_HTTP_PROTOCOL_PORT
     -+
     -+# Setup a repository
     -+#
     -+REPO_DIR="$(pwd)"/repo
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
     -+PID_FILE="$(pwd)"/pid-file.pid
     -+SERVER_LOG="$(pwd)"/OUT.server.log
     -+
     -+PATH="$GIT_BUILD_DIR/t/helper/:$PATH" && export PATH
     -+CREDENTIAL_HELPER="$GIT_BUILD_DIR/t/helper/test-credential-helper-replay.sh" \
     -+	&& export CREDENTIAL_HELPER
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
     -+	rm -f OUT.* &&
     -+	rm -f *.cred
     -+}
     -+
     -+test_expect_success 'http auth anonymous no challenge' '
     -+	test_when_finished "per_test_cleanup" &&
     -+	start_http_server --allow-anonymous &&
     -+
     -+	# Attempt to read from a protected repository
     -+	git ls-remote $ORIGIN_URL
     -+'
     -+
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
     -+test_expect_success 'http auth www-auth headers to credential helper basic valid' '
     -+	test_when_finished "per_test_cleanup" &&
     -+	# base64("alice:secret-passwd")
     -+	USERPASS64=YWxpY2U6c2VjcmV0LXBhc3N3ZA== &&
     -+	export USERPASS64 &&
     -+
     -+	start_http_server \
     -+		--auth=bearer:authority=\"id.example.com\"\ q=1\ p=0 \
     -+		--auth=basic:realm=\"example.com\" \
     -+		--auth-token=basic:$USERPASS64 &&
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
     -+	password=secret-passwd
     -+	authtype=basic
     -+	EOF
     -+
     -+	cat >get-response.cred <<-EOF &&
     -+	protocol=http
     -+	host=$HOST_PORT
     -+	username=alice
     -+	password=secret-passwd
     -+	authtype=basic
     -+	EOF
     -+
     -+	git -c credential.helper="$CREDENTIAL_HELPER" ls-remote $ORIGIN_URL &&
     -+
     -+	test_cmp get-expected.cred get-actual.cred &&
     -+	test_cmp store-expected.cred store-actual.cred
     -+'
     -+
     -+test_expect_success 'http auth www-auth headers to credential helper custom scheme' '
     -+	test_when_finished "per_test_cleanup" &&
     -+	start_http_server \
     -+		--auth=foobar:alg=test\ widget=1 \
     -+		--auth=bearer:authority=\"id.example.com\"\ q=1\ p=0 \
     -+		--auth=basic:realm=\"example.com\" \
     -+		--auth-token=foobar:SECRET-FOOBAR-VALUE &&
     -+
     -+	cat >get-expected.cred <<-EOF &&
     -+	protocol=http
     -+	host=$HOST_PORT
     -+	wwwauth[]=foobar alg=test widget=1
     -+	wwwauth[]=bearer authority="id.example.com" q=1 p=0
     -+	wwwauth[]=basic realm="example.com"
     -+	EOF
     -+
     -+	cat >store-expected.cred <<-EOF &&
     -+	protocol=http
     -+	host=$HOST_PORT
     -+	username=alice
     -+	password=SECRET-FOOBAR-VALUE
     -+	authtype=foobar
     -+	EOF
     -+
     -+	cat >get-response.cred <<-EOF &&
     -+	protocol=http
     -+	host=$HOST_PORT
     -+	username=alice
     -+	password=SECRET-FOOBAR-VALUE
     -+	authtype=foobar
     -+	EOF
     -+
     -+	git -c credential.helper="$CREDENTIAL_HELPER" ls-remote $ORIGIN_URL &&
     -+
     -+	test_cmp get-expected.cred get-actual.cred &&
     -+	test_cmp store-expected.cred store-actual.cred
     -+'
     -+
     -+test_expect_success 'http auth www-auth headers to credential helper invalid' '
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
     -+	cat >erase-expected.cred <<-EOF &&
     -+	protocol=http
     -+	host=$HOST_PORT
     -+	username=alice
     -+	password=invalid-token
     -+	authtype=bearer
     -+	wwwauth[]=bearer authority="id.example.com" q=1 p=0
     -+	wwwauth[]=basic realm="example.com"
     -+	EOF
     -+
     -+	cat >get-response.cred <<-EOF &&
     -+	protocol=http
     -+	host=$HOST_PORT
     -+	username=alice
     -+	password=invalid-token
     -+	authtype=bearer
     -+	EOF
     -+
     -+	test_must_fail git -c credential.helper="$CREDENTIAL_HELPER" ls-remote $ORIGIN_URL &&
     -+
     -+	test_cmp get-expected.cred get-actual.cred &&
     -+	test_cmp erase-expected.cred erase-actual.cred
     -+'
     -+
     -+test_done
  -:  ----------- >  7:  93bdf1d7060 test-http-server: add HTTP error response function
  -:  ----------- >  8:  b3e9156755f test-http-server: add HTTP request parsing
  -:  ----------- >  9:  5fb248c074a test-http-server: pass Git requests to http-backend
  -:  ----------- > 10:  192f09b9de4 test-http-server: add simple authentication
  -:  ----------- > 11:  b64d2f2c473 t5556: add HTTP authentication tests

-- 
gitgitgadget
