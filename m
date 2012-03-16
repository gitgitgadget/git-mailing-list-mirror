From: Gelonida N <gelonida@gmail.com>
Subject: Re: git push default behaviour?
Date: Fri, 16 Mar 2012 10:38:22 +0100
Message-ID: <jjv1me$ts7$1@dough.gmane.org>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>	<87k42vs8pi.fsf@thomas.inf.ethz.ch>	<CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com>	<1331202483.21444.11.camel@beez.lab.cmartin.tk>	<CAFsnPqpnH2CTki8zz6Mpz=qrdxF_aTA92cPrn1L9MQZVMoxdeg@mail.gmail.com>	<1331203321.21444.13.camel@beez.lab.cmartin.tk>	<4F58C977.8000400@xiplink.com> <vpq62efjeqd.fsf@bauges.imag.fr>	<CAHkcotiOGaOdDvibpoiEgys3PnSPfSw0mT3DeEOix+FuboULiA@mail.gmail.com>	<vpqfwdjas0m.fsf@bauges.imag.fr>	<20120309033826.GA6164@sigill.intra.peff.net>	<7vsjhi9wku.fsf@alter.siamese.dyndns.org>	<7vobs69vwj.fsf@alter.siamese.dyndns.org>	<CANgJU+WMxnNgdsP4JV6aAVW07NeWXUa5LsEa4dk5_1CZXC1nXA@mail.gmail.com> <87aa3qi2i7.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 16 10:39:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8Tch-0007oc-Hz
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 10:38:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760823Ab2CPJis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 05:38:48 -0400
Received: from plane.gmane.org ([80.91.229.3]:44898 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759609Ab2CPJih (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 05:38:37 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1S8TcI-0007VD-Cd
	for git@vger.kernel.org; Fri, 16 Mar 2012 10:38:34 +0100
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Mar 2012 10:38:34 +0100
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Mar 2012 10:38:34 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.27) Gecko/20120216 Lightning/1.0b2 ""
In-Reply-To: <87aa3qi2i7.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193247>

On 03/09/2012 09:48 AM, Thomas Rast wrote:
> demerphq <demerphq@gmail.com> writes:
> 
>> A possible solution might be to give config files a "format version"
>> of their own. They already contain a repository format version number,
>> so add a new variable "ConfigVersionLevel". Alongside that you might
>> introduce a policy of having new git "fill in" the defaults missing
>> from the config file whenever it operates, so that people can
>> explicitly view then all at once. Then if the defaults change in the
>> future an old repo will continue to work as it did before. This alone
>> would allow you to change the defaults for existing configurable
>> behavior, but you need the version number to handle new options.
>>
>> Once you have that you can change the default behavior based on the
>> version level so that older users operating in older repositories get
>> the old behavior, and new repositories get the new behavior. And you
>> have more flexibility in how your approach these problems when they
>> come up, and it seems to me that they are inevitable.
> 
> This would be a brilliant way to confuse the hell out of existing users:
> suddenly the apparent "defaults"[1] now change *between repositories*
> depending on when they were created.
> 
> In short, oh please god no.

If config file version changes would occur rarely, then this idea
dsoesn't sound that bad to me.
git could even ask whether it should upgrade (explicitely insert the old
default value if not existing and if different in the new release)  the
config file version whenver it encounters an old version.

By this means old projects wouldn't be broken whenever a default value
would be changed  and all rconfig files would upgrade to the same version.

Even older versions of git would still work with these upgraded config files
