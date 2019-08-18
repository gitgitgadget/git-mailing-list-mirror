Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F7D51F461
	for <e@80x24.org>; Sun, 18 Aug 2019 13:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbfHRNxe (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 09:53:34 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:46404 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfHRNxe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Aug 2019 09:53:34 -0400
Received: by mail-qt1-f180.google.com with SMTP id j15so11238465qtl.13
        for <git@vger.kernel.org>; Sun, 18 Aug 2019 06:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:from:to:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=Mzn6ZfK3XeqdQyK/3aZ4Qw/mzsmEYVRoDw37gCA8GFI=;
        b=hlUYRZHsu/Mgq72E34dr3IOnpcPxhzQcKd5KKqByBZZAe9hDK0kTLZO3JeqVCnPeQv
         JpeTe9gOkoodgG/vIw3dv8VkY8rYIgs3bdUyglM/sNP9CeKQOXwjAcBOQXy7g8Sq9sct
         QVyl37oum+u4sSqHSe5LBv8Ph55vqRsiy9Trd3NX9+3I1KXm/TXxc2Qzr5DXFgXvGQo8
         g6CFPKBKjv3Tz62eNF47mc3R+UuzlZXfCEkxXgRW+ma94B+/yIOSvgYSPmwUMLSom1lh
         nUiOGml6b6jYn4i2y41bSTMdPwGBxXCOipU8LMcrhm1qautfc8UDbh6uKPaCgRjVd+W6
         XSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:from:to:references:in-reply-to:subject
         :date:message-id:mime-version:content-transfer-encoding
         :content-language:thread-index;
        bh=Mzn6ZfK3XeqdQyK/3aZ4Qw/mzsmEYVRoDw37gCA8GFI=;
        b=EgAwoo6NaADnZj+8+nJDJOg41K2GchTpqIJqEyRoKhApLWYZPapc3gCAPSpxhS+Due
         ag/PPbkuJrEKEJmjpLo2AMzLAnIHH1etnYoa/SvXz/3VlWvqCtYNqZvS2rdXKRnoxyGp
         jUGOiC3Xjd+ecHJjWp7ZuYaqykBTTq0MoxrPOyr7lhJxALQ92RMmD/fRnSQncV9j4qnA
         q0CnobZfFGJCtKOS5PjOrduZGcIZPID/ZR9oq2gtuQVdiGKQRoVsiITBFNjCHJNe1VE7
         WsCJsAArjzT7YVxvLm5k+RKFZrWX2vNPkx8XGHytcNUa7TIM9hzLURvHgGjyhhTDZNI/
         o1gQ==
X-Gm-Message-State: APjAAAWFn6H2YR/SLyPEFTeuIPqps4/0poz3f4Sh7M09Gm4DqDz3t7b3
        OH4LPHmCeYhOzzUqgu5ywlEUVzEi
X-Google-Smtp-Source: APXvYqzBcV/5CDD4AodeZhcSj6zO60G+xpEyPrud92/P/UD0rVD21nQqhMxO9LQZQVph+3NHuGpoNQ==
X-Received: by 2002:ac8:305b:: with SMTP id g27mr17659097qte.127.1566136412571;
        Sun, 18 Aug 2019 06:53:32 -0700 (PDT)
Received: from Mobius (pool-96-230-106-117.bstnma.fios.verizon.net. [96.230.106.117])
        by smtp.gmail.com with ESMTPSA id r205sm5758342qke.115.2019.08.18.06.53.32
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Aug 2019 06:53:32 -0700 (PDT)
Reply-To: <gaiseric.vandal@gmail.com>
From:   "Gaeseric Vandal" <gaiseric.vandal@gmail.com>
To:     <git@vger.kernel.org>
References: <009e01d555cb$6c8ed640$45ac82c0$@gmail.com>
In-Reply-To: <009e01d555cb$6c8ed640$45ac82c0$@gmail.com>
Subject: Updates on centos7 break git access via  git-http-backend
Date:   Sun, 18 Aug 2019 09:53:28 -0400
Message-ID: <009f01d555cc$50564ca0$f102e5e0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQHQUSwBebTfO2IcOp4QtkblmjS3NqcK9QTg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


This a is a clarification of an earlier post.     I thought gitweb was =
the problem.  =20


The actual problem appears to be with =
/usr/libexec/git-core/git-http-backend.

Gitweb provides a list to unauthenticated users of available =
repositories.  I don't need that function so I have removed that package =
to avoid unexpected conflicts.

I recently applied the latest patches on centos7, including =
git-1.8.3.1-20.      When I try to access git repos (either via web  =
browser or git command line.) Repos are configured to require LDAP  =
authentication.

The httpd ssl-error.log shows
#
[Sun Aug 18 09:22:48.113435 2019] [authz_core:debug] [pid 30167] =
mod_authz_core.c(809): [client x.x.x.x:35876] AH01626: authorization =
result of <RequireAny>: granted [Sun Aug 18 09:22:48.119012 2019] =
[cgi:error] [pid 30167] [client x.x.x.x:x] AH01215: Request not =
supported: '/export/gitrepos/ABC [Sun Aug 18 09:22:48.119069 2019] =
[headers:debug] [pid 30167] mod_headers.c(823): AH01502: headers: =
ap_headers_output_filter() [Sun Aug 18 09:22:53.124599 2019] [ssl:info] =
[pid 30167] (70007)The timeout specified has expired: [client =
x.x.x.x:35876] AH01991: SSL input filter read failed.
[Sun Aug 18 09:22:53.124723 2019] [ssl:debug] [pid 30167] =
ssl_engine_io.c(993): [client x.x.x.x:35876] AH02001: Connection closed =
to child 1 with standard shutdown (#


If I change gitrepos.conf as follows I will get an error about the =
script not being found - so I know it is being called.

	#ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/
	ScriptAlias /git/ /usr/libexec/git-core/git-http-backend_not/



# git --version
git version 1.8.3.1


# httpd -v
Server version: Apache/2.4.6 (CentOS)
Server built:   Jul 29 2019 17:18:49
#


Partial config

       # cat /etc/httpd/conf.d/gitrepos.conf
       SetEnv GIT_PROJECT_ROOT /export/gitrepos
       SetEnv GIT_HTTP_EXPORT_ALL
       ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/

       RewriteEngine on
       RewriteCond %{QUERY_STRING} service=3Dgit-receive-pack [OR]
       RewriteCond %{REQUEST_URI} /git-receive-pack$
       RewriteRule ^/git/ - [E=3DAUTHREQUIRED]

       <Files "git-http-backend">
       AuthType Basic
       AuthBasicProvider ldap
       AuthLDAPURL "ldaps://xxxxxxxxxxxxxxx)"
       AuthLDAPBindDN  "uid=3Dxxxxxxxxxxxx"
       AuthLDAPBindPassword xxxxxxxxxxxxxxx
      AuthName "Git Access"
       Require user xxxxx xxxxx xxxxx
       Order deny,allow
       Deny from env=3DAUTHREQUIRED
       Satisfy any
       </Files>


       <Location /git/ABC>
       AuthType Basic
       AuthBasicProvider ldap
       AuthLDAPURL "ldaps://xxxxxxxxxxxxxxx)"
       AuthLDAPBindDN  "uid=3Dxxxxxxxxxxxx"
       AuthLDAPBindPassword xxxxxxxxxxxxxxx
       AuthName "Git Access ABC"
       Require user xxxxx xxxxx xxxxx
       Order deny,allow
 </Location>


This had been working fine for several years.

Appreciate any advice

Thanks


