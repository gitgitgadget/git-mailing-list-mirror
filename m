From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix git_setup_directory_gently when GIT_DIR is set
Date: Mon, 05 Jun 2006 16:10:18 -0700
Message-ID: <7vk67v2o85.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0606051943540.29608@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vodx74ca9.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0606060053440.25344@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 06 01:10:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnODI-0001j2-2B
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 01:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWFEXKV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 19:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWFEXKV
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 19:10:21 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:30662 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750717AbWFEXKU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jun 2006 19:10:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060605231019.NNQE11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 5 Jun 2006 19:10:19 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606060053440.25344@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 6 Jun 2006 00:57:19 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21348>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Mon, 5 Jun 2006, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > When calling git_setup_directory_gently, and GIT_DIR was set, it just
>> > ignored the variable nongit_ok.
>> 
>> Hmph.  Is this really a breakage?  That is, gently() is meant
>> for a case where you do not know if you even find a git
>> repository and tell it not to complain because you are prepared
>> for the case where you are not in a git repository.
>
> Yes, it is a breakage: in git-clone, line 212, we explicitely set GIT_DIR 
> (to the not-yet-existing repository path), and call git-init-db. Now, with 
> the alias thing we need to get the config if it exists, so we _got_ to 
> call gently(). Boom.

Hmph.  Would it be a bug in clone that does not create GIT_DIR
then?
