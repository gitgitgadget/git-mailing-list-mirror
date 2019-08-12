Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NUMERIC_HTTP_ADDR,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,WEIRD_PORT shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FB1A1F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 15:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfHLPJY (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 11:09:24 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:40395 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726791AbfHLPJY (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Aug 2019 11:09:24 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 4BDFD22025
        for <git@vger.kernel.org>; Mon, 12 Aug 2019 11:09:23 -0400 (EDT)
Received: from imap29 ([10.202.2.79])
  by compute2.internal (MEProxy); Mon, 12 Aug 2019 11:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailc.net; h=
        mime-version:message-id:date:from:to:subject:content-type; s=
        fm1; bh=w+kMyUTi7ZXXRAumTzigk5PY4Gi/FW+7J2+cVR8iL4g=; b=kmO0WhkN
        pQvUDswSi3xWlqhl99yiDXqLdcVVKoZDbvnD0r6qNmugnXrl5dJE93k19kXf+jRs
        QEn+ro7W85HsRmwu+fVgz9uRSSZaB5JzcnQFyi1TNFEqzWlUKVPCNSF8oPU8Ih7n
        i22YW6gfMQ8Uy0MW5szGJ0LbVa+v9sy6LeqPGnbgxTQJ9ZplOuGHM1dkZHsVRcL3
        w5DlSQ5OCwaUeayVvo5g066Rz1L65kd5To88AxthAmVxTuO0JDtaPKrcBZIH4zNE
        Q9vJ+d59J8t8xWLSKlywT0Bycz7yKideaWUr/eSSh+tRyBysZF3KUq+hUFjow+IH
        ylQfnDfBaxpi/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=w+kMyUTi7ZXXRAumTzigk5PY4Gi/F
        W+7J2+cVR8iL4g=; b=mXIhvptiO3NIxYBizaLcAonW6wZZ7S1hcUEw/YcUVWWNV
        YT2PEuMkJgog5OkXuWcjG6qJninCEMpGpZpCLB7G5bpuQdRKdzq24cW1LyAbKzBN
        oBlD7q3jJPZV3V9UbBiirs9X2LVRig21Muq8/UtnKAN/OpFmEeZPv5O+iFnx7BdV
        XSDfQ3MW8duQqgC8IN6/SptBMuastuUdX6BWdnPehGI/hz3/ZmaANHXHtyuq7LWp
        BM0vxua1s0wSoPLyMJvAEFb9IRy+gBxnhsspYI87+6RnMYO3ueKu1xM9uUnC6XH/
        a1+UWEPdc6v/8LyaC+UKfVN2D3bSpgFNNg5Y1w5sQ==
X-ME-Sender: <xms:IoFRXb_gHO_yuvI14KCwWocYnSKwSKY5hWhwX1WaOk-tj8T77m-cYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddvgedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpehkohhotghrsehmrghilhgtrdhnvghtnecuffhomhgrihhnpehn
    ghhinhigrdhorhhgpdhrvggrughthhgvughotghsrdhiohdpuddvjedrtddrtddrudenuc
    frrghrrghmpehmrghilhhfrhhomhepkhhoohgtrhesmhgrihhltgdrnhgvthenucevlhhu
    shhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:I4FRXdrUnaUt6whjcetrAhyqloyVNH4Zdzgjsx9-Ar2J7FFQyfEX4w>
    <xmx:I4FRXSuIrJ0D0S9dPoXeb8GFaxxrfpBce3qJTY21ofD2RoIRBxORYw>
    <xmx:I4FRXYTAjOmJ_Xo4ftmW97gGQRZ_BhXIXuxz-H0W4us8u8eh3ny6uA>
    <xmx:I4FRXaclaSdNDGEsx5vz0SURd1lb4F4Ua3k5hOsDkna58NPoZoLSng>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C6E509C009E; Mon, 12 Aug 2019 11:09:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-809-g8e5c451-fmstable-20190809v1
Mime-Version: 1.0
Message-Id: <88cc039d-2bf8-4c1d-90c4-486ff661c1e9@www.fastmail.com>
Date:   Mon, 12 Aug 2019 08:09:22 -0700
From:   koocr@mailc.net
To:     git@vger.kernel.org
Subject: How to get gitweb setup with nginx + uwsgi?
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all.

I'm setting up a local Git server, with Gitweb + Gitolite.

The gitolite wrapper is installed & working.  Now I'm working on the Gitweb frontend.

I run Nginx as my webserver.  Usually with PHP, using fpm.

Gitweb's gitweb.cgi looks like it needs perl CGI.

For perl cgi I'm trying to get it working with UWSGI,

	https://uwsgi-docs.readthedocs.io/en/latest/Nginx.html
	https://nginx.org/en/docs/http/ngx_http_uwsgi_module.html#example

I installed

	git --version
		git version 2.22.0
	ls -al /usr/share/gitweb/gitweb.cgi
		-rwxr-xr-x 1 root root 247K Jul 24 05:27 /usr/share/gitweb/gitweb.cgi
	grep "\$version =" /usr/share/gitweb/gitweb.cgi
		our $version = "2.22.0";
	nginx -v
		nginx version: nginx/1.17.1 
	uwsgi --version
		2.0.18

I set up the nginx vhost

	server { 
	    listen 127.0.0.1:60080 http2;
	    root /usr/share/gitweb;
	    index  gitweb.cgi;

	    location / {
	        try_files $uri $uri/ @gitweb;
	    }
	    location @gitweb {
	        root /usr/share/gitweb;
	        include uwsgi_params;
	        gzip off;
	        uwsgi_param UWSGI_SCRIPT gitweb;
	        uwsgi_param GITWEB_CONFIG /etc/gitweb/gitweb.conf;
	        uwsgi_pass unix:/run/uwsgi/uwsgi.sock;
	        uwsgi_modifier1 5;
	    }
	}

and the uwsgi server

	/etc/uwsgi/uwsgi.ini
		[uwsgi]
		strict = 1

		master = true
		processes = 2

		binary-path = /usr/sbin/uwsgi
		plugin-dir = /usr/lib64/uwsgi
		logto = /var/log/uwsgi/uwsgi.log

		uid = wwwrun
		gid = www
		umask = 022

		uwsgi-socket = /run/uwsgi/uwsgi.sock
		chmod-socket = 660
		chown-socket = wwwrun:www

		plugins = http,psgi
		chdir = /usr/share/gitweb
		psgi = gitweb.cgi


nginx & uwsgi services are both running

	ps aux | egrep "nginx|uwsgi"
		wwwrun   17463  0.0  0.1  89468 23704 ?        Ss   07:03   0:00 /usr/sbin/uwsgi --autoload --ini /etc/uwsgi/uwsgi.ini
		wwwrun   17465  0.0  0.1  97664 17184 ?        Sl   07:03   0:00 /usr/sbin/uwsgi --autoload --ini /etc/uwsgi/uwsgi.ini
		wwwrun   17468  0.0  0.1  97664 17184 ?        Sl   07:03   0:00 /usr/sbin/uwsgi --autoload --ini /etc/uwsgi/uwsgi.ini
		root     18006  0.0  0.0 211264  4276 ?        Ss   07:10   0:00 nginx: master process /opt/nginx/sbin/nginx -c /etc/nginx/nginx.conf -g pid /run/nginx.pid;
		wwwrun   18007  0.0  0.0 211416  5492 ?        S    07:10   0:00 nginx: worker process
		wwwrun   18008  0.0  0.0 212068 10300 ?        S    07:10   0:00 nginx: worker process
		wwwrun   18009  0.0  0.0 211416  5492 ?        S    07:10   0:00 nginx: worker process
		wwwrun   18011  0.0  0.0 211416  5492 ?        S    07:10   0:00 nginx: worker process
		wwwrun   18012  0.0  0.0 211452  5052 ?        S    07:10   0:00 nginx: cache manager process

	ls -al /run/uwsgi/uwsgi.sock
		srw-rw---- 1 wwwrun www  0 Aug 12 07:03 /run/uwsgi/uwsgi.sock=

when I go to the site

	http://127.0.0.1:60080/

I just get the script listing in the browser

	#!/usr/bin/perl
	 
	# gitweb - simple web interface to track changes in git repositories
	#
	# (C) 2005-2006, Kay Sievers <kay.sievers@vrfy.org>
	# (C) 2005, Christian Gierke
	#
	# This program is licensed under the GPLv2
	 
	use 5.008;
	use strict;
	use warnings;
	...

no errors anywhere, just the script display.

I'm missing something basic since it's not running the script. :-/

Anyone have any experience with gitweb + uwsgi on nginx?  Or know a good working example?

Thanks!


