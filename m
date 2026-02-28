Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBF342EEAB
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 11:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772277750; cv=none; b=S/CLp08Jufrlr66wPFoRTyTeXKDalwk3iF9quunnWE4If4VPGaWWm5lR+MpvvyaB+/x5pf+ZnP44kW9AIGp9xoEKMXcAGbIWpsB3aOhcS15p8+NUYHrcaP+4luDtBjBkPAEzV6nEZkW+y6oz3xGOTxkdmNYLoDQbcGh40Pk/OgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772277750; c=relaxed/simple;
	bh=HLDzWEJfMWKskWrFMpu3kNv9lO2FeW+tPLw2EUmMghY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bISsh+8ePt4dJbhdoOWKEtx+UWGVi9iz4Z8chq8cSNsp0hWTgRsHd4U4ekqfLYlSqI2ihCVqKUrezqC2KqAcHUPYEkKbWNrjyXIKLXbH6Z3SB8dBZm8G/INALU9lRGnlMWYqXXVo9O3kXn6HilTJLgDMlMu8I3X5X/m8xKglByI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LymimEip; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LymimEip"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-358d7dcc230so1982453a91.0
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 03:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772277748; x=1772882548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nz5a6LjDwuk56AvFr2Z/qqRLAx8901f41vWQ8ivrQWI=;
        b=LymimEipt+hSfEUrZKquRPcWyiu1gDQVjuNwJPlGqrBMbQvXOHAm7WNraLka8JDxzm
         dQhn3Aa2fxJA3m40Ba2UP52Cqajk2YIHITC3kbia0fIRiZtifhZzAeIJLtx1f5b+EM5F
         xYucLAyhnAe65NYkytXM8UE/hyWOxS9n2pyrrZIJUJH7kll14aEpYlQ3qH6vVYStDJES
         Nd1kQZocjtQvLoJYHdZBe5Ukqrfvbt8E2P6PDG0u+Aj4hsplv/mIKX5bL/RzMKrwqohU
         YQB1/YdBcivEJqKlqNVGXaQsfS0X+SZjEDFyA3bzhymBfSlyAjyUck/XC+wMvBFkBsPj
         vBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772277748; x=1772882548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nz5a6LjDwuk56AvFr2Z/qqRLAx8901f41vWQ8ivrQWI=;
        b=Dyi79zuQZesm/G4A5f7leySd7qXhnEJvfOIkCK1I8CsTedhhedM+eBgbU4zQPZUnjD
         njaQhyrAvEVcXhwrKq841eeZeVvjRbCLHaYtQVXy14JLLORiYIfrF2UDzkYvRSE0VDsR
         IU3ctdO3hDVG/1G37lMtnTQNkEUbemNZv/JuPuxpaqS6CwuT1XFrC38+Kfxp0Ggj9ins
         CJCkSKP5zrCiSWCyhE9QctUqoFTYPpSYaiCrhB2CEWVpHFyfbu3kbxAFCkfH70Bc0kM8
         /V1aN5qKMLLzhKyMdbsdLeOk40qsa2tdsMAVpEY8OJ8pT5zKGA1U7YysuQ50a+yUrksJ
         p7XA==
X-Gm-Message-State: AOJu0Yyy6jf+6fLgtKhOE0j4wqD66hxtMXlCl0HG+7qgaLv8KCYWysJQ
	4oMeL6BjCmDSrGOlf3jf8/20i3xf9hSrBGfc4NoCTVtvu8uTHxGajklixWhr2g==
X-Gm-Gg: ATEYQzxcIE47XoA4dzrX8X93N3PAjZ1z0pvMIsBtxeCczWdDa0fBDyy6cqgXVIdF+Ub
	Bw0OTZItP6WNHK5J8Y/iM90DJsTfaKnM7DEi7fAvQvYISEo/tb0RMXZd6MC+I8ozYbim5mIf1J2
	DcC8muAcrATXToj+BJhAJTrxDh/XXXpKlMdkvnWYdlu54+92ZJFkL7th2l6xIyn8zyBswDcTVgh
	UQZz6UFdMu8T7X+9n59M1S9/htBdReKHdXfhqnO4fDapgwWtcJTadSoFrx8HVPMJJqwEyOPK2Tl
	AmxPYUkdaaIisJyRs9deQA39hHHpdXvMI7HX6PW069POpAwFu+CqWtF1dluIBVSzAaHjT4DRy9r
	UMJsavBo7/HIMOl03nUfLKh/Rks9heUQa5vczOwUFI335WanXuoEBIAMYNI0jihKK4Ln9UPiVt2
	yO6TQ7zuypU+g+kWtyEztgQVle4n7wgdZwRx0MYF0kyvGeeMEN64MZyBh5Ig==
X-Received: by 2002:a17:90b:560e:b0:356:1edc:b6e with SMTP id 98e67ed59e1d1-35965c4966bmr5344425a91.8.1772277748426;
        Sat, 28 Feb 2026 03:22:28 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:2af:8eed:2c20:6d15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359806913c3sm395638a91.14.2026.02.28.03.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 03:22:27 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ben.knoble@gmail.com,
	gitster@pobox.com,
	philipoakley@iee.email,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v4] send-email: validate charset name in 8bit encoding prompt
Date: Sat, 28 Feb 2026 16:50:45 +0530
Message-ID: <20260228112210.270273-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g748bb03a00.dirty
In-Reply-To: <20260224143624.23678-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260224143624.23678-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a non-ASCII character is detected in the body or subject of the email
the user is prompted with,

        Which 8bit encoding should I declare [UTF-8]? foo

After this the input string is validated by the regex, based on the fact
that the charset string will be minimum 4 characters [1]. If the string is
more than 4 letters the email is sent, if not then a second prompt to
confirm is asked to the user,

        Are you sure you want to use <foo> [y/N]? y

This relies on a length based regex heuristic check to validate the user
input, and can allow clearly invalid charset names to pass if the input is
greater than 4 characters.

Add a semantic validation of the charset name using the
Encode::find_encoding() which is a bundled module of perl. If the encoding
is not recognized, warn the user and ask for confirmation before proceeding.
After this validation the lenght based validation becomes redundant and also
breaks flow, so change the regex of valid input to any non blank string.

Make the encoding warning logic specific to the 8bit prompt, also add a
unique confirmation prompt which  reduces the load on ask(), and improves
maintainability.

Additionally, the wording of the first prompt can confuse the user if not
read properly or under any default assumptions for a yes/no prompt. Change
the wording to make it explicitly clear to the user that the prompt needs a
string input, UTF-8 being the default.

The intended flow is,

        Declare which 8bit encoding to use [default: UTF-8]? foobar
        <foobar> does not appear to be a valid charset name. Use it anyway [y/N]?

[1]- https://github.com/git/git/commit/852a15d748034eec87adbee73a72689c8936fb8b

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
Changes in v4:
 - removed the confirm_ask() helper and changes to ask().
 - make a new warning/confirmation prompt specific to the 8bit encoding flow.

 git-send-email.perl   | 25 ++++++++++++++++++++++---
 t/t9001-send-email.sh |  2 +-
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index cd4b316ddc..3186104709 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -23,6 +23,7 @@
 use Git::LoadCPAN::Error qw(:try);
 use Git;
 use Git::I18N;
+use Encode qw(find_encoding);

 Getopt::Long::Configure qw/ pass_through /;

@@ -1044,9 +1045,27 @@ sub file_declares_8bit_cte {
 	foreach my $f (sort keys %broken_encoding) {
 		print "    $f\n";
 	}
-	$auto_8bit_encoding = ask(__("Which 8bit encoding should I declare [UTF-8]? "),
-				  valid_re => qr/.{4}/, confirm_only => 1,
-				  default => "UTF-8");
+	while (1) {
+		my $encoding = ask(
+			__("Declare which 8bit encoding to use [default: UTF-8]? "),
+			valid_re => qr/^\S+$/,
+			default  => "UTF-8");
+		next unless defined $encoding;
+		if (find_encoding($encoding)) {
+			$auto_8bit_encoding = $encoding;
+			last;
+		}
+		my $yesno = ask(
+			sprintf(
+			__("'%s' does not appear to be a valid charset name. Use it anyway [y/N]? "),
+			$encoding),
+			valid_re => qr/^(?:y|n)/i,
+			default => "n");
+		if (defined $yesno && $yesno =~ /^y/i) {
+			$auto_8bit_encoding = $encoding;
+			last;
+		}
+	}
 }

 if (!$force) {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index e56e0c8d77..24f6c76aee 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1691,7 +1691,7 @@ test_expect_success $PREREQ 'asks about and fixes 8bit encodings' '
 			email-using-8bit >stdout &&
 	grep "do not declare a Content-Transfer-Encoding" stdout &&
 	grep email-using-8bit stdout &&
-	grep "Which 8bit encoding" stdout &&
+	grep "Declare which 8bit encoding to use" stdout &&
 	grep -E "Content|MIME" msgtxt1 >actual &&
 	test_cmp content-type-decl actual
 '

Range-diff against v3:
1:  748bb03a00 ! 1:  37e17eac68 send-email: validate charset name in 8bit encoding prompt
    @@ Commit message
         validation the lenght based validation becomes redundant and also breaks
         flow, so change the regex of valid input to any non blank string.

    -    Introduce a dedicated helper for confirmation handling that can be reused
    -    both by ask() and the custom 8bit prompt flow. This makes the encoding
    -    warning logic specific to the 8bit prompt, reduces the load on ask(), and
    -    improves maintainability.
    +    Make the encoding warning logic specific to the 8bit prompt, also add a
    +    unique confirmation prompt which  reduces the load on ask(), and improves
    +    maintainability.

         Additionally, the wording of the first prompt can confuse the user if not
         read properly or under any default assumptions for a yes/no prompt. Change
    @@ Commit message
         The intended flow is,

                 Declare which 8bit encoding to use [default: UTF-8]? foobar
    -            warning: 'foobar' does not appear to be a valid charset name.
    -            Are you sure you want to use <foobar> [y/N]?
    +            <foobar> does not appear to be a valid charset name. Use it anyway [y/N]?

         [1]- https://github.com/git/git/commit/852a15d748034eec87adbee73a72689c8936fb8b

    @@ git-send-email.perl

      Getopt::Long::Configure qw/ pass_through /;

    -@@ git-send-email.perl: sub get_patch_subject {
    - 	}
    - }
    -
    -+sub confirm_ask {
    -+	my ($resp) = @_;
    -+	my $term = term();
    -+	return 0
    -+		unless defined $term->IN and defined fileno($term->IN) and
    -+		       defined $term->OUT and defined fileno($term->OUT);
    -+	my $yesno = $term->readline(
    -+		# TRANSLATORS: please keep [y/N] as is.
    -+		sprintf(__("Are you sure you want to use <%s> [y/N]? "), $resp));
    -+	return defined $yesno && $yesno =~ /y/i;
    -+}
    -+
    - sub ask {
    - 	my ($prompt, %arg) = @_;
    - 	my $valid_re = $arg{valid_re};
    -@@ git-send-email.perl: sub ask {
    - 			return $resp;
    - 		}
    - 		if ($confirm_only) {
    --			my $yesno = $term->readline(
    --				# TRANSLATORS: please keep [y/N] as is.
    --				sprintf(__("Are you sure you want to use <%s> [y/N]? "), $resp));
    --			if (defined $yesno && $yesno =~ /y/i) {
    -+			if (confirm_ask($resp)) {
    - 				return $resp;
    - 			}
    - 		}
     @@ git-send-email.perl: sub file_declares_8bit_cte {
      	foreach my $f (sort keys %broken_encoding) {
      		print "    $f\n";
    @@ git-send-email.perl: sub file_declares_8bit_cte {
     -	$auto_8bit_encoding = ask(__("Which 8bit encoding should I declare [UTF-8]? "),
     -				  valid_re => qr/.{4}/, confirm_only => 1,
     -				  default => "UTF-8");
    -+	while(1) {
    -+		my $encoding = ask(__("Declare which 8bit encoding to use [default: UTF-8]? "),
    -+		valid_re => qr/^\S+$/,
    -+		default  => "UTF-8");
    ++	while (1) {
    ++		my $encoding = ask(
    ++			__("Declare which 8bit encoding to use [default: UTF-8]? "),
    ++			valid_re => qr/^\S+$/,
    ++			default  => "UTF-8");
     +		next unless defined $encoding;
     +		if (find_encoding($encoding)) {
     +			$auto_8bit_encoding = $encoding;
     +			last;
     +		}
    -+		printf STDERR __("warning: '%s' does not appear to be a valid charset name.\n"), $encoding;
    -+		if (confirm_ask($encoding)) {
    ++		my $yesno = ask(
    ++			sprintf(
    ++			__("'%s' does not appear to be a valid charset name. Use it anyway [y/N]? "),
    ++			$encoding),
    ++			valid_re => qr/^(?:y|n)/i,
    ++			default => "n");
    ++		if (defined $yesno && $yesno =~ /^y/i) {
     +			$auto_8bit_encoding = $encoding;
     +			last;
     +		}
--
2.53.0.155.g748bb03a00.dirty
