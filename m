From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] fast-import: support the ls command anywhere comments
 are accepted
Date: Fri, 28 Nov 2014 07:01:43 +0900
Message-ID: <20141127220143.GA2554@glandium.org>
References: <1416954339-9304-1-git-send-email-mh@glandium.org>
 <20141125230333.GA11114@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 27 23:02:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xu78Q-0004KQ-Jz
	for gcvg-git-2@plane.gmane.org; Thu, 27 Nov 2014 23:01:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbaK0WBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2014 17:01:54 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:60523 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750729AbaK0WBx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2014 17:01:53 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1Xu78B-0001Kd-Tu; Fri, 28 Nov 2014 07:01:43 +0900
Content-Disposition: inline
In-Reply-To: <20141125230333.GA11114@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260354>

On Wed, Nov 26, 2014 at 08:03:33AM +0900, Mike Hommey wrote:
> On Wed, Nov 26, 2014 at 07:25:39AM +0900, Mike Hommey wrote:
> > The git-fast-import manual page says about both cat-blob and ls that they can
> > be used "anywhere in the stream that comments are accepted", but in practice
> > it turns out it was only true for cat-blob. This change makes fast-import
> > behavior match its documentation.
> > 
> > Signed-off-by: Mike Hommey <mh@glandium.org>
> > ---
> >  fast-import.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > The downside of this change is that if a script relies on the fixed behavior,
> > it won't work with older versions of git. I'm not sure it is better than
> > fixing the documentation to match the unfortunate current limitation?
> 
> Note, if my reading of the code is correct, then cat-blob can't be used
> between filemodify | filedelete | filecopy | filerename | filedeleteall
> | notemodify either...

Any thought on whether to fix those or to fix the documentation instead?

Mike
