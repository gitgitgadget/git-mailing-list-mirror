From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH/RFC 1/2] sha1_file: close all pack files after running
Date: Fri, 2 Oct 2015 22:21:48 +0300
Message-ID: <20151002192148.GD26154@wheezy.local>
References: <1443670163-31193-1-git-send-email-max@max630.net>
 <1443670163-31193-2-git-send-email-max@max630.net>
 <33b74e875c7298f67640f5850e88c152@dscho.org>
 <763ac2b63d56d250e5e1a27f490f79db@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Kirillov <max@max630.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 02 21:22:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zi5u1-0000Qt-Ap
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 21:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbbJBTVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 15:21:53 -0400
Received: from p3plsmtpa08-03.prod.phx3.secureserver.net ([173.201.193.104]:58352
	"EHLO p3plsmtpa08-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750911AbbJBTVw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Oct 2015 15:21:52 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa08-03.prod.phx3.secureserver.net with 
	id QKMo1r00D5B68XE01KMrd1; Fri, 02 Oct 2015 12:21:52 -0700
Content-Disposition: inline
In-Reply-To: <763ac2b63d56d250e5e1a27f490f79db@dscho.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278943>

On Fri, Oct 02, 2015 at 12:13:40PM +0200, Johannes Schindelin wrote:
> Hi Max,
> 
> On 2015-10-02 12:05, Johannes Schindelin wrote:
> 
> > On 2015-10-01 05:29, Max Kirillov wrote:
>>> When a builtin has done its job, but waits for pager or not waited
>>> by its caller and still hanging it keeps pack files opened.
>>> This can cause a number of issues, for example on Windows git gc
>>> cannot remove the packs.
> 
> Could you do me another favor? It seems that you want to
> work on this, so I will step back (I have to take off for
> the weekend very soon anyway, so I am really glad that you
> take care of it). But I would really love to see the line

As I explained in other message, your case is a bit
different.

I could add another call of close_all_packs() as a separate
commit with the "fixes" link, but I'm not so sure about it
if it turns out that additional efforts are required.

-- 
Max
