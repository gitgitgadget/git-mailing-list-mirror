From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] config: Add --quoted option to produce machine-parsable output
Date: Tue, 22 May 2007 00:37:57 +0200
Organization: At home
Message-ID: <f2t6na$5bi$1@sea.gmane.org>
References: <20070520225953.GK4085@planck.djpig.de> <11797696193384-git-send-email-frank@lichtenheld.de> <20070521195423.GC5082@efreet.light.src> <20070521205812.GO4085@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 22 00:34:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqGS3-0003AN-N3
	for gcvg-git@gmane.org; Tue, 22 May 2007 00:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754375AbXEUWd4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 18:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755907AbXEUWd4
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 18:33:56 -0400
Received: from main.gmane.org ([80.91.229.2]:57779 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754375AbXEUWd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 18:33:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HqGRU-00014Y-JC
	for git@vger.kernel.org; Tue, 22 May 2007 00:33:28 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 May 2007 00:33:28 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 May 2007 00:33:28 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48056>

Frank Lichtenheld wrote:

> On Mon, May 21, 2007 at 09:54:23PM +0200, Jan Hudec wrote:
>> On Mon, May 21, 2007 at 19:46:59 +0200, Frank Lichtenheld wrote:
>> > This option will enclose key names in quotes (") if they
>> > contain a subsection and then escape " and \. It will also
>> > escape line breaks in values. Together this should produce
>> > an easily parsable output.
>> 
>> That will lead to either eval (which runs perl parser and probably won't win
>> anything) or regexps (which is not big win over parsing the .ini directly
>> with them) on the perl side. IMHO only thing that would actually be faster is
>> NUL-separated entries.
> 
>> Either:
>>     KEY <NUL> VALUE <NUL>
>> 
>> or:
>>     KEY <TAB> VALUE <NUL>
> 
> Both subsection names and values can contain <TAB> characters, so the
> latter isn't possible.

But neither subsection names (even [section "subsection"] style) not key
names cannot contain newline <LF>. I.e.

        KEY <LF> VALUE <NUL>

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
