From: Al Haraka <alharaka@gmail.com>
Subject: Gitweb 1.7.5 and Textconv Configuration
Date: Sat, 2 Jul 2011 12:50:12 +0300
Message-ID: <CALWDD1x-_rEx+c9bpAgVk-hvnGz1bt0mbJoDkSjZkbe=gLscUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 02 11:50:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcwqE-0004p1-2i
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 11:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753677Ab1GBJuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jul 2011 05:50:15 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:49767 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753204Ab1GBJuO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2011 05:50:14 -0400
Received: by fxd18 with SMTP id 18so3882156fxd.11
        for <git@vger.kernel.org>; Sat, 02 Jul 2011 02:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=teC8hNgLrYWUAYfPkCRZpaXXDOasQ3Vh3xkJ1IxFUTo=;
        b=O5DJI9ABzPARPDf87GM3C/PsdX/SbQo5k8J4koJzcYbJPEtd0uD1seZbwMSOFaRQQf
         +/VBXksouFvb7xFTJqJgyzgS93KRa00xDAROInrzALZvOgwJNZJMgz8+hkCH8x9HfMxr
         /jxT1i3Jc3T6UvfiFWZf8Iv8+Acia5BW3JTDc=
Received: by 10.223.99.153 with SMTP id u25mr6140265fan.112.1309600212879;
 Sat, 02 Jul 2011 02:50:12 -0700 (PDT)
Received: by 10.223.101.207 with HTTP; Sat, 2 Jul 2011 02:50:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176548>

All,

I am sorry to bother the list with this question, but I have spent a
lot of time searching and have never really found what I was looking
for.  No one had answers to my question on IRC either.  I am running
git/gitweb 1.7.5 on shared hosting (Dreamhost, if that matters).  I
compiled it and followed a tutorial
(https://github.com/tmacam/private-git-on-dreamhost) on setting it up
in my environment.  It worked great, but I have some stuff that is not
source code, namely PDF's and ODP/ODT/ODS files I want to see changes
from beyond knowing they are binary files.  Enter the official wiki
page explaining textconv
(https://git.wiki.kernel.org/index.php/GitTips#How_to_use_git_to_track_OpenDocument_.28OpenOffice.2C_Koffice.29_files.3F).

So, I tried different variations of this, specifically for repos.
Now, I have tried it globally as that was tedious and it was not
working anyway. That works some of the time if I try commands over the
console (git log  -p for quick testing), but never in Gitweb.  It
continues to only say they are differing binary files.  Does Gitweb
1.7.5 support the use of this?  Is there something special I must do?
Below is my current config:

[dreamhost-server]$ git config --list --global
diff.odf.textconv=odt2txt
diff.odf.binary=false
diff.pdf.textconv=pdftotext
diff.pdf.binary=false
core.attributesfile=~/.gitattributes
[dreamhost-server]$ more ~/.gitattributes
*.odf diff=odf
*.odt diff=odf
*.odp diff=odf
*.pdf diff=pdf
[jabbah]$ more ~/repos/gitweb_config.perl
# where is the git binary?
$GIT = "/home/dreamhost_account/opt/bin/git";
# where are our git project repositories?
$projectroot = $ENV{'GIT_PROJECT_ROOT'};
# what do we call our projects in the gitweb UI?
$home_link_str = "~";
#  where are the files we need for gitweb to display?
@stylesheets = ("gitweb.css");
$logo = "git-logo.png";
$favicon = "/favicon.png";
# what do we call this site?
$site_name = "my personal git repos";

The diff.<driver>.binary addition is new.  I tried with or without
them, hoping mention of this on a mailing list thread from a while
back might help.  It was all in vain.  I also tried fiddling with
$diff_opts for Gitweb after scanning the man page for git-diff, but I
am not sure if there is anything helpful I missed.  I no this is a
newbish question, I am sure, so I apologize in advance.

Best,
_AJS
