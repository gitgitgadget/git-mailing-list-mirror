From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] Make the MSVC projects use PDB/IDB files named after the
 project
Date: Mon, 05 Oct 2009 11:54:47 +0200
Message-ID: <hacfq0$g9k$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 05 12:01:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MukNO-0002pN-C3
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 12:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbZJEJ4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 05:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbZJEJ4U
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 05:56:20 -0400
Received: from lo.gmane.org ([80.91.229.12]:51240 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932321AbZJEJ4T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 05:56:19 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MukI7-000828-Me
	for git@vger.kernel.org; Mon, 05 Oct 2009 11:55:39 +0200
Received: from 91-64-214-160-dynip.superkabel.de ([91.64.214.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Oct 2009 11:55:39 +0200
Received: from sschuberth by 91-64-214-160-dynip.superkabel.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Oct 2009 11:55:39 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 91-64-214-160-dynip.superkabel.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of having all PDB files for all projects named "vc90.pdb", name them
after the respective project to make the relation more clear (and to avoid name
clashes when copying files around).

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 contrib/buildsystems/Generators/Vcproj.pm |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/contrib/buildsystems/Generators/Vcproj.pm b/contrib/buildsystems/Generators/Vcproj.pm
index be94ba1..cfa74ad 100644
--- a/contrib/buildsystems/Generators/Vcproj.pm
+++ b/contrib/buildsystems/Generators/Vcproj.pm
@@ -178,6 +178,7 @@ sub createLibProject {
 				MinimalRebuild="true"
 				RuntimeLibrary="1"
 				UsePrecompiledHeader="0"
+				ProgramDataBaseFileName="\$(IntDir)\\\$(TargetName).pdb"
 				WarningLevel="3"
 				DebugInformationFormat="3"
 			/>
@@ -244,6 +245,7 @@ sub createLibProject {
 				RuntimeLibrary="0"
 				EnableFunctionLevelLinking="true"
 				UsePrecompiledHeader="0"
+				ProgramDataBaseFileName="\$(IntDir)\\\$(TargetName).pdb"
 				WarningLevel="3"
 				DebugInformationFormat="3"
 			/>
@@ -401,6 +403,7 @@ sub createAppProject {
 				MinimalRebuild="true"
 				RuntimeLibrary="1"
 				UsePrecompiledHeader="0"
+				ProgramDataBaseFileName="\$(IntDir)\\\$(TargetName).pdb"
 				WarningLevel="3"
 				DebugInformationFormat="3"
 			/>
@@ -472,6 +475,7 @@ sub createAppProject {
 				RuntimeLibrary="0"
 				EnableFunctionLevelLinking="true"
 				UsePrecompiledHeader="0"
+				ProgramDataBaseFileName="\$(IntDir)\\\$(TargetName).pdb"
 				WarningLevel="3"
 				DebugInformationFormat="3"
 			/>
-- 
1.6.5.rc2.13.g1be2
