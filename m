From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH 03/16] more tr portability test script fixes
Date: Thu, 13 Mar 2008 09:28:07 +0100
Message-ID: <20080313082807.GT10103@mail-vs.djpig.de>
References: <cover.1205356737.git.peff@peff.net> <20080312213106.GD26286@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Whit Armstrong <armstrong.whit@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 13 09:29:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZioE-0004Cd-BH
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 09:29:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbYCMI20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 04:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbYCMI20
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 04:28:26 -0400
Received: from pauli.djpig.de ([78.46.38.139]:50620 "EHLO pauli.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929AbYCMI2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 04:28:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by pauli.djpig.de (Postfix) with ESMTP id 9F49790073;
	Thu, 13 Mar 2008 09:28:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at pauli.djpig.de
Received: from pauli.djpig.de ([127.0.0.1])
	by localhost (pauli.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VStYGGuFB9Av; Thu, 13 Mar 2008 09:28:09 +0100 (CET)
Received: from mail-vs.djpig.de (mail-vs.djpig.de [78.47.136.189])
	by pauli.djpig.de (Postfix) with ESMTP id 2D8999006E;
	Thu, 13 Mar 2008 09:28:09 +0100 (CET)
Received: from djpig by mail-vs.djpig.de with local (Exim 4.63)
	(envelope-from <djpig@mail-vs.djpig.de>)
	id 1JZinI-0002V5-0t; Thu, 13 Mar 2008 09:28:08 +0100
Content-Disposition: inline
In-Reply-To: <20080312213106.GD26286@coredump.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77053>

On Wed, Mar 12, 2008 at 05:31:06PM -0400, Jeff King wrote:
> --- a/t/diff-lib.sh
> +++ b/t/diff-lib.sh
> @@ -21,8 +21,8 @@ compare_diff_raw_z () {
>      # Also we do not check SHA1 hash generation in this test, which
>      # is a job for t0000-basic.sh
>  
> -    tr '\000' '\012' <"$1" | sed -e "$sanitize_diff_raw_z" >.tmp-1
> -    tr '\000' '\012' <"$2" | sed -e "$sanitize_diff_raw_z" >.tmp-2
> +    perl -pe 'y/\000/\012/' <"$1" | sed -e "$sanitize_diff_raw_z" >.tmp-1
> +    perl -pe 'y/\000/\012/' <"$2" | sed -e "$sanitize_diff_raw_z" >.tmp-2

It might make sense performance-wise to integrate the job of the sed call into the perl
call here. Haven't tested it, though.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
