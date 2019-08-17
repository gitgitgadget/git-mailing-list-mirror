Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E0A21F461
	for <e@80x24.org>; Sat, 17 Aug 2019 20:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfHQUi7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 16:38:59 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40491 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfHQUi7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 16:38:59 -0400
Received: by mail-lf1-f68.google.com with SMTP id b17so6332843lff.7
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 13:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8KF/KZlnzkjlFpy36h9SgbqAS7SgaJnLPdDVel6EYtA=;
        b=f81r/Dkw+EWk2KFDLGTKk5eXgmybqWux/vFIdTMAVR9xxKQdGtJRaJeLkLlU5Y7DXO
         TE/4BfMaja7NMLjB3+73Z0X9u9z/C4TkRTEAM7qabMh5EMEFB9U59Y0HzRbROLbZdsY6
         41zUw8FWzJWEq+eKiG0Pt3+GXt2jNXevu5uVQXNR5Va6tDpG42aHx/s8stq++3xZBpXj
         8uj22tCFIW5/iip4aFDURiy3t+NQujObRfrONdRmCiieHE3XaVB2jEUdAYFLr8ypZzjL
         +UC1t3JgB80ye+vQObZfyHLp7NnNerxbKWBkqgQ+ZJpihZ6gJ7RLBYo9u0V2+344g9A2
         cjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8KF/KZlnzkjlFpy36h9SgbqAS7SgaJnLPdDVel6EYtA=;
        b=oq1+S4Tuvb3EjNPLOZoZxvCLWPxjuihVOvw2K7/vGr4Fbj//rkPW7UiCSuT1HnY9NS
         evQUkRXH79RfqUy/NEpVvEEvSJnuhfBT+/+2n5SdAQlIyJCaxKGC/Jg7OEsl1tSKpEqC
         vopJ0TlEoT44w8KlqQqcQtOWF9vHBVsS6Jqz8dwFGWTY7ixYWRYxUM/eBP7u+yxeXYF+
         ueVw1OTtRCMBzI2FHaTi28rplmyANkgV38IsnIBq5vhjAYfkeNhyW2J79khPm1p9NKyA
         nF77s6bGUFYPBUSsT7/xJBhUtYjDd+2EaFXrlpEzT0N7m9Knz83ZFoqaDYe98FR46olc
         YTpQ==
X-Gm-Message-State: APjAAAWwB95IpHgrxGruqP/m8PVPEonHybWIXpkcbgQzwF0+65xDq47K
        PlCU3WiAqEDLsa0J1+PQ6C8=
X-Google-Smtp-Source: APXvYqy+ofGc0n+FxMtP+fVv8tHJNk6gX0lNNpmzRM5r19A5ov0U3k9+2STSgXpwUoy8ncsRLb0Zsg==
X-Received: by 2002:ac2:4c12:: with SMTP id t18mr8501245lfq.134.1566074335705;
        Sat, 17 Aug 2019 13:38:55 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id w4sm1552981lfk.4.2019.08.17.13.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2019 13:38:54 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] bugreport: generate config whitelist based on docs
Date:   Sat, 17 Aug 2019 22:38:46 +0200
Message-Id: <20190817203846.31609-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190817003926.102944-3-emilyshaffer@google.com>
References: <20190817003926.102944-3-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 17 Aug 2019 at 02:42, Emily Shaffer <emilyshaffer@google.com> wrote:
>
> Add a new step to the build to generate a whitelist of git-config
> variables which are appropriate to include in the output of
> git-bugreport. New variables can be added to the whitelist by annotating
> their documentation in Documentation/config with the line
> "// bugreport-include".

These "// bugreport-include" show up in the rendered manpages, both with
AsciiDoc and Asciidoctor. :-(

> --- a/Documentation/config/sendemail.txt
> +++ b/Documentation/config/sendemail.txt
> @@ -1,63 +1,63 @@
> -sendemail.identity::
> +sendemail.identity:: // bugreport-exclude
>         A configuration identity. When given, causes values in the

If I put each comment on a line of its own (after the config option, but
I suppose before would work the same way), Asciidoctor truly ignores
them and everything's fine. And AsciiDoc renders this one and others
like it ok.

> -sendemail.aliasesFile::
> -sendemail.aliasFileType::
> -sendemail.annotate::
> +sendemail.aliasesFile:: // bugreport-exclude
> +sendemail.aliasFileType:: // bugreport-exclude
> +sendemail.annotate:: // bugreport-include

However, AsciiDoc (version 8.6.10) seems to effectively replace those
comments with an empty line during processing, and it makes quite the
difference here. Instead of these appearing in a compact comma-separated
list, they are treated as individual items in the description list with
no supporting content.

FWIW, I like the idea of annotating things here to make it harder to
forget this whitelisting when adding a new config item.

Below is what I came up with as an alternative approach. Feel free to
steal, squash and/or ignore as you see fit.

BTW, I'm not sure the grep invocation is portable (-R ? -h ? -P ? -o ?).
We should probably also do the usual "create a candidate output file,
then move it into place" dance for robustness.

I do think we should test the generated whitelist in some minimal way,
e.g., to check that it does contain something which objectively belongs
in the whitelist and -- more importantly IMHO -- does *not* contain
something that shouldn't be there, such as sendemail.smtpPass.

Martin

-- >8 --
Subject: [PATCH] Use a bugreport:include/exclude macro instead

Implement a no-op "bugreport" macro for use as "bugreport:include[x]" to
annotate the config keys that should be included in the automatically
generated whitelist. Use "exclude" for the others.

With Asciidoctor, it's ok to say "bugreport:include[]", but AsciiDoc
seems to want something between the brackets. A bit unfortunate, but
not a huge problem -- we'll just provide an "x".

"doc-diff" reports that this macro doesn't render at all. That is,
these are both empty after this commit:

  cd Documentation
  ./doc-diff --asciidoctor :/"bugreport: add tool" HEAD
  ./doc-diff --asciidoc    :/"bugreport: add tool" HEAD

Diffing the rendered HTML shows that there is some small amount of
whitespace and comments added. That shouldn't be a problem.

We could perhaps let the implementation verify that the "action" is one
of "include" and "exclude". For the Asciidoctor implementation that
should be straightforward, but for AsciiDoc I don't immediately know how
to do it. Anyway, if someone stumbles on the keyboard and writes
"bugreport:icndule", they'll "only" miss out on the config key being
included in the whitelist. If this were a blacklist, the consequences of
a misspelled target could be a lot more severe.

Disclaimer: This is the outcome of a combination of copy-paste and
trial and error -- better solutions might be possible...

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 I suppose this could also be "annotate:bugreport[ignore]" to avoid the
 "[x]" and to place all of this under a more general "annotate" macro.

 Documentation/asciidoc.conf             |  8 +++
 Documentation/asciidoctor-extensions.rb |  8 +++
 Documentation/config/sendemail.txt      | 68 ++++++++++++-------------
 bugreport-generate-config-whitelist.sh  |  2 +-
 4 files changed, 51 insertions(+), 35 deletions(-)

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 2c16c536ba..5a3c5ef028 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -6,9 +6,13 @@
 #
 # Show Git link as: <command>(<section>); if section is defined, else just show
 # the command.
+#
+# The bugreport macro does nothing as far as rendering is
+# concerned -- we just grep for it in the sources.
 
 [macros]
 (?su)[\\]?(?P<name>linkgit):(?P<target>\S*?)\[(?P<attrlist>.*?)\]=
+(?su)[\\]?(?P<name>bugreport):(?P<action>\S*?)\[(?P<attrlist>.*?)\]=
 
 [attributes]
 asterisk=&#42;
@@ -28,6 +32,8 @@ ifdef::backend-docbook[]
 {0#<citerefentry>}
 {0#<refentrytitle>{target}</refentrytitle><manvolnum>{0}</manvolnum>}
 {0#</citerefentry>}
+[bugreport-inlinemacro]
+{0#}
 endif::backend-docbook[]
 
 ifdef::backend-docbook[]
@@ -94,4 +100,6 @@ ifdef::backend-xhtml11[]
 git-relative-html-prefix=
 [linkgit-inlinemacro]
 <a href="{git-relative-html-prefix}{target}.html">{target}{0?({0})}</a>
+[bugreport-inlinemacro]
+<!-- -->
 endif::backend-xhtml11[]
diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index 0089e0cfb8..54cbd5ddaf 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -20,9 +20,17 @@ module Git
         end
       end
     end
+    class BugReportProcessor < Asciidoctor::Extensions::InlineMacroProcessor
+      def process(parent, action, attrs)
+        ""
+      end
+    end
   end
 end
 
 Asciidoctor::Extensions.register do
   inline_macro Git::Documentation::LinkGitProcessor, :linkgit
+  # The bugreport macro does nothing as far as rendering is
+  # concerned -- we just grep for it in the sources.
+  inline_macro Git::Documentation::BugReportProcessor, :bugreport
 end
diff --git a/Documentation/config/sendemail.txt b/Documentation/config/sendemail.txt
index 69f3e4f219..92f5082013 100644
--- a/Documentation/config/sendemail.txt
+++ b/Documentation/config/sendemail.txt
@@ -1,63 +1,63 @@
-sendemail.identity:: // bugreport-exclude
+sendemail.identity bugreport:exclude[x] ::
 	A configuration identity. When given, causes values in the
 	'sendemail.<identity>' subsection to take precedence over
 	values in the 'sendemail' section. The default identity is
 	the value of `sendemail.identity`.
 
-sendemail.smtpEncryption:: // bugreport-include
+sendemail.smtpEncryption bugreport:include[x] ::
 	See linkgit:git-send-email[1] for description.  Note that this
 	setting is not subject to the 'identity' mechanism.
 
-sendemail.smtpssl (deprecated):: // bugreport-exclude
+sendemail.smtpssl (deprecated) bugreport:exclude[x] ::
 	Deprecated alias for 'sendemail.smtpEncryption = ssl'.
 
-sendemail.smtpsslcertpath:: // bugreport-exclude
+sendemail.smtpsslcertpath bugreport:exclude[x] ::
 	Path to ca-certificates (either a directory or a single file).
 	Set it to an empty string to disable certificate verification.
 
-sendemail.<identity>.*:: // bugreport-exclude
+sendemail.<identity>.* bugreport:exclude[x] ::
 	Identity-specific versions of the 'sendemail.*' parameters
 	found below, taking precedence over those when this
 	identity is selected, through either the command-line or
 	`sendemail.identity`.
 
-sendemail.aliasesFile:: // bugreport-exclude
-sendemail.aliasFileType:: // bugreport-exclude
-sendemail.annotate:: // bugreport-include
-sendemail.bcc:: // bugreport-include
-sendemail.cc:: // bugreport-include
-sendemail.ccCmd:: // bugreport-include
-sendemail.chainReplyTo:: // bugreport-include
-sendemail.confirm:: // bugreport-include
-sendemail.envelopeSender:: // bugreport-include
-sendemail.from:: // bugreport-include
-sendemail.multiEdit:: // bugreport-include
-sendemail.signedoffbycc:: // bugreport-include
-sendemail.smtpPass:: // bugreport-exclude
-sendemail.suppresscc:: // bugreport-include
-sendemail.suppressFrom:: // bugreport-include
-sendemail.to:: // bugreport-include
-sendemail.tocmd:: // bugreport-include
-sendemail.smtpDomain:: // bugreport-include
-sendemail.smtpServer:: // bugreport-include
-sendemail.smtpServerPort:: // bugreport-include
-sendemail.smtpServerOption:: // bugreport-include
-sendemail.smtpUser:: // bugreport-exclude
-sendemail.thread:: // bugreport-include
-sendemail.transferEncoding:: // bugreport-include
-sendemail.validate:: // bugreport-include
-sendemail.xmailer:: // bugreport-include
+sendemail.aliasesFile bugreport:exclude[x] ::
+sendemail.aliasFileType bugreport:exclude[x] ::
+sendemail.annotate bugreport:include[x] ::
+sendemail.bcc bugreport:include[x] ::
+sendemail.cc bugreport:include[x] ::
+sendemail.ccCmd bugreport:include[x] ::
+sendemail.chainReplyTo bugreport:include[x] ::
+sendemail.confirm bugreport:include[x] ::
+sendemail.envelopeSender bugreport:include[x] ::
+sendemail.from bugreport:include[x] ::
+sendemail.multiEdit bugreport:include[x] ::
+sendemail.signedoffbycc bugreport:include[x] ::
+sendemail.smtpPass bugreport:exclude[x] ::
+sendemail.suppresscc bugreport:include[x] ::
+sendemail.suppressFrom bugreport:include[x] ::
+sendemail.to bugreport:include[x] ::
+sendemail.tocmd bugreport:include[x] ::
+sendemail.smtpDomain bugreport:include[x] ::
+sendemail.smtpServer bugreport:include[x] ::
+sendemail.smtpServerPort bugreport:include[x] ::
+sendemail.smtpServerOption bugreport:include[x] ::
+sendemail.smtpUser bugreport:exclude[x] ::
+sendemail.thread bugreport:include[x] ::
+sendemail.transferEncoding bugreport:include[x] ::
+sendemail.validate bugreport:include[x] ::
+sendemail.xmailer bugreport:include[x] ::
 	See linkgit:git-send-email[1] for description.
 
-sendemail.signedoffcc (deprecated):: // bugreport-exclude
+sendemail.signedoffcc (deprecated) bugreport:exclude[x] ::
 	Deprecated alias for `sendemail.signedoffbycc`.
 
-sendemail.smtpBatchSize:: // bugreport-include
+sendemail.smtpBatchSize bugreport:include[x] ::
 	Number of messages to be sent per connection, after that a relogin
 	will happen.  If the value is 0 or undefined, send all messages in
 	one connection.
 	See also the `--batch-size` option of linkgit:git-send-email[1].
 
-sendemail.smtpReloginDelay:: // bugreport-include
+sendemail.smtpReloginDelay bugreport:include[x] ::
 	Seconds wait before reconnecting to smtp server.
 	See also the `--relogin-delay` option of linkgit:git-send-email[1].
diff --git a/bugreport-generate-config-whitelist.sh b/bugreport-generate-config-whitelist.sh
index ca6b232024..896b838cfa 100755
--- a/bugreport-generate-config-whitelist.sh
+++ b/bugreport-generate-config-whitelist.sh
@@ -1,4 +1,4 @@
 #!/bin/sh
 
-grep -RhPo ".*(?=:: \/\/ bugreport-include)" Documentation/config \
+grep -RhPo ".*(?= +bugreport:include.* ::)" Documentation/config \
   >git-bugreport-config-whitelist
-- 
2.23.0

