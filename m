From: Robie Basak <robie.basak@canonical.com>
Subject: Re: [PATCH] apply: squash consecutive slashes with p_value > 0
Date: Thu, 17 Nov 2011 18:57:19 +0000
Message-ID: <20111117185718.GE17472@mal.justgohome.co.uk>
References: <20111116120403.GA10342@mal.justgohome.co.uk>
 <7v62ikq89h.fsf@alter.siamese.dyndns.org>
 <20111117150409.GB17472@mal.justgohome.co.uk>
 <7vr516myqh.fsf@alter.siamese.dyndns.org>
 <20111117175544.GC17472@mal.justgohome.co.uk>
 <7vmxbumxls.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 17 19:57:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RR79L-0004Nj-6p
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 19:57:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754264Ab1KQS5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Nov 2011 13:57:22 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36863 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485Ab1KQS5W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 13:57:22 -0500
Received: from 107.27.187.81.in-addr.arpa ([81.187.27.107] helo=localhost)
	by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71)
	(envelope-from <robie.basak@canonical.com>)
	id 1RR79D-0002co-VD; Thu, 17 Nov 2011 18:57:20 +0000
Content-Disposition: inline
In-Reply-To: <7vmxbumxls.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185604>

On Thu, Nov 17, 2011 at 10:07:27AM -0800, Junio C Hamano wrote:
> If that is the case, I would rather say we should even shoot for
> simpler. Just tell the patch generator not to include unneeded double
> slashes.

I don't have a choice about the patch generator. These are humans typing
"diff -ur foo.orig/ foo/" which I think is reasonable.

IMHO, this is a bug in git-apply's -p behaviour. It's not so much about
stripping double slashes; more about doing the -p split in the middle of
the doubled slashes rather than the end. patch does the right thing.
