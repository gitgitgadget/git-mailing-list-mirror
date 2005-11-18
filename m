From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: "make test" fails with current HEAD
Date: Fri, 18 Nov 2005 09:56:25 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.11.18.08.56.22.908009@smurf.noris.de>
References: <pan.2005.11.17.15.31.56.755022@smurf.noris.de> <7v7jb6o1kl.fsf@assigned-by-dhcp.cox.net> <20051118075117.GK31613@kiste.smurf.noris.de> <7vbr0imlha.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Nov 18 10:00:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ed24x-0001ot-6Y
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 09:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620AbVKRI6k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 03:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbVKRI6k
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 03:58:40 -0500
Received: from main.gmane.org ([80.91.229.2]:40644 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932620AbVKRI6k (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 03:58:40 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ed23W-0001Nb-EC
	for git@vger.kernel.org; Fri, 18 Nov 2005 09:57:14 +0100
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Nov 2005 09:57:14 +0100
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Nov 2005 09:57:14 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12217>

Hi, Junio C Hamano wrote:

> Matthias Urlichs <smurf@smurf.noris.de> writes:
> 
>>>> Files /dev/null and b/file3 differ
>>
>> Of course, with LANG=de_DE.UTF-8 the situation is worse ...
> 
> A midway compromise solution would be to detect if either file
> is binary ourselves and not to call diff but always say "Binary
> files difer".

Actually, there's a better way:

$ diff -u /dev/null /tmp/ra
Binary files /dev/null and /tmp/ra differ
$ echo $?
2

So the trivial fix is to emit our own "Binary files FOO and BAR differ"
line if the exit status is 2.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
If a man will go as far as he can see, he will be able to see farther when
he gets there.
