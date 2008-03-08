From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH/RFC] Make "git remote rm <remote>" remove file refs/remotes/<remote>/HEAD
Date: Sat, 8 Mar 2008 08:16:10 +0200
Message-ID: <200803080816.10811.tlikonen@iki.fi>
References: <200803051338.44938.tlikonen@iki.fi> <1204923732-29141-1-git-send-email-tlikonen@iki.fi> <7vlk4uyoln.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junio@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 07:16:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXsMa-00027T-Kn
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 07:16:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417AbYCHGQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 01:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401AbYCHGQS
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 01:16:18 -0500
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:51722 "EHLO
	pne-smtpout3-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752180AbYCHGQR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Mar 2008 01:16:17 -0500
Received: from [192.168.0.2] (80.220.180.181) by pne-smtpout3-sn2.hy.skanova.net (7.3.129)
        id 478BDB96002DB039; Sat, 8 Mar 2008 07:16:16 +0100
User-Agent: KMail/1.9.5
In-Reply-To: <7vlk4uyoln.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76550>

Junio C Hamano kirjoitti:

> Junio C Hamano <gitster@pobox.com> writes:
> > I think "update-ref -d" should remove the ref without dereferencing
> > anyway.  How about not doing your patch at all (you would need to
> > manually remove the symref in "prune" codepath as well), and
> > instead doing this?
> >
> > I do not know how this reacts when the tracked HEAD points at a ref
> > that lexicographically sorts earlier, say branch "A".
>
> And it turns out it does not react very well.  You would want to do
> something like this on top of that one.

This turned out to be much more complicated than just deleting a file. 
Thank you, these patches seem to work (at least from user's point of 
view).
