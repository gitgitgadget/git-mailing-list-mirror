Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E35261F42B
	for <e@80x24.org>; Wed,  3 Jan 2018 16:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751342AbeACQfD (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:35:03 -0500
Received: from mail-wr0-f173.google.com ([209.85.128.173]:40619 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbeACQe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:34:58 -0500
Received: by mail-wr0-f173.google.com with SMTP id p17so2149126wre.7
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MTaPKUl9PZBW3hwHEcNB3xIA3pT2gjUXoipas1Hf5zk=;
        b=J8e8yEt5ZSh/KcTgRflnCz2LiFIvUyHGJ6ypryVJDCLDZfjH8able3NtVTdYKzuDLV
         kS0RzWUDc1jIA1OR+HjsWcNJGO+s+82I4yR8w8CUY5oYRb+MY29L/ZPKfg0PQNaKvXkP
         5hts3ttRuI+0nCFVnJ0ejo3J4ckITDv13nhS1bIKl3EY1gXn+abTWOjpElcAVVfQfkqw
         5CLJzhGwdAFV4Nz9QZogRdc38ykuYXgMXvaI7DkILyDyxziIkXgdHtxZDQgmomLPH1nx
         yJik+yBRgJOVNzVgplPcZGIHMad9vPJ0PF2QTf9+XC0zWw13nGhLx/PrLhurkADWdqWC
         sGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MTaPKUl9PZBW3hwHEcNB3xIA3pT2gjUXoipas1Hf5zk=;
        b=PpCj4UEN7xcqrRDtffuekDiUpvqtIGmLkqVAk77z6OTbc8H6NeAXv0R6sA5doIYsIv
         2DTe/H7olnYv15nee50ofhchYt1vhXGdeM6CmhFMHpTwz+bbqRvw3ZY/sU0jdnU6AwRo
         A/T+mxEwAb5IgevrLfLNdjI+QGey9kKbFpGjcFT/mNEVYo+kpx88wxNJZepvxTGvEVyv
         Yd3FloEk5tPEBjJ09GKWvEffA1GURwHmwnr+nVDFhsx4ENiF0Tj0gzNFnOMqf/X3Asnp
         6w3BT7jyZ0gsxSDWTGExpWBHnlsYMrsViRvYUvmI7LdGrcbdMmBB1izhUdhrOo3N3Re5
         uyzg==
X-Gm-Message-State: AKGB3mJWM/qnOGl1lUBH4foImovq1P8PK7GoRB+vuT3As84XAfRRlOPH
        PkBsYlTk7bPJKjrZcWAsDJhEUIwA
X-Google-Smtp-Source: ACJfBos7wKXAkNtW6joHot/yYhuvPfHNo55n9kwN3KcNr7wASMknlMs46JRdZ0uy+WJ/LvTDBC9WlA==
X-Received: by 10.223.169.8 with SMTP id u8mr2174156wrc.232.1514997296507;
        Wed, 03 Jan 2018 08:34:56 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.34.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:34:55 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 26/40] lib-httpd: add apache-e-odb.conf
Date:   Wed,  3 Jan 2018 17:33:49 +0100
Message-Id: <20180103163403.11303-27-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
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
2.16.0.rc0.16.g82191dbc6c.dirty

