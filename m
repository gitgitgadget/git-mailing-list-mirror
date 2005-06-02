From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Find size of SHA1 object without inflating everything.
Date: Thu, 02 Jun 2005 15:47:21 -0700
Message-ID: <7vis0w1ime.fsf@assigned-by-dhcp.cox.net>
References: <7vy89ums2l.fsf@assigned-by-dhcp.cox.net>
	<7vis0xkjn4.fsf@assigned-by-dhcp.cox.net>
	<7v4qcg906f.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506020959250.1876@ppc970.osdl.org>
	<7vwtpc60z3.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506021508020.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 00:49:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdyUQ-0007Ce-KQ
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 00:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVFBWvI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 18:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVFBWr7
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 18:47:59 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:29640 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261558AbVFBWra (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2005 18:47:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050602224722.KBFL1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 2 Jun 2005 18:47:22 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506021508020.1876@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 2 Jun 2005 15:10:11 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Thu, 2 Jun 2005, Junio C Hamano wrote:
>> 
>> +int sha1_file_size(const unsigned char *sha1, unsigned long *sizep)
LT> ...
>> +	ret = unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr));
LT> ...
>> +	delta_data_head = unpack_sha1_rest(&stream, hdr, 200);

LT> Why do you do this?

Because I was not thinking when I wrote "char hdr[1024]".  

Nico pointed out the same problem and you have a fixed version
of both in your mailbox.




