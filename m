From: Martin Langhoff <martin@catalyst.net.nz>
Subject: Re: [PATCH] cvsexportcommit: be graceful when "cvs status" reorders
 the arguments
Date: Tue, 19 Feb 2008 05:33:31 +1300
Message-ID: <47B9B35B.7040200@catalyst.net.nz>
References: <alpine.LSU.1.00.0802180127100.30505@racer.site> <7vbq6fvudp.fsf@gitster.siamese.dyndns.org> <7vwsp3uf0u.fsf@gitster.siamese.dyndns.org> <47B9A354.7070905@catalyst.net.nz> <alpine.LSU.1.00.0802181624490.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 18 17:35:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR8wt-0005z1-O7
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 17:34:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755137AbYBRQeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 11:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbYBRQeB
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 11:34:01 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:36925 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858AbYBRQeA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 11:34:00 -0500
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=[127.0.0.1])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <martin@catalyst.net.nz>)
	id 1JR8w8-0003Er-4K; Tue, 19 Feb 2008 05:33:48 +1300
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <alpine.LSU.1.00.0802181624490.30505@racer.site>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74309>

Johannes Schindelin wrote:
> Note that for this reason, only the "File:" output -- which does not show 
> slashes, but only the basenames -- is used to match the files.  We need 
> the full path in the git repository, though, to apply the patches.

Yes - that's ugly. We have a couple of options

 - Run cvs status once per directory we touch. Use -l tomake it
non-recursive. It will be a tad slower/chattier.

 - Parse the 'Repository revision:' line to find out what path on the
server matches our repo 'root'.

> Thanks.  I am confident that I will have posted another version by the 
> time you come around to review it.

Great! Careful, you might end up enjoying Perl ;-)



m
-- 
