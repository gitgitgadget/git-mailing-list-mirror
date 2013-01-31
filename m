From: Jeff King <peff@peff.net>
Subject: Re: Segmentation fault with latest git (070c57df)
Date: Thu, 31 Jan 2013 01:49:21 -0500
Message-ID: <20130131064921.GB24660@sigill.intra.peff.net>
References: <28799936.346521359596121253.JavaMail.weblogic@epmltmp3>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jongman Heo <jongman.heo@samsung.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 07:49:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0nxy-0000nE-ME
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 07:49:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189Ab3AaGtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 01:49:25 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54452 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750851Ab3AaGtY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 01:49:24 -0500
Received: (qmail 3813 invoked by uid 107); 31 Jan 2013 06:50:47 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 31 Jan 2013 01:50:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Jan 2013 01:49:21 -0500
Content-Disposition: inline
In-Reply-To: <28799936.346521359596121253.JavaMail.weblogic@epmltmp3>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215100>

On Thu, Jan 31, 2013 at 01:35:21AM +0000, Jongman Heo wrote:

> Looks like following commit causes a segmentation fault in my machine
> (when running git pull or git fetch);
> 
> commit 8dd5afc926acb9829ebf56e9b78826a5242cd638
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Mon Jan 7 12:24:55 2013 -0800
> 
>     string-list: allow case-insensitive string list
> 
> 
> In my case, list->cmp (at get_entry_index() function) has an invalid
> address, obviously not an address of string comparision function,
> instead it points to 1.

Can you show us a stack trace? The string-list functions are generic and
get called in a lot of places. It would be useful to know which list is
causing the problem.

-Peff
