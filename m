From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH 2/2] builtin-tag.c: use valid_ident for checking tagger
 field
Date: Sun, 11 May 2008 11:39:58 -0700
Message-ID: <7vhcd43csh.fsf@gitster.siamese.dyndns.org>
References: <1210309416-27787-1-git-send-email-author@example.com>
 <9526336.1210309346451.JavaMail.teamon@b304.teamon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: drafnel@gmail.com
X-From: git-owner@vger.kernel.org Sun May 11 20:41:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvGTn-0001tf-9W
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 20:41:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756944AbYEKSkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 14:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756922AbYEKSkM
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 14:40:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60632 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756894AbYEKSkL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 14:40:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1A6232BE4;
	Sun, 11 May 2008 14:40:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 63F602BE1; Sun, 11 May 2008 14:40:05 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AF2D8070-1F89-11DD-8A61-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81812>

drafnel@gmail.com writes:

> From: Brandon Casey <drafnel@gmail.com>
>
> Use valid_ident function for validating the tagger field
> in generated tags rather than a tag specific version.
>
> Also update tests.
>
> Signed-off-by: Brandon Casey <drafnel@gmail.com>
> ---
>  builtin-tag.c    |   39 +++++----------------------------------
>  t/t3800-mktag.sh |   14 +++++++-------
>  2 files changed, 12 insertions(+), 41 deletions(-)
>
> diff --git a/builtin-tag.c b/builtin-tag.c
> index 0f79d47..2dcb795 100644
> --- a/builtin-tag.c
> +++ b/builtin-tag.c
> @@ -339,8 +339,7 @@ static int verify_tag_buffer(const char *buffer, size_t size)
>  	int typelen;
>  	char type[20];

Funny.

This [2/2] seems to depend on [3/5] that renames verify_tag to verify_tag_buffer().

What is going on?
