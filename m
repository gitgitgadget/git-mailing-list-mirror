From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: How to run git-gui always in English?
Date: Sun, 21 Oct 2007 09:03:36 +0200
Message-ID: <C65193EE-A45D-49ED-8831-1A006421A915@zib.de>
References: <CCAD0DE0-65D4-4FEC-B02F-658010FECD04@zib.de> <20071021065230.GE14735@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Oct 21 09:05:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjUrt-0008Em-TJ
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 09:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbXJUHEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 03:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbXJUHEq
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 03:04:46 -0400
Received: from mailer.zib.de ([130.73.108.11]:52132 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750912AbXJUHEp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 03:04:45 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9L728hr019090;
	Sun, 21 Oct 2007 09:04:42 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db1b164.pool.einsundeins.de [77.177.177.100])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9L727o6004083
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 21 Oct 2007 09:02:07 +0200 (MEST)
In-Reply-To: <20071021065230.GE14735@spearce.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61885>


On Oct 21, 2007, at 8:52 AM, Shawn O. Pearce wrote:

> Steffen Prohaska <prohaska@zib.de> wrote:
>
>> How can I switch msysgit's git-gui to English, independently of
>> the language selected for Windows? I recognized that git-gui
>> adjusts to the 'language selection' of Windows. How can I
>> disable this? I want git-gui to always display English. Nothing
>> else, never! I can't help people who use a different language
>> in the gui, because I'll not understand what they are talking
>> about and they'll not understand me.
>>
>> Can I set an option in git-gui's option menu? I haven't
>> found one.
>>
>
> Yea, we don't have a UI to let you set what language the UI should
> appear in.  Partly because once the UI is up we'd have to restart
> the entire process to change the strings its using.  And partly
> because nobody has asked for this before.
>
> I think that if you set LANG=en before you start git-gui it will
> take on English, and so will all of the standard dialogs that we
> "borrow" from wish.

Hmm. I have no shell. I run git-gui from the Windows Start Menu.
It directly runs wish to execute the Windows git-gui wrapper:

--- SNIP ---
#!/bin/sh
# Tcl ignores the next line -*- tcl -*- \
exec wish "$0" -- "$@"

if { $argc >=2 && [lindex $argv 0] == "--working-dir" } {
         cd [lindex $argv 1]
         set argv [lrange $argv 2 end]
         incr argc -2
}

set gitguidir [file dirname [info script]]
regsub -all ";" $gitguidir "\\;" gitguidir
set env(PATH) "$gitguidir;$env(PATH)"
unset gitguidir

source [file join [file dirname [info script]] git-gui.tcl]
--- SNIP ---

Do we have a chance before we source the real git-gui.tcl?
Maybe we could "set env(LANG)" based on "git config gui.lang"?
Or is it already too late because we needed to restart wish?

	Steffen
