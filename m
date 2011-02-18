From: Goswin von Brederlow <goswin-v-b@web.de>
Subject: Re: [fuse-devel] [sshfs] inode problem when using git on a sshfs filesystem
Date: Fri, 18 Feb 2011 08:41:16 +0100
Message-ID: <87ei75ssbn.fsf@frosties.localnet>
References: <1297893854.4097.43.camel@dworkin.quest-ce.net>
	<E1Pq1LW-0005rc-Qy@pomaz-ex.szeredi.hu>
	<7f02c4cb5ca13dae6de7caa1b6f90cfe.squirrel@webmail.ocsa-data.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Miklos Szeredi" <miklos@szeredi.hu>,
	fuse-devel@lists.sourceforge.net, fuse-sshfs@lists.sourceforge.net,
	git@vger.kernel.org
To: "Yann Droneaud" <yann@droneaud.fr>
X-From: git-owner@vger.kernel.org Fri Feb 18 08:41:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqKxw-0007bX-Eb
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 08:41:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755826Ab1BRHlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 02:41:20 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:52174 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752991Ab1BRHlT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 02:41:19 -0500
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate01.web.de (Postfix) with ESMTP id 9BB8B1890DC2C;
	Fri, 18 Feb 2011 08:41:17 +0100 (CET)
Received: from [78.43.204.177] (helo=frosties.localnet)
	by smtp02.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #2)
	id 1PqKxp-0004Zr-00; Fri, 18 Feb 2011 08:41:17 +0100
Received: from mrvn by frosties.localnet with local (Exim 4.72)
	(envelope-from <goswin-v-b@web.de>)
	id 1PqKxp-0003FT-0P; Fri, 18 Feb 2011 08:41:17 +0100
In-Reply-To: <7f02c4cb5ca13dae6de7caa1b6f90cfe.squirrel@webmail.ocsa-data.net>
	(Yann Droneaud's message of "Thu, 17 Feb 2011 12:54:43 +0100")
User-Agent: Gnus/5.110009 (No Gnus v0.9) XEmacs/21.4.22 (linux, no MULE)
X-Sender: goswin-v-b@web.de
X-Provags-ID: V01U2FsdGVkX1+2o58iRxNzYUASvPtDeZXJ/eNTxDQ5OWzbZ76k
	DWhJ4CarCgHVlPqxPlwqe2kBpGHLwnBSLK8m66BZGwmPnMnNQ5
	QWbTnTtH0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167181>

"Yann Droneaud" <yann@droneaud.fr> writes:

>> On Wed, 16 Feb 2011, Yann Droneaud wrote:
>> Fuse version 2.8.x has a "noforget" option that should provide stable
>> inode numbers, at the cost of unbounded memory use.  Could you please
>> try if this option fixes these issues?
>>
>
> Yes, this option seems to fix the problem.
>
> I will try it for a while to see if this is stable enough for a full day
> of git working. (How can I check memory usage ?)

The memory usage comes from the inodes. Fuse will never forget an inode
(unless you delete the dile/dir) that was once visited (thereby giving
allways the same inode number). As long as you don't have a billion
files that generally doesn't matter.

MfG
        Goswin
