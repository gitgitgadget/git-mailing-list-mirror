From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH v6 4/4] git-rebase: add keep_empty flag
Date: Wed, 18 Apr 2012 06:50:09 -0400
Message-ID: <20120418105009.GD22172@hmsreliant.think-freely.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334686809-17634-1-git-send-email-nhorman@tuxdriver.com>
 <1334686809-17634-5-git-send-email-nhorman@tuxdriver.com>
 <20120417214659.GC19908@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Apr 18 12:50:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKSSr-0003V9-Jo
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 12:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830Ab2DRKuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 06:50:15 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:35033 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362Ab2DRKuO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 06:50:14 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SKSSg-0004VW-DF; Wed, 18 Apr 2012 06:50:12 -0400
Content-Disposition: inline
In-Reply-To: <20120417214659.GC19908@ecki>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195855>

On Tue, Apr 17, 2012 at 11:47:01PM +0200, Clemens Buchacher wrote:
> On Tue, Apr 17, 2012 at 02:20:09PM -0400, Neil Horman wrote:
> >
> > @@ -780,9 +793,17 @@ git rev-list $merges_option --pretty=oneline --abbrev-commit \
> >  	sed -n "s/^>//p" |
> >  while read -r shortsha1 rest
> >  do
> > +
> > +	if test -z "$keep_empty" && is_empty_commit $shortsha1
> > +	then
> > +		comment_out="# pick"
> > +	else
> > +		comment_out="pick"
> > +	fi
> 
> You forgot to change this to comment_out="# " and comment_out="".
> 

Thanks, I'll fix that up when I modify the keep-redundant-commits commit message
Neil
