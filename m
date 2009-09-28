From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 2/2] Make just opening the generated MSVC solution
 file not modify it
Date: Mon, 28 Sep 2009 13:34:21 +0200
Message-ID: <f8aa063d3a2be33146b3626c4908ce1f64d9c7ac.1254137149.git.mstormo@gmail.com>
References: <cover.1254137149.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com
To: git@vger.kernel.org, spearce@spearce.org, sschuberth@gmail.com
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Sep 28 13:35:30 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f162.google.com ([209.85.211.162])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsEVR-00023Q-I1
	for gcvm-msysgit@m.gmane.org; Mon, 28 Sep 2009 13:35:01 +0200
Received: by mail-yw0-f162.google.com with SMTP id 34so5988149ywh.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 28 Sep 2009 04:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=bL78z+lRXwaS5OlQ8P+pa27NBdf36dIDzN6nwuOIA+M=;
        b=oTg/ubBcnXWJqPGvycBZrVnCdUKGBinwJXGPNyTJHjlRlF/8229kyDWMV7mFccXBl/
         e+w0NUVSooNrQ69U8rp0PP2RNILcSlOlwn23A23vfHV0RJC5gc7yAwNVhKZdkqXId4XN
         xuRp3iOFQdN/8acDoRDq3AdPmcXwuXm0S+P+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=ZBujeMCF7E+LQ38/tBNm+Q0dFKXrQbNkbincq3PqAKJ7voZPpZqtwYkdRsreXl2nMc
         f9CMUYi+GxTcv4FJK3h+a8Yd3uNcJczIse+aAT7zIlKlW4+SbXS0gxGF9pHhhKM2ZfxW
         f4hzzynLDQPEez2r41V+F7WYZ6dn8NQ5Yta/Q=
Received: by 10.100.240.3 with SMTP id n3mr634047anh.17.1254137695177;
        Mon, 28 Sep 2009 04:34:55 -0700 (PDT)
Received: by 10.177.5.4 with SMTP id h4gr7169yqi.0;
	Mon, 28 Sep 2009 04:34:47 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.146.28 with SMTP id y28mr516490ebn.4.1254137686416; Mon, 28 Sep 2009 04:34:46 -0700 (PDT)
Received: by 10.211.146.28 with SMTP id y28mr516488ebn.4.1254137686388; Mon, 28 Sep 2009 04:34:46 -0700 (PDT)
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.25]) by gmr-mx.google.com with ESMTP id 15si1291058ewy.0.2009.09.28.04.34.45; Mon, 28 Sep 2009 04:34:45 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 74.125.78.25 as permitted sender) client-ip=74.125.78.25;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 74.125.78.25 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by ey-out-2122.google.com with SMTP id 4so567778eyf.1 for <msysgit@googlegroups.com>; Mon, 28 Sep 2009 04:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=iMJAxtt2ND1l2z4iQTNz+9zgcwXEjglyJNoDWnJnYZs=; b=ecJcRUR0ks7E/BVpKmgcGXGOOTA3C8VYpq1qZEYnqJ3MQ+QkzjZNEtTYFx0tbGZ7hL Ha9Fsc6QqdHSo8QZALKR2Voh1rpd6GrHZKTIFYrvgrAQirWj50bRlJsH/8ewEOqcUpJQ djK6DGmPuy/W+yIZpWXWEFlyxw+lUO6DGgDgE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=D5r2zY0E7kwY+FFlaUeXaLr6rq8Es4zPX9uioV8mNyqFJOPcNepvYYK2r0IXk60Amy +105ToVSztqUUWDSaEJjqiZSozhTyUv0GgZ4gScGn2VFzTFOXAVG/CJuwCRixiUYqhHD 4NYR18AhpnXICcIjqUBINyQkjuee/PDD5o61c=
Received: by 10.211.147.5 with SMTP id z5mr3552800ebn.87.1254137685287; Mon, 28 Sep 2009 04:34:45 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 5sm755655eyh.35.2009.09.28.04.34.44 (version=SSLv3 cipher=RC4-MD5); Mon, 28 Sep 2009 04:34:44 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.rc2.177.ga9dd6
In-Reply-To: <cover.1254137149.git.mstormo@gmail.com>
In-Reply-To: <cover.1254137149.git.mstormo@gmail.com>
References: <4ABB84F4.7080403@gmail.com> <cover.1254137149.git.mstormo@gmail.com>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129254>


From: Sebastian Schuberth <sschuberth@gmail.com>

The format of the generated MSVC solution file is fixed in a way that
just opening it in Visual Studio and immediately closing it again
without performing any modifications does not trigger a prompt to save
the solution file. This behavior was caused by several minor
incompatibilities between the generated file and what Visual Studio
2008 expected, so Visual Studio transparently fixed the file format,
marking it internally as modified.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
Acked-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 contrib/buildsystems/Generators/Vcproj.pm |   42 +++++++---------------------
 1 files changed, 11 insertions(+), 31 deletions(-)

diff --git a/contrib/buildsystems/Generators/Vcproj.pm b/contrib/buildsystems/Generators/Vcproj.pm
index 50daa03..d53ff2c 100644
--- a/contrib/buildsystems/Generators/Vcproj.pm
+++ b/contrib/buildsystems/Generators/Vcproj.pm
@@ -571,45 +571,29 @@ sub createGlueProject {
         print F "\"${libname}\", \"${libname}\\${libname}.vcproj\", \"${uuid}\"";
         print F "$SLN_POST";
     }
+    my $uuid_libgit = $build_structure{"LIBS_libgit_GUID"};
+    my $uuid_xdiff_lib = $build_structure{"LIBS_xdiff_lib_GUID"};
     foreach (@apps) {
         my $appname = $_;
         my $uuid = $build_structure{"APPS_${appname}_GUID"};
         print F "$SLN_PRE";
-        print F "\"${appname}\", \"${appname}\\${appname}.vcproj\", \"${uuid}\"";
+        print F "\"${appname}\", \"${appname}\\${appname}.vcproj\", \"${uuid}\"\n";
+        print F "	ProjectSection(ProjectDependencies) = postProject\n";
+        print F "		${uuid_libgit} = ${uuid_libgit}\n";
+        print F "		${uuid_xdiff_lib} = ${uuid_xdiff_lib}\n";
+        print F "	EndProjectSection";
         print F "$SLN_POST";
     }
 
     print F << "EOM";
 Global
-	GlobalSection(SolutionConfiguration) = preSolution
-		ConfigName.0 = Debug|Win32
-		ConfigName.1 = Release|Win32
+	GlobalSection(SolutionConfigurationPlatforms) = preSolution
+		Debug|Win32 = Debug|Win32
+		Release|Win32 = Release|Win32
 	EndGlobalSection
-	GlobalSection(ProjectDependencies) = postSolution
 EOM
-    foreach (@{$build_structure{"APPS"}}) {
-        my $appname = $_;
-        my $appname_clean = $_;
-        $appname_clean =~ s/\//_/g;
-        $appname_clean =~ s/\.exe//;
-
-        my $uuid = $build_structure{"APPS_${appname_clean}_GUID"};
-        my $dep_index = 0;
-        foreach(@{$build_structure{"APPS_${appname}_LIBS"}}) {
-            my $libname = $_;
-            $libname =~ s/\//_/g;
-            $libname =~ s/\.(a|lib)//;
-            my $libuuid = $build_structure{"LIBS_${libname}_GUID"};
-            if (defined $libuuid) {
-                print F "\t\t${uuid}.${dep_index} = ${libuuid}\n";
-                $dep_index += 1;
-            }
-        }
-    }
-
     print F << "EOM";
-	EndGlobalSection
-	GlobalSection(ProjectConfiguration) = postSolution
+	GlobalSection(ProjectConfigurationPlatforms) = postSolution
 EOM
     foreach (@libs) {
         my $libname = $_;
@@ -630,10 +614,6 @@ EOM
 
     print F << "EOM";
 	EndGlobalSection
-	GlobalSection(ExtensibilityGlobals) = postSolution
-	EndGlobalSection
-	GlobalSection(ExtensibilityAddIns) = postSolution
-	EndGlobalSection
 EndGlobal
 EOM
     close F;
-- 
1.6.5.rc2.177.ga9dd6
