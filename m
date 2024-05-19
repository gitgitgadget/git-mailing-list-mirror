Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CBD17579
	for <git@vger.kernel.org>; Sun, 19 May 2024 07:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716102879; cv=none; b=ZtQHhHfU/WzFRlRtv9UX2SqAaguawZ90EIUzh3eRLSd/LdhaCQTub/YBWz+Em4dT5t/0gywDL3myC1wZbvTOx5HyVLI+Qe/kWRBQuFZEfTwEF0Zm4mktGHxk+94gX2KvZdwAIKjhTmnHmyh3uLvAouRpQDRLGx4sPnkAX95gGtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716102879; c=relaxed/simple;
	bh=XjCvqbVFJJyoffLZK6Gwv09tDuhSyxir40gJPdNmTPw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=j9u7keV7B42+N2/7JnB8QUUyuo75KcExDEWe1XwTYXuMayFsNUCCawbUSEIUUGrVrVhsB3eAaMkuAZDxpcuZnlp4RR+Kh4H9Ueit9E/OYpBzbsw8XHqA2gCY5T0XGXQ6End15TkDmqvGge3lZ4nbNCVb3hIuSqLLY4hLyHmUHmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmN5KNlD; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmN5KNlD"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42017f8de7aso11994495e9.1
        for <git@vger.kernel.org>; Sun, 19 May 2024 00:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716102876; x=1716707676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ixDigAgEZwnqusAuv6Ehz7QVQIr3XgQmz2zgyxO8XGg=;
        b=OmN5KNlDruZWXZlnT0kkE/uohjfGfLOWxo0YnQaXkus3Yipk+V+y+SZrMSMCREhTNI
         +0vlzsqC2yZIWUKDJTpLFRUf1y2S6rXj161SwoRNtNV4Vt8nZnkkLB/D29k2hwGuX32G
         mSVIH990PhS4LeYe0rZQeeinjMmgZ+EqKkF7E432xoAXpFSte5T3jsGNag4VjkEEiuVE
         pdRXWttbcQVSkBMw3sGQu+GTFfaOB8Qh4+a7elgmOP2AAkoa6SG7bL9YvLqt4eehA3uh
         phZku6M6IAC5dQWQEjqnd++/s/Ksg9RTN05hoej4GfdPT2WhIZIZjh1HSQHOxdE9exTI
         wMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716102876; x=1716707676;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ixDigAgEZwnqusAuv6Ehz7QVQIr3XgQmz2zgyxO8XGg=;
        b=XE+F+MQaEIV0CBFfsEdMJgHIys0Oj1SvYs1E6RpGbKdONe1vYtdguJRfBDF+C01z0n
         UAcmRAf98qvQl0ZRbtZFMq9J/kMw5U3XQxnkkTy0MyigqTZDKLgvwmRXwHJ4sKAwbJkd
         cK8+gPHv5ONCIdopESMEiUvuKUvP4XSdXH2R0EsTay/IqWbpbxQlIyZZqUBjl5qLckZI
         9gRS4R/xs9Wh/pZ8RdC6ZlEMfRV4SiWd67YqH4NmZu3XwMLTAhL0e8Kdd9s3gecmUybm
         SNQ1hzlZCpnE60V4n/VW63H7tnAgf0J/3tgWXWlb4G4IMFHoJ+NXjBa7QiGHtWUVlVyD
         7fSg==
X-Gm-Message-State: AOJu0Yzy0fSFKFzgE41KRvtwUJzB9GriY24Jp7RiRljb51Cl1pXAY92J
	FL2hpPfiExzwEA80P17P7IRoV9J7KJrpqeQbGKd/U9Crr4DqGOkJ6Qfvkw==
X-Google-Smtp-Source: AGHT+IG0ukz/pJjcvIEoO5qX+LxoYybex6YzEkxbDeVsBf0XzgRfcHvd3g0xBazmMlghh7B0HpHEIw==
X-Received: by 2002:a05:600c:548b:b0:420:e405:579d with SMTP id 5b1f17b1804b1-420e405595dmr16495455e9.21.1716102876368;
        Sun, 19 May 2024 00:14:36 -0700 (PDT)
Received: from gmail.com (173.red-88-14-51.dynamicip.rima-tde.net. [88.14.51.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87c235b4sm405227265e9.11.2024.05.19.00.14.35
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 May 2024 00:14:35 -0700 (PDT)
Message-ID: <d42a55b1-1ba9-4cfb-9c3d-98ea4d86da33@gmail.com>
Date: Sun, 19 May 2024 09:14:31 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 4/5] test-terminal: introduce --no-stdin-pty
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
Content-Language: en-US
In-Reply-To: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In 18d8c26930 (test_terminal: redirect child process' stdin to a pty,
2015-08-04), t/test-terminal.perl learned to connect the child process'
stdin to a pty.  It works well for what was intended: satisfying an
`isatty(STDIN_FILENO)` check.

However, the fork introduced, that copies the stdin to the child
process, does not always manage to send all the information.

To illustrate this behavior, we can use a function like this:

    f ()
    {
    	dd if=/dev/zero bs=1 count=10000 status=none |
    	t/test-terminal.perl cat - 2>/dev/null |
    	wc -c;
    }

We do not obtain the expected results when executing this function
100 times:

    $ for i in $(seq 100); do f; done | sort | uniq -c
         36 0
          4 1
         53 4095
          7 4159

If we do the same with a version that does not redirect stdin, a version
prior to 18d8c26930, the expected result is obtained:

    $ git checkout 18d8c26930~1
    $ for i in $(seq 100); do f; done | sort | uniq -c
        100 10000

In a subsequent commit, a new test is going to rely on test-terminate,
and it does not require stdin to be connected to a terminal, but all
piped data needs to be successfully transmitted to the child process.

To make this possible, add a new parameter "--no-stdin-pty" to allow
disabling the stdin redirection though a pty.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 t/test-terminal.perl | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/t/test-terminal.perl b/t/test-terminal.perl
index 3810e9bb43..85edc9e8b9 100755
--- a/t/test-terminal.perl
+++ b/t/test-terminal.perl
@@ -12,10 +12,10 @@ sub start_child {
 	if (not defined $pid) {
 		die "fork failed: $!"
 	} elsif ($pid == 0) {
-		open STDIN, "<&", $in;
+		open STDIN, "<&", $in if $in;
 		open STDOUT, ">&", $out;
 		open STDERR, ">&", $err;
-		close $in;
+		close $in if $in;
 		close $out;
 		exec(@$argv) or die "cannot exec '$argv->[0]': $!"
 	}
@@ -78,28 +78,32 @@ sub copy_stdio {
 }
 
 if ($#ARGV < 1) {
-	die "usage: test-terminal program args";
+	die "usage: test-terminal [--no-stdin-pty] program args";
 }
+my $no_stdin_pty = $ARGV[0] eq '--no-stdin-pty';
+shift @ARGV if $no_stdin_pty;
 $ENV{TERM} = 'vt100';
-my $parent_in = new IO::Pty;
+my $parent_in = $no_stdin_pty ? undef : IO::Pty->new;
 my $parent_out = new IO::Pty;
 my $parent_err = new IO::Pty;
-$parent_in->set_raw();
+$parent_in->set_raw() if $parent_in;
 $parent_out->set_raw();
 $parent_err->set_raw();
-$parent_in->slave->set_raw();
+$parent_in->slave->set_raw() if $parent_in;
 $parent_out->slave->set_raw();
 $parent_err->slave->set_raw();
-my $pid = start_child(\@ARGV, $parent_in->slave, $parent_out->slave, $parent_err->slave);
-close $parent_in->slave;
+my $pid = start_child(\@ARGV,$parent_in ? $parent_in->slave : undef, $parent_out->slave, $parent_err->slave);
+close $parent_in->slave if $parent_in;
 close $parent_out->slave;
 close $parent_err->slave;
-my $in_pid = copy_stdin($parent_in);
+my $in_pid = $no_stdin_pty ? 0 : copy_stdin($parent_in);
 copy_stdio($parent_out, $parent_err);
 my $ret = finish_child($pid);
-# If the child process terminates before our copy_stdin() process is able to
-# write all of its data to $parent_in, the copy_stdin() process could stall.
-# Send SIGTERM to it to ensure it terminates.
-kill 'TERM', $in_pid;
-finish_child($in_pid);
+if ($in_pid) {
+	# If the child process terminates before our copy_stdin() process is able to
+	# write all of its data to $parent_in, the copy_stdin() process could stall.
+	# Send SIGTERM to it to ensure it terminates.
+	kill 'TERM', $in_pid;
+	finish_child($in_pid);
+}
 exit($ret);
-- 
2.45.1.209.gd5886bf9cd
