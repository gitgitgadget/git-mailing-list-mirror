X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add verbose comments to split_msg()
Date: Mon, 11 Dec 2006 17:15:30 -0800
Message-ID: <7vzm9tzzgt.fsf@assigned-by-dhcp.cox.net>
References: <200612112212.51533.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 12 Dec 2006 01:15:40 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34052>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtwF6-0005jU-Pp for gcvg-git@gmane.org; Tue, 12 Dec
 2006 02:15:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750798AbWLLBPd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 20:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWLLBPd
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 20:15:33 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:54496 "EHLO
 fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1750798AbWLLBPc (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006
 20:15:32 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061212011531.VHTK18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Mon, 11
 Dec 2006 20:15:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id xdFi1V00V1kojtg0000000; Mon, 11 Dec 2006
 20:15:42 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> I was going to fix a bug in imap-send that was making it include the "From "
> line from git-format-patch in the message sent to the IMAP server.  So I
> commented up what split_msg already does.
>
> It turns out the bug was fixed in commit
> e0b0830726286287744cc9e1a629a534bbe75452.  So comments only, no fix needed.
> (cherry picked from 3d5b1768f15b5cd430b869f416e72f4f3afe3d4a commit)
>
> Signed-off-by: Andy Parkins <andyparkins@gmail.com>

3d5b1768 is not a public commit and is not useful information
other than your self.  Please omit the last line.

        Linus and everybody was right and I was wrong to leave this
        message default in git-cherry-pick for a long time.

> ---
>  imap-send.c |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
>
> diff --git a/imap-send.c b/imap-send.c
> index a6a6568..110bd54 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1216,35 +1216,48 @@ split_msg( msg_data_t *all_msgs, msg_data_t *msg, int *ofs )
>  {
>  	char *p, *data;
>  
> +	/* Clear this message's slot */
>  	memset( msg, 0, sizeof *msg );
> +	/* If we've run out of data, stop*/

"..., stop */"

>  	if (*ofs >= all_msgs->len)
>  		return 0;
>  
> +	/* Point at the next message chunk */
>  	data = &all_msgs->data[ *ofs ];
> +	/* This message length is at most, the length of all messages
> +	 * minus our current position */

Style?

/*
 * This message ...
 * ... position.
 */

>  	msg->len = all_msgs->len - *ofs;
>  
> +	/* If there isn't enough data remaining for a whole message or there
> +	 * is no , give up */

"there is no , "???
