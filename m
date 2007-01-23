From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: Meaning of "fatal: protocol error: bad line length character"?
Date: Tue, 23 Jan 2007 01:53:35 +0100
Message-ID: <45B55C8F.2090601@xs4all.nl>
References: <17842.1385.366750.915767@lisa.zopyra.com>	<7vk5zh7b7d.fsf@assigned-by-dhcp.cox.net> <45B5535E.2000808@xs4all.nl> <7v3b62r2r1.fsf@assigned-by-dhcp.cox.net>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 23 01:55:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H99wX-0001wG-In
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 01:55:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbXAWAzG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 19:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbXAWAzG
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 19:55:06 -0500
Received: from main.gmane.org ([80.91.229.2]:46040 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932448AbXAWAzE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 19:55:04 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1H99wE-0004Nb-IJ
	for git@vger.kernel.org; Tue, 23 Jan 2007 01:55:02 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 01:55:02 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 01:55:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
In-Reply-To: <7v3b62r2r1.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37474>


Sylvain, can you help out here? 

The lilypond repo got into a state where it will no longer
allow reading over the git:// protocol; for troubleshooting,
we need some info on what is happening on the GNU side of things.

Han-Wen

Junio C Hamano escreveu:
> Han-Wen Nienhuys <hanwen@xs4all.nl> writes:
> 
>> if you need another example where this is happening, the anongit
>> repo for lilypond seems to have gotten in this state as well,
>>
>> [hanwen@haring tmp]$ git clone git://git.sv.gnu.org/lilypond.git
>> Initialized empty Git repository in /tmp/lilypond/.git/
>> fatal: protocol error: bad line length character
>> fetch-pack from 'git://git.sv.gnu.org/lilypond.git' failed.
> 
> With my debugging patch applied to peek-remote:
> 
>         $ git-peek-remote git://git.sv.gnu.org/lilypond.git
>         error: protocol error: bad line length character
>         <<<<<
>         env: 
>         >>>>>
>         fatal: protocol error: bad line length character
> 
> So somebody says "env:" immediately followed by an EOF to the
> stdout when upload-pack is invoked via git-daemon.
> 
> The first thing that happens in the fetch/clone/peek-remote
> protocol is reading from the server side, so unfortunately there
> is no way to debug any further without having an access to their
> server.
> 


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
