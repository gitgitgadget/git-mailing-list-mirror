Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URI_TRY_3LD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20FB01F461
	for <e@80x24.org>; Sat, 17 Aug 2019 20:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfHQUji (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 16:39:38 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:39872 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfHQUji (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 16:39:38 -0400
Received: by mail-qk1-f178.google.com with SMTP id 125so7632513qkl.6
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 13:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=+CQRwlDshxN06vqfLfA1+EWmlBm+kskRX8wpuhhz890=;
        b=oje0jxj9JXYOT8BfRYV4dELXNy5jbu+IRpxAFdvCKwxjOJgcFd7GRPYfcvD1u/OcC5
         2vU0WId4CDnJlmoVzGgdhUrC1+LX53e8PX+pQz1zxXEExssTEQgJdty+eJtQ3pYsMnp4
         H45oEkkSY3zflSGuqelgKxRyNqeoDzT8qkQsflNcUEireTe3haeEIvH6sqQGFezLD3DV
         mO5uRpo2gKdOQJ4eve2LlicltIcn91lEYL0wP4XW2veyLorJDLPk+PG/2/pzpKDD0yIy
         kl+2DbxyoRsIHlDGNZqwELuB2XVubBPUFebpFGmayQIiPdglTPTG/E082/aqx4eXxktr
         l1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+CQRwlDshxN06vqfLfA1+EWmlBm+kskRX8wpuhhz890=;
        b=Jj939wXBUFGZq7JSZMhSmYBGCx7kepW538wEFd67RfkaiNsJgO1AxVFj+pBfa1dQKu
         IETw4JszswLZelvJaDbjuqih4mJLVApFA2Vqq22OdZfgSN5oMatCWHF0zGmYZK8aFIhV
         JF5002/Pg3AZuhakhnbkTxvsGqOvduM7JLxDcXCCtVSKp3pn0aXaffb8kr5bI9JbiCh1
         PEDCnSy9b2TGJSixeOs1oikkjR54gOiZHDVqngGxq4SIy/AOBzWJJ3XhxsczalWxuvZB
         eABQGeXAXZQDktL7i5VOg3Wdf0m/04Dm/5SSWk9btoHCErOHOXfwuJ0DMnB9A/x8TkLQ
         CfJA==
X-Gm-Message-State: APjAAAUyxQ6JgzmSSw9CnJ0ix5oPSBk0J7CXWKFemGbBd1X3kjUByxdo
        difzFaIpDSeRsHyiSdanQoH7O2spAKg=
X-Google-Smtp-Source: APXvYqznQZ5Cb61MgHCL+YTazbt0zVNCzCLb3mfmKJi+fDwEs+XSMh0vngzkXjvAX275ZEuEYTeUBQ==
X-Received: by 2002:ae9:eb8f:: with SMTP id b137mr14029461qkg.136.1566074376823;
        Sat, 17 Aug 2019 13:39:36 -0700 (PDT)
Received: from [10.0.0.79] ([24.61.222.48])
        by smtp.gmail.com with ESMTPSA id x145sm2703629qka.106.2019.08.17.13.39.36
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Aug 2019 13:39:36 -0700 (PDT)
From:   Gaiseric Vandal <gaiseric.vandal@gmail.com>
X-Google-Original-From: Gaiseric Vandal <Gaiseric.Vandal@gmail.com>
Subject: Re: Upgrade to gitweb-1.8.3.1-20 on centos7 breaks git access
To:     git@vger.kernel.org
References: <CAGJ3EkWrHPAD04cEcp9P6Hg4jtNFpiGSCSue+5T7oUL+sbhcUQ@mail.gmail.com>
Message-ID: <c226d34b-e293-1cce-16b0-e35059adaf80@gmail.com>
Date:   Sat, 17 Aug 2019 16:39:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAGJ3EkWrHPAD04cEcp9P6Hg4jtNFpiGSCSue+5T7oUL+sbhcUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If I remove /etc/httpd/conf.d/git.conf then I just get  blank page in 
the browser.

the ssl_error log shows

[Sat Aug 17 16:17:08.926093 2019] [cgi:error] [pid 18299] [client 
x.x.x.x:25050] AH01215: Request not supported: '/export/gitrepos/ABC/'


On 8/17/2019 4:03 PM, Gaiseric Vandal wrote:
> I recently applied the latest patches on centos7, including
> gitweb-1.8.3.1-20.      When I try to access git repos (either via web
> browser or git command line.) Repos are configured to require LDAP
> authentication.
>
>
> I should be able to access repo ABC via
>
> https://myserver.domain.com/git/ABC
>
> I get the correct user login prompt but then , after logging, get
> following error
>
>       The requested URL /git/ABC/ was not found on this server.
>
> I don't think any of the config files got changed.
>
> My partial config is
>
>       # cat /etc/httpd/conf.d/git.conf
>       Alias /git /var/www/git
>
>       <Directory /var/www/git>
>        Options +ExecCGI
>        AddHandler cgi-script .cgi
>        DirectoryIndex gitweb.cgi
>       </Directory>
>       #
>
>
>
>       # cat /etc/httpd/conf.d/gitrepos.conf
>       SetEnv GIT_PROJECT_ROOT /export/gitrepos
>       SetEnv GIT_HTTP_EXPORT_ALL
>       ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/
>
>       RewriteEngine on
>       RewriteCond %{QUERY_STRING} service=git-receive-pack [OR]
>       RewriteCond %{REQUEST_URI} /git-receive-pack$
>       RewriteRule ^/git/ - [E=AUTHREQUIRED]
>
>       <Files "git-http-backend">
>       AuthType Basic
>       AuthBasicProvider ldap
>       AuthLDAPURL "ldaps://xxxxxxxxxxxxxxx)"
>       AuthLDAPBindDN  "uid=xxxxxxxxxxxx"
>       AuthLDAPBindPassword xxxxxxxxxxxxxxx
>       AuthName "Git Access"
>       Require user xxxxx xxxxx xxxxx
>       Order deny,allow
>       Deny from env=AUTHREQUIRED
>       Satisfy any
>       </Files>
>
>
>       <Location /git/ABC>
>       AuthType Basic
>       AuthBasicProvider ldap
>       AuthLDAPURL "ldaps://xxxxxxxxxxxxxxx)"
>       AuthLDAPBindDN  "uid=xxxxxxxxxxxx"
>       AuthLDAPBindPassword xxxxxxxxxxxxxxx
>       AuthName "Git Access ABC"
>       Require user xxxxx xxxxx xxxxx
>       Order deny,allow
> </Location>
>
>
>
> The /var/www/git/gitweb.cgi file has the default settings.
>
> ...
> our $GIT = "/usr/bin/git";
>
> # absolute fs-path which will be prepended to the project path
> our $projectroot = "/var/lib/git";
> #our $projectroot = "/export/gitrepos";
>
> ...
>
>
> If I set $projectroot to point to /export/gitrepos, I can see a list
> of projects when I browse to https://myserver.domain.com/git-
> however I wanted to minimize how much information was exposed with no
> authentication.      And it didn't fix the access problem.
> The "git" command is in the default OS path.   changing
>        our $GIT = "/usr/bin/git";
> to
>       our $GIT = "git";
>
> did not help.
>
>
> The only thing in the httpd error logs that looks relevant is
>
> [Sat Aug 17 15:39:39.826265 2019] [core:info] [pid 15870] [client
> xxxxx] AH00128: File does not exist: /var/www/git/ABC/
> [Sat Aug 17 15:39:44.831598 2019] [ssl:info] [pid 15870] (70007)The
> timeout specified has expired: [client xxxxx] AH01991: SSL input
> filter read failed.
>
>
> selinux is disabled.
>
> Since I am getting an authentication prompt with "Git Access ABC" in
> the dialog box it seems clear that the project root is being picked up
> from  /etc/httpd/conf.d/gitrepos.conf and that the
> /usr/libexec/git-core/git-http-backend script is being run.
>
>
> Appreciate any advice.
>
> Thanks
