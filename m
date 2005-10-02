From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: Honor extractor's umask in git-tar-tree.
Date: Sun, 02 Oct 2005 11:55:55 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.10.02.09.55.52.564046@smurf.noris.de>
References: <20050930160353.F025C352B7B@atlas.denx.de> <Pine.LNX.4.64.0510010934290.3378@g5.osdl.org> <7vr7b53y0n.fsf@assigned-by-dhcp.cox.net> <7vk6gx3vkt.fsf_-_@assigned-by-dhcp.cox.net> <433F52DC.5090906@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sun Oct 02 11:58:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EM0bB-00019R-Pn
	for gcvg-git@gmane.org; Sun, 02 Oct 2005 11:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbVJBJ5f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Oct 2005 05:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbVJBJ5f
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Oct 2005 05:57:35 -0400
Received: from main.gmane.org ([80.91.229.2]:42190 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751048AbVJBJ5e (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Oct 2005 05:57:34 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EM0a4-0000qk-Kn
	for git@vger.kernel.org; Sun, 02 Oct 2005 11:56:28 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 02 Oct 2005 11:56:28 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 02 Oct 2005 11:56:28 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9609>

Hi, H. Peter Anvin wrote:

> I've thought that it would be nice if the files/directories were written
> into the archive with 0666/0777 permissions by default, and then
> extracted with the umask honoured.

The git archive oesn't *have* permissions, just one "execute" bit.

>  A special option then could be used
> to add files with special permissions, like files in .ssh, which *have*
> to be g-w or sshd will reject them.
> 
I'd include a script in the archive which you'd run afterwards to fix
problems like this. IMHO, in most situations you'll need it anyway
(for instance, to re-start services).

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
As I approached the intersection a sign suddenly appeared in a place
where no stop sign had ever appeared before. I was unable to stop in
time to avoid the accident. To avoid hitting the bumper of the car in
front, I struck the pedestrian.
