From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] launch_editor(): allow spaces in the filename
Date: Mon, 10 Mar 2008 22:46:13 +0100
Message-ID: <200803102246.13910.johannes.sixt@telecom.at>
References: <alpine.LSU.1.00.0803102140280.3975@racer.site> <200803102232.13727.johannes.sixt@telecom.at> <7vk5kai7kr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Zeng.Shixin@gmail.com, theevancarroll@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 22:46:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYppe-0005JT-Ag
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 22:46:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbYCJVqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 17:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbYCJVqQ
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 17:46:16 -0400
Received: from smtp1.srv.eunet.at ([193.154.160.119]:46085 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbYCJVqP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 17:46:15 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id 5E08633E2A;
	Mon, 10 Mar 2008 22:46:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 253D660998;
	Mon, 10 Mar 2008 22:46:14 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <7vk5kai7kr.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76760>

On Monday 10 March 2008 22:37, Junio C Hamano wrote:
> Johannes Sixt <johannes.sixt@telecom.at> writes:
> > On Monday 10 March 2008 21:42, Johannes Schindelin wrote:
> >> For some reason, the construct
> >>
> >> 	sh -c "$0 \"$@\"" <editor> <file>
> >>
> >> does not pick up quotes in <editor> as expected.  So replace $0 with
> >> <editor>.
> >
> > No surprise. It must be
> >
> > 	sh -c '"$0" "$@"' <editor> <file>
> >
> > Note the extra quotes around $0.
>
> ... assuming that there is no dq, $var_reference and other nastiness in
> <editor> ;-)

They are not a problem; there isn't yet another level of evaluation. I just 
tried with an <editor> that goes by this name:

   f "$DISPLAY"b

and I got the expected result, i.e. it was found and executed.

-- Hannes
