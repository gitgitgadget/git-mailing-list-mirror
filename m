From: Christian Stimming <stimming@tuhh.de>
Subject: Re: git-gui-i18n: Make "Revert changes in these $n files"
	translatable.
Date: Thu, 26 Jul 2007 16:53:34 +0200
Message-ID: <20070726165334.72vekk2ry80kk40c@webmail.tu-harburg.de>
References: <20070726104723.ugsfnbj1ogw8gg4k@webmail.tu-harburg.de>
	<20070726115301.GA27821@cc.hut.fi>
	<20070726143449.iklqfh5c6c48844k@webmail.tu-harburg.de>
	<20070726142152.GA5335@cc.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Harri Ilari Tapio Liusvaara <hliusvaa@cc.hut.fi>
X-From: git-owner@vger.kernel.org Thu Jul 26 16:53:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE4ip-0005eC-Rh
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 16:53:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755861AbXGZOxo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 10:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755844AbXGZOxo
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 10:53:44 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:43583 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753787AbXGZOxn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jul 2007 10:53:43 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6QErYKQ007528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 26 Jul 2007 16:53:34 +0200
Received: from webmail.tu-harburg.de (ocs3.rz.tu-harburg.de [134.28.202.66])
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6QErYEu006597;
	Thu, 26 Jul 2007 16:53:34 +0200
Received: by webmail.tu-harburg.de (Postfix, from userid 1001)
	id 33FF7E50349; Thu, 26 Jul 2007 16:53:34 +0200 (CEST)
Received: from hansjoerg.sick.de (hansjoerg.sick.de [62.180.123.245]) by
	webmail.tu-harburg.de (Horde MIME library) with HTTP; Thu, 26 Jul 2007
	16:53:34 +0200
In-Reply-To: <20070726142152.GA5335@cc.hut.fi>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53837>

Quoting Harri Ilari Tapio Liusvaara <hliusvaa@cc.hut.fi>:
>> >BTW: Here is list of some missed translations:
>>
>> >- Font setting names in options window.
>>
>> You mean the names of the fonts? But those are names. I thought by
>> definition they cannot be translated.
>
> Nope. The texts are "Main Font:" and "Diff/Console Font:". They are
> specified in somewhat bizarre manner (Search for "Main Font") from
> git-gui.sh.

Ok, thanks for the pointer. Patch attached (will be push on the weekend).

>> >- Buttons in hard reset confirmation (branch->revert or merge->abort,
>> >  and it is yes/no dialog).
>>
>> I see this in translated form (German Ja/Nein), and also the button
>> text (translated or not) doesn't appear in the git-gui source code.
>> Maybe those need to be translated in the tcl/tk system libraries?
>
> I think that they might come from system libraries. But I'd rather
> use better labels. AFAIK, HCI guidelines say that yes/no dialogs
> are to be avoided, especally for confirming potentially destructive
> actions.

True for now. This would concern basically all question dialogs that  
appear in git-gui.

Christian


---
  git-gui.sh     |    4 ++--
  lib/option.tcl |    2 +-
  2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 9f903ba..463ec32 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1652,8 +1652,8 @@ set default_config(gui.newbranchtemplate) {}
  set default_config(gui.fontui) [font configure font_ui]
  set default_config(gui.fontdiff) [font configure font_diff]
  set font_descs {
-	{fontui   font_ui   {Main Font}}
-	{fontdiff font_diff {Diff/Console Font}}
+	{fontui   font_ui   {mc "Main Font"}}
+	{fontdiff font_diff {mc "Diff/Console Font"}}
  }
  load_config 0
  apply_config
diff --git a/lib/option.tcl b/lib/option.tcl
index 20f1e8e..31c7d47 100644
--- a/lib/option.tcl
+++ b/lib/option.tcl
@@ -245,7 +245,7 @@ proc do_options {} {
  	foreach option $font_descs {
  		set name [lindex $option 0]
  		set font [lindex $option 1]
-		set text [lindex $option 2]
+		set text [eval [lindex $option 2]]

  		set global_config_new(gui.$font^^family) \
  			[font configure $font -family]
-- 
1.5.3.rc2.12.gbc280
