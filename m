From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb using "--cc"?
Date: Sat, 11 Feb 2006 11:32:00 -0800
Message-ID: <7vhd75n13j.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602081532360.2458@g5.osdl.org>
	<Pine.LNX.4.64.0602091029310.2458@g5.osdl.org>
	<7v3bisb9qn.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602091216460.2458@g5.osdl.org>
	<Pine.LNX.4.64.0602091235210.2458@g5.osdl.org>
	<7v8xsk9s3v.fsf@assigned-by-dhcp.cox.net>
	<7v4q389rwi.fsf@assigned-by-dhcp.cox.net>
	<7voe1g8air.fsf@assigned-by-dhcp.cox.net>
	<7vk6c48a69.fsf@assigned-by-dhcp.cox.net>
	<7v3bis88y9.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550602110117i7b742351m14e908de10aac12c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 11 20:32:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F80Ta-0003OT-Fo
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 20:32:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWBKTcE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 14:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbWBKTcE
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 14:32:04 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:43720 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S964782AbWBKTcB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2006 14:32:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060211192850.QRXD17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 11 Feb 2006 14:28:50 -0500
To: Marco Costalba <mcostalba@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15962>

Marco Costalba <mcostalba@gmail.com> writes:

> On 2/9/06, Junio C Hamano <junkio@cox.net> wrote:
>>
>> Does it matter?  I presume that a Porcelain that cares would
>> rather use the traditional "diff-tree -m -r" to look at diff
>> with each parent.  I dunno.
>
> Yes, please preserve this behaviour.
>...
> Please _do not_ change this behaviour to make -m a no-op as stated in
> "diff-tree -c raw output" patch message
> (ee63802422af14e43eccce3c6dc4150a27ceb1a3).

The one you pulled already contains another one to fix that
ee6380 change done by gittus.  What "diff-tree -r -m ca1820"
shows should be the same as traditional "diff-tree -r -m ca1820"
output.

What is different is "diff-tree ca1820".  It used to show
*nothing* only because it is a merge.  It now defaults to show
"diff-tree -c ca1820".

For the sake of backward compatibility we could change it to not
output anything, but I sort of feel that is backwards.  If a
Porcelain wants raw-diff for 1 (or more) parents, "diff-tree -r
-m" has been the way to do so before the ee6380 change, and that
output has not changed (well ee6380 might have changed it but
now it is fixed).
