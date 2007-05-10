From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCHv2] connect: display connection progress
Date: Thu, 10 May 2007 12:29:20 -0700
Message-ID: <7v7irgjx4f.fsf@assigned-by-dhcp.cox.net>
References: <20070506195230.GA30339@mellanox.co.il>
	<7vhcqpbs78.fsf@assigned-by-dhcp.cox.net>
	<20070510095156.GC13655@mellanox.co.il>
	<81b0412b0705100439j4e6b072bk1ba19a4f971e5d0c@mail.gmail.com>
	<20070510120802.GG13655@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Thu May 10 21:29:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmEKN-0004gK-0z
	for gcvg-git@gmane.org; Thu, 10 May 2007 21:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148AbXEJT3W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 15:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753656AbXEJT3W
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 15:29:22 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:52051 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148AbXEJT3V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 15:29:21 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070510192922.OCQW22040.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Thu, 10 May 2007 15:29:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xXVL1W00f1kojtg0000000; Thu, 10 May 2007 15:29:21 -0400
In-Reply-To: <20070510120802.GG13655@mellanox.co.il> (Michael S. Tsirkin's
	message of "Thu, 10 May 2007 15:08:02 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46888>

"Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:

>> Quoting Alex Riesen <raa.lkml@gmail.com>:
>> Subject: Re: [PATCHv2] connect: display connection progress
>> 
>> On 5/10/07, Michael S. Tsirkin <mst@dev.mellanox.co.il> wrote:
>> >-static int git_tcp_connect_sock(char *host)
>> >+static int git_tcp_connect_sock(char *host, int flags)
>> 
>> There is only one bit of flags ever used. What are the others for?
>
> Hmm, I thought it's easier to read 
> git_tcp_connect_sock(host, NET_QUIET)
> 	than
> git_tcp_connect_sock(host, 1)
>
> but maybe that's overdesign.
>
>> Why use negative logic?
>> What was wrong with plain "int verbose"?
>
> I want the default to report connections, and -q
> to silence them. Maybe "int quiet"?

I would really feel this extra verbosity should not be the
default.   Thanks.
