From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH v2] Re: mailinfo: allow individual e-mail files as input
Date: Thu, 06 Aug 2009 21:49:06 -0500
Message-ID: <7GvFnE4br-8WnXmtoea9V1LPY-qshCw6arPr6H40SRG59-b7YcpTsw@cipher.nrlssc.navy.mil>
References: <COrzR9ThNBy5SQ7chsXyUB30jVGIijxZQ3LI9L_y7Ab5vWcDcy_HolvjjuHTC7DHI9ntV-eR_v0@cipher.nrlssc.navy.mil> <fmF7fF0TYh9QnFuUzmi-Zw9fKRhYn2-S-kCVb2e-d84D87BPqjfwrwFursOoLGkB99qKJmb_oRs@cipher.nrlssc.navy.mil> <20090807015238.GF12924@vidovic> <20090807015628.GG12924@vidovic> <4Frzb2o8m7o4sjOhlZiN-mXQHUAsXYeImlNxZ8ANJZ5I3_S_JjSsoA@cipher.nrlssc.navy.mil> <20090807023126.GH12924@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, giuseppe.bilotta@gmail.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Fri Aug 07 04:49:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZFWB-00058t-QL
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 04:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756546AbZHGCtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 22:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756410AbZHGCtM
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 22:49:12 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57295 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756367AbZHGCtL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 22:49:11 -0400
Received: by mail.nrlssc.navy.mil id n772n8Ap032349; Thu, 6 Aug 2009 21:49:08 -0500
In-Reply-To: <20090807023126.GH12924@vidovic>
X-OriginalArrivalTime: 07 Aug 2009 02:49:07.0309 (UTC) FILETIME=[A1F939D0:01CA1709]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125166>

Nicolas Sebrecht wrote:
> The 06/08/09, Brandon Casey wrote:
>>                   I think it's a little strange like that though...
>>
>>    {
>>       sed "$1"
>>    } < "$1"
> 
> I'm not sure why this comment. The former
> 
>   sed "$1"
> 
> whithout anything else is enough.

The "former", or Junio's original patch, effectively has this form:

   {
      sed "$1"
   } < "$1"

Without reading closely enough, I thought it looked like this:

   {
      sed
   } < "$1"

Since I didn't study the sed statement closely enough, I assumed that it was
operating on the remaining portion of the patch email that was redirected to
the block on stdin.  I missed the fact that the file name was supplied to
it.  My comment was that I found it strange (and maybe unintuitive, or maybe
it's just me) that "$1" was piped on stdin and it was supplied as an
argument to sed.

-brandon
