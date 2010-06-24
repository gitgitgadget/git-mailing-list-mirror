From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-cat-file.txt: Document --textconv
Date: Thu, 24 Jun 2010 13:53:57 +0200
Message-ID: <vpqmxukir3e.fsf@bauges.imag.fr>
References: <2251bbc1e40505dcb80103bf5daebea07dc0e9f7.1277374210.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jun 24 14:01:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORl7Y-0007BA-HQ
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 14:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755233Ab0FXMBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 08:01:24 -0400
Received: from imag.imag.fr ([129.88.30.1]:38614 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754171Ab0FXMBX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 08:01:23 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o5OBrvFh025732
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 24 Jun 2010 13:53:57 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1ORl0H-0007s0-Mm; Thu, 24 Jun 2010 13:53:57 +0200
In-Reply-To: <2251bbc1e40505dcb80103bf5daebea07dc0e9f7.1277374210.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Thu\, 24 Jun 2010 12\:14\:49 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 24 Jun 2010 13:53:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149585>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> This formulation is based on my understanding that you can't cat-file
>  --textconv something in the index or worktree.

Actually, you can't textconv from the worktree, but you can from the
index, saying

git cat-file --textconv :path/to/file

(the :<path> syntax is not specific here, you can use it in other Git
commands)

> +--textconv::
> +	Show the content as transformed by a textconv filter. In this case,
> +	<object> has be of the form <treeish:path>, with treeish defaulting to
> +	HEAD.

So the "defaulting to HEAD" is incorrect. Also, I prefer
<treeish>:<path> to <treeish:path>, to make it clear the : is actually
a :.

What about this:

--textconv:: 
	Show the content as transformed by a textconv filter. In this
	case, <object> has be of the form <treeish>:<path>, or :<path>
	to run the filter on the file <path> stored in the index.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
