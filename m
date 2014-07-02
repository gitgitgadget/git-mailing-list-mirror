From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v2 2/2] git-merge-file: do not add LF at EOF while
 applying unrelated change
Date: Wed, 2 Jul 2014 07:44:28 +0300
Message-ID: <20140702044427.GA7325@wheezy.local>
References: <1403993086-15625-1-git-send-email-max@max630.net>
 <1403993086-15625-3-git-send-email-max@max630.net>
 <alpine.DEB.1.00.1406301650430.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 02 06:44:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2CPe-0002TH-Lj
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 06:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbaGBEou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 00:44:50 -0400
Received: from p3plsmtpa12-06.prod.phx3.secureserver.net ([68.178.252.235]:41383
	"EHLO p3plsmtpa12-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750893AbaGBEou (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jul 2014 00:44:50 -0400
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa12-06.prod.phx3.secureserver.net with 
	id MGkh1o00P3gsSd601Gkm4p; Tue, 01 Jul 2014 21:44:49 -0700
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1406301650430.14982@s15462909.onlinehome-server.info>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252766>

On Mon, Jun 30, 2014 at 04:55:10PM +0200, Johannes Schindelin wrote:
> I just wish the tests were a little easier to understand...

What could be improved with them?

> Having said that, here is my ACK for the current revision
> of the patch series

Thanks.

By the way, for "\r\n" eol it did even worse, adding just
"\n". And I guess it still adds just "\n" for union merge.
Should file merge consider the core.eol? I think it should,
and for the conflict markers also, it looks ugly when whole
file has "\r\n" but the conflict markers have "\n". But then
git-merge-file could not be used outside of repository, I
guess.

In general, I wish file merging (and diffing) were more
tolerant of the line endings in input. Because in windows
environment, when people have different core.autocrlf, it
becomes quite frustrating to always get conflicts and
changes.

-- 
Max
