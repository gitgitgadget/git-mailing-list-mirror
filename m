From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/4] fast-import: put option parsing code in seperate
 functions
Date: Thu, 13 Aug 2009 12:19:28 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908131208400.7429@intel-tinevez-2-302>
References: <1250140186-12363-1-git-send-email-srabbelier@gmail.com> <1250140186-12363-2-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 12:19:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbXPL-0008AC-IW
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 12:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbZHMKTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 06:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbZHMKTc
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 06:19:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:37854 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751012AbZHMKTc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 06:19:32 -0400
Received: (qmail invoked by alias); 13 Aug 2009 10:19:31 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp013) with SMTP; 13 Aug 2009 12:19:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+S4CQIbiKSVMCXhELiF46Q/97eIZTqX4nRt0pObN
	3r0jdTGLYvR1vU
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1250140186-12363-2-git-send-email-srabbelier@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125793>

Hi,

On Wed, 12 Aug 2009, Sverre Rabbelier wrote:

> +static void option_export_marks(const char *marks)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	strbuf_addstr(&buf, marks);
> +	mark_file = strbuf_detach(&buf, NULL);
> +}

Heh, this is a pretty convoluted way to write

	mark_file = xstrdup(marks);

;-)

> +static void option_force()
> +{
> +	force_update = 1;
> +}

I'm not sure that I would put these simple assignments in separate 
functions, but that's certainly up to you!

Thanks,
Dscho
