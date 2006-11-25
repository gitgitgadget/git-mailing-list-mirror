X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD] making separate-remote layout easier to use
Date: Sat, 25 Nov 2006 15:19:44 -0800
Message-ID: <7vvel3yuzz.fsf@assigned-by-dhcp.cox.net>
References: <7v1wnr19do.fsf@assigned-by-dhcp.cox.net>
	<ekafpm$fs7$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 25 Nov 2006 23:19:58 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <ekafpm$fs7$1@sea.gmane.org> (Jakub Narebski's message of "Sat,
	25 Nov 2006 23:25:35 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32307>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Go6oJ-0002yt-LL for gcvg-git@gmane.org; Sun, 26 Nov
 2006 00:19:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966964AbWKYXTr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 18:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935211AbWKYXTr
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 18:19:47 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:61391 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S935201AbWKYXTq
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 18:19:46 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061125231946.SOJQ5465.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>; Sat, 25
 Nov 2006 18:19:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id rBKE1V00K1kojtg0000000; Sat, 25 Nov 2006
 18:19:15 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Now separate-remote layout is the default for newly cloned
>> repositories, I think it is a good time to make further effort
>> to make things easier to use.  Here are some of the ideas off
>> the top of my head.
> [...]
>> * Change the default contents of $GIT_DIR/remotes/origin
>
> The question is: do we continue to use remotes/ file, or do we
> save remotes info in the config file: remote.<name>.url,
> remote.<name>.fetch, remote.<name>.push and branch.<name>.merge
> (in our case '[remote "origin"]' section)?

It is not "the question"; it is irrelevant because
$GIT_DIR/remotes/origin and [remote "origin"] are pretty much
interchangeable, and will hopefully continue to be.

        [remote "origin"]
                url = master.kernel.org:/pub/scm/git/git.git/
                fetch = +refs/heads/master:refs/remotes/origin/master
                fetch = +refs/heads/*:refs/remotes/origin/*

would be the way to express the equilvalent of the example in
the previous message.



