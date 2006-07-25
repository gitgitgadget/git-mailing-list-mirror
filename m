From: Nix <nix@esperi.org.uk>
Subject: Re: Handling very large numbers of symbolic references?
Date: Tue, 25 Jul 2006 22:52:48 +0100
Message-ID: <87u055bbdb.fsf@hades.wkstn.nix>
References: <87psfteb4l.fsf@hades.wkstn.nix> <44C68D52.6030107@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 25 23:52:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5Upj-0007Jt-PO
	for gcvg-git@gmane.org; Tue, 25 Jul 2006 23:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbWGYVww (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 17:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWGYVww
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 17:52:52 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:35342 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S964877AbWGYVwv
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jul 2006 17:52:51 -0400
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18])
	by mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id k6PLqmU8008315;
	Tue, 25 Jul 2006 22:52:48 +0100
Received: (from nix@localhost)
	by esperi.org.uk (8.12.11.20060614/8.12.11/Submit) id k6PLqmii021488;
	Tue, 25 Jul 2006 22:52:48 +0100
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
X-Emacs: don't try this at home, kids!
In-Reply-To: <44C68D52.6030107@lsrfire.ath.cx> (Rene Scharfe's message of "Tue, 25 Jul 2006 23:29:54 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24189>

On Tue, 25 Jul 2006, Rene Scharfe said:
> Nix schrieb:
>> However, this causes a potential problem. There are tens of thousands of
>> these bugs, and the .git/refs/heads directory gets *enormous* and thus
>> the system gets terribly terribly slow (crappy old Solaris filesystem
>> syndrome).
>> 
>> It seems to me there are two ways to fix this:
>> 
>>  - restructure .git/refs/* in a similar way to .git/objects, i.e. as a
>>    one- or two-level tree.
> 
> Branch names are allowed to contain slashes, thus your porcelain is free
> to implement such a tree.  Add a slash after every two bug ID digits and
> your directories will never contain more than 100 objects.

Oh, lovely! I was *sure* I'd need to make git core changes for this, but
no, the precognitive powers of the git hackers had anticipated my needs
before I knew what they were!

(Now the only downside is gitweb's treatment of such heads: but looking
at the code, making it skip suitably formatted heads when displaying the
heads list is an utterly trivial one-liner.)

-- 
`We're sysadmins. We deal with the inconceivable so often I can clearly 
 see the need to define levels of inconceivability.' --- Rik Steenwinkel
