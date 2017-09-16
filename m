Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B559120A21
	for <e@80x24.org>; Sat, 16 Sep 2017 08:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751556AbdIPIJ2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:09:28 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34976 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbdIPIIN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:08:13 -0400
Received: by mail-wm0-f68.google.com with SMTP id e64so4517136wmi.2
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2LHYbhHlIQ7gxXq0mZQVbo2y4cWJF0e/SgQeC5XNn1A=;
        b=QnWCP3xVdIqlNBxgxYUvrzbx3DbwP3G74K/DOahQdRKIGOPDDrkIDpdS9zvCmP1LRv
         x7xuWvS8nliueqsFVF32f7MTXBl9VHQrQj+3L0XLn43JJmOrIheA00rPgwJJ15paPgrL
         MSTw6GDm7oJ5ia/EDn9gAQtzT3w097p6ftLKrtjtTtIswlUy9N8dFvl8z7oz8TfBCUXM
         FhrZfjaMqpD+FlmE+Vi21LytOM6nJHFHdk6S9xqufN76/MlzG1azGaFYdKz5u73b/qnm
         ZI3Fx9Nx/IgUZQ2xNIrvap6cqrvNz10y3xsbVl4XRftlxxaD4Y3crECTqcevNxTD2Xgx
         bSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2LHYbhHlIQ7gxXq0mZQVbo2y4cWJF0e/SgQeC5XNn1A=;
        b=gw4dYyRrglpCidpa1zxt8PQZejM4NADNGH7rl9qSQp20XdrMxKV+VBDDrZo5ntCfUy
         aPQ+w2mxdoUDlNFt3HDpx0InCrfqUW5VBdKPIVaSy31mtwTIiFN6wF0f6OtzP47Njp+D
         k/Qg2EGymHYUku6iJWn5PbMR1BGGkIvFU5rfGXr/5YtM6rFSFt9rpVnGIFBfNXIsENMK
         Yh3MXWYOOIZHWU3dfpm1XS2w5HQCXtJfFiwPjCzGKLSMwRdtvKfHLgxpXeIIdOJIUPwg
         ub6JtgIWAfgQ5xwttzfrGEafKLveqPK1APs2yTRY4GL+zDtONcfwt+CdYO+fzHyVUgkt
         NXqg==
X-Gm-Message-State: AHPjjUjs0OjGf96k6pxcw/tkaH5QObCA9F31jCmYlf/8ExyZqY7+jDwb
        peIXxGHZz12CbQOpZnRz2q29Ag==
X-Google-Smtp-Source: AOwi7QAKcI0jiNx4pXSoIAz+JHOihFxKCqtFmF2RrsckzG5ofHCjsp6UQibB7UPYYh/VcRv4Zyo2fg==
X-Received: by 10.28.107.17 with SMTP id g17mr4925760wmc.58.1505549291289;
        Sat, 16 Sep 2017 01:08:11 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:08:10 -0700 (PDT)
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
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 20/40] lib-httpd: add apache-e-odb.conf
Date:   Sat, 16 Sep 2017 10:07:11 +0200
Message-Id: <20170916080731.13925-21-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
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
2.14.1.576.g3f707d88cd

