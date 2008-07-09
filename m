From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] git-imap-send: Allow the program to be run from
 subdirectories of a git tree.
Date: Tue, 08 Jul 2008 18:15:32 -0700
Message-ID: <7v3amjq2mj.fsf@gitster.siamese.dyndns.org>
References: <1215555496-21335-1-git-send-email-robertshearman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert Shearman <robertshearman@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 03:16:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGOIT-0001Fh-B1
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 03:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbYGIBPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 21:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752132AbYGIBPo
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 21:15:44 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47571 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbYGIBPo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 21:15:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 61D1816D62;
	Tue,  8 Jul 2008 21:15:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B830416D60; Tue,  8 Jul 2008 21:15:34 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 89B48688-4D54-11DD-8D54-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87825>

Robert Shearman <robertshearman@gmail.com> writes:

> Call setup_git_directory_gently to allow git-imap-send to be used from subdirectories of a git tree.
> ---
>  imap-send.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/imap-send.c b/imap-send.c
> index 1ec1310..89a1532 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1296,6 +1296,7 @@ main(int argc, char **argv)
>  	/* init the random number generator */
>  	arc4_init();
>  
> +	setup_git_directory_gently( NULL );
>  	git_config(git_imap_config, NULL);
>  
>  	if (!imap_folder) {

I thought Jeff already explained why this NULL was a bad idea, but perhaps
I was dreaming...

Besides, the extra spaces around the argument is very distracting.
