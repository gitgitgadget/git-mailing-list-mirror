From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH v2 1/4] Prevent diff machinery from examining 
 assume-unchanged entries on worktree
Date: Tue, 11 Aug 2009 08:45:21 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908110844160.4638@intel-tinevez-2-302>
References: <1249917562-5931-1-git-send-email-pclouds@gmail.com>  <1249917562-5931-2-git-send-email-pclouds@gmail.com> <alpine.DEB.1.00.0908101800480.8324@intel-tinevez-2-302> <fcaeb9bf0908101834n7cc7cfaakbf2d92fe8f32e9b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1715881235-1249973122=:4638"
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 14:16:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaqGx-0000RC-Rg
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 14:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbZHKMME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 08:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752488AbZHKMMD
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 08:12:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:35053 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751410AbZHKMMB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 08:12:01 -0400
Received: (qmail invoked by alias); 11 Aug 2009 06:45:21 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp051) with SMTP; 11 Aug 2009 08:45:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+WqMg6FK6WJFf8S4tToTXqRoOcVeeNpxhp3Fnr1o
	12QYWxX5Ed8okP
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <fcaeb9bf0908101834n7cc7cfaakbf2d92fe8f32e9b1@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125528>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1715881235-1249973122=:4638
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 11 Aug 2009, Nguyen Thai Ngoc Duy wrote:

> >> +test_expect_success 'diff-index does not examine assume-unchanged entries' '
> >> +     git diff-index HEAD^ -- one | grep -q 5626abf0f72e58d7a153368ba57db4c673c0e171
> >> +'
> >> +
> >> +# TODO ced_uptodate()
> >
> > What is this about?
> 
> It tests "if (ce_uptodate(ce) || (ce->ce_flags & CE_VALID))" and I was 
> pretty sure it hit ce_uptodate() first, so the second expression was not 
> tested.

Ah.  I was distracted by the "d" before the underscore.

ce_uptodate(ce) checks the time stamp amongst other things, right?  How 
about using test-chmtime to force an mtime mismatch?

Ciao,
Dscho

--8323329-1715881235-1249973122=:4638--
