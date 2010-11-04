From: Yann Dirson <ydirson@free.fr>
Subject: Re: [PATCH 1/4] Start to replace locate_rename_dst() with a
 generic function.
Date: Thu, 4 Nov 2010 22:22:04 +0100
Message-ID: <20101104212204.GC8911@home.lan>
References: <1288902795-8597-1-git-send-email-ydirson@altern.org>
 <1288902795-8597-2-git-send-email-ydirson@altern.org>
 <20101104204555.GA18187@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 22:22:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE7GE-0007f9-Cy
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 22:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152Ab0KDVWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 17:22:13 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:40677 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752960Ab0KDVWM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 17:22:12 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id B79FBD481BE;
	Thu,  4 Nov 2010 22:22:05 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PE7G0-0002La-Ip; Thu, 04 Nov 2010 22:22:04 +0100
Content-Disposition: inline
In-Reply-To: <20101104204555.GA18187@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160771>

On Thu, Nov 04, 2010 at 03:45:55PM -0500, Jonathan Nieder wrote:
>  static struct diff_rename_dst *locate_rename_dst(struct diff_filespec *two,
> 						  insert_ok)
>  {
> 	return locate_element(&rename_dst_nr, &rename_dst_alloc, elem, insert_ok);
>  }

The idea was to deprecate locate_rename_dst() itself and only use
locate_element()...

> takes more advantage of the compiler's typechecking and looks easy
> enough to read.

... but typechecking was something that was worrying me here.  Looks
like a good idea, after all.


> Since this is local to diffcore-rename, I don't mind the locate_element()
> name, but if this is to be used more widely I think it would need to be
> named more precisely.  (find_or_insert_in_array()?)

Yes - that's just a prototype.

> I guess these parentheses came from search+replace?  It's more
> readable without them.

Right, many of them are superfluous.
