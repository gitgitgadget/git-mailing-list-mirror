Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E7E176ADE
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 14:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264885; cv=none; b=betlh0e1qw9orLfl3ae4CiCzEzB4hmIpri7oF6Z3JcgFQovAY/q7w/dYqY1lFQt/+f2eVWKSGVBIiuQsjesn0QQ4DQX8dxT+Tj3E1ZOH0qAfpSfELH9eleCKoN1OUdTX0W8+HBd/Cm8eS3xnFW2PfdjLxllLEUrzGguFnRVbzIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264885; c=relaxed/simple;
	bh=qQtk3v7ZJI+BXexkri1Jtn0q3dpaZilOzWmLo8pbOSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LHcwfpa6umUO07CW4pGBdJHGf7T2Y9jEv1K/OkVGUU7X08ZhhEKc0/S9ALMsNxB6+aGx+/q0fKnP1RJpha3N06tg6ePKxofb8Y1SAWXEHqPMPposF/h0DS1RnzEiv2i/A65L2meRNolqnHUADth8xhn9LggQ82Ooz1EKNsWqq+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPi/PiQN; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPi/PiQN"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7866aca9e25so23735427b3.3
        for <git@vger.kernel.org>; Tue, 04 Nov 2025 06:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762264882; x=1762869682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=y8bKtlFsuya4DvJ75JEnOvA29OBgMRPuWkKdiy+cBLs=;
        b=QPi/PiQNTpjNphiGiw5IBTqPvqql576GUq+hzhd8yIfbbZvHom6vvcwBgtD8j1FsDk
         M0DPYriLmg1OuTdBh7VsTi+rLt90gGMRIiTAqFp3NbtSEu6pWdi2uPG9NyUKySiOKZqv
         cg86rclT4eyO+xXd7vlnlgt1g11Ckj6nEtotQzYHuTcDeMHIOMcZkd1KD+b0U8/BhyKa
         FZX2ss8DOY3t4zdkakzm8T9+MWIPXuxORJRZqPWVN6OMHsBDvAJS0kQUt03a0iD0Lcju
         UsPQl5UkK68TBcxZmKOZNKBirmtxLjcL6f94CQOEuqv8cUiwmoGuWolGIkdgKctB4FJx
         GogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762264882; x=1762869682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8bKtlFsuya4DvJ75JEnOvA29OBgMRPuWkKdiy+cBLs=;
        b=Uun86UKpSi3QbGNVm8C31pX56QaZIc1nqiQvFHsF0nmk7Jg8a6vmNIdVflwh/P1vlt
         BVShyRBzxzRwc/plM+hrnY6jXIj/qfmulZ7sBVczEa0OiqkXMPYjloRJlqe955GB1N62
         UU9HqbbKTRIlwhmVBU8WiNBq8nSmc+tHxjfavIBzO96cE09K0OUx58iS05Ac1NtHdQ84
         PKD8s0JeN/tQN8bgPqUfKV6rzu3yGqDeGDVOOfotJHRBv0Jl6tQveuGnqSMZljkdBADA
         sAIXKic7tyQ7Hb9Vv+2YUV3tE/4DkPD0E+Ds+xb9rkO3VnaBLyyAR5Ub2HPImcTQntag
         mOSA==
X-Gm-Message-State: AOJu0YynoB0eEaudXyN4CVYeBAqg6XV33T3kX9mbZ5RyGoy39yYBUs0d
	nW6Sk53dkiaF31qBKfrZsjBMqzXAV97mBVB1h7bbteCdsYlZZjnDWbHFCso06E50
X-Gm-Gg: ASbGnctPBqgjjOQDFrR6XDmP5NO8IGyUvPgDLU+neQWnErvvEYR9gYqIiKRjB5JHAez
	s89+yxITkBtL+HQrATCvCfwN1W/RErf8uoLH1iyrIOwuQy1kL7jalA2KCy4cr4ToK8OICwXATPP
	5d6vua4gkLM03EKANNgpTu8vRZO1ysx+WjCsYMHAOsKxmnyxA6ZwPU0Pcq6US/dICRa1Md5NUoB
	FdyQuMPDiWJot31SrfqcqSKluTosTH+4wH1bK1Lz2624WDbrZ7GiDDYgjR8pwwHX+9DI0CS2Psx
	xyAt/ma/0NFbZJltel9kuoIofHF0cbijhLdpzcnYkzAm9Qw3V8oilaRaZdvpIObwyP+GYU74fZw
	f/FiR+YKPvlKizuwFUV3YzIu66CqzobD2OCoacYdx/DReET+EEL7NFk53HmAXXGBoF4vktoAPVr
	rNKmfjWLutKyKnsXYZXTk3m0thNw763oLXr0pU
X-Google-Smtp-Source: AGHT+IHcDyCFkFt4DKaC9EDEY570OqG7xxhvmCiYe13gKr5RHWjzBHK7A3dZkKM8yPQNT3vRB3cIuQ==
X-Received: by 2002:a05:690c:6ac3:b0:784:1f81:8c39 with SMTP id 00721157ae682-7864855928bmr154318367b3.59.1762264881825;
        Tue, 04 Nov 2025 06:01:21 -0800 (PST)
Received: from macaroon.lan ([2605:a601:90a8:8b00:c994:debe:d31f:7aa])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78691d8eecfsm10219337b3.12.2025.11.04.06.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:01:20 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Todd Zullinger <tmz@pobox.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] meson: make GIT_HTML_PATH configurable
Date: Tue,  4 Nov 2025 08:58:29 -0500
Message-ID: <385992f6020703558f0ba75a1be6c4f9dae08b83.1762264709.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Makefile-based builds can configure Git's internal HTML_PATH by defining
htmldir, which is useful for packagers that put documentation in
different locations. Gentoo, for example, uses version-suffixed
directories like ${prefix}/share/doc/git-2.51 and puts the HTML
documentation in an 'html' subdirectory of the same.

Propagate the same configuration knob to Meson-based builds so that
"git --html-path" on such systems can be configured to output the
correct directory.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---

I've tested this with a modified live Gentoo ebuild [1] and had good results.

[1]: https://github.com/benknoble/gentoo-repo/commit/f2e6bbc8ec5e061a7f8151e56fa91a9d31b5b30b

 Documentation/howto/meson.build     |  4 ++--
 Documentation/meson.build           | 12 ++++++------
 Documentation/technical/meson.build |  4 ++--
 contrib/contacts/meson.build        |  2 +-
 contrib/subtree/meson.build         |  2 +-
 meson.build                         |  7 ++++++-
 meson_options.txt                   |  2 ++
 7 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/Documentation/howto/meson.build b/Documentation/howto/meson.build
index ece20244af..16b9056f24 100644
--- a/Documentation/howto/meson.build
+++ b/Documentation/howto/meson.build
@@ -35,7 +35,7 @@ doc_targets += custom_target(
   output: 'howto-index.html',
   depends: documentation_deps,
   install: true,
-  install_dir: get_option('datadir') / 'doc/git-doc',
+  install_dir: htmldir,
 )
 
 foreach howto : howto_sources
@@ -57,6 +57,6 @@ foreach howto : howto_sources
     output: fs.stem(howto_stripped.full_path()) + '.html',
     depends: documentation_deps,
     install: true,
-    install_dir: get_option('datadir') / 'doc/git-doc/howto',
+    install_dir: htmldir / 'howto',
   )
 endforeach
diff --git a/Documentation/meson.build b/Documentation/meson.build
index 9d24f2da54..c00c9fe7f4 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -412,7 +412,7 @@ foreach manpage, category : manpages
       input: manpage,
       output: fs.stem(manpage) + '.html',
       install: true,
-      install_dir: get_option('datadir') / 'doc/git-doc',
+      install_dir: htmldir,
     )
   endif
 endforeach
@@ -423,7 +423,7 @@ if get_option('docs').contains('html')
     output: 'docinfo.html',
     copy: true,
     install: true,
-    install_dir: get_option('datadir') / 'doc/git-doc',
+    install_dir: htmldir,
   )
 
   configure_file(
@@ -431,11 +431,11 @@ if get_option('docs').contains('html')
     output: 'docbook-xsl.css',
     copy: true,
     install: true,
-    install_dir: get_option('datadir') / 'doc/git-doc',
+    install_dir: htmldir,
   )
 
   install_symlink('index.html',
-    install_dir: get_option('datadir') / 'doc/git-doc',
+    install_dir: htmldir,
     pointing_to: 'git.html',
   )
 
@@ -466,7 +466,7 @@ if get_option('docs').contains('html')
     input: 'docbook.xsl',
     output: 'user-manual.html',
     install: true,
-    install_dir: get_option('datadir') / 'doc/git-doc',
+    install_dir: htmldir,
   )
 
   articles = [
@@ -492,7 +492,7 @@ if get_option('docs').contains('html')
       output: fs.stem(article) + '.html',
       depends: documentation_deps,
       install: true,
-      install_dir: get_option('datadir') / 'doc/git-doc',
+      install_dir: htmldir,
     )
   endforeach
 
diff --git a/Documentation/technical/meson.build b/Documentation/technical/meson.build
index be698ef22a..faff3964a9 100644
--- a/Documentation/technical/meson.build
+++ b/Documentation/technical/meson.build
@@ -53,7 +53,7 @@ doc_targets += custom_target(
   output: 'api-index.html',
   depends: documentation_deps,
   install: true,
-  install_dir: get_option('datadir') / 'doc/git-doc/technical',
+  install_dir: htmldir / 'technical',
 )
 
 foreach article : api_docs + articles
@@ -63,6 +63,6 @@ foreach article : api_docs + articles
     output: fs.stem(article) + '.html',
     depends: documentation_deps,
     install: true,
-    install_dir: get_option('datadir') / 'doc/git-doc/technical',
+    install_dir: htmldir / 'technical',
   )
 endforeach
diff --git a/contrib/contacts/meson.build b/contrib/contacts/meson.build
index c8fdb35ed9..4ae6b32a03 100644
--- a/contrib/contacts/meson.build
+++ b/contrib/contacts/meson.build
@@ -50,6 +50,6 @@ if get_option('docs').contains('html')
     input: 'git-contacts.adoc',
     output: 'git-contacts.html',
     install: true,
-    install_dir: get_option('datadir') / 'doc/git-doc',
+    install_dir: htmldir,
   )
 endif
diff --git a/contrib/subtree/meson.build b/contrib/subtree/meson.build
index 46cdbcc30c..161435abeb 100644
--- a/contrib/subtree/meson.build
+++ b/contrib/subtree/meson.build
@@ -68,6 +68,6 @@ if get_option('docs').contains('html')
     input: 'git-subtree.adoc',
     output: 'git-subtree.html',
     install: true,
-    install_dir: get_option('datadir') / 'doc/git-doc',
+    install_dir: htmldir,
   )
 endif
diff --git a/meson.build b/meson.build
index 2b763f7c53..1f95a06edb 100644
--- a/meson.build
+++ b/meson.build
@@ -768,13 +768,18 @@ if test_output_directory == ''
   test_output_directory = meson.project_build_root() / 'test-output'
 endif
 
+htmldir = get_option('htmldir')
+if htmldir == ''
+  htmldir = get_option('datadir') / 'doc/git-doc'
+endif
+
 # These variables are used for building libgit.a.
 libgit_c_args = [
   '-DBINDIR="' + get_option('bindir') + '"',
   '-DDEFAULT_GIT_TEMPLATE_DIR="' + get_option('datadir') / 'git-core/templates' + '"',
   '-DFALLBACK_RUNTIME_PREFIX="' + get_option('prefix') + '"',
   '-DGIT_HOST_CPU="' + host_machine.cpu_family() + '"',
-  '-DGIT_HTML_PATH="' + get_option('datadir') / 'doc/git-doc"',
+  '-DGIT_HTML_PATH="' + htmldir + '"',
   '-DGIT_INFO_PATH="' + get_option('infodir') + '"',
   '-DGIT_LOCALE_PATH="' + get_option('localedir') + '"',
   '-DGIT_MAN_PATH="' + get_option('mandir') + '"',
diff --git a/meson_options.txt b/meson_options.txt
index 143dee9237..13d421c067 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -1,6 +1,8 @@
 # Configuration for Git installation
 option('perllibdir', type: 'string', value: '',
   description: 'Directory to install perl lib to. Defaults to <datadir>/perl5')
+option('htmldir', type: 'string', value: '',
+  description: 'Directory to install HTML docs to. Defaults to <datadir>/doc/git-doc')
 
 # Configuration for how Git behaves at runtime.
 option('default_pager', type: 'string', value: 'less',

base-commit: 7f278e958afbf9b7e0727631b4c26dcfa1c63d6e
-- 
2.48.1

