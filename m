From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 14/14] Add scripts to generate projects for other
 buildsystems (MSVC vcproj, QMake)
Date: Tue, 15 Sep 2009 15:44:17 +0200
Message-ID: <343aaea4c31fef11f433acaba3de0b2af88e328a.1253021728.git.mstormo@gmail.com>
References: <cover.1253021221.git.mstormo@gmail.com> <213f3c7799721c3f42ffa689498175f0495048eb.1253021728.git.mstormo@gmail.com> <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253021728.git.mstormo@gmail.com> <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253021728.git.mstormo@gmail.com> <badc5d24387c28c752a45f75e8aec6bce64f81fe.1253021728.git.mstormo@gmail.com> <8368a0b347c01e7ddb5e5b514a46e55dd6f0daf7.1253021728.git.mstormo@gmail.com> <ffd7cfd6114f08c6502b21140d56d9bcd5d2a554.1253021728.git.mstormo@gmail.com> <4924c3de4fa490d1f41b75d18864f0a57fbd0eda.1253021728.git.mstormo@gmail.com> <88c817f030cfcc1e3b9e08f80d7ccfbcdfad7ecb.1253021728.git.mstormo@gmail.com> <8bcd4b022f59a5f55b63f87c9cf6a4dadc71cc44.1253021728.git.mstormo@gmail.com> <606db5a89cc49818fa225312a3bb6dbda18867a6.1253021728.git.mstorm
 o@gmail.com> <65347d022ba857d57d3c081f28b239b9b665c587.1253021728.git.mstormo@gmail.com> <9fc49662e1ec00388adb3d50c41d20561ed58939.1253021728.git.mstormo@gmail.com> <22e0abb5a1e91c3ca95f8538d8396c167bb1028d.1253021728.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com, raa.lkml@gmail.com, snaury@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Sep 15 15:45:25 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f140.google.com ([209.85.211.140])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnYLP-0007Fa-Nz
	for gcvm-msysgit@m.gmane.org; Tue, 15 Sep 2009 15:45:20 +0200
Received: by mail-yw0-f140.google.com with SMTP id 4so11220463ywh.9
        for <gcvm-msysgit@m.gmane.org>; Tue, 15 Sep 2009 06:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=OuL22gQFs94u7OmS6ZDZLA0RzZsu1TzPg5Kt0MKomEs=;
        b=mJ9z7OalxYov1mxPr0mT/Q5udhiYGSStVBf/VYIPQQZmfhjKyvxy5Nqe2eiCl5o87i
         eJWmeej3sV4hqhlLNWBMFMGDdSUWqTVX9Oxrs7gRWQ57hELdoL2BUUYRlZzWq8g+RT9m
         pYdzpHcPjsL5DgB549GWOMueLZAjwrTOeJkXA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=A5F3juqk6dHzeMkuthENcNyZIdwQhPUMMBQF2qMgtaRNEAiUb6Tm0CswedF3t3l+lS
         rTKk4wchJQgxQTjZ2FyaHzjOEq8k9Ym9JA5BMMAr0tVXLlHugk1yk6hYgyxOKlBa3rt1
         n1/sEHZ5Tv+qyKz/WGpauimYDiiXHgDdCQKkQ=
Received: by 10.150.106.5 with SMTP id e5mr2119725ybc.33.1253022307441;
        Tue, 15 Sep 2009 06:45:07 -0700 (PDT)
Received: by 10.177.112.39 with SMTP id p39gr7021yqm.0;
	Tue, 15 Sep 2009 06:44:59 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.101.1 with SMTP id y1mr93755ebb.13.1253022297841; Tue, 15 Sep 2009 06:44:57 -0700 (PDT)
Received: by 10.210.101.1 with SMTP id y1mr93754ebb.13.1253022297819; Tue, 15 Sep 2009 06:44:57 -0700 (PDT)
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.26]) by gmr-mx.google.com with ESMTP id 16si1527597ewy.3.2009.09.15.06.44.56; Tue, 15 Sep 2009 06:44:56 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 74.125.78.26 as permitted sender) client-ip=74.125.78.26;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 74.125.78.26 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by ey-out-2122.google.com with SMTP id 9so774061eyd.25 for <msysgit@googlegroups.com>; Tue, 15 Sep 2009 06:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=QC4GZomQoSV8r2NCKJaZjVNfEo6onTR8EAAdK2JUEUE=; b=wKs/G8IAqcRRwSL0nFTq+PMi3WQnPtxMAFAZsbfOvNzDlkI0ZDC8B1qZ2uCIF1C/nw ipCoNhWZN1zXVNfRJI3QXJUnx/dnOd+S3wziceolQHKK+/D037I18T0wpy8mnEQIh7sV Rrc131/1Kq3emdLN0BEZXFFO4Zi/IK+v/jCmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=lpXB6MLEnmXfg7lAU/d8Ap51skT6wrpF3k3zsplweMKfYwLaSxliWKwZZEBAhmFp71 yQTEE+uK1HwN7KtgVhcy5IO2yE25+CKkyC62Jew+7KFEVTgcnCbk+6jY41uz/FxokGCl IlYevELddG85To7uKasbouooX9nnPGllea6Iw=
Received: by 10.211.184.18 with SMTP id l18mr8385772ebp.30.1253022296640; Tue, 15 Sep 2009 06:44:56 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 7sm81939eyg.4.2009.09.15.06.44.55 (version=SSLv3 cipher=RC4-MD5); Tue, 15 Sep 2009 06:44:56 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <22e0abb5a1e91c3ca95f8538d8396c167bb1028d.1253021728.git.mstormo@gmail.com>
In-Reply-To: <cover.1253021728.git.mstormo@gmail.com>
References: <cover.1253021728.git.mstormo@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128557>


These scripts generate projects for the MSVC IDE (.vcproj files) or
QMake (.pro files), based on the output of a 'make -n MSVC=1 V=1' run.

This enables us to simply do the necesarry changes in the Makefile, and you
can update the other buildsystems by regenerating the files. Keeping the
other buildsystems up-to-date with main development.

The generator system is designed to easily drop in pm's for other
buildsystems as well, if someone has an itch. However, the focus has been
Windows development, so the 'engine' might need patches to support any
platform.

Also add some .gitignore entries for MSVC files.

Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 .gitignore                                |   11 +
 compat/vcbuild/README                     |   13 +-
 contrib/buildsystems/Generators.pm        |   42 ++
 contrib/buildsystems/Generators/QMake.pm  |  189 +++++++++
 contrib/buildsystems/Generators/Vcproj.pm |  639 +++++++++++++++++++++++++++++
 contrib/buildsystems/engine.pl            |  353 ++++++++++++++++
 contrib/buildsystems/generate             |   29 ++
 contrib/buildsystems/parse.pl             |  228 ++++++++++
 8 files changed, 1503 insertions(+), 1 deletions(-)
 create mode 100644 contrib/buildsystems/Generators.pm
 create mode 100644 contrib/buildsystems/Generators/QMake.pm
 create mode 100644 contrib/buildsystems/Generators/Vcproj.pm
 create mode 100644 contrib/buildsystems/engine.pl
 create mode 100644 contrib/buildsystems/generate
 create mode 100644 contrib/buildsystems/parse.pl

diff --git a/.gitignore b/.gitignore
index 47672b0..51a37b1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -179,3 +179,14 @@ configure
 tags
 TAGS
 cscope*
+*.obj
+*.lib
+*.sln
+*.suo
+*.ncb
+*.vcproj
+*.user
+*.idb
+*.pdb
+Debug/
+Release/
diff --git a/compat/vcbuild/README b/compat/vcbuild/README
index 5d7a07a..e64f7e5 100644
--- a/compat/vcbuild/README
+++ b/compat/vcbuild/README
@@ -33,7 +33,18 @@ The Steps of Build Git with VS2008
        make common-cmds.h
    to generate the common-cmds.h file needed to compile git.
 
-5. Then build Git with the GNU Make Makefile in the Git projects root
+5. Then either build Git with the GNU Make Makefile in the Git projects
+   root
        make MSVC=1
+   or generate Visual Studio solution/projects (.sln/.vcproj) with the
+   command
+       perl contrib/buildsystems/generate -g Vcproj
+   and open and build the solution with the IDE
+       devenv git.sln /useenv
+   or build with the IDE build engine directly from the command line
+       devenv git.sln /useenv /build "Release|Win32"
+   The /useenv option is required, so Visual Studio picks up the
+   environment variables for the support libraries required to build
+   Git, which you set up in step 1.
 
 Done!
diff --git a/contrib/buildsystems/Generators.pm b/contrib/buildsystems/Generators.pm
new file mode 100644
index 0000000..408ef71
--- /dev/null
+++ b/contrib/buildsystems/Generators.pm
@@ -0,0 +1,42 @@
+package Generators;
+require Exporter;
+
+use strict;
+use File::Basename;
+no strict 'refs';
+use vars qw($VERSION @AVAILABLE);
+
+our $VERSION = '1.00';
+our(@ISA, @EXPORT, @EXPORT_OK, @AVAILABLE);
+@ISA = qw(Exporter);
+
+BEGIN {
+    local(*D);
+    my $me = $INC{"Generators.pm"};
+    die "Couldn't find myself in \@INC, which is required to load the generators!" if ("$me" eq "");
+    $me = dirname($me);
+    if (opendir(D,"$me/Generators")) {
+        foreach my $gen (readdir(D)) {
+            next if ($gen  =~ /^\.\.?$/);
+            require "${me}/Generators/$gen";
+            $gen =~ s,\.pm,,;
+            push(@AVAILABLE, $gen);
+        }
+        closedir(D);
+        my $gens = join(', ', @AVAILABLE);
+    }
+
+    push @EXPORT_OK, qw(available);
+}
+
+sub available {
+    return @AVAILABLE;
+}
+
+sub generate {
+    my ($gen, $git_dir, $out_dir, $rel_dir, %build_structure) = @_;
+    return eval("Generators::${gen}::generate(\$git_dir, \$out_dir, \$rel_dir, \%build_structure)") if grep(/^$gen$/, @AVAILABLE);
+    die "Generator \"${gen}\" is not available!\nAvailable generators are: @AVAILABLE\n";
+}
+
+1;
diff --git a/contrib/buildsystems/Generators/QMake.pm b/contrib/buildsystems/Generators/QMake.pm
new file mode 100644
index 0000000..ff3b657
--- /dev/null
+++ b/contrib/buildsystems/Generators/QMake.pm
@@ -0,0 +1,189 @@
+package Generators::QMake;
+require Exporter;
+
+use strict;
+use vars qw($VERSION);
+
+our $VERSION = '1.00';
+our(@ISA, @EXPORT, @EXPORT_OK, @AVAILABLE);
+@ISA = qw(Exporter);
+
+BEGIN {
+    push @EXPORT_OK, qw(generate);
+}
+
+sub generate {
+    my ($git_dir, $out_dir, $rel_dir, %build_structure) = @_;
+
+    my @libs = @{$build_structure{"LIBS"}};
+    foreach (@libs) {
+        createLibProject($_, $git_dir, $out_dir, $rel_dir, %build_structure);
+    }
+
+    my @apps = @{$build_structure{"APPS"}};
+    foreach (@apps) {
+        createAppProject($_, $git_dir, $out_dir, $rel_dir, %build_structure);
+    }
+
+    createGlueProject($git_dir, $out_dir, $rel_dir, %build_structure);
+    return 0;
+}
+
+sub createLibProject {
+    my ($libname, $git_dir, $out_dir, $rel_dir, %build_structure) = @_;
+    print "Generate $libname lib project\n";
+    $rel_dir = "../$rel_dir";
+
+    my $sources = join(" \\\n\t", sort(map("$rel_dir/$_", @{$build_structure{"LIBS_${libname}_SOURCES"}})));
+    my $defines = join(" \\\n\t", sort(@{$build_structure{"LIBS_${libname}_DEFINES"}}));
+    my $includes= join(" \\\n\t", sort(map("$rel_dir/$_", @{$build_structure{"LIBS_${libname}_INCLUDES"}})));
+    my $cflags  = join(" ", sort(@{$build_structure{"LIBS_${libname}_CFLAGS"}}));
+
+    my $cflags_debug = $cflags;
+    $cflags_debug =~ s/-MT/-MTd/;
+    $cflags_debug =~ s/-O.//;
+
+    my $cflags_release = $cflags;
+    $cflags_release =~ s/-MTd/-MT/;
+
+    my @tmp  = @{$build_structure{"LIBS_${libname}_LFLAGS"}};
+    my @tmp2 = ();
+    foreach (@tmp) {
+        if (/^-LTCG/) {
+        } elsif (/^-L/) {
+            $_ =~ s/^-L/-LIBPATH:$rel_dir\//;
+        }
+        push(@tmp2, $_);
+    }
+    my $lflags = join(" ", sort(@tmp));
+
+    my $target = $libname;
+    $target =~ s/\//_/g;
+    $defines =~ s/-D//g;
+    $defines =~ s/"/\\\\"/g;
+    $includes =~ s/-I//g;
+    mkdir "$target" || die "Could not create the directory $target for lib project!\n";
+    open F, ">$target/$target.pro" || die "Could not open $target/$target.pro for writing!\n";
+    print F << "EOM";
+TEMPLATE = lib
+TARGET = $target
+DESTDIR = $rel_dir
+
+CONFIG -= qt
+CONFIG += static
+
+QMAKE_CFLAGS =
+QMAKE_CFLAGS_RELEASE = $cflags_release
+QMAKE_CFLAGS_DEBUG = $cflags_debug
+QMAKE_LIBFLAGS = $lflags
+
+DEFINES += \\
+        $defines
+
+INCLUDEPATH += \\
+        $includes
+
+SOURCES += \\
+        $sources
+EOM
+    close F;
+}
+
+sub createAppProject {
+    my ($appname, $git_dir, $out_dir, $rel_dir, %build_structure) = @_;
+    print "Generate $appname app project\n";
+    $rel_dir = "../$rel_dir";
+
+    my $sources = join(" \\\n\t", sort(map("$rel_dir/$_", @{$build_structure{"APPS_${appname}_SOURCES"}})));
+    my $defines = join(" \\\n\t", sort(@{$build_structure{"APPS_${appname}_DEFINES"}}));
+    my $includes= join(" \\\n\t", sort(map("$rel_dir/$_", @{$build_structure{"APPS_${appname}_INCLUDES"}})));
+    my $cflags  = join(" ", sort(@{$build_structure{"APPS_${appname}_CFLAGS"}}));
+
+    my $cflags_debug = $cflags;
+    $cflags_debug =~ s/-MT/-MTd/;
+    $cflags_debug =~ s/-O.//;
+
+    my $cflags_release = $cflags;
+    $cflags_release =~ s/-MTd/-MT/;
+
+    my $libs;
+    foreach (sort(@{$build_structure{"APPS_${appname}_LIBS"}})) {
+        $_ =~ s/\//_/g;
+        $libs .= " $_";
+    }
+    my @tmp  = @{$build_structure{"APPS_${appname}_LFLAGS"}};
+    my @tmp2 = ();
+    foreach (@tmp) {
+        # next if ($_ eq "-NODEFAULTLIB:MSVCRT.lib");
+        if (/^-LTCG/) {
+        } elsif (/^-L/) {
+            $_ =~ s/^-L/-LIBPATH:$rel_dir\//;
+        }
+        push(@tmp2, $_);
+    }
+    my $lflags = join(" ", sort(@tmp));
+
+    my $target = $appname;
+    $target =~ s/\.exe//;
+    $target =~ s/\//_/g;
+    $defines =~ s/-D//g;
+    $defines =~ s/"/\\\\"/g;
+    $includes =~ s/-I//g;
+    mkdir "$target" || die "Could not create the directory $target for app project!\n";
+    open F, ">$target/$target.pro" || die "Could not open $target/$target.pro for writing!\n";
+    print F << "EOM";
+TEMPLATE = app
+TARGET = $target
+DESTDIR = $rel_dir
+
+CONFIG -= qt embed_manifest_exe
+CONFIG += console
+
+QMAKE_CFLAGS =
+QMAKE_CFLAGS_RELEASE = $cflags_release
+QMAKE_CFLAGS_DEBUG = $cflags_debug
+QMAKE_LFLAGS = $lflags
+LIBS   = $libs
+
+DEFINES += \\
+        $defines
+
+INCLUDEPATH += \\
+        $includes
+
+win32:QMAKE_LFLAGS += -LIBPATH:$rel_dir
+else: QMAKE_LFLAGS += -L$rel_dir
+
+SOURCES += \\
+        $sources
+EOM
+    close F;
+}
+
+sub createGlueProject {
+    my ($git_dir, $out_dir, $rel_dir, %build_structure) = @_;
+    my $libs = join(" \\ \n", map("\t$_|$_.pro", @{$build_structure{"LIBS"}}));
+    my $apps = join(" \\ \n", map("\t$_|$_.pro", @{$build_structure{"APPS"}}));
+    $libs =~ s/\.a//g;
+    $libs =~ s/\//_/g;
+    $libs =~ s/\|/\//g;
+    $apps =~ s/\.exe//g;
+    $apps =~ s/\//_/g;
+    $apps =~ s/\|/\//g;
+
+    my $filename = $out_dir;
+    $filename =~ s/.*\/([^\/]+)$/$1/;
+    $filename =~ s/\/$//;
+    print "Generate glue project $filename.pro\n";
+    open F, ">$filename.pro" || die "Could not open $filename.pro for writing!\n";
+    print F << "EOM";
+TEMPLATE = subdirs
+CONFIG += ordered
+SUBDIRS += \\
+$libs \\
+$apps
+EOM
+    close F;
+}
+
+1;
diff --git a/contrib/buildsystems/Generators/Vcproj.pm b/contrib/buildsystems/Generators/Vcproj.pm
new file mode 100644
index 0000000..00ec0c1
--- /dev/null
+++ b/contrib/buildsystems/Generators/Vcproj.pm
@@ -0,0 +1,639 @@
+package Generators::Vcproj;
+require Exporter;
+
+use strict;
+use vars qw($VERSION);
+
+our $VERSION = '1.00';
+our(@ISA, @EXPORT, @EXPORT_OK, @AVAILABLE);
+@ISA = qw(Exporter);
+
+BEGIN {
+    push @EXPORT_OK, qw(generate);
+}
+
+my $guid_index = 0;
+my @GUIDS = (
+    "{E07B9989-2BF7-4F21-8918-BE22BA467AC3}",
+    "{278FFB51-0296-4A44-A81A-22B87B7C3592}",
+    "{7346A2C4-F0FD-444F-9EBE-1AF23B2B5650}",
+    "{67F421AC-EB34-4D49-820B-3196807B423F}",
+    "{385DCFE1-CC8C-4211-A451-80FCFC31CA51}",
+    "{97CC46C5-D2CC-4D26-B634-E75792B79916}",
+    "{C7CE21FE-6EF8-4012-A5C7-A22BCEDFBA11}",
+    "{51575134-3FDF-42D1-BABD-3FB12669C6C9}",
+    "{0AE195E4-9823-4B87-8E6F-20C5614AF2FF}",
+    "{4B918255-67CA-43BB-A46C-26704B666E6B}",
+    "{18CCFEEF-C8EE-4CC1-A265-26F95C9F4649}",
+    "{5D5D90FA-01B7-4973-AFE5-CA88C53AC197}",
+    "{1F054320-036D-49E1-B384-FB5DF0BC8AC0}",
+    "{7CED65EE-F2D9-4171-825B-C7D561FE5786}",
+    "{8D341679-0F07-4664-9A56-3BA0DE88B9BC}",
+    "{C189FEDC-2957-4BD7-9FA4-7622241EA145}",
+    "{66844203-1B9F-4C53-9274-164FFF95B847}",
+    "{E4FEA145-DECC-440D-AEEA-598CF381FD43}",
+    "{73300A8E-C8AC-41B0-B555-4F596B681BA7}",
+    "{873FDEB1-D01D-40BF-A1BF-8BBC58EC0F51}",
+    "{7922C8BE-76C5-4AC6-8BF7-885C0F93B782}",
+    "{E245D370-308B-4A49-BFC1-1E527827975F}",
+    "{F6FA957B-66FC-4ED7-B260-E59BBE4FE813}",
+    "{E6055070-0198-431A-BC49-8DB6CEE770AE}",
+    "{54159234-C3EB-43DA-906B-CE5DA5C74654}",
+    "{594CFC35-0B60-46F6-B8EF-9983ACC1187D}",
+    "{D93FCAB7-1F01-48D2-B832-F761B83231A5}",
+    "{DBA5E6AC-E7BE-42D3-8703-4E787141526E}",
+    "{6171953F-DD26-44C7-A3BE-CC45F86FC11F}",
+    "{9E19DDBE-F5E4-4A26-A2FE-0616E04879B8}",
+    "{AE81A615-99E3-4885-9CE0-D9CAA193E867}",
+    "{FBF4067E-1855-4F6C-8BCD-4D62E801A04D}",
+    "{17007948-6593-4AEB-8106-F7884B4F2C19}",
+    "{199D4C8D-8639-4DA6-82EF-08668C35DEE0}",
+    "{E085E50E-C140-4CF3-BE4B-094B14F0DDD6}",
+    "{00785268-A9CC-4E40-AC29-BAC0019159CE}",
+    "{4C06F56A-DCDB-46A6-B67C-02339935CF12}",
+    "{3A62D3FD-519E-4EC9-8171-D2C1BFEA022F}",
+    "{3A62D3FD-519E-4EC9-8171-D2C1BFEA022F}",
+    "{9392EB58-D7BA-410B-B1F0-B2FAA6BC89A7}",
+    "{2ACAB2D5-E0CE-4027-BCA0-D78B2D7A6C66}",
+    "{86E216C3-43CE-481A-BCB2-BE5E62850635}",
+    "{FB631291-7923-4B91-9A57-7B18FDBB7A42}",
+    "{0A176EC9-E934-45B8-B87F-16C7F4C80039}",
+    "{DF55CA80-46E8-4C53-B65B-4990A23DD444}",
+    "{3A0F9895-55D2-4710-BE5E-AD7498B5BF44}",
+    "{294BDC5A-F448-48B6-8110-DD0A81820F8C}",
+    "{4B9F66E9-FAC9-47AB-B1EF-C16756FBFD06}",
+    "{72EA49C6-2806-48BD-B81B-D4905102E19C}",
+    "{5728EB7E-8929-486C-8CD5-3238D060E768}"
+);
+
+sub generate {
+    my ($git_dir, $out_dir, $rel_dir, %build_structure) = @_;
+    my @libs = @{$build_structure{"LIBS"}};
+    foreach (@libs) {
+        createLibProject($_, $git_dir, $out_dir, $rel_dir, \%build_structure);
+    }
+
+    my @apps = @{$build_structure{"APPS"}};
+    foreach (@apps) {
+        createAppProject($_, $git_dir, $out_dir, $rel_dir, \%build_structure);
+    }
+
+    createGlueProject($git_dir, $out_dir, $rel_dir, %build_structure);
+    return 0;
+}
+
+sub createLibProject {
+    my ($libname, $git_dir, $out_dir, $rel_dir, $build_structure) = @_;
+    print "Generate $libname vcproj lib project\n";
+    $rel_dir = "..\\$rel_dir";
+    $rel_dir =~ s/\//\\/g;
+
+    my $target = $libname;
+    $target =~ s/\//_/g;
+    $target =~ s/\.a//;
+
+    my $uuid = $GUIDS[$guid_index];
+    $$build_structure{"LIBS_${target}_GUID"} = $uuid;
+    $guid_index += 1;
+
+    my @srcs = sort(map("$rel_dir\\$_", @{$$build_structure{"LIBS_${libname}_SOURCES"}}));
+    my @sources;
+    foreach (@srcs) {
+        $_ =~ s/\//\\/g;
+        push(@sources, $_);
+    }
+    my $defines = join(",", sort(@{$$build_structure{"LIBS_${libname}_DEFINES"}}));
+    my $includes= join(";", sort(map("&quot;$rel_dir\\$_&quot;", @{$$build_structure{"LIBS_${libname}_INCLUDES"}})));
+    my $cflags  = join(" ", sort(@{$$build_structure{"LIBS_${libname}_CFLAGS"}}));
+    $cflags =~ s/\"/&quot;/g;
+
+    my $cflags_debug = $cflags;
+    $cflags_debug =~ s/-MT/-MTd/;
+    $cflags_debug =~ s/-O.//;
+
+    my $cflags_release = $cflags;
+    $cflags_release =~ s/-MTd/-MT/;
+
+    my @tmp  = @{$$build_structure{"LIBS_${libname}_LFLAGS"}};
+    my @tmp2 = ();
+    foreach (@tmp) {
+        if (/^-LTCG/) {
+        } elsif (/^-L/) {
+            $_ =~ s/^-L/-LIBPATH:$rel_dir\//;
+        }
+        push(@tmp2, $_);
+    }
+    my $lflags = join(" ", sort(@tmp));
+
+    $defines =~ s/-D//g;
+    $defines =~ s/\"/\\&quot;/g;
+    $defines =~ s/\'//g;
+    $includes =~ s/-I//g;
+    mkdir "$target" || die "Could not create the directory $target for lib project!\n";
+    open F, ">$target/$target.vcproj" || die "Could not open $target/$target.pro for writing!\n";
+    print F << "EOM";
+<?xml version="1.0" encoding = "Windows-1252"?>
+<VisualStudioProject
+	ProjectType="Visual C++"
+	Version="9,00"
+	Name="$target"
+	ProjectGUID="$uuid">
+	<Platforms>
+		<Platform
+			Name="Win32"/>
+	</Platforms>
+	<ToolFiles>
+	</ToolFiles>
+	<Configurations>
+		<Configuration
+			Name="Debug|Win32"
+			OutputDirectory="$rel_dir"
+			ConfigurationType="4"
+			CharacterSet="0"
+			IntermediateDirectory="\$(ProjectDir)\$(ConfigurationName)"
+			>
+			<Tool
+				Name="VCPreBuildEventTool"
+			/>
+			<Tool
+				Name="VCCustomBuildTool"
+			/>
+			<Tool
+				Name="VCXMLDataGeneratorTool"
+			/>
+			<Tool
+				Name="VCWebServiceProxyGeneratorTool"
+			/>
+			<Tool
+				Name="VCMIDLTool"
+			/>
+			<Tool
+				Name="VCCLCompilerTool"
+				AdditionalOptions="$cflags_debug"
+				Optimization="0"
+				InlineFunctionExpansion="1"
+				AdditionalIncludeDirectories="$includes"
+				PreprocessorDefinitions="UNICODE,WIN32,_DEBUG,$defines"
+				MinimalRebuild="true"
+				RuntimeLibrary="1"
+				UsePrecompiledHeader="0"
+				WarningLevel="3"
+				DebugInformationFormat="3"
+			/>
+			<Tool
+				Name="VCManagedResourceCompilerTool"
+			/>
+			<Tool
+				Name="VCResourceCompilerTool"
+			/>
+			<Tool
+				Name="VCPreLinkEventTool"
+			/>
+			<Tool
+				Name="VCLibrarianTool"
+				SuppressStartupBanner="true"
+			/>
+			<Tool
+				Name="VCALinkTool"
+			/>
+			<Tool
+				Name="VCXDCMakeTool"
+			/>
+			<Tool
+				Name="VCBscMakeTool"
+			/>
+			<Tool
+				Name="VCFxCopTool"
+			/>
+			<Tool
+				Name="VCPostBuildEventTool"
+			/>
+		</Configuration>
+		<Configuration
+			Name="Release|Win32"
+			OutputDirectory="$rel_dir"
+			ConfigurationType="4"
+			CharacterSet="0"
+			WholeProgramOptimization="1"
+			IntermediateDirectory="\$(ProjectDir)\$(ConfigurationName)"
+			>
+			<Tool
+				Name="VCPreBuildEventTool"
+			/>
+			<Tool
+				Name="VCCustomBuildTool"
+			/>
+			<Tool
+				Name="VCXMLDataGeneratorTool"
+			/>
+			<Tool
+				Name="VCWebServiceProxyGeneratorTool"
+			/>
+			<Tool
+				Name="VCMIDLTool"
+			/>
+			<Tool
+				Name="VCCLCompilerTool"
+				AdditionalOptions="$cflags_release"
+				Optimization="2"
+				InlineFunctionExpansion="1"
+				EnableIntrinsicFunctions="true"
+				AdditionalIncludeDirectories="$includes"
+				PreprocessorDefinitions="UNICODE,WIN32,NDEBUG,$defines"
+				RuntimeLibrary="0"
+				EnableFunctionLevelLinking="true"
+				UsePrecompiledHeader="0"
+				WarningLevel="3"
+				DebugInformationFormat="3"
+			/>
+			<Tool
+				Name="VCManagedResourceCompilerTool"
+			/>
+			<Tool
+				Name="VCResourceCompilerTool"
+			/>
+			<Tool
+				Name="VCPreLinkEventTool"
+			/>
+			<Tool
+				Name="VCLibrarianTool"
+				SuppressStartupBanner="true"
+			/>
+			<Tool
+				Name="VCALinkTool"
+			/>
+			<Tool
+				Name="VCXDCMakeTool"
+			/>
+			<Tool
+				Name="VCBscMakeTool"
+			/>
+			<Tool
+				Name="VCFxCopTool"
+			/>
+			<Tool
+				Name="VCPostBuildEventTool"
+			/>
+		</Configuration>
+	</Configurations>
+	<Files>
+		<Filter
+			Name="Source Files"
+			Filter="cpp;c;cxx;def;odl;idl;hpj;bat;asm;asmx"
+			UniqueIdentifier="{4FC737F1-C7A5-4376-A066-2A32D752A2FF}">
+EOM
+    foreach(@sources) {
+        print F << "EOM";
+			<File
+				RelativePath="$_"/>
+EOM
+    }
+    print F << "EOM";
+		</Filter>
+	</Files>
+	<Globals>
+	</Globals>
+</VisualStudioProject>
+EOM
+    close F;
+}
+
+sub createAppProject {
+    my ($appname, $git_dir, $out_dir, $rel_dir, $build_structure) = @_;
+    print "Generate $appname vcproj app project\n";
+    $rel_dir = "..\\$rel_dir";
+    $rel_dir =~ s/\//\\/g;
+
+    my $target = $appname;
+    $target =~ s/\//_/g;
+    $target =~ s/\.exe//;
+
+    my $uuid = $GUIDS[$guid_index];
+    $$build_structure{"APPS_${target}_GUID"} = $uuid;
+    $guid_index += 1;
+
+    my @srcs = sort(map("$rel_dir\\$_", @{$$build_structure{"APPS_${appname}_SOURCES"}}));
+    my @sources;
+    foreach (@srcs) {
+        $_ =~ s/\//\\/g;
+        push(@sources, $_);
+    }
+    my $defines = join(",", sort(@{$$build_structure{"APPS_${appname}_DEFINES"}}));
+    my $includes= join(";", sort(map("&quot;$rel_dir\\$_&quot;", @{$$build_structure{"APPS_${appname}_INCLUDES"}})));
+    my $cflags  = join(" ", sort(@{$$build_structure{"APPS_${appname}_CFLAGS"}}));
+    $cflags =~ s/\"/&quot;/g;
+
+    my $cflags_debug = $cflags;
+    $cflags_debug =~ s/-MT/-MTd/;
+    $cflags_debug =~ s/-O.//;
+
+    my $cflags_release = $cflags;
+    $cflags_release =~ s/-MTd/-MT/;
+
+    my $libs;
+    foreach (sort(@{$$build_structure{"APPS_${appname}_LIBS"}})) {
+        $_ =~ s/\//_/g;
+        $libs .= " $_";
+    }
+    my @tmp  = @{$$build_structure{"APPS_${appname}_LFLAGS"}};
+    my @tmp2 = ();
+    foreach (@tmp) {
+        if (/^-LTCG/) {
+        } elsif (/^-L/) {
+            $_ =~ s/^-L/-LIBPATH:$rel_dir\//;
+        }
+        push(@tmp2, $_);
+    }
+    my $lflags = join(" ", sort(@tmp)) . " -LIBPATH:$rel_dir";
+
+    $defines =~ s/-D//g;
+    $defines =~ s/\"/\\&quot;/g;
+    $defines =~ s/\'//g;
+    $defines =~ s/\\\\/\\/g;
+    $includes =~ s/-I//g;
+    mkdir "$target" || die "Could not create the directory $target for lib project!\n";
+    open F, ">$target/$target.vcproj" || die "Could not open $target/$target.pro for writing!\n";
+    print F << "EOM";
+<?xml version="1.0" encoding = "Windows-1252"?>
+<VisualStudioProject
+	ProjectType="Visual C++"
+	Version="9,00"
+	Name="$target"
+	ProjectGUID="$uuid">
+	<Platforms>
+		<Platform
+			Name="Win32"/>
+	</Platforms>
+	<ToolFiles>
+	</ToolFiles>
+	<Configurations>
+		<Configuration
+			Name="Debug|Win32"
+			OutputDirectory="$rel_dir"
+			ConfigurationType="1"
+			CharacterSet="0"
+			IntermediateDirectory="\$(ProjectDir)\$(ConfigurationName)"
+			>
+			<Tool
+				Name="VCPreBuildEventTool"
+			/>
+			<Tool
+				Name="VCCustomBuildTool"
+			/>
+			<Tool
+				Name="VCXMLDataGeneratorTool"
+			/>
+			<Tool
+				Name="VCWebServiceProxyGeneratorTool"
+			/>
+			<Tool
+				Name="VCMIDLTool"
+			/>
+			<Tool
+				Name="VCCLCompilerTool"
+				AdditionalOptions="$cflags_debug"
+				Optimization="0"
+				InlineFunctionExpansion="1"
+				AdditionalIncludeDirectories="$includes"
+				PreprocessorDefinitions="UNICODE,WIN32,_DEBUG,$defines"
+				MinimalRebuild="true"
+				RuntimeLibrary="1"
+				UsePrecompiledHeader="0"
+				WarningLevel="3"
+				DebugInformationFormat="3"
+			/>
+			<Tool
+				Name="VCManagedResourceCompilerTool"
+			/>
+			<Tool
+				Name="VCResourceCompilerTool"
+			/>
+			<Tool
+				Name="VCPreLinkEventTool"
+			/>
+			<Tool
+				Name="VCLinkerTool"
+				AdditionalDependencies="$libs"
+				AdditionalOptions="$lflags"
+				LinkIncremental="2"
+				GenerateDebugInformation="true"
+				SubSystem="1"
+				TargetMachine="1"
+			/>
+			<Tool
+				Name="VCALinkTool"
+			/>
+			<Tool
+				Name="VCXDCMakeTool"
+			/>
+			<Tool
+				Name="VCBscMakeTool"
+			/>
+			<Tool
+				Name="VCFxCopTool"
+			/>
+			<Tool
+				Name="VCPostBuildEventTool"
+			/>
+		</Configuration>
+		<Configuration
+			Name="Release|Win32"
+			OutputDirectory="$rel_dir"
+			ConfigurationType="1"
+			CharacterSet="0"
+			WholeProgramOptimization="1"
+			IntermediateDirectory="\$(ProjectDir)\$(ConfigurationName)"
+			>
+			<Tool
+				Name="VCPreBuildEventTool"
+			/>
+			<Tool
+				Name="VCCustomBuildTool"
+			/>
+			<Tool
+				Name="VCXMLDataGeneratorTool"
+			/>
+			<Tool
+				Name="VCWebServiceProxyGeneratorTool"
+			/>
+			<Tool
+				Name="VCMIDLTool"
+			/>
+			<Tool
+				Name="VCCLCompilerTool"
+				AdditionalOptions="$cflags_release"
+				Optimization="2"
+				InlineFunctionExpansion="1"
+				EnableIntrinsicFunctions="true"
+				AdditionalIncludeDirectories="$includes"
+				PreprocessorDefinitions="UNICODE,WIN32,NDEBUG,$defines"
+				RuntimeLibrary="0"
+				EnableFunctionLevelLinking="true"
+				UsePrecompiledHeader="0"
+				WarningLevel="3"
+				DebugInformationFormat="3"
+			/>
+			<Tool
+				Name="VCManagedResourceCompilerTool"
+			/>
+			<Tool
+				Name="VCResourceCompilerTool"
+			/>
+			<Tool
+				Name="VCPreLinkEventTool"
+			/>
+			<Tool
+				Name="VCLinkerTool"
+				AdditionalDependencies="$libs"
+				AdditionalOptions="$lflags"
+				LinkIncremental="1"
+				GenerateDebugInformation="true"
+				SubSystem="1"
+				TargetMachine="1"
+				OptimizeReferences="2"
+				EnableCOMDATFolding="2"
+			/>
+			<Tool
+				Name="VCALinkTool"
+			/>
+			<Tool
+				Name="VCXDCMakeTool"
+			/>
+			<Tool
+				Name="VCBscMakeTool"
+			/>
+			<Tool
+				Name="VCFxCopTool"
+			/>
+			<Tool
+				Name="VCPostBuildEventTool"
+			/>
+		</Configuration>
+	</Configurations>
+	<Files>
+		<Filter
+			Name="Source Files"
+			Filter="cpp;c;cxx;def;odl;idl;hpj;bat;asm;asmx"
+			UniqueIdentifier="{4FC737F1-C7A5-4376-A066-2A32D752A2FF}">
+EOM
+    foreach(@sources) {
+        print F << "EOM";
+			<File
+				RelativePath="$_"/>
+EOM
+    }
+    print F << "EOM";
+		</Filter>
+	</Files>
+	<Globals>
+	</Globals>
+</VisualStudioProject>
+EOM
+    close F;
+}
+
+sub createGlueProject {
+    my ($git_dir, $out_dir, $rel_dir, %build_structure) = @_;
+    print "Generate solutions file\n";
+    $rel_dir = "..\\$rel_dir";
+    $rel_dir =~ s/\//\\/g;
+    my $SLN_HEAD = "Microsoft Visual Studio Solution File, Format Version 10.00\n";
+    my $SLN_PRE  = "Project(\"{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}\") = ";
+    my $SLN_POST = "\nEndProject\n";
+
+    my @libs = @{$build_structure{"LIBS"}};
+    my @tmp;
+    foreach (@libs) {
+        $_ =~ s/\//_/g;
+        $_ =~ s/\.a//;
+        push(@tmp, $_);
+    }
+    @libs = @tmp;
+
+    my @apps = @{$build_structure{"APPS"}};
+    @tmp = ();
+    foreach (@apps) {
+        $_ =~ s/\//_/g;
+        $_ =~ s/\.exe//;
+        push(@tmp, $_);
+    }
+    @apps = @tmp;
+
+    open F, ">git.sln" || die "Could not open git.sln for writing!\n";
+    print F "$SLN_HEAD";
+    foreach (@libs) {
+        my $libname = $_;
+        my $uuid = $build_structure{"LIBS_${libname}_GUID"};
+        print F "$SLN_PRE";
+        print F "\"${libname}\", \"${libname}\\${libname}.vcproj\", \"${uuid}\"";
+        print F "$SLN_POST";
+    }
+    foreach (@apps) {
+        my $appname = $_;
+        my $uuid = $build_structure{"APPS_${appname}_GUID"};
+        print F "$SLN_PRE";
+        print F "\"${appname}\", \"${appname}\\${appname}.vcproj\", \"${uuid}\"";
+        print F "$SLN_POST";
+    }
+
+    print F << "EOM";
+Global
+	GlobalSection(SolutionConfiguration) = preSolution
+		ConfigName.0 = Debug|Win32
+		ConfigName.1 = Release|Win32
+	EndGlobalSection
+	GlobalSection(ProjectDependencies) = postSolution
+EOM
+    foreach (@{$build_structure{"APPS"}}) {
+        my $appname = $_;
+        my $appname_clean = $_;
+        $appname_clean =~ s/\//_/g;
+        $appname_clean =~ s/\.exe//;
+
+        my $uuid = $build_structure{"APPS_${appname_clean}_GUID"};
+        my $dep_index = 0;
+        foreach(@{$build_structure{"APPS_${appname}_LIBS"}}) {
+            my $libname = $_;
+            $libname =~ s/\//_/g;
+            $libname =~ s/\.(a|lib)//;
+            my $libuuid = $build_structure{"LIBS_${libname}_GUID"};
+            if (defined $libuuid) {
+                print F "\t\t${uuid}.${dep_index} = ${libuuid}\n";
+                $dep_index += 1;
+            }
+        }
+    }
+
+    print F << "EOM";
+	EndGlobalSection
+	GlobalSection(ProjectConfiguration) = postSolution
+EOM
+    foreach (@libs) {
+        my $libname = $_;
+        my $uuid = $build_structure{"LIBS_${libname}_GUID"};
+        print F "\t\t${uuid}.Debug|Win32.ActiveCfg = Debug|Win32\n";
+        print F "\t\t${uuid}.Debug|Win32.Build.0 = Debug|Win32\n";
+        print F "\t\t${uuid}.Release|Win32.ActiveCfg = Release|Win32\n";
+        print F "\t\t${uuid}.Release|Win32.Build.0 = Release|Win32\n";
+    }
+    foreach (@apps) {
+        my $appname = $_;
+        my $uuid = $build_structure{"APPS_${appname}_GUID"};
+        print F "\t\t${uuid}.Debug|Win32.ActiveCfg = Debug|Win32\n";
+        print F "\t\t${uuid}.Debug|Win32.Build.0 = Debug|Win32\n";
+        print F "\t\t${uuid}.Release|Win32.ActiveCfg = Release|Win32\n";
+        print F "\t\t${uuid}.Release|Win32.Build.0 = Release|Win32\n";
+    }
+
+    print F << "EOM";
+	EndGlobalSection
+	GlobalSection(ExtensibilityGlobals) = postSolution
+	EndGlobalSection
+	GlobalSection(ExtensibilityAddIns) = postSolution
+	EndGlobalSection
+EndGlobal
+EOM
+    close F;
+}
+
+1;
diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
new file mode 100644
index 0000000..20bd061
--- /dev/null
+++ b/contrib/buildsystems/engine.pl
@@ -0,0 +1,353 @@
+#!/usr/bin/perl -w
+######################################################################
+# Do not call this script directly!
+#
+# The generate script ensures that @INC is correct before the engine
+# is executed.
+#
+# Copyright (C) 2009 Marius Storm-Olsen <mstormo@gmail.com>
+######################################################################
+use strict;
+use File::Basename;
+use File::Spec;
+use Cwd;
+use Generators;
+
+my (%build_structure, %compile_options, @makedry);
+my $out_dir = getcwd();
+my $git_dir = $out_dir;
+$git_dir =~ s=\\=/=g;
+$git_dir = dirname($git_dir) while (!-e "$git_dir/git.c" && "$git_dir" ne "");
+die "Couldn't find Git repo" if ("$git_dir" eq "");
+
+my @gens = Generators::available();
+my $gen = "Vcproj";
+
+sub showUsage
+{
+    my $genlist = join(', ', @gens);
+    print << "EOM";
+generate usage:
+  -g <GENERATOR>  --gen <GENERATOR> Specify the buildsystem generator    (default: $gen)
+                                    Available: $genlist
+  -o <PATH>       --out <PATH>      Specify output directory generation  (default: .)
+  -i <FILE>       --in <FILE>       Specify input file, instead of running GNU Make
+  -h,-?           --help            This help
+EOM
+    exit 0;
+}
+
+# Parse command-line options
+while (@ARGV) {
+    my $arg = shift @ARGV;
+    if ("$arg" eq "-h" || "$arg" eq "--help" || "$arg" eq "-?") {
+	showUsage();
+	exit(0);
+    } elsif("$arg" eq "--out" || "$arg" eq "-o") {
+	$out_dir = shift @ARGV;
+    } elsif("$arg" eq "--gen" || "$arg" eq "-g") {
+	$gen = shift @ARGV;
+    } elsif("$arg" eq "--in" || "$arg" eq "-i") {
+	my $infile = shift @ARGV;
+        open(F, "<$infile") || die "Couldn't open file $infile";
+        @makedry = <F>;
+        close(F);
+    }
+}
+
+# NOT using File::Spec->rel2abs($path, $base) here, as
+# it fails badly for me in the msysgit environment
+$git_dir = File::Spec->rel2abs($git_dir);
+$out_dir = File::Spec->rel2abs($out_dir);
+my $rel_dir = makeOutRel2Git($git_dir, $out_dir);
+
+# Print some information so the user feels informed
+print << "EOM";
+-----
+Generator: $gen
+Git dir:   $git_dir
+Out dir:   $out_dir
+-----
+Running GNU Make to figure out build structure...
+EOM
+
+# Pipe a make --dry-run into a variable, if not already loaded from file
+@makedry = `cd $git_dir && make -n MSVC=1 V=1 2>/dev/null` if !@makedry;
+
+# Parse the make output into usable info
+parseMakeOutput();
+
+# Finally, ask the generator to start generating..
+Generators::generate($gen, $git_dir, $out_dir, $rel_dir, %build_structure);
+
+# main flow ends here
+# -------------------------------------------------------------------------------------------------
+
+
+# 1) path: /foo/bar/baz        2) path: /foo/bar/baz   3) path: /foo/bar/baz
+#    base: /foo/bar/baz/temp      base: /foo/bar          base: /tmp
+#    rel:  ..                     rel:  baz               rel:  ../foo/bar/baz
+sub makeOutRel2Git
+{
+    my ($path, $base) = @_;
+    my $rel;
+    if ("$path" eq "$base") {
+        return ".";
+    } elsif ($base =~ /^$path/) {
+        # case 1
+        my $tmp = $base;
+        $tmp =~ s/^$path//;
+        foreach (split('/', $tmp)) {
+            $rel .= "../" if ("$_" ne "");
+        }
+    } elsif ($path =~ /^$base/) {
+        # case 2
+        $rel = $path;
+        $rel =~ s/^$base//;
+        $rel = "./$rel";
+    } else {
+        my $tmp = $base;
+        foreach (split('/', $tmp)) {
+            $rel .= "../" if ("$_" ne "");
+        }
+        $rel .= $path;
+    }
+    $rel =~ s/\/\//\//g; # simplify
+    $rel =~ s/\/$//;     # don't end with /
+    return $rel;
+}
+
+sub parseMakeOutput
+{
+    print "Parsing GNU Make output to figure out build structure...\n";
+    my $line = 0;
+    while (my $text = shift @makedry) {
+        my $ate_next;
+        do {
+            $ate_next = 0;
+            $line++;
+            chomp $text;
+            chop $text if ($text =~ /\r$/);
+            if ($text =~ /\\$/) {
+                $text =~ s/\\$//;
+                $text .= shift @makedry;
+                $ate_next = 1;
+            }
+        } while($ate_next);
+
+        if($text =~ / -c /) {
+            # compilation
+            handleCompileLine($text, $line);
+
+        } elsif ($text =~ / -o /) {
+            # linking executable
+            handleLinkLine($text, $line);
+
+        } elsif ($text =~ /\.o / && $text =~ /\.a /) {
+            # libifying
+            handleLibLine($text, $line);
+#
+#        } elsif ($text =~ /^cp /) {
+#            # copy file around
+#
+#        } elsif ($text =~ /^rm -f /) {
+#            # shell command
+#
+#        } elsif ($text =~ /^make[ \[]/) {
+#            # make output
+#
+#        } elsif ($text =~ /^echo /) {
+#            # echo to file
+#
+#        } elsif ($text =~ /^if /) {
+#            # shell conditional
+#
+#        } elsif ($text =~ /^tclsh /) {
+#            # translation stuff
+#
+#        } elsif ($text =~ /^umask /) {
+#            # handling boilerplates
+#
+#        } elsif ($text =~ /\$\(\:\)/) {
+#            # ignore
+#
+#        } elsif ($text =~ /^FLAGS=/) {
+#            # flags check for dependencies
+#
+#        } elsif ($text =~ /^'\/usr\/bin\/perl' -MError -e/) {
+#            # perl commands for copying files
+#
+#        } elsif ($text =~ /generate-cmdlist\.sh/) {
+#            # command for generating list of commands
+#
+#        } elsif ($text =~ /^test / && $text =~ /|| rm -f /) {
+#            # commands removing executables, if they exist
+#
+#        } elsif ($text =~ /new locations or Tcl/) {
+#            # command for detecting Tcl/Tk changes
+#
+#        } elsif ($text =~ /mkdir -p/) {
+#            # command creating path
+#
+#        } elsif ($text =~ /: no custom templates yet/) {
+#            # whatever
+#
+#        } else {
+#            print "Unhandled (line: $line): $text\n";
+        }
+    }
+
+#    use Data::Dumper;
+#    print "Parsed build structure:\n";
+#    print Dumper(%build_structure);
+}
+
+# variables for the compilation part of each step
+my (@defines, @incpaths, @cflags, @sources);
+
+sub clearCompileStep
+{
+    @defines = ();
+    @incpaths = ();
+    @cflags = ();
+    @sources = ();
+}
+
+sub removeDuplicates
+{
+    my (%dupHash, $entry);
+    %dupHash = map { $_, 1 } @defines;
+    @defines = keys %dupHash;
+
+    %dupHash = map { $_, 1 } @incpaths;
+    @incpaths = keys %dupHash;
+
+    %dupHash = map { $_, 1 } @cflags;
+    @cflags = keys %dupHash;
+}
+
+sub handleCompileLine
+{
+    my ($line, $lineno) = @_;
+    my @parts = split(' ', $line);
+    my $sourcefile;
+    shift(@parts); # ignore cmd
+    while (my $part = shift @parts) {
+        if ("$part" eq "-o") {
+            # ignore object file
+            shift @parts;
+        } elsif ("$part" eq "-c") {
+            # ignore compile flag
+        } elsif ("$part" eq "-c") {
+        } elsif ($part =~ /^.?-I/) {
+            push(@incpaths, $part);
+        } elsif ($part =~ /^.?-D/) {
+            push(@defines, $part);
+        } elsif ($part =~ /^-/) {
+            push(@cflags, $part);
+        } elsif ($part =~ /\.(c|cc|cpp)$/) {
+            $sourcefile = $part;
+        } else {
+            die "Unhandled compiler option @ line $lineno: $part";
+        }
+    }
+    @{$compile_options{"${sourcefile}_CFLAGS"}} = @cflags;
+    @{$compile_options{"${sourcefile}_DEFINES"}} = @defines;
+    @{$compile_options{"${sourcefile}_INCPATHS"}} = @incpaths;
+    clearCompileStep();
+}
+
+sub handleLibLine
+{
+    my ($line, $lineno) = @_;
+    my (@objfiles, @lflags, $libout, $part);
+    # kill cmd and rm 'prefix'
+    $line =~ s/^rm -f .* && .* rcs //;
+    my @parts = split(' ', $line);
+    while ($part = shift @parts) {
+        if ($part =~ /^-/) {
+            push(@lflags, $part);
+        } elsif ($part =~ /\.(o|obj)$/) {
+            push(@objfiles, $part);
+        } elsif ($part =~ /\.(a|lib)$/) {
+            $libout = $part;
+            $libout =~ s/\.a$//;
+        } else {
+            die "Unhandled lib option @ line $lineno: $part";
+        }
+    }
+#    print "LibOut: '$libout'\nLFlags: @lflags\nOfiles: @objfiles\n";
+#    exit(1);
+    foreach (@objfiles) {
+        my $sourcefile = $_;
+        $sourcefile =~ s/\.o/.c/;
+        push(@sources, $sourcefile);
+        push(@cflags, @{$compile_options{"${sourcefile}_CFLAGS"}});
+        push(@defines, @{$compile_options{"${sourcefile}_DEFINES"}});
+        push(@incpaths, @{$compile_options{"${sourcefile}_INCPATHS"}});
+    }
+    removeDuplicates();
+
+    push(@{$build_structure{"LIBS"}}, $libout);
+    @{$build_structure{"LIBS_${libout}"}} = ("_DEFINES", "_INCLUDES", "_CFLAGS", "_SOURCES",
+                                             "_OBJECTS");
+    @{$build_structure{"LIBS_${libout}_DEFINES"}} = @defines;
+    @{$build_structure{"LIBS_${libout}_INCLUDES"}} = @incpaths;
+    @{$build_structure{"LIBS_${libout}_CFLAGS"}} = @cflags;
+    @{$build_structure{"LIBS_${libout}_LFLAGS"}} = @lflags;
+    @{$build_structure{"LIBS_${libout}_SOURCES"}} = @sources;
+    @{$build_structure{"LIBS_${libout}_OBJECTS"}} = @objfiles;
+    clearCompileStep();
+}
+
+sub handleLinkLine
+{
+    my ($line, $lineno) = @_;
+    my (@objfiles, @lflags, @libs, $appout, $part);
+    my @parts = split(' ', $line);
+    shift(@parts); # ignore cmd
+    while ($part = shift @parts) {
+        if ($part =~ /^-IGNORE/) {
+            push(@lflags, $part);
+        } elsif ($part =~ /^-[GRIMDO]/) {
+            # eat compiler flags
+        } elsif ("$part" eq "-o") {
+            $appout = shift @parts;
+        } elsif ("$part" eq "-lz") {
+            push(@libs, "zlib.lib");
+        } elsif ($part =~ /^-/) {
+            push(@lflags, $part);
+        } elsif ($part =~ /\.(a|lib)$/) {
+            $part =~ s/\.a$/.lib/;
+            push(@libs, $part);
+        } elsif ($part =~ /\.(o|obj)$/) {
+            push(@objfiles, $part);
+        } else {
+            die "Unhandled lib option @ line $lineno: $part";
+        }
+    }
+#    print "AppOut: '$appout'\nLFlags: @lflags\nLibs  : @libs\nOfiles: @objfiles\n";
+#    exit(1);
+    foreach (@objfiles) {
+        my $sourcefile = $_;
+        $sourcefile =~ s/\.o/.c/;
+        push(@sources, $sourcefile);
+        push(@cflags, @{$compile_options{"${sourcefile}_CFLAGS"}});
+        push(@defines, @{$compile_options{"${sourcefile}_DEFINES"}});
+        push(@incpaths, @{$compile_options{"${sourcefile}_INCPATHS"}});
+    }
+    removeDuplicates();
+
+    removeDuplicates();
+    push(@{$build_structure{"APPS"}}, $appout);
+    @{$build_structure{"APPS_${appout}"}} = ("_DEFINES", "_INCLUDES", "_CFLAGS", "_LFLAGS",
+                                             "_SOURCES", "_OBJECTS", "_LIBS");
+    @{$build_structure{"APPS_${appout}_DEFINES"}} = @defines;
+    @{$build_structure{"APPS_${appout}_INCLUDES"}} = @incpaths;
+    @{$build_structure{"APPS_${appout}_CFLAGS"}} = @cflags;
+    @{$build_structure{"APPS_${appout}_LFLAGS"}} = @lflags;
+    @{$build_structure{"APPS_${appout}_SOURCES"}} = @sources;
+    @{$build_structure{"APPS_${appout}_OBJECTS"}} = @objfiles;
+    @{$build_structure{"APPS_${appout}_LIBS"}} = @libs;
+    clearCompileStep();
+}
diff --git a/contrib/buildsystems/generate b/contrib/buildsystems/generate
new file mode 100644
index 0000000..bc10f25
--- /dev/null
+++ b/contrib/buildsystems/generate
@@ -0,0 +1,29 @@
+#!/usr/bin/perl -w
+######################################################################
+# Generate buildsystem files
+#
+# This script generate buildsystem files based on the output of a
+# GNU Make --dry-run, enabling Windows users to develop Git with their
+# trusted IDE with native projects.
+#
+# Note:
+# It is not meant as *the* way of building Git with MSVC, but merely a
+# convenience. The correct way of building Git with MSVC is to use the
+# GNU Make tool to build with the maintained Makefile in the root of
+# the project. If you have the msysgit environment installed and
+# available in your current console, together with the Visual Studio
+# environment you wish to build for, all you have to do is run the
+# command:
+#     make MSVC=1
+#
+# Copyright (C) 2009 Marius Storm-Olsen <mstormo@gmail.com>
+######################################################################
+use strict;
+use File::Basename;
+use Cwd;
+
+my $git_dir = getcwd();
+$git_dir =~ s=\\=/=g;
+$git_dir = dirname($git_dir) while (!-e "$git_dir/git.c" && "$git_dir" ne "");
+die "Couldn't find Git repo" if ("$git_dir" eq "");
+exec join(" ", ("PERL5LIB=${git_dir}/contrib/buildsystems ${git_dir}/contrib/buildsystems/engine.pl", @ARGV));
diff --git a/contrib/buildsystems/parse.pl b/contrib/buildsystems/parse.pl
new file mode 100644
index 0000000..c9656ec
--- /dev/null
+++ b/contrib/buildsystems/parse.pl
@@ -0,0 +1,228 @@
+#!/usr/bin/perl -w
+######################################################################
+# Do not call this script directly!
+#
+# The generate script ensures that @INC is correct before the engine
+# is executed.
+#
+# Copyright (C) 2009 Marius Storm-Olsen <mstormo@gmail.com>
+######################################################################
+use strict;
+use File::Basename;
+use Cwd;
+
+my $file = $ARGV[0];
+die "No file provided!" if !defined $file;
+
+my ($cflags, $target, $type, $line);
+
+open(F, "<$file") || die "Couldn't open file $file";
+my @data = <F>;
+close(F);
+
+while (my $text = shift @data) {
+    my $ate_next;
+    do {
+        $ate_next = 0;
+        $line++;
+        chomp $text;
+        chop $text if ($text =~ /\r$/);
+        if ($text =~ /\\$/) {
+            $text =~ s/\\$//;
+            $text .= shift @data;
+            $ate_next = 1;
+        }
+    } while($ate_next);
+
+    if($text =~ / -c /) {
+        # compilation
+        handleCompileLine($text, $line);
+
+    } elsif ($text =~ / -o /) {
+        # linking executable
+        handleLinkLine($text, $line);
+
+    } elsif ($text =~ /\.o / && $text =~ /\.a /) {
+        # libifying
+        handleLibLine($text, $line);
+
+#    } elsif ($text =~ /^cp /) {
+#        # copy file around
+#
+#    } elsif ($text =~ /^rm -f /) {
+#        # shell command
+#
+#    } elsif ($text =~ /^make[ \[]/) {
+#        # make output
+#
+#    } elsif ($text =~ /^echo /) {
+#        # echo to file
+#
+#    } elsif ($text =~ /^if /) {
+#        # shell conditional
+#
+#    } elsif ($text =~ /^tclsh /) {
+#        # translation stuff
+#
+#    } elsif ($text =~ /^umask /) {
+#        # handling boilerplates
+#
+#    } elsif ($text =~ /\$\(\:\)/) {
+#        # ignore
+#
+#    } elsif ($text =~ /^FLAGS=/) {
+#        # flags check for dependencies
+#
+#    } elsif ($text =~ /^'\/usr\/bin\/perl' -MError -e/) {
+#        # perl commands for copying files
+#
+#    } elsif ($text =~ /generate-cmdlist\.sh/) {
+#        # command for generating list of commands
+#
+#    } elsif ($text =~ /^test / && $text =~ /|| rm -f /) {
+#        # commands removing executables, if they exist
+#
+#    } elsif ($text =~ /new locations or Tcl/) {
+#        # command for detecting Tcl/Tk changes
+#
+#    } elsif ($text =~ /mkdir -p/) {
+#        # command creating path
+#
+#    } elsif ($text =~ /: no custom templates yet/) {
+#        # whatever
+
+    } else {
+#        print "Unhandled (line: $line): $text\n";
+    }
+}
+close(F);
+
+# use Data::Dumper;
+# print "Parsed build structure:\n";
+# print Dumper(%build_structure);
+
+# -------------------------------------------------------------------
+# Functions under here
+# -------------------------------------------------------------------
+my (%build_structure, @defines, @incpaths, @cflags, @sources);
+
+sub clearCompileStep
+{
+    @defines = ();
+    @incpaths = ();
+    @cflags = ();
+    @sources = ();
+}
+
+sub removeDuplicates
+{
+    my (%dupHash, $entry);
+    %dupHash = map { $_, 1 } @defines;
+    @defines = keys %dupHash;
+
+    %dupHash = map { $_, 1 } @incpaths;
+    @incpaths = keys %dupHash;
+
+    %dupHash = map { $_, 1 } @cflags;
+    @cflags = keys %dupHash;
+
+    %dupHash = map { $_, 1 } @sources;
+    @sources = keys %dupHash;
+}
+
+sub handleCompileLine
+{
+    my ($line, $lineno) = @_;
+    my @parts = split(' ', $line);
+    shift(@parts); # ignore cmd
+    while (my $part = shift @parts) {
+        if ("$part" eq "-o") {
+            # ignore object file
+            shift @parts;
+        } elsif ("$part" eq "-c") {
+            # ignore compile flag
+        } elsif ("$part" eq "-c") {
+        } elsif ($part =~ /^.?-I/) {
+            push(@incpaths, $part);
+        } elsif ($part =~ /^.?-D/) {
+            push(@defines, $part);
+        } elsif ($part =~ /^-/) {
+            push(@cflags, $part);
+        } elsif ($part =~ /\.(c|cc|cpp)$/) {
+            push(@sources, $part);
+        } else {
+            die "Unhandled compiler option @ line $lineno: $part";
+        }
+    }
+    #print "Sources: @sources\nCFlags: @cflags\nDefine: @defines\nIncpat: @incpaths\n";
+    #exit(1);
+}
+
+sub handleLibLine
+{
+    my ($line, $lineno) = @_;
+    my (@objfiles, @lflags, $libout, $part);
+    # kill cmd and rm 'prefix'
+    $line =~ s/^rm -f .* && .* rcs //;
+    my @parts = split(' ', $line);
+    while ($part = shift @parts) {
+        if ($part =~ /^-/) {
+            push(@lflags, $part);
+        } elsif ($part =~ /\.(o|obj)$/) {
+            push(@objfiles, $part);
+        } elsif ($part =~ /\.(a|lib)$/) {
+            $libout = $part;
+        } else {
+            die "Unhandled lib option @ line $lineno: $part";
+        }
+    }
+    #print "LibOut: '$libout'\nLFlags: @lflags\nOfiles: @objfiles\n";
+    #exit(1);
+    removeDuplicates();
+    push(@{$build_structure{"LIBS"}}, $libout);
+    @{$build_structure{"LIBS_${libout}"}} = ("_DEFINES", "_INCLUDES", "_CFLAGS", "_SOURCES",
+                                             "_OBJECTS");
+    @{$build_structure{"LIBS_${libout}_DEFINES"}} = @defines;
+    @{$build_structure{"LIBS_${libout}_INCLUDES"}} = @incpaths;
+    @{$build_structure{"LIBS_${libout}_CFLAGS"}} = @cflags;
+    @{$build_structure{"LIBS_${libout}_SOURCES"}} = @sources;
+    @{$build_structure{"LIBS_${libout}_OBJECTS"}} = @objfiles;
+    clearCompileStep();
+}
+
+sub handleLinkLine
+{
+    my ($line, $lineno) = @_;
+    my (@objfiles, @lflags, @libs, $appout, $part);
+    my @parts = split(' ', $line);
+    shift(@parts); # ignore cmd
+    while ($part = shift @parts) {
+        if ($part =~ /^-[GRIDO]/) {
+            # eat compiler flags
+        } elsif ("$part" eq "-o") {
+            $appout = shift @parts;
+        } elsif ($part =~ /^-/) {
+            push(@lflags, $part);
+        } elsif ($part =~ /\.(a|lib)$/) {
+            push(@libs, $part);
+        } elsif ($part =~ /\.(o|obj)$/) {
+            push(@objfiles, $part);
+        } else {
+            die "Unhandled lib option @ line $lineno: $part";
+        }
+    }
+    #print "AppOut: '$appout'\nLFlags: @lflags\nLibs  : @libs\nOfiles: @objfiles\n";
+    #exit(1);
+    removeDuplicates();
+    push(@{$build_structure{"APPS"}}, $appout);
+    @{$build_structure{"APPS_${appout}"}} = ("_DEFINES", "_INCLUDES", "_CFLAGS", "_LFLAGS",
+                                             "_SOURCES", "_OBJECTS", "_LIBS");
+    @{$build_structure{"APPS_${appout}_DEFINES"}} = @defines;
+    @{$build_structure{"APPS_${appout}_INCLUDES"}} = @incpaths;
+    @{$build_structure{"APPS_${appout}_CFLAGS"}} = @cflags;
+    @{$build_structure{"APPS_${appout}_LFLAGS"}} = @lflags;
+    @{$build_structure{"APPS_${appout}_SOURCES"}} = @sources;
+    @{$build_structure{"APPS_${appout}_OBJECTS"}} = @objfiles;
+    @{$build_structure{"APPS_${appout}_LIBS"}} = @libs;
+    clearCompileStep();
+}
-- 
1.6.2.1.418.g33d56.dirty
