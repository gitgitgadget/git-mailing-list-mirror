From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/8] Allow fetch to modify refs
Date: Fri, 4 Sep 2009 12:46:53 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909041243420.4605@intel-tinevez-2-302>
References: <alpine.LNX.2.00.0909032213260.28290@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Sep 04 12:47:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjWJw-0001LB-O3
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 12:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933563AbZIDKqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 06:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755793AbZIDKqx
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 06:46:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:35828 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755785AbZIDKqx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 06:46:53 -0400
Received: (qmail invoked by alias); 04 Sep 2009 10:46:53 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp021) with SMTP; 04 Sep 2009 12:46:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19MqdIxYDhMWTqjvjb7Qot4X1gpKx+F9FBJ37OI9F
	R4BpS9o2u14da+
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.LNX.2.00.0909032213260.28290@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127708>

Hi,

On Thu, 3 Sep 2009, Daniel Barkalow wrote:

> +	/**
> +	 * Fetch the objects for the given refs. Note that this gets
> +	 * an array, and should ignore the list structure.

This is not clear at all.  You should rather say "[...] and should not 
look at, or set, the 'next' member of the refs".

> +	 *
> +	 * If the transport did not get hashes for refs in
> +	 * get_refs_list(), it should set the old_sha1 fields in the
> +	 * provided refs now.

Not the "new_sha1"?

> +	 **/
> +	int (*fetch)(struct transport *transport, int refs_nr, struct ref **refs);
> +
> [...]
> +	/** get_refs_list(), fetch(), and push_refs() can keep

The "/**" wants to have a line to itself.

> +	 * resources (such as a connection) reserved for futher
> +	 * use. disconnect() releases these resources.
> +	 **/
>  	int (*disconnect)(struct transport *connection);
>  	char *pack_lockfile;
>  	signed verbose : 2;

Ciao,
Dscho
