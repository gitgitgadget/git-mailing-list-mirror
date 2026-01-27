Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6ED36CE18
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 20:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769546002; cv=none; b=ApACpFsAEVCERjT7y858lQD67s808byc8np7AOXKgk40v0set3HBoSTW1tJuNyvL+pVruUd2Wb4X7hoeqD7uAeyWoZ+yNUXy0Gvow0qUL8pUzUBOlo4peI3T+UOKDUT38nGF4ca3kesxJ8ICyx+KAUgBpZenAeBI4bnzsHQEcdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769546002; c=relaxed/simple;
	bh=2h/4vckmKtfH4+/ruvKt1hyKE7p44yAgWncpe9p9A7Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EKQ8NxtcoVWgcSB7RddrTsCMhuFyW6drQsHJE+vDwaRPQb50Gj45VKu9xK0NfdL0DTzICtCuoVmXLPPsoRRAfgN95Yla977OPKGhlMlDtmYxK8J+V8J8veRYqN4xNtJHIVLbR0GwD3rmv7eyXDIH78prvd692RjNtiOUN116h4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODKgOAPz; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODKgOAPz"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5014f383df6so52255081cf.1
        for <git@vger.kernel.org>; Tue, 27 Jan 2026 12:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769546000; x=1770150800; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbEZk6lXaYa6Q32G6dn15l77jZrZogKfhs66aaZFS8U=;
        b=ODKgOAPzuZTMoq/tfCpyHV8aZ8GEu78zu8i+hwj499YZPbm81pNl+Tf2ZcfzWfr2H1
         Ik94oPKv9tr2sfsGtCDguuE5cRkE+SvpubS+3koN5HJ9QPxSFCdyW4dlo8wEDGDI19ao
         pXOvPi6UUwUqH5GHYt5znk3Vos9Y18idXNX2qMjFT2Fq6mZ/veOVpe0w2XEs0z7G9NsJ
         b2+Vp8hR5dOta9WLZduLFJznlxcB2L4jjl+NJrUN6hINhBECjGsaY9jMA3gSCXSTfR9k
         i8JeXWAUeRZY5TQ3hKgqpY+bpMXF0wVjwnKWIpfuK0pP7skvjGyk5FBOQhmvIe8BAF/v
         znHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769546000; x=1770150800;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YbEZk6lXaYa6Q32G6dn15l77jZrZogKfhs66aaZFS8U=;
        b=I5nRq1i/W1DhWHwZ6TPmgP58cwlqCKDfersXJrE629wtOU61nJ3K5Q5ankf+UbC7Tv
         rqwO2DlN0NW5T1WPGvmctwf6H4+UJ1X9YkxiSuT9LJRRSgktZMs2Hxv7Cb92YGSXv8YL
         DslNUJ9syl1hL9GAjUHWx7o3DV7NJof84cx3scKiqJPF6BUAfaThivv2rSC8UgOCRY2M
         OxFCizPkMg+/pNst0z+0nE57PMie7eWSvCkfzgUOtEHojp40OXxCt+w7RlcFfi77clo7
         ksWeXMLhf6R2E8+IsDbucbZexALM8HmaaV7QShOqaQXqYQ+RDp7rAwezNcN498CbzqJW
         uDpg==
X-Gm-Message-State: AOJu0YwPeKAVwTW2bDNHh61B+1ad3HbAflLrSeT/nM9908BKvYkAjoAu
	xxR1SbfsBFYmInVrm/e9mhgmv74DTc02YpAd2i6TIkK/3EcuXe1sngPZ+CF79w==
X-Gm-Gg: AZuq6aJNtvOm5HfOw/8S7pEuAS4Anaht9TjALZZLLDBtC1MbI1Rv7s6n5J9Mh8+SuFD
	P3+JNSLT47FnApFSlA/tMJiE0wZaPkHe8V4++gNmZumwyvVZY8CqFQ3i8ofpLSEoUxkgSnRUlPY
	5Ar7XnH22aBU257WONaV6YqqOhoZQr00jcnlmZ4g2Np7Rgqz06L/PIyohhnGAWkHon5iURaw4NG
	yeFq3aVTbstbqcs/QQMG7IbUteJszlpoq7zCQ15psaGL6jc5HmXWr8gghc21HO8w0S/4xF2IRec
	ff2Fm1TpBHx9U/TTuwwoeh8YRSJHIMclwIZqjPzKCc28DG6k922YHn6tnW0P6aqQU5zuLUOqiCh
	T0D6gMk2QBmtugYWjvTeKc0f3LcRJEtgd9So8GOmvqivMdLX76MI3S8CXOoXXJmmY/VlNccj0ZB
	wvKef1O2Uv3f4=
X-Received: by 2002:a05:622a:48a:b0:501:51e4:1ec3 with SMTP id d75a77b69052e-5032fc2b977mr37871541cf.78.1769545998457;
        Tue, 27 Jan 2026 12:33:18 -0800 (PST)
Received: from [127.0.0.1] ([51.8.121.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d3740f6dsm3862856d6.37.2026.01.27.12.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 12:33:17 -0800 (PST)
Message-Id: <f2a09c15eb600c4de8ca2e25596f02ad9d1c30f7.1769545996.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.v2.git.git.1769545996.gitgitgadget@gmail.com>
References: <pull.2179.git.git.1769424301394.gitgitgadget@gmail.com>
	<pull.2179.v2.git.git.1769545996.gitgitgadget@gmail.com>
From: "Chris Idema via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Jan 2026 20:33:15 +0000
Subject: [PATCH/RFC v2 1/2] diff.tcl: fixed alignment of tabs in git-gui diff
 by using spaces
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
Cc: Chris Idema <github_chris_idema@proton.me>,
    Chris Idema <github_chris_idema@proton.me>

From: Chris Idema <github_chris_idema@proton.me>

Tabs were not properly rendered in TK regardless of tab width settings.
Converting tab alignment to spaces before rendering in TK fixes this.
Does not fix alignment issues in gitk.

Signed-off-by: Chris Idema <github_chris_idema@proton.me>
---
 git-gui/lib/diff.tcl | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
index 442737ba4f..2e13f8c776 100644
--- a/git-gui/lib/diff.tcl
+++ b/git-gui/lib/diff.tcl
@@ -12,6 +12,27 @@ proc apply_tab_size {{firsttab {}}} {
 	}
 }
 
+proc expand_tabs {line {startcol -1}} {
+	# startcol set to -1, because in preview the lines start with a '+', '-', or ' '
+	global repo_config
+
+	set col $startcol
+	set out ""
+
+	foreach char [split $line ""] {
+		if {$char eq "\t"} {
+			set spaces [expr {$repo_config(gui.tabsize) - ($col % $repo_config(gui.tabsize))}]
+			append out [string repeat " " $spaces]
+			incr col $spaces
+		} else {
+			append out $char
+			incr col
+		}
+	}
+
+	return $out
+}
+
 proc clear_diff {} {
 	global ui_diff current_diff_path current_diff_header
 	global ui_index ui_workdir
@@ -495,7 +516,9 @@ proc read_diff {fd conflict_size cont_info} {
 			}
 		}
 		set mark [$ui_diff index "end - 1 line linestart"]
-		$ui_diff insert end $line $tags
+		set line [expand_tabs $line]
+		$ui_diff insert end "$line" $tags
+
 		if {[string index $line end] eq "\r"} {
 			$ui_diff tag add d_cr {end - 2c}
 		}
-- 
gitgitgadget

