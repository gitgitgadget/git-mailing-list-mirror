From: Joe Perches <joe@perches.com>
Subject: Re: bug?  git format-patch -M -D then git am fails
Date: Tue, 13 Nov 2012 15:06:02 -0800
Message-ID: <1352847962.17444.27.camel@joe-AO722>
References: <1352846721.17444.24.camel@joe-AO722>
	 <7vsj8dcdv6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, David Miller <davem@davemloft.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 00:06:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYPYd-0004EN-J8
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 00:06:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753575Ab2KMXGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 18:06:00 -0500
Received: from perches-mx.perches.com ([206.117.179.246]:47688 "EHLO
	labridge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753296Ab2KMXF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 18:05:59 -0500
Received: from [173.51.221.202] (account joe@perches.com HELO [192.168.1.167])
  by labridge.com (CommuniGate Pro SMTP 5.0.14)
  with ESMTPA id 19837769; Tue, 13 Nov 2012 15:05:59 -0800
In-Reply-To: <7vsj8dcdv6.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.6.0-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209682>

On Tue, 2012-11-13 at 14:55 -0800, Junio C Hamano wrote:
> Joe Perches <joe@perches.com> writes:
> 
> > (Sorry about the partial message.
> >  evolution and ctrl-enter sends, grumble...)
> >
> > If a file is deleted with git rm and a patch
> > is then generated with git format-patch -M -D
> > git am is unable to apply the resultant patch.
> >
> > Is this working as designed?
> 
> I would say it is broken as designed and it is even documented.
> 
> Please run "git format-patch --help | less" and then type
> "/--irreversible-delete" to find:
> 
>     The resulting patch is not meant to be applied with patch nor
>     git apply; this is solely for people who want to just
>     concentrate on reviewing the text after the change.

yeah, it's just that not using -D can result in
some unfortunately large patches being sent to
mailing lists.  I don't believe that reversibility
is a really useful aspect of deletion patches
when there are known git repositories involved.

cheers, Joe
