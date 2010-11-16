From: Yann Dirson <ydirson@free.fr>
Subject: Re: [PATCH v3 1/3] Introduce sorted-array binary-search function.
Date: Tue, 16 Nov 2010 23:04:18 +0100
Message-ID: <20101116220418.GA3187@home.lan>
References: <1289255942-19705-1-git-send-email-ydirson@altern.org>
 <1289255942-19705-2-git-send-email-ydirson@altern.org>
 <7vy68ti3gr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 23:04:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PITdl-0001qe-68
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 23:04:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932764Ab0KPWEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 17:04:31 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:40927 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932609Ab0KPWEb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 17:04:31 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 26A24D48129;
	Tue, 16 Nov 2010 23:04:19 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PITdS-0007Aj-SO; Tue, 16 Nov 2010 23:04:18 +0100
Content-Disposition: inline
In-Reply-To: <7vy68ti3gr.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161589>

On Tue, Nov 16, 2010 at 09:27:16AM -0800, Junio C Hamano wrote:
> Yann Dirson <ydirson@altern.org> writes:
> 
> > We use a cpp-based template mechanism to declare the array and its
> > management data, as well as a search function, derived from locate_rename_dst()
> > from diffcore-rename.c.  Thanks to Jonathan Nieder for this design idea.
> 
> Hmmm.... Yet another binary search...

Well, not exactly another, it still generalizes code that was already here.

> Can we generalize the existing ones first before adding any of this in
> (hint: look for "git grep -w -e hi --and -e lo")?

With great pleasure.  I have simply missed those, only looking for the
pattern used in diffcore-rename.

Looking at a few ones, that seems just a matter of:
* refreshing my "[RFC] Add a sorted-list API for use-cases that
  require to get the element index." from v2 series
* adding support for more than one func, which I already required for
  bulk-rename
