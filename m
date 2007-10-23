From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 0/9] Make git-svn fetch ~1.7x faster
Date: Tue, 23 Oct 2007 08:08:13 +0200
Organization: glandium.org
Message-ID: <20071023060812.GA30978@glandium.org>
References: <1193118397-4696-1-git-send-email-aroben@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Tue Oct 23 08:09:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkCxV-0003v5-7f
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 08:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbXJWGJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 02:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbXJWGJd
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 02:09:33 -0400
Received: from vawad.err.no ([85.19.200.177]:54769 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751283AbXJWGJc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 02:09:32 -0400
Received: from aputeaux-153-1-14-141.w82-124.abo.wanadoo.fr ([82.124.56.141] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IkCxE-0000LG-Jz; Tue, 23 Oct 2007 08:09:29 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IkCw1-00083r-5d; Tue, 23 Oct 2007 08:08:13 +0200
Content-Disposition: inline
In-Reply-To: <1193118397-4696-1-git-send-email-aroben@apple.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62108>

On Mon, Oct 22, 2007 at 10:46:28PM -0700, Adam Roben wrote:
> 
> This patch series makes git-svn fetch about 1.7x faster by reducing the number
> of forks/execs that occur for each file retrieved from Subversion. To do so, a
> few new options are added to git-cat-file and git-hash-object to allow
> continuous input on stdin and continuous output on stdout, so that one instance
> of each of these commands can be kept running for the duration of the fetch.

You don't need to do this to avoid forks. Just use git-fast-import
instead.

Mike
