From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] tests: make test_must_fail more verbose
Date: Tue, 31 Aug 2010 14:35:15 -0500
Message-ID: <20100831193515.GV2315@burratino>
References: <20100831155457.GB11014@sigill.intra.peff.net>
 <20100831155636.GA11530@sigill.intra.peff.net>
 <20100831171055.GO2315@burratino>
 <20100831180618.GB15020@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 31 21:37:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqWdr-00070d-NZ
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 21:37:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755295Ab0HaThG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 15:37:06 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46708 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718Ab0HaThE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 15:37:04 -0400
Received: by fxm13 with SMTP id 13so4219855fxm.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 12:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=waAzv2LFvlmqYTb+cAYpZnZSNq2Ulojl1U+CWZqpH2c=;
        b=U3DfPqjQajUWbX7rY1/qXYs+CNmP1oW3eQeV06eIEFh1m76FQP1rwQHHlAN6SjbH3B
         YuyFt8lct4KGWi/ZZlossARYuRGgb5iwtsxMFPS10PA2X/oDeq16kjWgtvylnlTV4hnc
         xQ82lTyOyYLqK4Y1AVlh20Shjj9miPeCH2NIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=P/r/Lsekw5n7Pq3QWfGy4giuz6s/W+TvYNQTjZcOyN6U0XxdV/kJ9/OXlTHrC6RLal
         o1ywuhTso8HWprkvoB0RYn0UmG0l9t6OIO3e4+YT7Otk0QJYOa7lh9bBR6iYtLY+CwRO
         H/ewjDm6SGtBLMDFdMbX/XSaCZgPYp8/fV5XI=
Received: by 10.223.105.14 with SMTP id r14mr6012025fao.33.1283283422391;
        Tue, 31 Aug 2010 12:37:02 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id b36sm4199150faq.35.2010.08.31.12.36.59
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 12:37:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100831180618.GB15020@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154975>

Jeff King wrote:
> On Tue, Aug 31, 2010 at 12:10:55PM -0500, Jonathan Nieder wrote:

>> Can the exit status (e.g. from a shell function) be negative?
>
> I don't believe so. Both bash and dash complain about "return -1" (and
> POSIX says the number must be "an unsigned decimal integer").

Thanks for checking; missed that.  It is clearer in POSIX that the
exit status from an external command will be truncated to an 8-bit
unsigned integer, which as you say is the most important thing.
