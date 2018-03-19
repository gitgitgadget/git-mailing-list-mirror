Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19C851F404
	for <e@80x24.org>; Mon, 19 Mar 2018 13:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933369AbeCSNeN (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:34:13 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:55856 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933308AbeCSNcn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:32:43 -0400
Received: by mail-wm0-f48.google.com with SMTP id t7so2356647wmh.5
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jtwuz3OrJegKOhbUnI0qt2nILNjwW6mfxsG85tOSMAg=;
        b=UKTvtTS+DYi4MEJHpTF/Hi2Ed3HWGZhcjIJm7Bp/XgF7giD3IfC4FAnm4++hceT1NH
         u9e/BIUC8c48Z11uMgVzW+w99foDqvL1r2PCOyr+CB1ZRFBbB5HspnEdEwKr6H4PzV2Y
         6t5JdNCWwBMNwDdAC6X1g7XzN1UCYgnfZqyn0+R4Fl5I0u3uAo2kcU5w1oZ9YxsK5C5o
         Ra8AVX9N/YkBAq8N0QFAK+9H+6qhvqaweYzM4flQOfszhlSRu8rrSqaZ159OW75h8Eq5
         k9es2XNoIgdn3RQq4V2GlKrQbfYRPzswH24FFzpyOy7/aNqObmhYH+HJFyxaAhZ+tGb4
         /zxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jtwuz3OrJegKOhbUnI0qt2nILNjwW6mfxsG85tOSMAg=;
        b=NeL5tIZBho6JHXd+qjaHH31XLc03leJ68v/y597WMXQPATWp5fHEqEpSRw+sdd/N6L
         C0v7YvDyjG1A/Qiiiw5Odv4yUWEXusVtKVweNlmqMwo2vNEWUVaE1bL1kVk/jpvVGP+9
         OxKHy+BuJOtQwTFjo9wdyGCsg6GPJryKR8GjgzzFeihMA9Bre8HOYFX9/ME6zeCmHw/k
         6hXOZLcde7AsFc1APQS3GzE6Q99TU0wOCUpzh7b+ci7FUD02r9ABk/247CdLKXhhyUlZ
         yEdIh8fk13RRiPEwjQLgxHXHh0furpikXJfmYxyyBBydfOuzaId4Uo777/M4y1lU4XLJ
         xqkg==
X-Gm-Message-State: AElRT7G2CX4Ors1aAxhE+xrf3VYXHxQ7YBO++e+CkoB9bnebuGWzxJ5M
        cbnpFV+L4HSW/daoSRoUsF6ttFPC
X-Google-Smtp-Source: AG47ELtlOemabthmnv0pSU/iyEAo+Efwli6iUNYpfBTVtJ1uOBWky1xd2WQ/OODzP3shvdGuF3zh2Q==
X-Received: by 10.28.154.140 with SMTP id c134mr9242141wme.109.1521466361318;
        Mon, 19 Mar 2018 06:32:41 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id p29sm539434wmf.3.2018.03.19.06.32.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:32:40 -0700 (PDT)
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
Subject: [PATCH v2 24/36] lib-httpd: add apache-e-odb.conf
Date:   Mon, 19 Mar 2018 14:31:35 +0100
Message-Id: <20180319133147.15413-25-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
In-Reply-To: <20180319133147.15413-1-chriscool@tuxfamily.org>
References: <20180319133147.15413-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an apache config file to test external object databases.
It uses the upload.sh and list.sh cgi that have been added
previously to make apache store external objects.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/lib-httpd/apache-e-odb.conf | 214 ++++++++++++++++++++++++++++++++++
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
2.17.0.rc0.37.g8f476fabe9

