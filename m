From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GIT push to sftp (feature request)
Date: Mon, 06 Aug 2007 02:14:02 +0200
Organization: At home
Message-ID: <f95p47$607$1@sea.gmane.org>
References: <200708051105.44376.pavlix@pavlix.net> <46a038f90708051412p722aa906v73e986a805f1558b@mail.gmail.com> <vpqir7t8vy0.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 06 02:14:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHqEh-0000JE-28
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 02:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758282AbXHFAOM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 20:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758297AbXHFAOM
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 20:14:12 -0400
Received: from main.gmane.org ([80.91.229.2]:53117 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758282AbXHFAOL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 20:14:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IHqEa-0000Js-Ee
	for git@vger.kernel.org; Mon, 06 Aug 2007 02:14:08 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Aug 2007 02:14:08 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Aug 2007 02:14:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55090>

Matthieu Moy wrote:

> "Martin Langhoff" <martin.langhoff@gmail.com> writes:
> 
>> Git tries to be smart in at least 2 ways that don't work with dump
>> protocols: it works locklessly (yet it performs atomic updates) and it
>> sends only the objects needed over the wire (saving a lot of
>> bandwidth).
>>
>> Using dumb protocols it's impossible to do either.

But git _can_ push over http protocol (with WebDAV), and http is a dumb
protocol, and over rsync (although it is deprecated).
 
> That's not exactly true. You can't be as efficient with dumb protocols
> than you are with a dedicated protocol (something with some
> intelligence on both sides), but at least the second point you mention
> can be achieved with a dumb protocol, and bzr is a proof of existance.
> To read over HTTP, it uses ranges request, and to push over
> ftp/sftp/webdav, it appends new data to existing files (its ancestor,
> GNU Arch, also had a way to be network-efficient on dumb protocols).

If I understand correctly to read (fetch) over http and other dumb
protocols (like ftp), git uses two indices .git/info/refs
and .git/objects/info/packs which must be present on the server serving
http protocol (see git-update-server-info) to calculate which packs
to get, and I think it always downloads whole packs, but I'm not sure...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
