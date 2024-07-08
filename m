Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA053B64C
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 05:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720415296; cv=none; b=cAIEBD3VxGVhjdTsUOTkSbV5OPje+uuiTkd9D6DcIQbgU94bTvHZKKiLhp1eNzrb+gS65U3vOxVHl0r6NeLZXLA7WysMkc/8nhUmUys2ywlcUf7MbzhlzST6lWHx1pPoHXgSJd3fXzRBO3gjD0jVIFWp285qpNtsjUqRqZvmKdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720415296; c=relaxed/simple;
	bh=nUh+GNaU3BBJLORqqmsc/4vES4bHNeq8yJ/fPt7+R7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qKsAbrZCQy9raAycuAYytTvNYtqwTKvjjHQt7tGSs8GJGFyuwlrvC5dw+GD0rLNL23ctRwzORf0zm24wxzFSvFeZF1dtMEWy37NpghIRyDTdmGYYa3vfkhTWHwqSvYfeubPNFAetg9JOK9L3sWkXA+p+7t4CITB0/GNs5k5tCP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b5dfcfb165so21090016d6.0
        for <git@vger.kernel.org>; Sun, 07 Jul 2024 22:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720415293; x=1721020093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P77WCfMHzuknZxvhVmYLG9s036DxlmU7a/lsydU7q80=;
        b=nlqgeyXPKeKm5cGdjID/dmgHIhIXXXsMpIKf0wc4anUAUj9snFFeuqkuz1Ax3L8/P9
         nZm8Pqt7fHVA3xEPz1JrIrur5KAcFJrKq3LrZd0mpbOzK1f/ad6Ue8iU4/MQ516kuIvl
         9JvN8jbWaocbFnBAajjYFde74LvJI3A7VaK+r4h9RL97TvMYG5i0c0pFw+hZZUDBq4s6
         GkjRMz5c61x3hqGY9BT1+qSwkjW51CjKoRU5+XuMjY/+qYS/Qak/x4VZ+f6AR/ys+Evs
         llHaq+j46hzviXMOrYf9xAwMU5fKdgF3Uz3lmqU66gRODl6GtVqYkpWeU8XI3rEFkwJ0
         Q0fg==
X-Forwarded-Encrypted: i=1; AJvYcCUwjUwjQSa/kEdskbkO2GTcV77B9D2W7wliDrtDSL0ypqvg70ABVsfLaZRjWKB3hjFiqD7bBl8tXW3YK2dV9Y0+/EJU
X-Gm-Message-State: AOJu0Yw1vNKtZI73E15IskXwA+KOqeANdee8l+jxxUiDCZQ2UfovuwlC
	EeWoUlqS63n8PNjjor0E40c1lX6hdMdhZvaBYFDLQmdDuQ1bKn+4GCALj0USGbW0oizhJFbBm37
	sN7MMNfo4bURBTn47K35efWXtY48=
X-Google-Smtp-Source: AGHT+IEKLfNZxGE2VVQZzWK2FoKqXizvJb84N1lFQUZ7DTiAjcQCSDAr69wxyPdpsrtiO1Yyq6faoLXQLRpQCv436yc=
X-Received: by 2002:ad4:5d6e:0:b0:6b5:e194:c5fa with SMTP id
 6a1803df08f44-6b5ecfc6b25mr137252226d6.26.1720415293646; Sun, 07 Jul 2024
 22:08:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706060143.GD698153@coredump.intra.peff.net> <20240706060515.GA700151@coredump.intra.peff.net>
In-Reply-To: <20240706060515.GA700151@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 8 Jul 2024 01:08:02 -0400
Message-ID: <CAPig+cRxnpG9Yfix09EnJAbnzwN=yoUtSeYxt7S-Od+xBgfaYQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] chainlint.pl: fix line number reporting
To: Jeff King <peff@peff.net>
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"

On 7/6/24 2:05 AM, Jeff King wrote:
> The previous commit taught chainlint.pl to handle test bodies in
> heredocs, but there are two small bugs related to line numbers:
>
> 2. For an invocation like the one above, if the test_expect_success
> line is X, then "test body" would correctly start at X+1, since the
> hanging newline at the start of the single-quoted test body
> increments the count. But for a here-doc, there is an implicit
> newline at the end of the token stream before the here-doc starts.
> We have to increment "lineno" to account for this.
>
> Actually, this is not _quite_ correct, as there could be multiple
> here-docs, like:
>
> test_expect_success "$(cat <<END_OF_TITLE)" - <<END_OF_TEST
> this is the title
> END_OF_TITLE
> this is the test
> END_OF_TEST
>
> in which case we'd need to skip past END_OF_TITLE. Given how
> unlikely it is for anybody to do this, and since it would only
> affect line numbers, it's probably not worth caring about too much.
> The solution would probably be to record the starting line number
> of each here-doc section in the lexer/shellparser stage.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I actually suspect the "record the heredoc line number" thing would not
> be too hard. I.e., turn ShellParser's "heredoc" hash to point to
> hashrefs like: "{ content => ..., lineno => ... }". And that would give
> us a good spot to stick an "interpolate" boolean later if we want.

It turned out to be quite easy. See below for an implementation atop
your patch [1/3] (modulo Gmail whitespace damage). Given how simple
this ended up being, it probably makes sense to squash this change in,
as well.

--- >8 ---

diff --git a/t/chainlint.pl b/t/chainlint.pl
index c9ab79b6b0..b31cb263f8 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -174,8 +174,10 @@ sub swallow_heredocs {
     $$b =~ /(?:\G|\n)$indent\Q$$tag[0]\E(?:\n|\z)/gc;
     if (pos($$b) > $start) {
       my $body = substr($$b, $start, pos($$b) - $start);
-      $self->{parser}->{heredocs}->{$$tag[0]} =
-          substr($body, 0, length($body) - length($&));
+      $self->{parser}->{heredocs}->{$$tag[0]} = {
+        content => substr($body, 0, length($body) - length($&)),
+        start_line => $self->{lineno},
+      };
       $self->{lineno} += () = $body =~ /\n/sg;
       next;
     }
@@ -624,8 +626,9 @@ sub check_test {
   my $lineno = $body->[3];
   $body = unwrap($body);
   if ($body eq '-') {
-    $body = shift @_;
-    $lineno++;
+    my $herebody = shift @_;
+    $body = $herebody->{content};
+    $lineno = $herebody->{start_line};
   }
   $self->{ntests}++;
   my $parser = TestParser->new(\$body);
--
