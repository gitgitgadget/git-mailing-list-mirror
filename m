Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D95E1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbeJ0PEg (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:36 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38763 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbeJ0PEf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:35 -0400
Received: by mail-lj1-f196.google.com with SMTP id k11-v6so3113949lja.5
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A1R7jgjH/mQMjuNtop0dsRB7++I5Y7UlbIyEFc4ZrXk=;
        b=PcoJRBfkzLdXXRV2oODkJShUYBSJpwvAZbk7blJobAg7az+MDA4jfNtEZRXbgcc14A
         XmzjIay/VEzzp2jplSwqfvcBgdKqbKMSGNDwBEIUM00Z4DoKh13BCBd5gZosct4LSMPG
         +/9eWr0/MjbnFSd2MRA0vit8YIxIQ0/La+gmv9UgfddAWKyiGAsJaoE11OvTYvQzo5Hn
         CZVZMclq3Psthewusxn8JLk8QWdNs4rJzRBy00koi8D11Dky/2w5Fq86tnzgGw+XjkPc
         5tDFLG/tjyY97R2MB4jhJ1bmYPjh6NQC7PPXCRuDGebTCChfjevjX42tzxSqTPqQBnzK
         ZrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A1R7jgjH/mQMjuNtop0dsRB7++I5Y7UlbIyEFc4ZrXk=;
        b=bc7g2/81/6OPr2gmbwePSEd/aCwVkloXVSuetUaIKmioPCVIRTCWMxOLpIBlWIY4l8
         b26o1o8qf06m34z2+u4pB8cU2aLy1q4bkVDhF1dwxjuqTyTwBf+G4uMHcwymGW0PXIB0
         x9karODTPzQpfg3Bv2RfsO8VUTcndNuo2H6iXuxTTRobYPSHwtUw6dFJrAxCgXbwbw0w
         NmqR2D7469lfZCN8qW7W7Xr4xrkOgMTV4x0TNwz3E09v7cMJbGhDqtCCdoHvVEOPdXnQ
         IhI8NU1E/V9SakvBO7r35fMim7oSKWCVXzMb5qfhOI/IqJkctMvTdllJ3QFT6Vrn4taE
         KgTw==
X-Gm-Message-State: AGRZ1gIyexhmSJdkBakqpIEVL6nI2Fh2IDxWLPliGKSEC4uYj10ud3i8
        bu8gj9xbhIsva0+kebQyjBcYOs1f
X-Google-Smtp-Source: AJdET5cOnVfZ+WvCSxkoUX+mfhu7psx+1ZS4ykxVL/Dhx6qWDWHxlbTai6wt6ag9dfbk5apltZ2Agw==
X-Received: by 2002:a2e:92ca:: with SMTP id k10-v6mr4122268ljh.103.1540621477104;
        Fri, 26 Oct 2018 23:24:37 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:35 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 35/78] config.txt: move http.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:08 +0200
Message-Id: <20181027062351.30446-36-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027062351.30446-1-pclouds@gmail.com>
References: <20181027062351.30446-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt      | 272 +---------------------------------
 Documentation/config/http.txt | 271 +++++++++++++++++++++++++++++++++
 2 files changed, 272 insertions(+), 271 deletions(-)
 create mode 100644 Documentation/config/http.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 60c2204fb4..11194e1851 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -349,277 +349,7 @@ include::config/guitool.txt[]
 
 include::config/help.txt[]
 
-http.proxy::
-	Override the HTTP proxy, normally configured using the 'http_proxy',
-	'https_proxy', and 'all_proxy' environment variables (see `curl(1)`). In
-	addition to the syntax understood by curl, it is possible to specify a
-	proxy string with a user name but no password, in which case git will
-	attempt to acquire one in the same way it does for other credentials. See
-	linkgit:gitcredentials[7] for more information. The syntax thus is
-	'[protocol://][user[:password]@]proxyhost[:port]'. This can be overridden
-	on a per-remote basis; see remote.<name>.proxy
-
-http.proxyAuthMethod::
-	Set the method with which to authenticate against the HTTP proxy. This
-	only takes effect if the configured proxy string contains a user name part
-	(i.e. is of the form 'user@host' or 'user@host:port'). This can be
-	overridden on a per-remote basis; see `remote.<name>.proxyAuthMethod`.
-	Both can be overridden by the `GIT_HTTP_PROXY_AUTHMETHOD` environment
-	variable.  Possible values are:
-+
---
-* `anyauth` - Automatically pick a suitable authentication method. It is
-  assumed that the proxy answers an unauthenticated request with a 407
-  status code and one or more Proxy-authenticate headers with supported
-  authentication methods. This is the default.
-* `basic` - HTTP Basic authentication
-* `digest` - HTTP Digest authentication; this prevents the password from being
-  transmitted to the proxy in clear text
-* `negotiate` - GSS-Negotiate authentication (compare the --negotiate option
-  of `curl(1)`)
-* `ntlm` - NTLM authentication (compare the --ntlm option of `curl(1)`)
---
-
-http.emptyAuth::
-	Attempt authentication without seeking a username or password.  This
-	can be used to attempt GSS-Negotiate authentication without specifying
-	a username in the URL, as libcurl normally requires a username for
-	authentication.
-
-http.delegation::
-	Control GSSAPI credential delegation. The delegation is disabled
-	by default in libcurl since version 7.21.7. Set parameter to tell
-	the server what it is allowed to delegate when it comes to user
-	credentials. Used with GSS/kerberos. Possible values are:
-+
---
-* `none` - Don't allow any delegation.
-* `policy` - Delegates if and only if the OK-AS-DELEGATE flag is set in the
-  Kerberos service ticket, which is a matter of realm policy.
-* `always` - Unconditionally allow the server to delegate.
---
-
-
-http.extraHeader::
-	Pass an additional HTTP header when communicating with a server.  If
-	more than one such entry exists, all of them are added as extra
-	headers.  To allow overriding the settings inherited from the system
-	config, an empty value will reset the extra headers to the empty list.
-
-http.cookieFile::
-	The pathname of a file containing previously stored cookie lines,
-	which should be used
-	in the Git http session, if they match the server. The file format
-	of the file to read cookies from should be plain HTTP headers or
-	the Netscape/Mozilla cookie file format (see `curl(1)`).
-	NOTE that the file specified with http.cookieFile is used only as
-	input unless http.saveCookies is set.
-
-http.saveCookies::
-	If set, store cookies received during requests to the file specified by
-	http.cookieFile. Has no effect if http.cookieFile is unset.
-
-http.sslVersion::
-	The SSL version to use when negotiating an SSL connection, if you
-	want to force the default.  The available and default version
-	depend on whether libcurl was built against NSS or OpenSSL and the
-	particular configuration of the crypto library in use. Internally
-	this sets the 'CURLOPT_SSL_VERSION' option; see the libcurl
-	documentation for more details on the format of this option and
-	for the ssl version supported. Actually the possible values of
-	this option are:
-
-	- sslv2
-	- sslv3
-	- tlsv1
-	- tlsv1.0
-	- tlsv1.1
-	- tlsv1.2
-	- tlsv1.3
-
-+
-Can be overridden by the `GIT_SSL_VERSION` environment variable.
-To force git to use libcurl's default ssl version and ignore any
-explicit http.sslversion option, set `GIT_SSL_VERSION` to the
-empty string.
-
-http.sslCipherList::
-  A list of SSL ciphers to use when negotiating an SSL connection.
-  The available ciphers depend on whether libcurl was built against
-  NSS or OpenSSL and the particular configuration of the crypto
-  library in use.  Internally this sets the 'CURLOPT_SSL_CIPHER_LIST'
-  option; see the libcurl documentation for more details on the format
-  of this list.
-+
-Can be overridden by the `GIT_SSL_CIPHER_LIST` environment variable.
-To force git to use libcurl's default cipher list and ignore any
-explicit http.sslCipherList option, set `GIT_SSL_CIPHER_LIST` to the
-empty string.
-
-http.sslVerify::
-	Whether to verify the SSL certificate when fetching or pushing
-	over HTTPS. Defaults to true. Can be overridden by the
-	`GIT_SSL_NO_VERIFY` environment variable.
-
-http.sslCert::
-	File containing the SSL certificate when fetching or pushing
-	over HTTPS. Can be overridden by the `GIT_SSL_CERT` environment
-	variable.
-
-http.sslKey::
-	File containing the SSL private key when fetching or pushing
-	over HTTPS. Can be overridden by the `GIT_SSL_KEY` environment
-	variable.
-
-http.sslCertPasswordProtected::
-	Enable Git's password prompt for the SSL certificate.  Otherwise
-	OpenSSL will prompt the user, possibly many times, if the
-	certificate or private key is encrypted.  Can be overridden by the
-	`GIT_SSL_CERT_PASSWORD_PROTECTED` environment variable.
-
-http.sslCAInfo::
-	File containing the certificates to verify the peer with when
-	fetching or pushing over HTTPS. Can be overridden by the
-	`GIT_SSL_CAINFO` environment variable.
-
-http.sslCAPath::
-	Path containing files with the CA certificates to verify the peer
-	with when fetching or pushing over HTTPS. Can be overridden
-	by the `GIT_SSL_CAPATH` environment variable.
-
-http.sslBackend::
-	Name of the SSL backend to use (e.g. "openssl" or "schannel").
-	This option is ignored if cURL lacks support for choosing the SSL
-	backend at runtime.
-
-http.schannelCheckRevoke::
-	Used to enforce or disable certificate revocation checks in cURL
-	when http.sslBackend is set to "schannel". Defaults to `true` if
-	unset. Only necessary to disable this if Git consistently errors
-	and the message is about checking the revocation status of a
-	certificate. This option is ignored if cURL lacks support for
-	setting the relevant SSL option at runtime.
-
-http.schannelUseSSLCAInfo::
-	As of cURL v7.60.0, the Secure Channel backend can use the
-	certificate bundle provided via `http.sslCAInfo`, but that would
-	override the Windows Certificate Store. Since this is not desirable
-	by default, Git will tell cURL not to use that bundle by default
-	when the `schannel` backend was configured via `http.sslBackend`,
-	unless `http.schannelUseSSLCAInfo` overrides this behavior.
-
-http.pinnedpubkey::
-	Public key of the https service. It may either be the filename of
-	a PEM or DER encoded public key file or a string starting with
-	'sha256//' followed by the base64 encoded sha256 hash of the
-	public key. See also libcurl 'CURLOPT_PINNEDPUBLICKEY'. git will
-	exit with an error if this option is set but not supported by
-	cURL.
-
-http.sslTry::
-	Attempt to use AUTH SSL/TLS and encrypted data transfers
-	when connecting via regular FTP protocol. This might be needed
-	if the FTP server requires it for security reasons or you wish
-	to connect securely whenever remote FTP server supports it.
-	Default is false since it might trigger certificate verification
-	errors on misconfigured servers.
-
-http.maxRequests::
-	How many HTTP requests to launch in parallel. Can be overridden
-	by the `GIT_HTTP_MAX_REQUESTS` environment variable. Default is 5.
-
-http.minSessions::
-	The number of curl sessions (counted across slots) to be kept across
-	requests. They will not be ended with curl_easy_cleanup() until
-	http_cleanup() is invoked. If USE_CURL_MULTI is not defined, this
-	value will be capped at 1. Defaults to 1.
-
-http.postBuffer::
-	Maximum size in bytes of the buffer used by smart HTTP
-	transports when POSTing data to the remote system.
-	For requests larger than this buffer size, HTTP/1.1 and
-	Transfer-Encoding: chunked is used to avoid creating a
-	massive pack file locally.  Default is 1 MiB, which is
-	sufficient for most requests.
-
-http.lowSpeedLimit, http.lowSpeedTime::
-	If the HTTP transfer speed is less than 'http.lowSpeedLimit'
-	for longer than 'http.lowSpeedTime' seconds, the transfer is aborted.
-	Can be overridden by the `GIT_HTTP_LOW_SPEED_LIMIT` and
-	`GIT_HTTP_LOW_SPEED_TIME` environment variables.
-
-http.noEPSV::
-	A boolean which disables using of EPSV ftp command by curl.
-	This can helpful with some "poor" ftp servers which don't
-	support EPSV mode. Can be overridden by the `GIT_CURL_FTP_NO_EPSV`
-	environment variable. Default is false (curl will use EPSV).
-
-http.userAgent::
-	The HTTP USER_AGENT string presented to an HTTP server.  The default
-	value represents the version of the client Git such as git/1.7.1.
-	This option allows you to override this value to a more common value
-	such as Mozilla/4.0.  This may be necessary, for instance, if
-	connecting through a firewall that restricts HTTP connections to a set
-	of common USER_AGENT strings (but not including those like git/1.7.1).
-	Can be overridden by the `GIT_HTTP_USER_AGENT` environment variable.
-
-http.followRedirects::
-	Whether git should follow HTTP redirects. If set to `true`, git
-	will transparently follow any redirect issued by a server it
-	encounters. If set to `false`, git will treat all redirects as
-	errors. If set to `initial`, git will follow redirects only for
-	the initial request to a remote, but not for subsequent
-	follow-up HTTP requests. Since git uses the redirected URL as
-	the base for the follow-up requests, this is generally
-	sufficient. The default is `initial`.
-
-http.<url>.*::
-	Any of the http.* options above can be applied selectively to some URLs.
-	For a config key to match a URL, each element of the config key is
-	compared to that of the URL, in the following order:
-+
---
-. Scheme (e.g., `https` in `https://example.com/`). This field
-  must match exactly between the config key and the URL.
-
-. Host/domain name (e.g., `example.com` in `https://example.com/`).
-  This field must match between the config key and the URL. It is
-  possible to specify a `*` as part of the host name to match all subdomains
-  at this level. `https://*.example.com/` for example would match
-  `https://foo.example.com/`, but not `https://foo.bar.example.com/`.
-
-. Port number (e.g., `8080` in `http://example.com:8080/`).
-  This field must match exactly between the config key and the URL.
-  Omitted port numbers are automatically converted to the correct
-  default for the scheme before matching.
-
-. Path (e.g., `repo.git` in `https://example.com/repo.git`). The
-  path field of the config key must match the path field of the URL
-  either exactly or as a prefix of slash-delimited path elements.  This means
-  a config key with path `foo/` matches URL path `foo/bar`.  A prefix can only
-  match on a slash (`/`) boundary.  Longer matches take precedence (so a config
-  key with path `foo/bar` is a better match to URL path `foo/bar` than a config
-  key with just path `foo/`).
-
-. User name (e.g., `user` in `https://user@example.com/repo.git`). If
-  the config key has a user name it must match the user name in the
-  URL exactly. If the config key does not have a user name, that
-  config key will match a URL with any user name (including none),
-  but at a lower precedence than a config key with a user name.
---
-+
-The list above is ordered by decreasing precedence; a URL that matches
-a config key's path is preferred to one that matches its user name. For example,
-if the URL is `https://user@example.com/foo/bar` a config key match of
-`https://example.com/foo` will be preferred over a config key match of
-`https://user@example.com`.
-+
-All URLs are normalized before attempting any matching (the password part,
-if embedded in the URL, is always ignored for matching purposes) so that
-equivalent URLs that are simply spelled differently will match properly.
-Environment variable settings always override any matches.  The URLs that are
-matched against are those given directly to Git commands.  This means any URLs
-visited as a result of a redirection do not participate in matching.
+include::config/http.txt[]
 
 i18n.commitEncoding::
 	Character encoding the commit messages are stored in; Git itself
diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
new file mode 100644
index 0000000000..a56d848bc0
--- /dev/null
+++ b/Documentation/config/http.txt
@@ -0,0 +1,271 @@
+http.proxy::
+	Override the HTTP proxy, normally configured using the 'http_proxy',
+	'https_proxy', and 'all_proxy' environment variables (see `curl(1)`). In
+	addition to the syntax understood by curl, it is possible to specify a
+	proxy string with a user name but no password, in which case git will
+	attempt to acquire one in the same way it does for other credentials. See
+	linkgit:gitcredentials[7] for more information. The syntax thus is
+	'[protocol://][user[:password]@]proxyhost[:port]'. This can be overridden
+	on a per-remote basis; see remote.<name>.proxy
+
+http.proxyAuthMethod::
+	Set the method with which to authenticate against the HTTP proxy. This
+	only takes effect if the configured proxy string contains a user name part
+	(i.e. is of the form 'user@host' or 'user@host:port'). This can be
+	overridden on a per-remote basis; see `remote.<name>.proxyAuthMethod`.
+	Both can be overridden by the `GIT_HTTP_PROXY_AUTHMETHOD` environment
+	variable.  Possible values are:
++
+--
+* `anyauth` - Automatically pick a suitable authentication method. It is
+  assumed that the proxy answers an unauthenticated request with a 407
+  status code and one or more Proxy-authenticate headers with supported
+  authentication methods. This is the default.
+* `basic` - HTTP Basic authentication
+* `digest` - HTTP Digest authentication; this prevents the password from being
+  transmitted to the proxy in clear text
+* `negotiate` - GSS-Negotiate authentication (compare the --negotiate option
+  of `curl(1)`)
+* `ntlm` - NTLM authentication (compare the --ntlm option of `curl(1)`)
+--
+
+http.emptyAuth::
+	Attempt authentication without seeking a username or password.  This
+	can be used to attempt GSS-Negotiate authentication without specifying
+	a username in the URL, as libcurl normally requires a username for
+	authentication.
+
+http.delegation::
+	Control GSSAPI credential delegation. The delegation is disabled
+	by default in libcurl since version 7.21.7. Set parameter to tell
+	the server what it is allowed to delegate when it comes to user
+	credentials. Used with GSS/kerberos. Possible values are:
++
+--
+* `none` - Don't allow any delegation.
+* `policy` - Delegates if and only if the OK-AS-DELEGATE flag is set in the
+  Kerberos service ticket, which is a matter of realm policy.
+* `always` - Unconditionally allow the server to delegate.
+--
+
+
+http.extraHeader::
+	Pass an additional HTTP header when communicating with a server.  If
+	more than one such entry exists, all of them are added as extra
+	headers.  To allow overriding the settings inherited from the system
+	config, an empty value will reset the extra headers to the empty list.
+
+http.cookieFile::
+	The pathname of a file containing previously stored cookie lines,
+	which should be used
+	in the Git http session, if they match the server. The file format
+	of the file to read cookies from should be plain HTTP headers or
+	the Netscape/Mozilla cookie file format (see `curl(1)`).
+	NOTE that the file specified with http.cookieFile is used only as
+	input unless http.saveCookies is set.
+
+http.saveCookies::
+	If set, store cookies received during requests to the file specified by
+	http.cookieFile. Has no effect if http.cookieFile is unset.
+
+http.sslVersion::
+	The SSL version to use when negotiating an SSL connection, if you
+	want to force the default.  The available and default version
+	depend on whether libcurl was built against NSS or OpenSSL and the
+	particular configuration of the crypto library in use. Internally
+	this sets the 'CURLOPT_SSL_VERSION' option; see the libcurl
+	documentation for more details on the format of this option and
+	for the ssl version supported. Actually the possible values of
+	this option are:
+
+	- sslv2
+	- sslv3
+	- tlsv1
+	- tlsv1.0
+	- tlsv1.1
+	- tlsv1.2
+	- tlsv1.3
+
++
+Can be overridden by the `GIT_SSL_VERSION` environment variable.
+To force git to use libcurl's default ssl version and ignore any
+explicit http.sslversion option, set `GIT_SSL_VERSION` to the
+empty string.
+
+http.sslCipherList::
+  A list of SSL ciphers to use when negotiating an SSL connection.
+  The available ciphers depend on whether libcurl was built against
+  NSS or OpenSSL and the particular configuration of the crypto
+  library in use.  Internally this sets the 'CURLOPT_SSL_CIPHER_LIST'
+  option; see the libcurl documentation for more details on the format
+  of this list.
++
+Can be overridden by the `GIT_SSL_CIPHER_LIST` environment variable.
+To force git to use libcurl's default cipher list and ignore any
+explicit http.sslCipherList option, set `GIT_SSL_CIPHER_LIST` to the
+empty string.
+
+http.sslVerify::
+	Whether to verify the SSL certificate when fetching or pushing
+	over HTTPS. Defaults to true. Can be overridden by the
+	`GIT_SSL_NO_VERIFY` environment variable.
+
+http.sslCert::
+	File containing the SSL certificate when fetching or pushing
+	over HTTPS. Can be overridden by the `GIT_SSL_CERT` environment
+	variable.
+
+http.sslKey::
+	File containing the SSL private key when fetching or pushing
+	over HTTPS. Can be overridden by the `GIT_SSL_KEY` environment
+	variable.
+
+http.sslCertPasswordProtected::
+	Enable Git's password prompt for the SSL certificate.  Otherwise
+	OpenSSL will prompt the user, possibly many times, if the
+	certificate or private key is encrypted.  Can be overridden by the
+	`GIT_SSL_CERT_PASSWORD_PROTECTED` environment variable.
+
+http.sslCAInfo::
+	File containing the certificates to verify the peer with when
+	fetching or pushing over HTTPS. Can be overridden by the
+	`GIT_SSL_CAINFO` environment variable.
+
+http.sslCAPath::
+	Path containing files with the CA certificates to verify the peer
+	with when fetching or pushing over HTTPS. Can be overridden
+	by the `GIT_SSL_CAPATH` environment variable.
+
+http.sslBackend::
+	Name of the SSL backend to use (e.g. "openssl" or "schannel").
+	This option is ignored if cURL lacks support for choosing the SSL
+	backend at runtime.
+
+http.schannelCheckRevoke::
+	Used to enforce or disable certificate revocation checks in cURL
+	when http.sslBackend is set to "schannel". Defaults to `true` if
+	unset. Only necessary to disable this if Git consistently errors
+	and the message is about checking the revocation status of a
+	certificate. This option is ignored if cURL lacks support for
+	setting the relevant SSL option at runtime.
+
+http.schannelUseSSLCAInfo::
+	As of cURL v7.60.0, the Secure Channel backend can use the
+	certificate bundle provided via `http.sslCAInfo`, but that would
+	override the Windows Certificate Store. Since this is not desirable
+	by default, Git will tell cURL not to use that bundle by default
+	when the `schannel` backend was configured via `http.sslBackend`,
+	unless `http.schannelUseSSLCAInfo` overrides this behavior.
+
+http.pinnedpubkey::
+	Public key of the https service. It may either be the filename of
+	a PEM or DER encoded public key file or a string starting with
+	'sha256//' followed by the base64 encoded sha256 hash of the
+	public key. See also libcurl 'CURLOPT_PINNEDPUBLICKEY'. git will
+	exit with an error if this option is set but not supported by
+	cURL.
+
+http.sslTry::
+	Attempt to use AUTH SSL/TLS and encrypted data transfers
+	when connecting via regular FTP protocol. This might be needed
+	if the FTP server requires it for security reasons or you wish
+	to connect securely whenever remote FTP server supports it.
+	Default is false since it might trigger certificate verification
+	errors on misconfigured servers.
+
+http.maxRequests::
+	How many HTTP requests to launch in parallel. Can be overridden
+	by the `GIT_HTTP_MAX_REQUESTS` environment variable. Default is 5.
+
+http.minSessions::
+	The number of curl sessions (counted across slots) to be kept across
+	requests. They will not be ended with curl_easy_cleanup() until
+	http_cleanup() is invoked. If USE_CURL_MULTI is not defined, this
+	value will be capped at 1. Defaults to 1.
+
+http.postBuffer::
+	Maximum size in bytes of the buffer used by smart HTTP
+	transports when POSTing data to the remote system.
+	For requests larger than this buffer size, HTTP/1.1 and
+	Transfer-Encoding: chunked is used to avoid creating a
+	massive pack file locally.  Default is 1 MiB, which is
+	sufficient for most requests.
+
+http.lowSpeedLimit, http.lowSpeedTime::
+	If the HTTP transfer speed is less than 'http.lowSpeedLimit'
+	for longer than 'http.lowSpeedTime' seconds, the transfer is aborted.
+	Can be overridden by the `GIT_HTTP_LOW_SPEED_LIMIT` and
+	`GIT_HTTP_LOW_SPEED_TIME` environment variables.
+
+http.noEPSV::
+	A boolean which disables using of EPSV ftp command by curl.
+	This can helpful with some "poor" ftp servers which don't
+	support EPSV mode. Can be overridden by the `GIT_CURL_FTP_NO_EPSV`
+	environment variable. Default is false (curl will use EPSV).
+
+http.userAgent::
+	The HTTP USER_AGENT string presented to an HTTP server.  The default
+	value represents the version of the client Git such as git/1.7.1.
+	This option allows you to override this value to a more common value
+	such as Mozilla/4.0.  This may be necessary, for instance, if
+	connecting through a firewall that restricts HTTP connections to a set
+	of common USER_AGENT strings (but not including those like git/1.7.1).
+	Can be overridden by the `GIT_HTTP_USER_AGENT` environment variable.
+
+http.followRedirects::
+	Whether git should follow HTTP redirects. If set to `true`, git
+	will transparently follow any redirect issued by a server it
+	encounters. If set to `false`, git will treat all redirects as
+	errors. If set to `initial`, git will follow redirects only for
+	the initial request to a remote, but not for subsequent
+	follow-up HTTP requests. Since git uses the redirected URL as
+	the base for the follow-up requests, this is generally
+	sufficient. The default is `initial`.
+
+http.<url>.*::
+	Any of the http.* options above can be applied selectively to some URLs.
+	For a config key to match a URL, each element of the config key is
+	compared to that of the URL, in the following order:
++
+--
+. Scheme (e.g., `https` in `https://example.com/`). This field
+  must match exactly between the config key and the URL.
+
+. Host/domain name (e.g., `example.com` in `https://example.com/`).
+  This field must match between the config key and the URL. It is
+  possible to specify a `*` as part of the host name to match all subdomains
+  at this level. `https://*.example.com/` for example would match
+  `https://foo.example.com/`, but not `https://foo.bar.example.com/`.
+
+. Port number (e.g., `8080` in `http://example.com:8080/`).
+  This field must match exactly between the config key and the URL.
+  Omitted port numbers are automatically converted to the correct
+  default for the scheme before matching.
+
+. Path (e.g., `repo.git` in `https://example.com/repo.git`). The
+  path field of the config key must match the path field of the URL
+  either exactly or as a prefix of slash-delimited path elements.  This means
+  a config key with path `foo/` matches URL path `foo/bar`.  A prefix can only
+  match on a slash (`/`) boundary.  Longer matches take precedence (so a config
+  key with path `foo/bar` is a better match to URL path `foo/bar` than a config
+  key with just path `foo/`).
+
+. User name (e.g., `user` in `https://user@example.com/repo.git`). If
+  the config key has a user name it must match the user name in the
+  URL exactly. If the config key does not have a user name, that
+  config key will match a URL with any user name (including none),
+  but at a lower precedence than a config key with a user name.
+--
++
+The list above is ordered by decreasing precedence; a URL that matches
+a config key's path is preferred to one that matches its user name. For example,
+if the URL is `https://user@example.com/foo/bar` a config key match of
+`https://example.com/foo` will be preferred over a config key match of
+`https://user@example.com`.
++
+All URLs are normalized before attempting any matching (the password part,
+if embedded in the URL, is always ignored for matching purposes) so that
+equivalent URLs that are simply spelled differently will match properly.
+Environment variable settings always override any matches.  The URLs that are
+matched against are those given directly to Git commands.  This means any URLs
+visited as a result of a redirection do not participate in matching.
-- 
2.19.1.647.g708186aaf9

