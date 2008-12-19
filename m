From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH] git-send-email: handle email address with quoted comma
Date: Fri, 19 Dec 2008 16:28:58 +0000 (UTC)
Message-ID: <loom.20081219T162504-25@post.gmane.org>
References: <1229658012-9240-1-git-send-email-fengguang.wu@intel.com> <7vej04d5wy.fsf@gitster.siamese.dyndns.org> <20081219081010.GA12494@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 20 09:21:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDx5b-0002Ty-UJ
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 09:21:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337AbYLTIUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 03:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753334AbYLTIUK
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 03:20:10 -0500
Received: from main.gmane.org ([80.91.229.2]:60775 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753253AbYLTIUI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 03:20:08 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LDx46-0007IJ-M2
	for git@vger.kernel.org; Sat, 20 Dec 2008 08:20:06 +0000
Received: from 134.217.96.252 ([134.217.96.252])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 20 Dec 2008 08:20:02 +0000
Received: from kraai by 134.217.96.252 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 20 Dec 2008 08:20:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 134.217.96.252 (Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103633>

Howdy,

Wu Fengguang <fengguang.wu <at> intel.com> writes:
> +sub split_addrs {
> +	return parse_line('\s*,\s*', 1, @_);
> +}
> +

I'm not sure it's still a good idea to use parse_line.  It should work OK for
now, since split_addrs is only passed one string.  If anyone ever tries to pass
it a list of strings, however, parse_line will ignore all but the first.

-- 
Matt
