Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A29C81FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 21:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753869AbcK3VYm (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 16:24:42 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34313 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbcK3VYk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 16:24:40 -0500
Received: by mail-wm0-f68.google.com with SMTP id g23so31368032wme.1
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 13:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ads6E8+isMbxJ492Qfu/FOpm2r38Kq4tTKmTIQg244A=;
        b=j+huv7uKQ/jMZw0HZIyFkhHrXhA7ZuByidSNGS3T6X1S04JlpJIKqwTT81T0O07H42
         0uT7M60EAfVZHGMIFV7GQC4BUKi2VksdcNygClOa1ekiFPcJWABvzIOVrPSDML+Pf5Nw
         LlvLPuaXEYS8ovb+nm/qWA2MLwkW+SdI1W+XvThLOmg711gLMAQ+jEisMbsnQ5vMiHun
         b9iYTPziGk7BKblyQcau2TXv8lrzJf83dWWqDEONSy2Rmy2yZmKtBPL7HZtCieu1zq2F
         J1EiZWMO6WhB9Y5FustnF5LRgh6BdZm2wwGv42LAWpdO2yE9xVVahJIhA/h/DlbPtFnX
         kh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ads6E8+isMbxJ492Qfu/FOpm2r38Kq4tTKmTIQg244A=;
        b=ZwKIl4ZM6PLd2tN16pGWjytlEoKB9CkMq0JCsH4Y4Hzs+Tb6gqDNK3bv0pXwRqnVxV
         KDE6YpqRhP1JND/mytirdF1S4cm9QcH6Q8PQInhB+zQjp+nW34gBUl4pLl3cYp60lIm+
         cxEe0B0eZvAd0Wmc2OY6Nj7DFq6zfLvIZXTeJ0/UhYVU5Dkr7wc6moovfl+BviSKC/2n
         yvW8m1lof+FbUoZ1WRGF4sEYe5bACey1l652Pz2efa04wekODTHhb0aqj6ZjPZaDiA1A
         tfug0BA3eMzzde7fFpIqrDv/qD/acezgTmjSqWhUZD19lfuuBjf87bYVYbeCTI2ej1yq
         2utg==
X-Gm-Message-State: AKaTC03hWjzDjLqchJF1hJi0yluc0P35RDDUm1iropP4tmJUv7E+jb6Hw2prU6iPSNJH3g==
X-Received: by 10.28.157.137 with SMTP id g131mr28180639wme.29.1480539913677;
        Wed, 30 Nov 2016 13:05:13 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d64sm9802427wmh.3.2016.11.30.13.05.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Nov 2016 13:05:12 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v3 14/16] lib-httpd: add apache-e-odb.conf
Date:   Wed, 30 Nov 2016 22:04:18 +0100
Message-Id: <20161130210420.15982-15-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.rc2.37.geb49ca6
In-Reply-To: <20161130210420.15982-1-chriscool@tuxfamily.org>
References: <20161130210420.15982-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an apache config file to test external object databases.
It uses the upload.sh and list.sh cgi that have been added
previously to make apache store external objects.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/lib-httpd/apache-e-odb.conf | 214 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 214 insertions(+)
 create mode 100644 t/lib-httpd/apache-e-odb.conf

diff --git a/t/lib-httpd/apache-e-odb.conf b/t/lib-httpd/apache-e-odb.conf
new file mode 100644
index 0000000000..19a1540c82
--- /dev/null
+++ b/t/lib-httpd/apache-e-odb.conf
@@ -0,0 +1,214 @@
+ServerName dummy
+PidFile httpd.pid
+DocumentRoot www
+LogFormat "%h %l %u %t \"%r\" %>s %b" common
+CustomLog access.log common
+ErrorLog error.log
+<IfModule !mod_log_config.c>
+	LoadModule log_config_module modules/mod_log_config.so
+</IfModule>
+<IfModule !mod_alias.c>
+	LoadModule alias_module modules/mod_alias.so
+</IfModule>
+<IfModule !mod_cgi.c>
+	LoadModule cgi_module modules/mod_cgi.so
+</IfModule>
+<IfModule !mod_env.c>
+	LoadModule env_module modules/mod_env.so
+</IfModule>
+<IfModule !mod_rewrite.c>
+	LoadModule rewrite_module modules/mod_rewrite.so
+</IFModule>
+<IfModule !mod_version.c>
+	LoadModule version_module modules/mod_version.so
+</IfModule>
+<IfModule !mod_headers.c>
+	LoadModule headers_module modules/mod_headers.so
+</IfModule>
+
+<IfVersion < 2.4>
+LockFile accept.lock
+</IfVersion>
+
+<IfVersion < 2.1>
+<IfModule !mod_auth.c>
+	LoadModule auth_module modules/mod_auth.so
+</IfModule>
+</IfVersion>
+
+<IfVersion >= 2.1>
+<IfModule !mod_auth_basic.c>
+	LoadModule auth_basic_module modules/mod_auth_basic.so
+</IfModule>
+<IfModule !mod_authn_file.c>
+	LoadModule authn_file_module modules/mod_authn_file.so
+</IfModule>
+<IfModule !mod_authz_user.c>
+	LoadModule authz_user_module modules/mod_authz_user.so
+</IfModule>
+<IfModule !mod_authz_host.c>
+	LoadModule authz_host_module modules/mod_authz_host.so
+</IfModule>
+</IfVersion>
+
+<IfVersion >= 2.4>
+<IfModule !mod_authn_core.c>
+	LoadModule authn_core_module modules/mod_authn_core.so
+</IfModule>
+<IfModule !mod_authz_core.c>
+	LoadModule authz_core_module modules/mod_authz_core.so
+</IfModule>
+<IfModule !mod_access_compat.c>
+	LoadModule access_compat_module modules/mod_access_compat.so
+</IfModule>
+<IfModule !mod_mpm_prefork.c>
+	LoadModule mpm_prefork_module modules/mod_mpm_prefork.so
+</IfModule>
+<IfModule !mod_unixd.c>
+	LoadModule unixd_module modules/mod_unixd.so
+</IfModule>
+</IfVersion>
+
+PassEnv GIT_VALGRIND
+PassEnv GIT_VALGRIND_OPTIONS
+PassEnv GNUPGHOME
+PassEnv ASAN_OPTIONS
+PassEnv GIT_TRACE
+PassEnv GIT_CONFIG_NOSYSTEM
+
+Alias /dumb/ www/
+Alias /auth/dumb/ www/auth/dumb/
+
+<LocationMatch /smart/>
+	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
+	SetEnv GIT_HTTP_EXPORT_ALL
+</LocationMatch>
+<LocationMatch /smart_noexport/>
+	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
+</LocationMatch>
+<LocationMatch /smart_custom_env/>
+	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
+	SetEnv GIT_HTTP_EXPORT_ALL
+	SetEnv GIT_COMMITTER_NAME "Custom User"
+	SetEnv GIT_COMMITTER_EMAIL custom@example.com
+</LocationMatch>
+<LocationMatch /smart_namespace/>
+	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
+	SetEnv GIT_HTTP_EXPORT_ALL
+	SetEnv GIT_NAMESPACE ns
+</LocationMatch>
+<LocationMatch /smart_cookies/>
+	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
+	SetEnv GIT_HTTP_EXPORT_ALL
+	Header set Set-Cookie name=value
+</LocationMatch>
+<LocationMatch /smart_headers/>
+	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
+	SetEnv GIT_HTTP_EXPORT_ALL
+</LocationMatch>
+ScriptAlias /upload/ upload.sh/
+ScriptAlias /list/ list.sh/
+<Directory ${GIT_EXEC_PATH}>
+	Options FollowSymlinks
+</Directory>
+<Files upload.sh>
+  Options ExecCGI
+</Files>
+<Files list.sh>
+  Options ExecCGI
+</Files>
+<Files ${GIT_EXEC_PATH}/git-http-backend>
+	Options ExecCGI
+</Files>
+
+RewriteEngine on
+RewriteRule ^/smart-redir-perm/(.*)$ /smart/$1 [R=301]
+RewriteRule ^/smart-redir-temp/(.*)$ /smart/$1 [R=302]
+RewriteRule ^/smart-redir-auth/(.*)$ /auth/smart/$1 [R=301]
+RewriteRule ^/smart-redir-limited/(.*)/info/refs$ /smart/$1/info/refs [R=301]
+RewriteRule ^/ftp-redir/(.*)$ ftp://localhost:1000/$1 [R=302]
+
+RewriteRule ^/loop-redir/x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-(.*) /$1 [R=302]
+RewriteRule ^/loop-redir/(.*)$ /loop-redir/x-$1 [R=302]
+
+# Apache 2.2 does not understand <RequireAll>, so we use RewriteCond.
+# And as RewriteCond does not allow testing for non-matches, we match
+# the desired case first (one has abra, two has cadabra), and let it
+# pass by marking the RewriteRule as [L], "last rule, do not process
+# any other matching RewriteRules after this"), and then have another
+# RewriteRule that matches all other cases and lets them fail via '[F]',
+# "fail the request".
+RewriteCond %{HTTP:x-magic-one} =abra
+RewriteCond %{HTTP:x-magic-two} =cadabra
+RewriteRule ^/smart_headers/.* - [L]
+RewriteRule ^/smart_headers/.* - [F]
+
+<IfDefine SSL>
+LoadModule ssl_module modules/mod_ssl.so
+
+SSLCertificateFile httpd.pem
+SSLCertificateKeyFile httpd.pem
+SSLRandomSeed startup file:/dev/urandom 512
+SSLRandomSeed connect file:/dev/urandom 512
+SSLSessionCache none
+SSLMutex file:ssl_mutex
+SSLEngine On
+</IfDefine>
+
+<Location /auth/>
+	AuthType Basic
+	AuthName "git-auth"
+	AuthUserFile passwd
+	Require valid-user
+</Location>
+
+<LocationMatch "^/auth-push/.*/git-receive-pack$">
+	AuthType Basic
+	AuthName "git-auth"
+	AuthUserFile passwd
+	Require valid-user
+</LocationMatch>
+
+<LocationMatch "^/auth-fetch/.*/git-upload-pack$">
+	AuthType Basic
+	AuthName "git-auth"
+	AuthUserFile passwd
+	Require valid-user
+</LocationMatch>
+
+RewriteCond %{QUERY_STRING} service=git-receive-pack [OR]
+RewriteCond %{REQUEST_URI} /git-receive-pack$
+RewriteRule ^/half-auth-complete/ - [E=AUTHREQUIRED:yes]
+
+<Location /half-auth-complete/>
+  Order Deny,Allow
+  Deny from env=AUTHREQUIRED
+
+  AuthType Basic
+  AuthName "Git Access"
+  AuthUserFile passwd
+  Require valid-user
+  Satisfy Any
+</Location>
+
+<IfDefine DAV>
+	LoadModule dav_module modules/mod_dav.so
+	LoadModule dav_fs_module modules/mod_dav_fs.so
+
+	DAVLockDB DAVLock
+	<Location /dumb/>
+		Dav on
+	</Location>
+	<Location /auth/dumb>
+		Dav on
+	</Location>
+</IfDefine>
+
+<IfDefine SVN>
+	LoadModule dav_svn_module modules/mod_dav_svn.so
+
+	<Location /${LIB_HTTPD_SVN}>
+		DAV svn
+		SVNPath "${LIB_HTTPD_SVNPATH}"
+	</Location>
+</IfDefine>
-- 
2.11.0.rc2.37.geb49ca6

