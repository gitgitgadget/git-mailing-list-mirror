Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F27763F1
	for <git@vger.kernel.org>; Tue, 21 May 2024 20:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716324751; cv=none; b=cBVeic2y5AFDfanAEqeXimVnTmdha+x2DF2mLX2hU7bvRILZlfMJomMeBioYKfPH99UjqI1gKNAbKBB8JxNE8A2D1raz/KdxA1synYq/5fFKFf22haUdMrkxCISpOzItFlZKDR056nATXSQ5llqaXdIfFg/+y1nZYLC8AuApOmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716324751; c=relaxed/simple;
	bh=gb+/IHrX+nEItntARH0D8QGG/1suD+WGB15Ml94S01E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qcRqcU0qqEoqhaqmzqLpfqzvoW95iliNdNI92KL1YlG/vTUEIj+mHpbKS3proM8KN9zCUiLrY2j75cBYgIff3x7etM5Q+5P/Lq/LwI717k1f2BocNAPNMt3eEZGHx+1feYm1E2U/TNFXDwDfjCa4nqR/YE9XC9TERqsc4FL6PwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gM2oFiht; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gM2oFiht"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-420180b58c5so1300065e9.3
        for <git@vger.kernel.org>; Tue, 21 May 2024 13:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716324748; x=1716929548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BXKIuawax3P08yQl5Ba5LeEQdV70DNxfE80xfI7olmc=;
        b=gM2oFihtUIknYdPHbTO8rwtsTk5ozKpUFRqS6mGCEF04NhDglWUvq1z4mL0+ZuWlJC
         IDhL16njxn9xdlgkUkXPqaUqAnQqYyChxtlrJLmSj4tOArOwAduzR59onogf7iddhdrd
         Uaph+sMdG77uKblY0olUqNfgAE5nl5pHOKYLrUWkw57pYfy600X2gBz2P1ttaLJ2ztly
         53DRxaUdI0gnSUOHQhbSQCl5GZt4Iz93YV9L7kUttwTjq8lnouA+V14Wxijbo5IHtB+V
         4X8rLA06kwgJwA8p4LaLZGosNw9OV8k0OUYI145DR12ay9RVh0Du0wXPIH5krMiuH3Ot
         TD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716324748; x=1716929548;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BXKIuawax3P08yQl5Ba5LeEQdV70DNxfE80xfI7olmc=;
        b=RW1J7N5a1HKPL+yBZ8sTYMsG4IVKJJXi8wkRNVfOTQZQLj7Jxbap5bF82edMP1LVeq
         KE5hFkp1uXm412kJtrNOjOTKm2humIVvPy8PM7/5ZZZejB7uPneAggQq1ufME34t3mcu
         PvWSUrd2gOcIDZq6JWuN4r5jP4TIys+e8pZvddmvkxapPljkawUNGONNV7NDkZejNyVR
         uIgjot98/T8cgDgyVqej+MYEgFpPhLCgzUnPSCVTD9TNSEKkC3Bo8s9RDVtYsIwj95xe
         6KyXBgiwrIcuj7JIl8nUgOueP7YysawdNwsg0N0Gd7HlG/Cy27YkPQ/T0xRCbVrX3Rzf
         O8bQ==
X-Gm-Message-State: AOJu0Yxv0bznCLAXiLD/5YW0At5CG69jv4N0Oi5rUd47Ls7pN7FZdmPp
	mEk4Ru1RkBl1yBp9fR34ckzxeh+KIQlo1LcWHqUfP2bfMMV9Tag8PnXzpg==
X-Google-Smtp-Source: AGHT+IGrWVS7kVitd/Ezn+WN4KJja+m5W5cwB7jLn96p48E9WSb48gArDhDL9xLzZKdOn8SpZ/TsEQ==
X-Received: by 2002:a05:600c:4f92:b0:420:fff:f4c9 with SMTP id 5b1f17b1804b1-420fd303360mr345685e9.13.1716324747782;
        Tue, 21 May 2024 13:52:27 -0700 (PDT)
Received: from gmail.com (96.red-88-14-210.dynamicip.rima-tde.net. [88.14.210.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41ff7a840d2sm437479885e9.39.2024.05.21.13.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 13:52:27 -0700 (PDT)
Message-ID: <dabf978d-1e3d-4446-9f62-32081f393371@gmail.com>
Date: Tue, 21 May 2024 22:52:26 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 4/5] test-terminal: introduce --no-stdin-pty
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
Content-Language: en-US
In-Reply-To: <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In 18d8c26930 (test_terminal: redirect child process' stdin to a pty,
2015-08-04), t/test-terminal.perl learned to connect the child process'
stdin to a pty.  It works well for what was intended: satisfying an
`isatty(STDIN_FILENO)` check.

However, the fork introduced, that copies the stdin to the child
process, does not always manage to send all the information.

To illustrate this behaviour, we can use a function like this:

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
2.45.1.221.gd3c11dbb1d
