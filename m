From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: extracting to/cc addresses for stg mail
Date: Tue, 5 Aug 2008 15:39:22 +0200
Message-ID: <20080805133922.GB29499@diana.vm.bytemark.co.uk>
References: <200808011650.45915.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 15:19:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQMRW-0001M4-9S
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 15:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756195AbYHENRs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Aug 2008 09:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753910AbYHENRr
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 09:17:47 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3012 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185AbYHENRq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 09:17:46 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KQMl0-0000Ni-00; Tue, 05 Aug 2008 14:39:22 +0100
Content-Disposition: inline
In-Reply-To: <200808011650.45915.bjorn.helgaas@hp.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91440>

On 2008-08-01 16:50:45 -0600, Bjorn Helgaas wrote:

> Is there a way to make stg pay attention to my "To:" lines in the
> patch description? Or another way to accomplish this?

It can't do it at the moment, but it should be easy to fix. In
stgit/commands/mail.py, the following lines

    if options.auto:
        extra_cc =3D __get_signers_list(descr)
    else:
        extra_cc =3D []

add the extra CC addresses. You could augment __get_signers_list to
return a tuple of to and cc addresses instead of just cc addresses,
pass those addesses to the same place extra_cc is fed now, and that's
it.

If you really hate Python, don't have time, etc., I can do it for you
(as long as you agree to test it) -- just ask -- but I try to take
every opportunity to get people to contribute patches. :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
