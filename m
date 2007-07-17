From: David Kastrup <dak@gnu.org>
Subject: Re: Can someone explain this git-blame/git-rev behavior to me?
Date: Tue, 17 Jul 2007 11:57:09 +0200
Message-ID: <863aznz72i.fsf@lola.quinscape.zz>
References: <86sl7oaasx.fsf@lola.quinscape.zz> <7v7ip02b81.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 17 11:57:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAjo5-000356-3o
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 11:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636AbXGQJ5U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 05:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752660AbXGQJ5U
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 05:57:20 -0400
Received: from main.gmane.org ([80.91.229.2]:43064 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752520AbXGQJ5T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 05:57:19 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IAjnw-0000u0-F5
	for git@vger.kernel.org; Tue, 17 Jul 2007 11:57:16 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Jul 2007 11:57:16 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Jul 2007 11:57:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:q3KOa3UxW2IcGxfdQRZX7HFN5pQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52752>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> git-rev-list HEAD --not tags/v1.4.2-rc1~88 --parents contrib/emacs/vc-git.el|tail -1|git-name-rev --stdin
>>
>> d87b90e47f7430455385edcf8506288b9a73d3b5 (tags/v1.4.2-rc1~87) b5dd9d2027c1bd5758033c7baf6d087752b0263d (tags/v1.4.2-rc1~88) 280242d1cc1fe2847f649d2f16b273e168fcbc48 (tags/v1.4.2-rc1~92)
>>
>> So we have tags/v1.4.2-rc1~87 listed as successor again, so I get into
>> a loop of blame.
>
> Without the final name-rev, it reads:
>
> d87b90e4... b5dd9d20... 280242d1...
>
> Without the --parent option, you get only d87b90e4...;

No.  Without the --parents option, I get

076a10c7282a08f783a28c1b64d0e114a3fe3d39

which is what I would think correct, as opposed to the output with
--parents option.  Have you actually tried this?

-- 
David Kastrup
