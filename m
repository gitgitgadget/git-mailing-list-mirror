From: "Jon Nelson" <jnelson@jamponi.net>
Subject: Re: [PATCH] fix pack.packSizeLimit and --max-pack-size handling
Date: Wed, 12 Nov 2008 11:58:29 -0600
Message-ID: <cccedfc60811120958u3e1625e4y4ffee1d073102ab8@mail.gmail.com>
References: <cccedfc60811120712o7fcbf648l9f4b8e6f52e50e39@mail.gmail.com>
	 <alpine.LFD.2.00.0811121109420.27509@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Nov 12 18:59:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0K0I-0001x6-FY
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 18:59:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbYKLR6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 12:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751975AbYKLR6b
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 12:58:31 -0500
Received: from rn-out-0910.google.com ([64.233.170.185]:52291 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbYKLR6b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 12:58:31 -0500
Received: by rn-out-0910.google.com with SMTP id k40so452631rnd.17
        for <git@vger.kernel.org>; Wed, 12 Nov 2008 09:58:30 -0800 (PST)
Received: by 10.65.212.17 with SMTP id o17mr8991245qbq.60.1226512709388;
        Wed, 12 Nov 2008 09:58:29 -0800 (PST)
Received: by 10.65.107.14 with HTTP; Wed, 12 Nov 2008 09:58:29 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0811121109420.27509@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100787>

On Wed, Nov 12, 2008 at 10:17 AM, Nicolas Pitre <nico@cam.org> wrote:
> First, pack.packSizeLimit and --max-pack-size didn't use the same base
> unit which was confusing.  They both use MiB now.
>
> Also, if the limit was sufficiently low, having a single object written
> could bust the limit (by design), but caused the remaining allowed size
> to go negative for subsequent objects, which for an unsigned variable is
> a rather huge limit.
>
> Signed-off-by: Nicolas Pitre <nico@cam.org>

The patch does appear to resolve the issue!

-- 
Jon
