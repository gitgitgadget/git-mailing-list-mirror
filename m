Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174CE2040BF
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736429148; cv=none; b=dV76VMhorSxvQfOSmRKVAjNnrlr9y+LBo2QPmutzAlUR72gLGBljk43imZzgFllvRCqF2tVRpWouMkJqUekCL+yGzYTOa+hScLS5aG2zTJvn9RrHujlNTBB92derP7EHysYjTRho86yIx6A4wWxr6Y3EusyG3b/hMXc0w4lQXmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736429148; c=relaxed/simple;
	bh=l140nzpXCcNDDWyUPnkzbCcF1fwtpDfA5Jp9AXptb6k=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=MRqaBitBgLhBalu4js4eKqwY4s+t+I4hZmJ3154xEaBQtyTZLXH0/AzRiwtAPm9TgZplRa/e+FRuc6x4pHKPPFs7oJFRClQuwRx798eZxwBdvfpW37qPF5DFWAmVSs0N7xzGt3jm2DyD300aw7nz+vQRqD8+CXZhpH6j0ez3eNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODBZNkBB; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODBZNkBB"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so3872949a12.1
        for <git@vger.kernel.org>; Thu, 09 Jan 2025 05:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736429144; x=1737033944; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8VPTal1tqQG9mr8AVLJjvkgNPkq73GzXcPk0ZvIWRdw=;
        b=ODBZNkBBaWuvvd90ifRD6M/gLK7zhzswznh2Uvu6P7wyPb8XRNP4ZEVsq3VOUIHKa0
         uWgdwYQZCLb2mKB4f6oLm9W+SbdGOyu+MLgVF2/jThUZY7x8k1kU/PSdlY99HdzkW4B3
         bqkMs6aOQzyaO26nVP5NqgrrPF8zRD8U3AwWXH9NmMsjxMpGVLUpB3m25akncTU0P1lU
         ToJNJEClHwQd8DqDzfVbJKdbM3WjDcbCJ11r2YSIKnXILtVntx9q4g9/AU2kFYVMbpqR
         ehCHDO7yFY0kf5HMpdhBUhxm+ju4Oh8kJHD9R5c4mwHbJ+oME6nQZN/C0opvuCSKmGJ9
         T0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736429144; x=1737033944;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8VPTal1tqQG9mr8AVLJjvkgNPkq73GzXcPk0ZvIWRdw=;
        b=wlyH+o8SMei6SLeEULJI4IZtnZS7OV8eSh/TZAucvL8eFvzt3eciNFrp2Sl31SPiiJ
         IgskkU5rxTL7rhW1pHgF36wRl7c8XjDgKeFjSx4RulnGO92Usrm5B5IPucWqJw31WDl1
         XRtAuK7zuzlKeQQO3eg2f+sIhcNZGJVbq+PCaaQQcCPmAjXev6yUMO/qllWYECIrXsog
         9ZwYDAMI871lOJYa7BHkIQCIQcLB1MXDfSdGBDf/Y/25QUTH2HEcY78z7xsM1P0gr2FH
         G5icPpkbZPsa6Vwxb1VPBBIot4FEfzDdiy/5mYVR3e4PbJafcr1P7Fv8nojWe73GoWSt
         tUfg==
X-Gm-Message-State: AOJu0Yxda1JQ79tTVTDZy2kQ5mXp4MHOI012MIh33nAH17EQoQksQfuY
	KWXbQfcQcWqEhdPwhJ23pri4n3u3+D+MK8EvbpyjGqbg92wUaCFCTXmzfA==
X-Gm-Gg: ASbGncsT3w0uBm8NcmlZjeir+HEM+GviONfoRUTpuffcMsxjgC15SAyxC/C9ML/T8fF
	3iqYhta7modYcLi1ibeo1Q4H/iOAaJQau3fYWgKYlAniVBtF5Og4bZidYys9AAsySD0TMuQcw/c
	KnmzZQuk4WiZZiFNhGkGrD5dFRb+NGqc7DtZfHwh0/rO2iC5DycTm60IdHHUAyvHVcmfJUGJxyt
	3V7PT97GQm/cS6xyTKZ6jeU6xlceug3Wgd7w/u5gzb8TqKTesthvgij5w==
X-Google-Smtp-Source: AGHT+IHEjBneTu6OmtcZkyw5PPY1hORA/CYT1OFcRUOcUHFM4lxciIuVizeKMGnfkRb5JuJrAyY3Mw==
X-Received: by 2002:a17:907:d1c:b0:aa6:912f:7eb4 with SMTP id a640c23a62f3a-ab2c3c7e227mr296759666b.10.1736429143616;
        Thu, 09 Jan 2025 05:25:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9564873sm71425166b.111.2025.01.09.05.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 05:25:43 -0800 (PST)
Message-Id: <pull.1871.git.git.1736429142334.gitgitgadget@gmail.com>
From: "Julian Prein via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jan 2025 13:25:42 +0000
Subject: [PATCH] config.txt: add trailer.* variables
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
Cc: Julian Prein <julian@druckdev.xyz>,
    Julian Prein <julian@druckdev.xyz>

From: Julian Prein <julian@druckdev.xyz>

The trailer.* configuration variables are currently only described in
git-interpret-trailers(1) but affect git-commit and git-tag as well.
Move that section into its own config/trailer.txt file and also include
it in git-config(1).

Signed-off-by: Julian Prein <julian@druckdev.xyz>
---
    config.txt: add trailer.* variables

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1871%2Fdruckdev%2Ftrailer-config-vars-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1871/druckdev/trailer-config-vars-v1
Pull-Request: https://github.com/git/git/pull/1871

 Documentation/config.txt                 |   2 +
 Documentation/config/trailer.txt         | 136 ++++++++++++++++++++++
 Documentation/git-interpret-trailers.txt | 137 +----------------------
 3 files changed, 140 insertions(+), 135 deletions(-)
 create mode 100644 Documentation/config/trailer.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8c0b3ed8075..1b86323ca3f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -540,6 +540,8 @@ include::config/tar.txt[]
 
 include::config/trace2.txt[]
 
+include::config/trailer.txt[]
+
 include::config/transfer.txt[]
 
 include::config/uploadarchive.txt[]
diff --git a/Documentation/config/trailer.txt b/Documentation/config/trailer.txt
new file mode 100644
index 00000000000..60bc221c88b
--- /dev/null
+++ b/Documentation/config/trailer.txt
@@ -0,0 +1,136 @@
+trailer.separators::
+	This option tells which characters are recognized as trailer
+	separators. By default only ':' is recognized as a trailer
+	separator, except that '=' is always accepted on the command
+	line for compatibility with other git commands.
++
+The first character given by this option will be the default character
+used when another separator is not specified in the config for this
+trailer.
++
+For example, if the value for this option is "%=$", then only lines
+using the format '<key><sep><value>' with <sep> containing '%', '='
+or '$' and then spaces will be considered trailers. And '%' will be
+the default separator used, so by default trailers will appear like:
+'<key>% <value>' (one percent sign and one space will appear between
+the key and the value).
+
+trailer.where::
+	This option tells where a new trailer will be added.
++
+This can be `end`, which is the default, `start`, `after` or `before`.
++
+If it is `end`, then each new trailer will appear at the end of the
+existing trailers.
++
+If it is `start`, then each new trailer will appear at the start,
+instead of the end, of the existing trailers.
++
+If it is `after`, then each new trailer will appear just after the
+last trailer with the same <key>.
++
+If it is `before`, then each new trailer will appear just before the
+first trailer with the same <key>.
+
+trailer.ifexists::
+	This option makes it possible to choose what action will be
+	performed when there is already at least one trailer with the
+	same <key> in the input.
++
+The valid values for this option are: `addIfDifferentNeighbor` (this
+is the default), `addIfDifferent`, `add`, `replace` or `doNothing`.
++
+With `addIfDifferentNeighbor`, a new trailer will be added only if no
+trailer with the same (<key>, <value>) pair is above or below the line
+where the new trailer will be added.
++
+With `addIfDifferent`, a new trailer will be added only if no trailer
+with the same (<key>, <value>) pair is already in the input.
++
+With `add`, a new trailer will be added, even if some trailers with
+the same (<key>, <value>) pair are already in the input.
++
+With `replace`, an existing trailer with the same <key> will be
+deleted and the new trailer will be added. The deleted trailer will be
+the closest one (with the same <key>) to the place where the new one
+will be added.
++
+With `doNothing`, nothing will be done; that is no new trailer will be
+added if there is already one with the same <key> in the input.
+
+trailer.ifmissing::
+	This option makes it possible to choose what action will be
+	performed when there is not yet any trailer with the same
+	<key> in the input.
++
+The valid values for this option are: `add` (this is the default) and
+`doNothing`.
++
+With `add`, a new trailer will be added.
++
+With `doNothing`, nothing will be done.
+
+trailer.<keyAlias>.key::
+	Defines a <keyAlias> for the <key>. The <keyAlias> must be a
+	prefix (case does not matter) of the <key>. For example, in `git
+	config trailer.ack.key "Acked-by"` the "Acked-by" is the <key> and
+	the "ack" is the <keyAlias>. This configuration allows the shorter
+	`--trailer "ack:..."` invocation on the command line using the "ack"
+	<keyAlias> instead of the longer `--trailer "Acked-by:..."`.
++
+At the end of the <key>, a separator can appear and then some
+space characters. By default the only valid separator is ':',
+but this can be changed using the `trailer.separators` config
+variable.
++
+If there is a separator in the key, then it overrides the default
+separator when adding the trailer.
+
+trailer.<keyAlias>.where::
+	This option takes the same values as the 'trailer.where'
+	configuration variable and it overrides what is specified by
+	that option for trailers with the specified <keyAlias>.
+
+trailer.<keyAlias>.ifexists::
+	This option takes the same values as the 'trailer.ifexists'
+	configuration variable and it overrides what is specified by
+	that option for trailers with the specified <keyAlias>.
+
+trailer.<keyAlias>.ifmissing::
+	This option takes the same values as the 'trailer.ifmissing'
+	configuration variable and it overrides what is specified by
+	that option for trailers with the specified <keyAlias>.
+
+trailer.<keyAlias>.command::
+	Deprecated in favor of 'trailer.<keyAlias>.cmd'.
+	This option behaves in the same way as 'trailer.<keyAlias>.cmd', except
+	that it doesn't pass anything as argument to the specified command.
+	Instead the first occurrence of substring $ARG is replaced by the
+	<value> that would be passed as argument.
++
+Note that $ARG in the user's command is
+only replaced once and that the original way of replacing $ARG is not safe.
++
+When both 'trailer.<keyAlias>.cmd' and 'trailer.<keyAlias>.command' are given
+for the same <keyAlias>, 'trailer.<keyAlias>.cmd' is used and
+'trailer.<keyAlias>.command' is ignored.
+
+trailer.<keyAlias>.cmd::
+	This option can be used to specify a shell command that will be called
+	once to automatically add a trailer with the specified <keyAlias>, and then
+	called each time a '--trailer <keyAlias>=<value>' argument is specified to
+	modify the <value> of the trailer that this option would produce.
++
+When the specified command is first called to add a trailer
+with the specified <keyAlias>, the behavior is as if a special
+'--trailer <keyAlias>=<value>' argument was added at the beginning
+of the "git interpret-trailers" command, where <value>
+is taken to be the standard output of the command with any
+leading and trailing whitespace trimmed off.
++
+If some '--trailer <keyAlias>=<value>' arguments are also passed
+on the command line, the command is called again once for each
+of these arguments with the same <keyAlias>. And the <value> part
+of these arguments, if any, will be passed to the command as its
+first argument. This way the command can produce a <value> computed
+from the <value> passed in the '--trailer <keyAlias>=<value>' argument.
diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index d9dfb75fef5..c9435d549ad 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -186,142 +186,9 @@ OPTIONS
 CONFIGURATION VARIABLES
 -----------------------
 
-trailer.separators::
-	This option tells which characters are recognized as trailer
-	separators. By default only ':' is recognized as a trailer
-	separator, except that '=' is always accepted on the command
-	line for compatibility with other git commands.
-+
-The first character given by this option will be the default character
-used when another separator is not specified in the config for this
-trailer.
-+
-For example, if the value for this option is "%=$", then only lines
-using the format '<key><sep><value>' with <sep> containing '%', '='
-or '$' and then spaces will be considered trailers. And '%' will be
-the default separator used, so by default trailers will appear like:
-'<key>% <value>' (one percent sign and one space will appear between
-the key and the value).
-
-trailer.where::
-	This option tells where a new trailer will be added.
-+
-This can be `end`, which is the default, `start`, `after` or `before`.
-+
-If it is `end`, then each new trailer will appear at the end of the
-existing trailers.
-+
-If it is `start`, then each new trailer will appear at the start,
-instead of the end, of the existing trailers.
-+
-If it is `after`, then each new trailer will appear just after the
-last trailer with the same <key>.
-+
-If it is `before`, then each new trailer will appear just before the
-first trailer with the same <key>.
+include::includes/cmd-config-section-all.txt[]
 
-trailer.ifexists::
-	This option makes it possible to choose what action will be
-	performed when there is already at least one trailer with the
-	same <key> in the input.
-+
-The valid values for this option are: `addIfDifferentNeighbor` (this
-is the default), `addIfDifferent`, `add`, `replace` or `doNothing`.
-+
-With `addIfDifferentNeighbor`, a new trailer will be added only if no
-trailer with the same (<key>, <value>) pair is above or below the line
-where the new trailer will be added.
-+
-With `addIfDifferent`, a new trailer will be added only if no trailer
-with the same (<key>, <value>) pair is already in the input.
-+
-With `add`, a new trailer will be added, even if some trailers with
-the same (<key>, <value>) pair are already in the input.
-+
-With `replace`, an existing trailer with the same <key> will be
-deleted and the new trailer will be added. The deleted trailer will be
-the closest one (with the same <key>) to the place where the new one
-will be added.
-+
-With `doNothing`, nothing will be done; that is no new trailer will be
-added if there is already one with the same <key> in the input.
-
-trailer.ifmissing::
-	This option makes it possible to choose what action will be
-	performed when there is not yet any trailer with the same
-	<key> in the input.
-+
-The valid values for this option are: `add` (this is the default) and
-`doNothing`.
-+
-With `add`, a new trailer will be added.
-+
-With `doNothing`, nothing will be done.
-
-trailer.<keyAlias>.key::
-	Defines a <keyAlias> for the <key>. The <keyAlias> must be a
-	prefix (case does not matter) of the <key>. For example, in `git
-	config trailer.ack.key "Acked-by"` the "Acked-by" is the <key> and
-	the "ack" is the <keyAlias>. This configuration allows the shorter
-	`--trailer "ack:..."` invocation on the command line using the "ack"
-	<keyAlias> instead of the longer `--trailer "Acked-by:..."`.
-+
-At the end of the <key>, a separator can appear and then some
-space characters. By default the only valid separator is ':',
-but this can be changed using the `trailer.separators` config
-variable.
-+
-If there is a separator in the key, then it overrides the default
-separator when adding the trailer.
-
-trailer.<keyAlias>.where::
-	This option takes the same values as the 'trailer.where'
-	configuration variable and it overrides what is specified by
-	that option for trailers with the specified <keyAlias>.
-
-trailer.<keyAlias>.ifexists::
-	This option takes the same values as the 'trailer.ifexists'
-	configuration variable and it overrides what is specified by
-	that option for trailers with the specified <keyAlias>.
-
-trailer.<keyAlias>.ifmissing::
-	This option takes the same values as the 'trailer.ifmissing'
-	configuration variable and it overrides what is specified by
-	that option for trailers with the specified <keyAlias>.
-
-trailer.<keyAlias>.command::
-	Deprecated in favor of 'trailer.<keyAlias>.cmd'.
-	This option behaves in the same way as 'trailer.<keyAlias>.cmd', except
-	that it doesn't pass anything as argument to the specified command.
-	Instead the first occurrence of substring $ARG is replaced by the
-	<value> that would be passed as argument.
-+
-Note that $ARG in the user's command is
-only replaced once and that the original way of replacing $ARG is not safe.
-+
-When both 'trailer.<keyAlias>.cmd' and 'trailer.<keyAlias>.command' are given
-for the same <keyAlias>, 'trailer.<keyAlias>.cmd' is used and
-'trailer.<keyAlias>.command' is ignored.
-
-trailer.<keyAlias>.cmd::
-	This option can be used to specify a shell command that will be called
-	once to automatically add a trailer with the specified <keyAlias>, and then
-	called each time a '--trailer <keyAlias>=<value>' argument is specified to
-	modify the <value> of the trailer that this option would produce.
-+
-When the specified command is first called to add a trailer
-with the specified <keyAlias>, the behavior is as if a special
-'--trailer <keyAlias>=<value>' argument was added at the beginning
-of the "git interpret-trailers" command, where <value>
-is taken to be the standard output of the command with any
-leading and trailing whitespace trimmed off.
-+
-If some '--trailer <keyAlias>=<value>' arguments are also passed
-on the command line, the command is called again once for each
-of these arguments with the same <keyAlias>. And the <value> part
-of these arguments, if any, will be passed to the command as its
-first argument. This way the command can produce a <value> computed
-from the <value> passed in the '--trailer <keyAlias>=<value>' argument.
+include::config/trailer.txt[]
 
 EXAMPLES
 --------

base-commit: a60673e9252b08d4eca90543b3729f4798b9aafd
-- 
gitgitgadget
