From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add --show-size to git log to print message size
Date: Mon, 16 Jul 2007 10:50:30 -0700
Message-ID: <7v4pk444rd.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550707140952hb60735bi95a4f03636c4aa99@mail.gmail.com>
	<7vodiehko7.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550707160504p52770227l9af66aa750d9efd6@mail.gmail.com>
	<81b0412b0707160531mad35ed4x4c89b2d6c6f5f707@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Marco Costalba" <mcostalba@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 19:50:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAUiR-0006j6-QV
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 19:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbXGPRuc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 13:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbXGPRuc
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 13:50:32 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:57485 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbXGPRub (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 13:50:31 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070716175030.GDLB1349.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 16 Jul 2007 13:50:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id QHqW1X00K1kojtg0000000; Mon, 16 Jul 2007 13:50:31 -0400
In-Reply-To: <81b0412b0707160531mad35ed4x4c89b2d6c6f5f707@mail.gmail.com>
	(Alex Riesen's message of "Mon, 16 Jul 2007 14:31:36 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52698>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> On 7/16/07, Marco Costalba <mcostalba@gmail.com> wrote:
>> Currently the patch just include the log message because the diff
>> content (-p option) is not buffered but is written with a combination
>> of printf, puts, fputs, fwrite and putchar directly to stdout.
>>
>> My question is, there is a way to get the quantity of bytes written to
>> stdout before they are printed? I'm not an expert of C stdio library,
>> so perhaps this is nonsense, but I was thinking of reading the size of
>> stout buffer before to fflush() (I don't know if it is possible).
>
> It is not possible. Buffers can be flushed at any time (i.e. they are
> flushed when EOL reached and the output is a terminal for stdout).
>
> It is also a bit unclear _why_ do you need the diff output. You don't
> show it immediately anyway.

I'd say making --show-message-size option incompatible with diff output
would be good enough futureproofing for now.
