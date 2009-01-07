From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH 2/3] replace_object: add mechanism to replace objects
 found in "refs/replace/"
Date: Wed, 7 Jan 2009 13:29:27 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901071327481.7496@intel-tinevez-2-302>
References: <20090107084341.1554d8cd.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Jan 07 13:31:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKXYl-00020Y-M8
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 13:30:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbZAGM3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 07:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbZAGM3b
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 07:29:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:34408 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750713AbZAGM3b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 07:29:31 -0500
Received: (qmail invoked by alias); 07 Jan 2009 12:29:28 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp011) with SMTP; 07 Jan 2009 13:29:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19OJE95J8ROpMUYFX4X7BQNs96Ucs3PwNis/tXzJt
	tzNjW0ri054SXU
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090107084341.1554d8cd.chriscool@tuxfamily.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104791>

Hi,

On Wed, 7 Jan 2009, Christian Couder wrote:

> diff --git a/replace_object.c b/replace_object.c
> new file mode 100644
> index 0000000..b50890d
> --- /dev/null
> +++ b/replace_object.c
> @@ -0,0 +1,102 @@
> +#include "cache.h"
> +#include "refs.h"
> +
> +static struct replace_object {
> +	unsigned char sha1[2][20];
> +} **replace_object;
> +
> +static int replace_object_alloc, replace_object_nr;
> +
> +static int replace_object_pos(const unsigned char *sha1)
> +{
> +	int lo, hi;
> +	lo = 0;
> +	hi = replace_object_nr;
> +	while (lo < hi) {
> [...]

I suspect that this sorted list should be a hashmap.

Ciao,
Dscho
