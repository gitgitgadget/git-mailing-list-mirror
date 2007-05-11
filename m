From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] [TRIVIAL] Change default man page path to /usr/share/man
Date: Fri, 11 May 2007 12:27:35 -0700
Message-ID: <7v646zb1p4.fsf@assigned-by-dhcp.cox.net>
References: <200705081349.34964.ismail@pardus.org.tr>
	<200705112025.58095.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ismail =?utf-8?Q?D=C3=B6nmez?= <ismail@pardus.org.tr>
X-From: git-owner@vger.kernel.org Fri May 11 21:27:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmamL-00088C-0K
	for gcvg-git@gmane.org; Fri, 11 May 2007 21:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756744AbXEKT1k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 11 May 2007 15:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755477AbXEKT1k
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 15:27:40 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:57940 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756744AbXEKT1j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 May 2007 15:27:39 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070511192739.ZZTB6556.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Fri, 11 May 2007 15:27:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xvTd1W00c1kojtg0000000; Fri, 11 May 2007 15:27:38 -0400
In-Reply-To: <200705112025.58095.ismail@pardus.org.tr> (Ismail =?utf-8?Q?D?=
 =?utf-8?Q?=C3=B6nmez's?=
	message of "Fri, 11 May 2007 20:25:57 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46973>

Ismail D=C3=B6nmez <ismail@pardus.org.tr> writes:

> On Tuesday 08 May 2007 13:49:31 you wrote:
>> Hi,
>>
>> According to FHS standard default man page path is $prefix/share/man=
 [0] ,
>> attached patch fixes this for GIT.
>>
>> [0] http://www.pathname.com/fhs/pub/fhs-2.3.html#USRSHAREMANMANUALPA=
GES
>>
>> Signed-off-by: Ismail Donmez <ismail@pardus.org.tr>
>
> ACK? NAK? Do we care about this? :)

I would not say the patch is wrong per-se, but:

 - People who do not override prefix to install in $HOME would
   suddenly get their mandir under $HOME/share/man; the fact
   nobody complained so far suggests me that these people have
   $MANPATH pointing at $HOME/man, which means your patch breaks
   things for them, unless they have been overriding mandir in
   which case your patch does not matter to them;

 - Distros who package git and want to conform to FHS would have
   been overriding not just prefix but mandir anyway, so your patch
   is not an improvement to them;

 - People who override prefix to install locally in /usr or
   /usr/local does "make prefix=3D" thing anyway, and the fact
   nobody complained so far suggests me that they have already
   known they need to override mandir as well if they do not
   like /usr/local/man, so your patch is not an improvement to
   them.

That makes one half negative plus two and half neutral.
