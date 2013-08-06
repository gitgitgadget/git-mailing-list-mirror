From: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
Subject: Re: [[TIG][PATCH v2] 2/3] Display correct diff the context in split
 log view
Date: Tue, 06 Aug 2013 19:05:34 -0400
Message-ID: <20130806230534.GA11980@bluemoon.alumni.iitm.ac.in>
References: <1375765101-31461-1-git-send-email-a.kumar@alumni.iitm.ac.in>
 <1375765101-31461-3-git-send-email-a.kumar@alumni.iitm.ac.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
To: fonseca@diku.dk, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 07 01:05:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6qJx-0005Bc-KQ
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 01:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756815Ab3HFXFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 19:05:37 -0400
Received: from mta2.srv.hcvlny.cv.net ([167.206.4.197]:57860 "EHLO
	mta2.srv.hcvlny.cv.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756795Ab3HFXFh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 19:05:37 -0400
Received: from odessa (ool-18bb429a.dyn.optonline.net [24.187.66.154])
 by mta2.srv.hcvlny.cv.net
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPA id <0MR4009JZTHBZ320@mta2.srv.hcvlny.cv.net> for
 git@vger.kernel.org; Tue, 06 Aug 2013 19:05:36 -0400 (EDT)
Received: from kumar by odessa with local (Exim 4.80)
	(envelope-from <a.kumar@alumni.iitm.ac.in>)	id 1V6qJr-0003Kt-1J; Tue,
 06 Aug 2013 19:05:35 -0400
In-reply-to: <1375765101-31461-3-git-send-email-a.kumar@alumni.iitm.ac.in>
Mail-followup-to: fonseca@diku.dk, git@vger.kernel.org
Content-disposition: inline
X-OS: Linux odessa 3.3.0-trunk-amd64 x86_64
X-Operating-System: Linux odessa 3.3.0-trunk-amd64 x86_64
X-Editor: GNU Emacs 24.3.1
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231794>

On Tue, Aug 06, 2013 at 12:58:20AM -0400, Kumar Appaiah wrote:
>  tig-1.1
>  -------
> diff --git a/tig.c b/tig.c
> index 845153f..256b589 100644
> --- a/tig.c
> +++ b/tig.c
> @@ -4475,8 +4475,15 @@ log_request(struct view *view, enum request request, struct line *line)
>  		state->recalculate_commit_context = TRUE;
>  		return request;
>  
> +	case REQ_ENTER:
> +		state->recalculate_commit_context = TRUE;
> +		if (VIEW(REQ_VIEW_DIFF)->ref != ref_commit)
> +			open_view(view, REQ_VIEW_DIFF, OPEN_SPLIT);
> +		update_view_title(view);
  		^^^^^^^^^^^^^^^^^^^^^^^

I missed removing update_view_title. I've done it locally, though.

Thanks.

Kumar

> +		return request;
> +
>  	default:
> -		return pager_request(view, request, line);
> +		return request;
>  	}
>  }
>  
> -- 
> 1.8.3.2

-- 
Kumar Appaiah
