From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] index-pack: correctly initialize appended objects
Date: Fri, 25 Jul 2008 12:24:47 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807251219530.11976@eeepc-johanness>
References: <alpine.DEB.1.00.0807241821440.8986@racer> <7vy73q4jzp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, spearce@spearce.org,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 12:24:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMKTn-00009F-G7
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 12:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382AbYGYKXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 06:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbYGYKXu
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 06:23:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:38401 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752566AbYGYKXt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 06:23:49 -0400
Received: (qmail invoked by alias); 25 Jul 2008 10:23:47 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp006) with SMTP; 25 Jul 2008 12:23:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19fuTZ8bpdfZY8Mp5jlsueK7u4GY+DExMj9xXv2ki
	tLC5Sc1d7O7sTP
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vy73q4jzp.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90023>

Hi,

On Thu, 24 Jul 2008, Junio C Hamano wrote:

> The function does not seem to use type (which the patch is also setting) 
> nor real_type (which the patch does not set).
> 
> However, the code checks objects[nth].real_type all over the place in 
> the code.  Doesn't the lack of real_type assignment in 
> append_obj_to_pack() affect them in any way?

>From staring at the code, I thought that real_type was set in 
resolve_delta(), but I may be wrong.

The safer thing would be to set it, but I am not quite sure if we can use 
"type" directly, or if type can be "delta" for an object that is used to 
complete the pack, and therefore stored as a non-delta.

Ciao,
Dscho
