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
	by dcvr.yhbt.net (Postfix) with ESMTP id 57DD61F461
	for <e@80x24.org>; Sat, 17 Aug 2019 20:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfHQUDr (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 16:03:47 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46270 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfHQUDr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 16:03:47 -0400
Received: by mail-yb1-f194.google.com with SMTP id x10so3073164ybs.13
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 13:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=BWlXu9K4VZq1DOg5KokWssG+IAdiVhRT3040sJUjmM4=;
        b=i33hXiNZ5AtPJLt01/SDQbyrgUOmt8GCSMhxHsfmd+/sKBBwY884RNXTF1ZU5P9lRX
         1FdNZzdFjnfi4AvTcwPxi/s4ehC7pd8fi+mbM/5Nl8bFY0tzX6BonyaR73aKiwC+53fT
         ATtVehePfybw+SuBWjlOzh8J9zL1LsXfk2jxoyp5y5WSAT6xfUNZGW2tNjNY4g31qB/x
         MTHn/5jT2YOhmxzIKxam5bCAZjD+gzxnMgDEXWCh41Ul5ES4qR57caLKPzIT8KZ9lRtz
         ckHAfZVOSxzAXZhqYds8f8bKsFoI1A3LDSMA3XCuiaKaczxQRlmqK3g1FA5mFOUdpXpK
         tSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BWlXu9K4VZq1DOg5KokWssG+IAdiVhRT3040sJUjmM4=;
        b=bHe6Sx+DHqgMb4cTf1WX0hWvKy4faFJQPrb+8HfvHLU7mI/AwX0Sg0BabCYDsUa6bP
         xN3Eyl3YlPZQyEh2mQyOWWXujPSi0nHxd60Xqu9YOvI94Rzgl+/9NudEUoKmlCRQuiqT
         MdFjdK1Rgzh3j3YhFdakoMukoSZXj14UMD6fSX2yXzBR33wd1hHqVSI5fbabyHlckqEt
         y2GgWtDFdGsKM1j4kULq6WDv5gPq8muXyH/pAD8UV7k6Enm6lLviIxoj0H16LzMKhtW5
         6u5GVP+drmnB9Xx4g5PG75QqzVK0rq7AY5C+mM0+ZxhEMZWPDZ2Be7T+3EoKcMp9FCxN
         oGyQ==
X-Gm-Message-State: APjAAAVGeAYmURdAtQv7pButn9EuWSG0Gg3FWZcc4hOd/qp6eqno7UF6
        ZSsbUVP0Sx8On8LlCLxIx5KhFbVCSoz3HstZYmz5yS/zl6+R6Apb
X-Google-Smtp-Source: APXvYqwzxkly8iebHg7MkPwg0Z/3vFCflriKjHnOfAhV0Ic5IL1SJySyAnMOZca6aW7bXf2Kl2MCx6NpklYBMrKckJA=
X-Received: by 2002:a25:a508:: with SMTP id h8mr1616308ybi.52.1566072226734;
 Sat, 17 Aug 2019 13:03:46 -0700 (PDT)
MIME-Version: 1.0
From:   Gaiseric Vandal <gaiseric.vandal@gmail.com>
Date:   Sat, 17 Aug 2019 16:03:36 -0400
Message-ID: <CAGJ3EkWrHPAD04cEcp9P6Hg4jtNFpiGSCSue+5T7oUL+sbhcUQ@mail.gmail.com>
Subject: Upgrade to gitweb-1.8.3.1-20 on centos7 breaks git access
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently applied the latest patches on centos7, including
gitweb-1.8.3.1-20.      When I try to access git repos (either via web
browser or git command line.) Repos are configured to require LDAP
authentication.


I should be able to access repo ABC via

https://myserver.domain.com/git/ABC

I get the correct user login prompt but then , after logging, get
following error

     The requested URL /git/ABC/ was not found on this server.

I don't think any of the config files got changed.

My partial config is

     # cat /etc/httpd/conf.d/git.conf
     Alias /git /var/www/git

     <Directory /var/www/git>
      Options +ExecCGI
      AddHandler cgi-script .cgi
      DirectoryIndex gitweb.cgi
     </Directory>
     #



     # cat /etc/httpd/conf.d/gitrepos.conf
     SetEnv GIT_PROJECT_ROOT /export/gitrepos
     SetEnv GIT_HTTP_EXPORT_ALL
     ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/

     RewriteEngine on
     RewriteCond %{QUERY_STRING} service=git-receive-pack [OR]
     RewriteCond %{REQUEST_URI} /git-receive-pack$
     RewriteRule ^/git/ - [E=AUTHREQUIRED]

     <Files "git-http-backend">
     AuthType Basic
     AuthBasicProvider ldap
     AuthLDAPURL "ldaps://xxxxxxxxxxxxxxx)"
     AuthLDAPBindDN  "uid=xxxxxxxxxxxx"
     AuthLDAPBindPassword xxxxxxxxxxxxxxx
     AuthName "Git Access"
     Require user xxxxx xxxxx xxxxx
     Order deny,allow
     Deny from env=AUTHREQUIRED
     Satisfy any
     </Files>


     <Location /git/ABC>
     AuthType Basic
     AuthBasicProvider ldap
     AuthLDAPURL "ldaps://xxxxxxxxxxxxxxx)"
     AuthLDAPBindDN  "uid=xxxxxxxxxxxx"
     AuthLDAPBindPassword xxxxxxxxxxxxxxx
     AuthName "Git Access ABC"
     Require user xxxxx xxxxx xxxxx
     Order deny,allow
</Location>



The /var/www/git/gitweb.cgi file has the default settings.

...
our $GIT = "/usr/bin/git";

# absolute fs-path which will be prepended to the project path
our $projectroot = "/var/lib/git";
#our $projectroot = "/export/gitrepos";

...


If I set $projectroot to point to /export/gitrepos, I can see a list
of projects when I browse to https://myserver.domain.com/git-
however I wanted to minimize how much information was exposed with no
authentication.      And it didn't fix the access problem.
The "git" command is in the default OS path.   changing
      our $GIT = "/usr/bin/git";
to
     our $GIT = "git";

did not help.


The only thing in the httpd error logs that looks relevant is

[Sat Aug 17 15:39:39.826265 2019] [core:info] [pid 15870] [client
xxxxx] AH00128: File does not exist: /var/www/git/ABC/
[Sat Aug 17 15:39:44.831598 2019] [ssl:info] [pid 15870] (70007)The
timeout specified has expired: [client xxxxx] AH01991: SSL input
filter read failed.


selinux is disabled.

Since I am getting an authentication prompt with "Git Access ABC" in
the dialog box it seems clear that the project root is being picked up
from  /etc/httpd/conf.d/gitrepos.conf and that the
/usr/libexec/git-core/git-http-backend script is being run.


Appreciate any advice.

Thanks
