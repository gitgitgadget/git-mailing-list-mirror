From: Teemu Likonen <tlikonen@iki.fi>
Subject: MIME headers in introductory message (git send-email --compose)
Date: Tue, 25 Mar 2008 20:31:16 +0200
Message-ID: <200803252031.17017.tlikonen@iki.fi>
References: <1205426419-4594-1-git-send-email-sam@rfc1149.net> <7vhcfaxxxk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Samuel Tardieu <sam@rfc1149.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 19:33:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeDxe-0004mL-8w
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 19:33:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758103AbYCYSbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 14:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759075AbYCYSbW
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 14:31:22 -0400
Received: from pne-smtpout3-sn1.fre.skanova.net ([81.228.11.120]:42859 "EHLO
	pne-smtpout3-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759749AbYCYSbU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Mar 2008 14:31:20 -0400
Received: from [192.168.0.2] (80.220.180.181) by pne-smtpout3-sn1.fre.skanova.net (7.3.129)
        id 47A78857002AB81A; Tue, 25 Mar 2008 19:31:19 +0100
User-Agent: KMail/1.9.5
In-Reply-To: <7vhcfaxxxk.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78204>

Junio C Hamano kirjoitti:

> Samuel Tardieu <sam@rfc1149.net> writes:
> > Add MIME-Version/Content-Type/Content-Transfer-Encoding headers in
> > messages generated with git-format-patch. Without it, messages
> > generated without using --attach or --inline didn't have any
> > content type information.
>
> Isn't that job for send-email (or user's MUA)?  I really do not think
> we want to clutter format-patch output any more than necessary.

By the way, 'git send-email --compose' does not add MIME headers to 
introductory message. All non-Ascii chars will output something 
undefined in receivers' end.

I guess the right way would be to detect user's charset (locale) and add 
appropriate MIME headers. Also, the Subject field should be encoded if 
it contains non-Ascii characters.
