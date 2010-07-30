From: Robert Pollak <robert.pollak@gmail.com>
Subject: Re: [PATCH] git svn: add an option to recode pathnames
Date: Fri, 30 Jul 2010 04:30:13 +0200
Message-ID: <4C523935.5070504@gmail.com>
References: <ylnfxcfdeyq.fsf@tmsoft-ltd.kiev.ua> <20090729185919.GA13518@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Dmitry Statyvka <dstatyvka@tmsoft-ltd.kiev.ua>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jul 30 04:30:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OefMb-00085R-4E
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 04:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758295Ab0G3CaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 22:30:14 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41354 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755706Ab0G3CaM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 22:30:12 -0400
Received: by fxm14 with SMTP id 14so639683fxm.19
        for <git@vger.kernel.org>; Thu, 29 Jul 2010 19:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=9skPWpk0zw+Gb/t+COg8rG7tiNeQw+ERA2Ye7WWnNM0=;
        b=Ud9ND0LvsKZXOc1CeP9LHGQzYgIYBcpd+hrpc8H8m0yvC689OhpianYgxD4tpsoQGw
         9QwI1XscJJ/+A9Q9w7Fd8ygchYdlBl0JuaqsFgrzUBt+nvtff5rXVCNsRPv1yPGRNJVP
         3sApMx+cp8ieAdG/cpO1d/WbdbnHp5/2zyJYE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=oaQVpOB5POvbEm+Ileuva1i9b7f27GbnH3oTWfuHPU20fggG59p51MpXJTKVxtTV2e
         hzFUUCRkLqDkUtSgrtCMkWqsbN3N5hfiU2EJSa7OQWSlJPlS/j9u4jjIub3z+6tFUId5
         LBO77kIISZfGm6Ybp5EFk9JkyAp1xkBkvcH5s=
Received: by 10.223.119.204 with SMTP id a12mr1229258far.67.1280457010955;
        Thu, 29 Jul 2010 19:30:10 -0700 (PDT)
Received: from [192.168.1.3] (cm217-122.liwest.at [81.10.217.122])
        by mx.google.com with ESMTPS id r27sm595572faa.24.2010.07.29.19.30.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Jul 2010 19:30:10 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
In-Reply-To: <20090729185919.GA13518@dcvr.yhbt.net>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152216>

Introduce a new option 'svn.pathnameencoding' that instructs git svn to
recode pathnames to a given encoding.  It can be used by windows users
and by those who work in non-utf8 locales to avoid corrupted file names
with non-ascii characters.

Signed-off-by: Dmitry Statyvka <dstatyvka@tmsoft-ltd.kiev.ua>
[robert.pollak@gmail.com: renamed the option and added manpage documentation]
Signed-off-by: Robert Pollak <robert.pollak@gmail.com>
---

Hello Eric,

since the patch is useful to me, I have made the requested option name
change and added some manpage documentation. Please consider applying the
patch or give me additional feedback.

This is the first patch I submit on this list, so I hope it's ok.

Best regards,
Robert


 Documentation/git-svn.txt |    6 ++++++
 git-svn.perl              |    9 +++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index b09bd97..4b84d08 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -646,6 +646,12 @@ svn.brokenSymlinkWorkaround::
 	revision fetched.  If unset, 'git svn' assumes this option to
 	be "true".

+svn.pathnameencoding::
+	This instructs git svn to recode pathnames to a given encoding.
+	It can be used by windows users and by those who work in non-utf8
+	locales to avoid corrupted file names with non-ASCII characters.
+	Valid encodings are the ones supported by Perl's Encode module.
+
 Since the noMetadata, rewriteRoot, rewriteUUID, useSvnsyncProps and useSvmProps
 options all affect the metadata generated and used by 'git svn'; they
 *must* be set in the configuration file before any history is imported
diff --git a/git-svn.perl b/git-svn.perl
index c416358..c92238e 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4050,6 +4050,7 @@ sub new {
 	$self->{absent_dir} = {};
 	$self->{absent_file} = {};
 	$self->{gii} = $git_svn->tmp_index_do(sub { Git::IndexInfo->new });
+	$self->{pathnameencoding} = Git::config('svn.pathnameencoding');
 	$self;
 }

@@ -4133,6 +4134,10 @@ sub open_directory {

 sub git_path {
 	my ($self, $path) = @_;
+	if (my $enc = $self->{pathnameencoding}) {
+		require Encode;
+		Encode::from_to($path, 'UTF-8', $enc);
+	}
 	if ($self->{path_strip}) {
 		$path =~ s!$self->{path_strip}!! or
 		  die "Failed to strip path '$path' ($self->{path_strip})\n";
@@ -4521,6 +4526,10 @@ sub split_path {

 sub repo_path {
 	my ($self, $path) = @_;
+	if (my $enc = $self->{pathnameencoding}) {
+		require Encode;
+		Encode::from_to($path, $enc, 'UTF-8');
+	}
 	$self->{path_prefix}.(defined $path ? $path : '');
 }

-- 
1.6.3.3
