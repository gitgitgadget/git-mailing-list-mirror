From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Cannot rewrite branch(es) with a dirty working directory
Date: Fri, 02 Sep 2011 07:52:16 +0200
Message-ID: <vpqpqjjlcdr.fsf@bauges.imag.fr>
References: <CACyv8dfL-G0Px0aFe3VFNHP-1xRUDLsFxgUu3amPGzO7qKp7jQ@mail.gmail.com>
	<vpqmxeoqj61.fsf@bauges.imag.fr>
	<20110901215003.GC16308@sigill.intra.peff.net>
	<20110901215306.GD16308@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	James Blackburn <jamesblackburn@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 02 07:52:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzMgD-0003po-Rs
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 07:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753304Ab1IBFwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 01:52:31 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60360 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752388Ab1IBFwb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 01:52:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p825pUdK005880
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 2 Sep 2011 07:51:30 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QzMfp-0000sh-3t; Fri, 02 Sep 2011 07:52:17 +0200
In-Reply-To: <20110901215306.GD16308@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 1 Sep 2011 17:53:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 02 Sep 2011 07:51:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p825pUdK005880
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1315547497.15291@B5aTriX1YVzuSmu/HnZ0ew
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180597>

Jeff King <peff@peff.net> writes:

> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -108,9 +108,7 @@ OPTIONS_SPEC=
>  . git-sh-setup
>  
>  if [ "$(is_bare_repository)" = false ]; then
> -	git diff-files --ignore-submodules --quiet &&
> -	git diff-index --cached --quiet HEAD -- ||
> -	die "Cannot rewrite branch(es) with a dirty working directory."
> +	require_clean_work_tree 'rewrite branches'
>  fi
>  
>  tempdir=.git-rewrite

Sounds good, yes.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
