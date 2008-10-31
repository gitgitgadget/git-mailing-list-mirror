From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git show <tree>: show mode and hash, and handle -r
Date: Fri, 31 Oct 2008 10:37:33 -0700
Message-ID: <7vk5bo8y3m.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0810290207330.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <7vtzatdbtk.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0810311753080.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, schacon@gmail.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 31 18:39:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvxxj-0003IU-Tb
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 18:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbYJaRhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 13:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbYJaRhy
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 13:37:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43628 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbYJaRhy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 13:37:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4BB5977448;
	Fri, 31 Oct 2008 13:37:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BA3CD77445; Fri, 31 Oct 2008 13:37:42 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0810311753080.22125@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes
 Schindelin's message of "Fri, 31 Oct 2008 17:55:03 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A424E292-A772-11DD-8E63-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99612>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Thu, 30 Oct 2008, Junio C Hamano wrote:
>
>> I wonder if it would help breaking down cmd_log_init() a bit like this.
>
> Sorry, I am quite busy (this is the first time I am able to check my mail 
> since the GitTogether), so I cannot look at that in detail.
>
> However, I strongly expect your suggestion not to help: for showing 
> commits, we _want_ recursive to be the default.  And switching that on 
> devoids us from being able to DIFF_OPT_TST(.., RECURSIVE) to detect if the 
> user said '-r' _explicitely_.

You can turn on recursive unconditionally for the normal "show committish"
case, and check for explicit "-r" for "show treeish" that was bolted-on
much later, can't you?
