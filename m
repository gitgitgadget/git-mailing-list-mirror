Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDE212E7E
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722441682; cv=none; b=gNQ3K3jhpAZAJRZ5C2Uz97+jV6ooyQmqWNAZW4h3xTC0Bfr/0MROfSTwW7ezfnif4y6SgoyiVFN8jwVreM/5+8NTtJjIlKH2WdGK+uw5UIi5sNhFcXXmIg+DCAaErT9c7iOoYnBSBRNe8TePkzFUjLZKtft1U2p+RASVtO/ETYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722441682; c=relaxed/simple;
	bh=nAAhGk2eJu67rFRMBvZ64LQ4doIFz8Zw/qkItqQprWk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WOGsiz8dzaAiMDcerDiKkmo+iYUR6e/ZoWCpBTumkSnrWumpzVXkfE1CCZO5IxXIMNo7in6bzPN5+C8VZZ+2SdzRDL+QgHN1/Pz6kEiO1LmFp6jnox91cBWQGSTfP7Zq63GK4PBNKNnKg6BLNV8u7aB5sVLegp4cI/fMSk0eoy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4ES8RQC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4ES8RQC"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-428035c0bb2so6638045e9.1
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 09:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722441678; x=1723046478; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpkxAV2E9M8UuXKD42S2KArpUFdEyr3bWTtTVZilnBs=;
        b=O4ES8RQCHtUgSHQRnybR7aCrZGGh2Lycv9x8J9w7MTIU4LQK6Dupogw4oOy2hUQLJx
         Qab1b5q9vihZ6Cmviq+MtkIOGm/43a2NtZuoXyqcLLmD0oAMld/TmQmKFZMfntJixnqp
         SlynP1HNz4KgGz9xAZnE5U5ZiCgoXhQMYQCY2QEng5tP1CYWpQVzkJtyiEtn/rPfXHUG
         4q6KEXQs42GhKuxah5nE9KrIJ6+iTZrJAQnGlt8dSyPounfkArD9mIdmmiZf2VNxA4jh
         PD7xLCqmnddejJVVVnyOt1utHKKEXpGUgtxCziMQpLdUgl1oyfuZOqNd4GC41Oe+Tyvx
         V4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722441678; x=1723046478;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpkxAV2E9M8UuXKD42S2KArpUFdEyr3bWTtTVZilnBs=;
        b=Vy4MLill2PulbQgeMXsJalx/8rRgZNdcXkwHNx6t8onn0/BZ3lwysUf7sFLAUm8aK0
         j3/FV4S4UHqEVv3yAGqLNtWTzCUyTjKuypnZ1Y3pRqNq9eVnf13K7Fd2I67Pm8mAoiBZ
         wffr8v6TwqFApdwvkxxmDvg5ly+BsXG2goFi1iB8s7XhOzinno+KklSNfoXbK32uo5u2
         aM+qTyUwlq1C5DPkuySXHjkASMFHG/mJucQ7z092mEKGWuTrkwKOKaYhxNC61PM52Z19
         rXmyi6HiMC619+mmpQX3xPugCqRDdHOYpybVQ697QGZhTzruzWtOZhGWRwKzfx+p3lmO
         4BYQ==
X-Gm-Message-State: AOJu0Yy8C//as3Gz0MFXq9n46uggG6fWFuBp+uY3rYZR2z3QfV59EZ3Q
	ZZDieYYXWtnw66kkWu8fXy2RWDbl+XOxSsfmA0iWuA0qc79dOXMITY9Qxg==
X-Google-Smtp-Source: AGHT+IFioB6+O9BqPFgq9Hkji8Tdq6S+LC0KeTZrkA3vZiE4T9JLwIGMb58qQlfeRst/qp+yB6e/9Q==
X-Received: by 2002:a05:6000:18aa:b0:367:89ae:c204 with SMTP id ffacd0b85a97d-36b8c8e5d30mr5160500f8f.12.1722441677426;
        Wed, 31 Jul 2024 09:01:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bafc2dbsm25648735e9.40.2024.07.31.09.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 09:01:17 -0700 (PDT)
Message-Id: <pull.1767.v3.git.1722441675945.gitgitgadget@gmail.com>
In-Reply-To: <pull.1767.v2.git.1722062682858.gitgitgadget@gmail.com>
References: <pull.1767.v2.git.1722062682858.gitgitgadget@gmail.com>
From: "Ryan Hendrickson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 31 Jul 2024 16:01:15 +0000
Subject: [PATCH v3] http: do not ignore proxy path
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>,
    Jeff King <peff@peff.net>,
    Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>,
    Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>

From: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>

The documentation for `http.proxy` describes that option, and the
environment variables it overrides, as supporting "the syntax understood
by curl". curl allows SOCKS proxies to use a path to a Unix domain
socket, like `socks5h://localhost/path/to/socket.sock`. Git should
therefore include, if present, the path part of the proxy URL in what it
passes to libcurl.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
---
    http: do not ignore proxy path
    
    Re earlier discussion about regressions, it turns out that curl has only
    supported this syntax since 2022 [https://curl.se/ch/7.84.0.html].
    Earlier versions of curl, if provided an http_proxy that contained a
    path, would also ignore it. curl didn't seem to consider this a breaking
    change when the feature was introduced
    [https://github.com/curl/curl/pull/8668], though; is that a valid
    argument for Git not to lose sleep over it either?
    
    A test has been added, but unfortunately it is not being run on any of
    GitHub's CI workflows, because the runner images in use all have
    versions of libcurl that are too old. It works on my machine, but
    unknown troubles may await someone else.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1767%2Frhendric%2Frhendric%2Fhttp-proxy-path-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1767/rhendric/rhendric/http-proxy-path-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1767

Range-diff vs v2:

 1:  b4715eba5b1 ! 1:  7a58da7102e http: do not ignore proxy path
     @@ Commit message
          therefore include, if present, the path part of the proxy URL in what it
          passes to libcurl.
      
     +    Co-authored-by: Jeff King <peff@peff.net>
          Signed-off-by: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
      
       ## Documentation/config/http.txt ##
     @@ http.c: static CURL *get_curl_handle(void)
      -		curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
      +		strbuf_addstr(&proxy, proxy_auth.host);
      +		if (proxy_auth.path) {
     -+			int path_is_supported = 0;
     -+			/* curl_version_info was added in curl 7.10 */
     -+#if LIBCURL_VERSION_NUM >= 0x070a00
      +			curl_version_info_data *ver = curl_version_info(CURLVERSION_NOW);
     -+			path_is_supported = ver->version_num >= 0x075400;
     -+#endif
     -+			if (path_is_supported) {
     -+				strbuf_addch(&proxy, '/');
     -+				strbuf_add_percentencode(&proxy, proxy_auth.path, 0);
     -+			} else {
     ++			if (ver->version_num < 0x075400)
      +				die("libcurl 7.84 or later is required to support paths in proxy URLs");
     -+			}
     ++
     ++			if (!starts_with(proxy_auth.protocol, "socks"))
     ++				die("Invalid proxy URL '%s': only SOCKS proxies support paths",
     ++				    curl_http_proxy);
     ++
     ++			if (strcasecmp(proxy_auth.host, "localhost"))
     ++				die("Invalid proxy URL '%s': host must be localhost if a path is present",
     ++				    curl_http_proxy);
     ++
     ++			strbuf_addch(&proxy, '/');
     ++			strbuf_add_percentencode(&proxy, proxy_auth.path, 0);
      +		}
      +		curl_easy_setopt(result, CURLOPT_PROXY, proxy.buf);
      +		strbuf_release(&proxy);
     @@ http.c: static CURL *get_curl_handle(void)
       		var_override(&curl_no_proxy, getenv("no_proxy"));
       		curl_easy_setopt(result, CURLOPT_NOPROXY, curl_no_proxy);
      
     - ## t/socks5-proxy-server/LICENSE (new) ##
     -@@
     -+MIT License
     -+
     -+Copyright (c) 2014 kaimi.io
     -+
     -+Permission is hereby granted, free of charge, to any person obtaining a copy
     -+of this software and associated documentation files (the "Software"), to deal
     -+in the Software without restriction, including without limitation the rights
     -+to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
     -+copies of the Software, and to permit persons to whom the Software is
     -+furnished to do so, subject to the following conditions:
     -+
     -+The above copyright notice and this permission notice shall be included in all
     -+copies or substantial portions of the Software.
     -+
     -+THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
     -+IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
     -+FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
     -+AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
     -+LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
     -+OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
     -+SOFTWARE.
     -
     - ## t/socks5-proxy-server/README.md (new) ##
     -@@
     -+socks5-proxy-server
     -+===================
     -+
     -+This Perl code implements a SOCKS5 proxy server that listens for incoming connections and processes them in separate threads. The server takes three input parameters: `path`, `login`, and `password`.
     -+
     -+When a client attempts to connect to the server, the server checks if the client supports any of the available authentication methods (no authentication or login/password authentication). If a suitable method is found, the server establishes a connection with the target server and begins forwarding data between the client and the target server.
     -+
     -+The code uses the `IO::Select` module for working with sockets and the `threads` module for creating and managing threads. It includes several functions, including:
     -+
     -+- `main`: the main function that creates threads for processing incoming connections.
     -+- `replenish`: a function that creates additional threads if the number of free threads is less than the specified value.
     -+- `new_client`: a function that handles incoming client connections and checks if the available authentication methods are supported by the client.
     -+- `socks_auth`: a function that performs login and password authentication.
     -+- `handle_client`: a function that establishes a connection with the target server and forwards data between the client and the target server.
     -+
     -+This code includes the use of the following Perl modules: `IO::Select`, `Socket`, `threads`, `threads::shared`.
     -+
     -+To run this code, enter the following command:
     -+`perl socks5.pl path login password`
     -+
     -+Note that this code is designed for educational purposes and should not be used in production environments without proper modifications and security measures. 😊
     -+
     -+This code is distributed under the [MIT License](LICENSE), which allows for free use, modification, and distribution of the code as long as the original copyright notice and license are included.
     -+
     -+---
     -+
     -+Originally from: https://github.com/kaimi-io/socks5-proxy-server
     -
     - ## t/socks5-proxy-server/src/socks5.pl (new) ##
     + ## t/socks4-proxy.pl (new) ##
      @@
     -+#!/usr/bin/perl
     -+#В коде использованы части rdss (.Slip) и sss (hm2k)
      +use strict;
      +use IO::Select;
     -+use Socket;
     -+use threads;
     -+use threads::shared;
     ++use IO::Socket::UNIX;
     ++use IO::Socket::INET;
      +
     -+if(scalar @ARGV < 1)
     -+{
     -+	die "Usage: serv.pl path login pass\n";
     -+}
     ++my $path = shift;
      +
     -+my ($path, $login, $passw) = @ARGV;
     -+
     -+my %config = (thr_init => 10, thr_min => 2, thr_max => 20, conn_limit => SOMAXCONN);
     ++unlink($path);
     ++my $server = IO::Socket::UNIX->new(Listen => 1, Local => $path)
     ++	or die "unable to listen on $path: $!";
      +
      +$| = 1;
     ++print "ready\n";
      +
     -+my %status : shared;
     -+my $accept : shared;
     -+
     -+my $sock_addr = sockaddr_un $path or die $!;
     -+socket my $socket, PF_UNIX, SOCK_STREAM, 0;
     -+bind $socket, $sock_addr or die $!;
     -+listen $socket, $config{'conn_limit'} or die $!;
     -+
     -+
     -+my $sel = IO::Select->new($socket);
     -+
     -+print "Starting...\n";
     -+
     -+replenish($config{'thr_init'});
     -+
     -+while(1)
     -+{
     -+	lock %status;
     -+	cond_wait %status;
     ++while (my $client = $server->accept()) {
     ++	sysread $client, my $buf, 8;
     ++	my ($version, $cmd, $port, $ip) = unpack 'CCnN', $buf;
     ++	next unless $version == 4; # socks4
     ++	next unless $cmd == 1; # TCP stream connection
      +
     -+	my @free = sort {$a <=> $b} grep {$status{$_} eq 'free'} keys %status;
     -+
     -+	if(scalar @free < $config{'thr_min'})
     -+	{
     -+		replenish($#free - $config{'thr_min'});
     -+	}
     -+	elsif(scalar @free > $config{'thr_max'})
     -+	{
     -+		my @kill = @free[0..$#free - $config{'thr_max'}];
     -+		status($_ => 'kill') for @kill;
     ++	# skip NUL-terminated id
     ++	while (sysread $client, my $char, 1) {
     ++		last unless ord($char);
      +	}
     -+}
     -+
     -+status($_ => 'kill') for keys %status;
     -+
     -+sub main
     -+{
     -+	my $sock = shift;
     -+	my $loop = 50;
     -+
     -+	my $tid = threads->tid;
     -+	my $conn;
     -+
     -+	threads->self->detach;
     -+	status($tid, 'free');
     -+
     -+	while(status($tid) ne 'kill' && $loop > 0)
     -+	{
     -+		next unless $sel->can_read(.1);
     -+		{
     -+			lock $accept;
     -+			next unless accept $conn, $sock;
     -+		}
     -+		$loop--;
     -+		status($tid => 'work');
     -+		new_client($conn);
     -+		close $conn;
     -+		status($tid => 'free');
     -+	}
     -+
     -+	status($tid, 'kill');
     -+}
     -+
     -+sub status
     -+{
     -+	my ($tid, $state) = @_;
     -+	lock %status;
     -+
     -+	return $status{$tid} unless $state;
     -+	if($state)
     -+	{
     -+		$status{$tid} = $state unless defined $status{$tid} and $status{$tid} eq 'kill';
     -+	}
     -+	else
     -+	{
     -+		delete $status{$tid};
     -+	}
     -+
     -+	cond_broadcast %status;
     -+}
     -+
     -+sub replenish
     -+{
     -+	threads->create(\&main, $socket) for 1..$_[0];
     -+}
     -+
     -+sub new_client
     -+{
     -+	my $sock = shift;
     -+
     -+	sysread $sock, my $buf, 2;
     -+
     -+	my ($ver, $auth_num) = unpack('H2H2', $buf);
     -+	#Версия протокола
     -+	return unless $ver eq '05';
     -+	sysread $sock, $buf, $auth_num;
      +
     -+	my $ok = 0;
     -+	#Перечисление методов авторизации
     -+	for(my ($mode, $i) = (0, 0); $i < $auth_num; $mode = ord substr $buf, ++$i, 1)
     -+	{
     -+		#0 - Без авторизации; 2 - Username/Password
     -+		if($mode == 0 && !$login)
     -+		{
     -+			syswrite $sock, "\x05\x00";
     -+			$ok++;
     -+			last;
     -+		}
     -+		elsif($mode == 2 && $login)
     -+		{
     -+			return unless socks_auth($sock);
     -+			$ok++;
     -+			last;
     -+		}
     -+	}
     -+	#Подходящие методы есть
     -+	if($ok)
     -+	{
     -+		sysread $sock, $buf, 3;
     -+		my ($ver, $cmd, $r) = unpack 'H2H2H2', $buf;
     -+
     -+		if($ver eq '05' && $r eq '00')
     -+		{
     -+			my ($client_host, $client_host_raw, $client_port, $client_port_raw) = get_conn_info($sock);
     -+			return unless ($client_host || $client_port);
     -+
     -+			syswrite $sock, "\x05\x00\x00".$client_host_raw.$client_port_raw;
     -+			handle_client($sock, $client_host, $client_port, $cmd);
     -+		}
     -+	}
     -+	else
     -+	{
     -+		syswrite $sock, "\x05\xFF";
     -+	}
     -+}
     -+
     -+sub socks_auth
     -+{
     -+	my $sock = shift;
     -+
     -+	syswrite $sock, "\x05\x02";
     -+	sysread $sock, my $buf, 1;
     -+
     -+	if(ord $buf == 1)
     -+	{
     -+		#username length : username : password length : password
     -+		sysread $sock, $buf, 1;
     -+		sysread $sock, my $s_login, ord($buf);
     -+		sysread $sock, $buf, 1;
     -+		sysread $sock, my $s_passw, ord($buf);
     -+
     -+		#0x00 = success; any other value = failure
     -+		if($login eq $s_login && $passw eq $s_passw)
     -+		{
     -+			syswrite $sock, "\x05\x00";
     -+			return 1;
     -+		}
     -+		else
     -+		{
     -+			syswrite $sock, "\x05\x01";
     -+		}
     -+	}
     -+
     -+	return 0;
     -+}
     -+
     -+sub handle_client
     -+{
     -+	my ($sock, $host, $port, $cmd) = @_;
     -+
     -+	#0x01 = establish a TCP/IP stream connection
     -+	if($cmd == 1)
     -+	{
     -+		my $sock_addr = sockaddr_in $port, inet_aton($host) or return;
     -+		socket my $target, PF_INET, SOCK_STREAM, getprotobyname('tcp') or return;
     -+		connect $target, $sock_addr or return;
     -+
     -+		while($sock || $target)
     -+		{
     -+			my ($rin, $cbuf, $tbuf, $rout, $eout) = ('', '', '', '', '');
     -+			vec($rin, fileno($sock), 1) = 1 if $sock;
     -+			vec($rin, fileno($target), 1) = 1 if $target;
     -+			select($rout = $rin, undef, $eout = $rin, 120);
     -+			return if(!$rout && !$eout);
     -+
     -+			if($sock && (vec($eout, fileno($sock), 1) || vec($rout, fileno($sock), 1)))
     -+			{
     -+				my $res = sysread $sock, $tbuf, 1024;
     -+				return if(!defined $res || !$res);
     -+			}
     -+			if($target && (vec($eout, fileno($target), 1) || vec($rout, fileno($target), 1)))
     -+			{
     -+				my $res = sysread $target, $cbuf, 1024;
     -+				return if(!defined $res || !$res);
     -+			}
     -+			while(my $len = length($tbuf))
     -+			{
     -+				my $r = syswrite $target, $tbuf, $len;
     -+				return if(!defined $r || $r <= 0);
     -+				$tbuf = substr($tbuf, $r);
     -+			}
     -+			while(my $len = length($cbuf))
     -+			{
     -+				my $r = syswrite $sock, $cbuf, $len;
     -+				return if(!defined $r || $r <= 0);
     -+				$cbuf = substr($cbuf, $r);
     ++	# version(0), reply(5a == granted), port (ignored), ip (ignored)
     ++	syswrite $client, "\x00\x5a\x00\x00\x00\x00\x00\x00";
     ++
     ++	my $remote = IO::Socket::INET->new(PeerHost => $ip, PeerPort => $port)
     ++		or die "unable to connect to $ip/$port: $!";
     ++
     ++	my $io = IO::Select->new($client, $remote);
     ++	while ($io->count) {
     ++		for my $fh ($io->can_read(0)) {
     ++			for my $pair ([$client, $remote], [$remote, $client]) {
     ++				my ($from, $to) = @$pair;
     ++				next unless $fh == $from;
     ++
     ++				my $r = sysread $from, my $buf, 1024;
     ++				if (!defined $r || $r <= 0) {
     ++					$io->remove($from);
     ++					next;
     ++				}
     ++				syswrite $to, $buf;
      +			}
      +		}
      +	}
     -+}
     -+
     -+sub get_conn_info
     -+{
     -+	my $sock = shift;
     -+
     -+	my ($host, $raw_host) = ('', '');
     -+	sysread $sock, my $buf, 1;
     -+	($raw_host, $buf) = ($buf, ord $buf);
     -+	#0x01 = IPv4 address; 0x03 = Domain name
     -+	if($buf == 1)
     -+	{
     -+		#4 bytes for IPv4 address
     -+		sysread $sock, $buf, 4;
     -+		$raw_host .= $buf;
     -+		$host = join '.', map(ord, split //, $buf);
     -+	}
     -+	elsif($buf == 3)
     -+	{
     -+		#1 byte of name length followed by the name for Domain name
     -+		sysread $sock, $buf, 1;
     -+		sysread $sock, $host, ord($buf);
     -+		$raw_host .= $host;
     -+	}
     -+
     -+	#port number in a network byte order, 2 bytes
     -+	my ($port, $raw_port) = ('', '');
     -+	sysread $sock, $raw_port, 2;
     -+	$port = ord(substr($raw_port, 0, 1)) << 8 | ord(substr($raw_port, 1, 1));
     -+
     -+	return $host, $raw_host, $port, $raw_port;
      +}
      
       ## t/t5564-http-proxy.sh ##
     @@ t/t5564-http-proxy.sh: test_expect_success 'clone can prompt for proxy password'
       '
       
      +start_socks() {
     ++	mkfifo socks_output &&
     ++	{
     ++		"$PERL_PATH" "$TEST_DIRECTORY/socks4-proxy.pl" "$1" >socks_output &
     ++		socks_pid=$!
     ++	} &&
     ++	read line <socks_output &&
     ++	test "$line" = ready
     ++}
     ++
     ++test_expect_success PERL 'try to start SOCKS proxy' '
      +	# The %30 tests that the correct amount of percent-encoding is applied
      +	# to the proxy string passed to curl.
     -+	"$PERL_PATH" "$TEST_DIRECTORY/socks5-proxy-server/src/socks5.pl" \
     -+		"$TRASH_DIRECTORY/%30.sock" proxuser proxpass &
     -+	socks_pid=$!
     -+}
     ++	if start_socks %30.sock
     ++	then
     ++		test_set_prereq SOCKS_PROXY
     ++	fi
     ++'
     ++
     ++test_expect_success SOCKS_PROXY 'clone via Unix socket' '
     ++	test_when_finished "rm -rf clone" &&
     ++	test_config_global http.proxy "socks4://localhost$PWD/%2530.sock" && {
     ++		{
     ++			GIT_TRACE_CURL=$PWD/trace git clone "$HTTPD_URL/smart/repo.git" clone 2>err &&
     ++			grep -i "SOCKS4 request granted." trace
     ++		} ||
     ++		grep "^fatal: libcurl 7\.84 or later" err
     ++	}
     ++'
      +
     -+test_lazy_prereq LIBCURL_7_84 'expr x$(curl-config --vernum) \>= x075400'
     ++test_expect_success SOCKS_PROXY 'stop SOCKS proxy' 'kill "$socks_pid"'
      +
     -+test_expect_success PERL,LIBCURL_7_84 'clone via Unix socket' '
     -+	start_socks &&
     -+	test_when_finished "rm -rf clone && kill $socks_pid" &&
     -+	test_config_global http.proxy "socks5://proxuser:proxpass@localhost$PWD/%2530.sock" &&
     -+	GIT_TRACE_CURL=$PWD/trace git clone "$HTTPD_URL/smart/repo.git" clone &&
     -+	grep -i "SOCKS5 request granted." trace
     ++test_expect_success 'Unix socket requires socks*:' '
     ++	! git clone -c http.proxy=localhost/path https://example.com/repo.git 2>err && {
     ++		grep "^fatal: Invalid proxy URL '\''localhost/path'\'': only SOCKS proxies support paths" err ||
     ++		grep "^fatal: libcurl 7\.84 or later" err
     ++	}
     ++'
     ++
     ++test_expect_success 'Unix socket requires localhost' '
     ++	! git clone -c http.proxy=socks4://127.0.0.1/path https://example.com/repo.git 2>err && {
     ++		grep "^fatal: Invalid proxy URL '\''socks4://127\.0\.0\.1/path'\'': host must be localhost if a path is present" err ||
     ++		grep "^fatal: libcurl 7\.84 or later" err
     ++	}
      +'
      +
       test_done


 Documentation/config/http.txt |  4 +--
 http.c                        | 22 +++++++++++++++-
 t/socks4-proxy.pl             | 48 +++++++++++++++++++++++++++++++++++
 t/t5564-http-proxy.sh         | 46 +++++++++++++++++++++++++++++++++
 4 files changed, 117 insertions(+), 3 deletions(-)
 create mode 100644 t/socks4-proxy.pl

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index 162b33fc52f..a14371b5c96 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -5,8 +5,8 @@ http.proxy::
 	proxy string with a user name but no password, in which case git will
 	attempt to acquire one in the same way it does for other credentials. See
 	linkgit:gitcredentials[7] for more information. The syntax thus is
-	'[protocol://][user[:password]@]proxyhost[:port]'. This can be overridden
-	on a per-remote basis; see remote.<name>.proxy
+	'[protocol://][user[:password]@]proxyhost[:port][/path]'. This can be
+	overridden on a per-remote basis; see remote.<name>.proxy
 +
 Any proxy, however configured, must be completely transparent and must not
 modify, transform, or buffer the request or response in any way.  Proxies which
diff --git a/http.c b/http.c
index 623ed234891..a50ba095889 100644
--- a/http.c
+++ b/http.c
@@ -1227,6 +1227,7 @@ static CURL *get_curl_handle(void)
 		 */
 		curl_easy_setopt(result, CURLOPT_PROXY, "");
 	} else if (curl_http_proxy) {
+		struct strbuf proxy = STRBUF_INIT;
 		if (starts_with(curl_http_proxy, "socks5h"))
 			curl_easy_setopt(result,
 				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS5_HOSTNAME);
@@ -1265,7 +1266,26 @@ static CURL *get_curl_handle(void)
 		if (!proxy_auth.host)
 			die("Invalid proxy URL '%s'", curl_http_proxy);
 
-		curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
+		strbuf_addstr(&proxy, proxy_auth.host);
+		if (proxy_auth.path) {
+			curl_version_info_data *ver = curl_version_info(CURLVERSION_NOW);
+			if (ver->version_num < 0x075400)
+				die("libcurl 7.84 or later is required to support paths in proxy URLs");
+
+			if (!starts_with(proxy_auth.protocol, "socks"))
+				die("Invalid proxy URL '%s': only SOCKS proxies support paths",
+				    curl_http_proxy);
+
+			if (strcasecmp(proxy_auth.host, "localhost"))
+				die("Invalid proxy URL '%s': host must be localhost if a path is present",
+				    curl_http_proxy);
+
+			strbuf_addch(&proxy, '/');
+			strbuf_add_percentencode(&proxy, proxy_auth.path, 0);
+		}
+		curl_easy_setopt(result, CURLOPT_PROXY, proxy.buf);
+		strbuf_release(&proxy);
+
 		var_override(&curl_no_proxy, getenv("NO_PROXY"));
 		var_override(&curl_no_proxy, getenv("no_proxy"));
 		curl_easy_setopt(result, CURLOPT_NOPROXY, curl_no_proxy);
diff --git a/t/socks4-proxy.pl b/t/socks4-proxy.pl
new file mode 100644
index 00000000000..4c3a35c0083
--- /dev/null
+++ b/t/socks4-proxy.pl
@@ -0,0 +1,48 @@
+use strict;
+use IO::Select;
+use IO::Socket::UNIX;
+use IO::Socket::INET;
+
+my $path = shift;
+
+unlink($path);
+my $server = IO::Socket::UNIX->new(Listen => 1, Local => $path)
+	or die "unable to listen on $path: $!";
+
+$| = 1;
+print "ready\n";
+
+while (my $client = $server->accept()) {
+	sysread $client, my $buf, 8;
+	my ($version, $cmd, $port, $ip) = unpack 'CCnN', $buf;
+	next unless $version == 4; # socks4
+	next unless $cmd == 1; # TCP stream connection
+
+	# skip NUL-terminated id
+	while (sysread $client, my $char, 1) {
+		last unless ord($char);
+	}
+
+	# version(0), reply(5a == granted), port (ignored), ip (ignored)
+	syswrite $client, "\x00\x5a\x00\x00\x00\x00\x00\x00";
+
+	my $remote = IO::Socket::INET->new(PeerHost => $ip, PeerPort => $port)
+		or die "unable to connect to $ip/$port: $!";
+
+	my $io = IO::Select->new($client, $remote);
+	while ($io->count) {
+		for my $fh ($io->can_read(0)) {
+			for my $pair ([$client, $remote], [$remote, $client]) {
+				my ($from, $to) = @$pair;
+				next unless $fh == $from;
+
+				my $r = sysread $from, my $buf, 1024;
+				if (!defined $r || $r <= 0) {
+					$io->remove($from);
+					next;
+				}
+				syswrite $to, $buf;
+			}
+		}
+	}
+}
diff --git a/t/t5564-http-proxy.sh b/t/t5564-http-proxy.sh
index bb35b87071d..7fcffba67a2 100755
--- a/t/t5564-http-proxy.sh
+++ b/t/t5564-http-proxy.sh
@@ -39,4 +39,50 @@ test_expect_success 'clone can prompt for proxy password' '
 	expect_askpass pass proxuser
 '
 
+start_socks() {
+	mkfifo socks_output &&
+	{
+		"$PERL_PATH" "$TEST_DIRECTORY/socks4-proxy.pl" "$1" >socks_output &
+		socks_pid=$!
+	} &&
+	read line <socks_output &&
+	test "$line" = ready
+}
+
+test_expect_success PERL 'try to start SOCKS proxy' '
+	# The %30 tests that the correct amount of percent-encoding is applied
+	# to the proxy string passed to curl.
+	if start_socks %30.sock
+	then
+		test_set_prereq SOCKS_PROXY
+	fi
+'
+
+test_expect_success SOCKS_PROXY 'clone via Unix socket' '
+	test_when_finished "rm -rf clone" &&
+	test_config_global http.proxy "socks4://localhost$PWD/%2530.sock" && {
+		{
+			GIT_TRACE_CURL=$PWD/trace git clone "$HTTPD_URL/smart/repo.git" clone 2>err &&
+			grep -i "SOCKS4 request granted." trace
+		} ||
+		grep "^fatal: libcurl 7\.84 or later" err
+	}
+'
+
+test_expect_success SOCKS_PROXY 'stop SOCKS proxy' 'kill "$socks_pid"'
+
+test_expect_success 'Unix socket requires socks*:' '
+	! git clone -c http.proxy=localhost/path https://example.com/repo.git 2>err && {
+		grep "^fatal: Invalid proxy URL '\''localhost/path'\'': only SOCKS proxies support paths" err ||
+		grep "^fatal: libcurl 7\.84 or later" err
+	}
+'
+
+test_expect_success 'Unix socket requires localhost' '
+	! git clone -c http.proxy=socks4://127.0.0.1/path https://example.com/repo.git 2>err && {
+		grep "^fatal: Invalid proxy URL '\''socks4://127\.0\.0\.1/path'\'': host must be localhost if a path is present" err ||
+		grep "^fatal: libcurl 7\.84 or later" err
+	}
+'
+
 test_done

base-commit: 39bf06adf96da25b87c9aa7d35a32ef3683eb4a4
-- 
gitgitgadget
