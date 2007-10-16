From: Adam Piatyszek <ediap@users.sourceforge.net>
Subject: Re: On Tabs and Spaces
Date: Tue, 16 Oct 2007 12:16:18 +0200
Message-ID: <47148F72.1090602@users.sourceforge.net>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>	 <471476B7.5050105@users.sourceforge.net> <8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael Witten <mfwitten@mit.edu>, git@vger.kernel.org
To: Lars Hjemli <lh@elementstorage.no>
X-From: git-owner@vger.kernel.org Tue Oct 16 12:26:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhjcQ-0007O5-AF
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 12:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759607AbXJPKZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 06:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759454AbXJPKZ0
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 06:25:26 -0400
Received: from pisces.et.put.poznan.pl ([150.254.29.122]:44710 "EHLO
	pisces.et.put.poznan.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760024AbXJPKZY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 06:25:24 -0400
Received: from hydrus.et.put.poznan.pl (hydrus.et.put.poznan.pl [150.254.11.145])
	by pisces.et.put.poznan.pl (8.13.8/8.13.8) with ESMTP id l9GAK251024294;
	Tue, 16 Oct 2007 12:20:04 +0200 (CEST)
	(envelope-from ediap@users.sourceforge.net)
Received: from [150.254.11.65] (pc1065.et.put.poznan.pl [150.254.11.65])
	by hydrus.et.put.poznan.pl (8.11.7p1+Sun/8.11.6) with ESMTP id l9GAG7S04176;
	Tue, 16 Oct 2007 12:16:07 +0200 (MET DST)
User-Agent: Thunderbird 2.0.0.6 (X11/20070917)
In-Reply-To: <8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com>
X-Enigmail-Version: 0.95.3
OpenPGP: id=1F115CCB
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.313940, Antispam-Data: 2007.10.16.23352
X-PerlMx-Spam: Gauge=XIII, Probability=13%, Report='OBFUSCATING_HTML 1.2, __CP_URI_IN_BODY 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __STOCK_PHRASE_24 0, __USER_AGENT 0'
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61139>

* Lars Hjemli [16 X 2007 11:04]:
>>From http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=Documentation/CodingStyle;h=7f1730f1a1ae2e9a6f368bdb10ff65f4568863d5;hb=HEAD
> 
> (defun linux-c-mode ()
>   "C mode with adjusted defaults for use with the Linux kernel."
>   (interactive)
>   (c-mode)
>   (c-set-style "K&R")
>   (setq tab-width 8)
>   (setq indent-tabs-mode t)
>   (setq c-basic-offset 8))
> 
> 
> And to use this only in a specific directory:
> 
> (setq auto-mode-alist (cons '("/usr/src/linux.*/.*\\.[ch]$" . linux-c-mode)
> 	auto-mode-alist))

Thanks!

But it seems that the above settings are still imperfect, since they
mixes tabs and spaces when aligning. For instance:

int some_function(int some_variable)
{
<T>	int result;
<T>	result = execute_another_function(some_variable,
<T>	<T>	<T>	<T>	<T>	..other_variable);
<T>	return result;
}

<T> - represents tab here, `.' - space

And if one change the tab size, it will result in a messy alignment in
line 5.
I guess there is no ideal solution for this in Emacs.

BR,
/Adam


-- 
.:.  Adam Piatyszek - "ediap"       .:.  JID: ediap(at)jabber.org .:.
.:.  ediap(at)users.sourceforge.net .:.  PGP key ID: 0x1F115CCB   .:.
