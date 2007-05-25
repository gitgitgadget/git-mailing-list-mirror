From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Fri, 25 May 2007 12:06:02 +0200
Organization: At home
Message-ID: <f36c4s$ltp$1@sea.gmane.org>
References: <20070518220826.GM942MdfPADPa@greensroom.kotnet.org> <20070518224209.GG10475@steel.home> <7vd50x1n0r.fsf@assigned-by-dhcp.cox.net> <20070519130542.GR942MdfPADPa@greensroom.kotnet.org> <7v4pm8y8tf.fsf@assigned-by-dhcp.cox.net> <20070520155407.GC27087@efreet.light.src> <7vbqgfmjki.fsf@assigned-by-dhcp.cox.net> <20070521165938.GA4118@efreet.light.src> <20070521211133.GD5412@admingilde.org> <20070522193706.GA4432@efreet.light.src> <20070524154833.GL5412@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 25 12:01:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrWc0-0002b2-Ai
	for gcvg-git@gmane.org; Fri, 25 May 2007 12:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbXEYKB1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 06:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbXEYKB1
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 06:01:27 -0400
Received: from main.gmane.org ([80.91.229.2]:37651 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751163AbXEYKB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 06:01:27 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HrWbj-0001B9-Ex
	for git@vger.kernel.org; Fri, 25 May 2007 12:01:15 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 May 2007 12:01:15 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 May 2007 12:01:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48353>

Martin Waitz wrote:

> On Tue, May 22, 2007 at 09:37:06PM +0200, Jan Hudec wrote:

>> Including the same project several times is indeed interesting. Maybe the
>> subprojects should be "light checkouts" (I believe something like this was
>> already discussed on the list sometime). Those would be .git dirs, that would
>> only have HEAD and pointer to another .git dir with everything else.
> 
> Well, even if they might share a lot of objects they might be included
> for completely different reasons and so might need to work with
> different communities (remote entries, branches, etc.).
> 
> So sharing objects makes sense, sharing the rest of .git is not
> neccessary.

One of the final ideas for "lightweight checkout" was having in
.git/config the location of "true" $GIT_DIR (or parts of it: 
GIT_INDEX_FILE, GIT_OBJECT_DIRECTORY), and "shadowing" the rest
of "true $GIT_DIR" with what is present in .git. It means that
you can have .git/index and .git/HEAD, and if you don't find
appropriate .git/refs/heads/master file you look to "true $GIT_DIR".

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
