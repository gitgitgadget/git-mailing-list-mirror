From: John Goerzen <jgoerzen@complete.org>
Subject: Re: FastCGI support in gitweb
Date: Tue, 4 Mar 2008 08:48:50 -0600
Message-ID: <slrnfsqoai.njm.jgoerzen@katherina.lan.complete.org>
References: <1c3be50f0803011334u2629011cg85cb8728a244ea4e@mail.gmail.com> <m38x12jeqt.fsf@localhost.localdomain> <47CBEED2.30808@vilain.net> <200803040119.22240.jnareb@gmail.com> <slrnfspi8b.83u.jgoerzen@katherina.lan.complete.org> <m3od9uiyru.fsf@localhost.localdomain>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 16:09:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWYlN-0001xn-Km
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 16:09:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757885AbYCDPI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 10:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757828AbYCDPI2
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 10:08:28 -0500
Received: from main.gmane.org ([80.91.229.2]:45313 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754475AbYCDPI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 10:08:27 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JWYke-00039u-1d
	for git@vger.kernel.org; Tue, 04 Mar 2008 15:08:20 +0000
Received: from 63-245-179-205.kitusa.com ([63.245.179.205])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 15:08:20 +0000
Received: from jgoerzen by 63-245-179-205.kitusa.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 15:08:20 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 63-245-179-205.kitusa.com
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76097>

On 2008-03-04, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Debian, this was as easy as apt-get install libapache2-mod-fcgid
>
> And for Fedora Core?
>
> From what I have found there exists three 3rd-party (i.e. not
> developed by Apache) modules for FastCGI support: mod_fastcgi,
> mod_fcgi and mod_proxy_fcgi. Which one to choose?

I like mod_fcgid, but that's just me.

>> Sure it can.  I currently am running both Python and Ruby code under
>> FastCGI.  Adding mod_perl for just one program increases my
>> webserver's memory footprint, potentially dramatically, and increases
>> my complexity as well.  I'd much rather run FastCGI than mod_perl.
>
> Well, if you are running FastCGI for other scripts, it makes sense
> then.
>
> Although... doesn't there exists modules for Python (mod_python,
> mod_wsgi, mod_snake) and for Ruby (mod_ruby)?

Sure.  But think of the horrendous memory footprint if I have mod_php,
mod_python, mod_perl, and mod_ruby all loaded into Apache at once!  (I
do have mod_php in my installation)  Remember that if it is configured
that way, *each* Apache process/thread carries the module for PHP,
Python, Perl, AND Ruby, even if it uses none of them.  I've been
there, done that, and it's not pretty.

FastCGI is much, much lighter on resource requirements if you are
deploying apps written in various languages on a single server.
Sometimes even if you aren't.

-- John

