From: David Kastrup <dak@gnu.org>
Subject: Re: Errors building git-1.5.2.2 on 64-bit Centos 5
Date: Tue, 19 Jun 2007 16:13:55 +0200
Message-ID: <86wsy0qbfg.fsf@lola.quinscape.zz>
References: <18039.52754.563688.907038@lisa.zopyra.com> <Pine.LNX.4.64.0706191359160.4059@racer.site> <18039.57163.667319.439210@lisa.zopyra.com> <Pine.LNX.4.64.0706191457440.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 19 16:55:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0f79-0002jq-UW
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 16:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605AbXFSOzX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 10:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752293AbXFSOzX
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 10:55:23 -0400
Received: from main.gmane.org ([80.91.229.2]:33740 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751116AbXFSOzW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 10:55:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I0esB-0002jh-8J
	for git@vger.kernel.org; Tue, 19 Jun 2007 16:39:59 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 16:39:59 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 16:39:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:BkvpSuBXtwKbMRiP8j+H9+mYclw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50488>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Tue, 19 Jun 2007, Bill Lear wrote:
>
>> On Tuesday, June 19, 2007 at 14:00:07 (+0100) Johannes Schindelin writes:
>> >
>> >On Tue, 19 Jun 2007, Bill Lear wrote:
>> >
>> >> Also breaks (tar fails) if I do the 'make configure; ./configure'
>> >> route.
>> >
>> >Then there is a test missing in configure.
>> 
>> Here is the particular error:
>> 
>> install git '/opt/git-1.5.2.2/bin'
>> make -C templates DESTDIR='' install
>> make[1]: Entering directory `/home/blear/build/git-1.5.2.2/templates'
>> install -d -m755 '/opt/git-1.5.2.2/share/git-core/templates/'
>> (cd blt && gtar cf - .) | \
>> 	(cd '/opt/git-1.5.2.2/share/git-core/templates/' && gtar xf -)
>> gtar: This does not look like a tar archive
>> gtar: Skipping to next header
>> gtar: Archive contains obsolescent base-64 headers
>> gtar: Error exit delayed from previous errors
>> make[1]: *** [install] Error 2
>> make[1]: Leaving directory `/home/blear/build/git-1.5.2.2/templates'
>> make: *** [install] Error 2
>
> WTF? gtar cannot read its own output?
>
> Be that as may, this is not git error.

It is possible that cd is an alias outputting the target of cd.
People do those kind of things.  It is also possible that the first cd
fails and thus the first gtar is not run (though tar xf /dev/null is
quiet here, so probably should be at the OP's site, too.).

-- 
David Kastrup
