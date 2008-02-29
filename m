From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t6024-recursive-merge.sh: hide spurious output when
	not running verbosely
Date: Fri, 29 Feb 2008 17:53:31 -0500
Message-ID: <20080229225331.GA8440@coredump.intra.peff.net>
References: <1204323805-23185-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Feb 29 23:54:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVE7G-0007Fo-Pk
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 23:54:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755211AbYB2Wxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 17:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755094AbYB2Wxe
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 17:53:34 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4086 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752114AbYB2Wxe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 17:53:34 -0500
Received: (qmail 8865 invoked by uid 111); 29 Feb 2008 22:53:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 29 Feb 2008 17:53:32 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Feb 2008 17:53:31 -0500
Content-Disposition: inline
In-Reply-To: <1204323805-23185-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75584>

On Fri, Feb 29, 2008 at 11:23:25PM +0100, Mike Hommey wrote:

>  test_expect_success "virtual trees were processed" "git diff expect out"
>  
> -git reset --hard
> +git reset --hard >&3 2>&4
>  test_expect_success 'refuse to merge binary files' '
>  	printf "\0" > binary-file &&
>  	git add binary-file &&

Should this perhaps just be:

  test_expect_success 'reset state' 'git reset --hard'

?

-Peff
