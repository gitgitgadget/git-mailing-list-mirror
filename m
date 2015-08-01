From: Jan Viktorin <viktorin@rehivetech.com>
Subject: Re: [PATCH v1] send-email: provide whitelist of SMTP AUTH
 mechanisms
Date: Sat, 1 Aug 2015 20:21:56 +0200
Organization: RehiveTech, spol. s r.o.
Message-ID: <20150801202156.57debcc3@jvn>
References: <1438385617-29159-1-git-send-email-viktorin@rehivetech.com>
	<20150801164959.GC488564@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sat Aug 01 20:22:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLbQD-0004ue-7T
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 20:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbbHASWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2015 14:22:08 -0400
Received: from w-smtp-out-7.wedos.net ([46.28.106.5]:44607 "EHLO
	we2-f167.wedos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751430AbbHASWI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2015 14:22:08 -0400
Received: from ([109.81.211.51])
        by we2-f167.wedos.net (WEDOS Mail Server mail2) with ASMTP id OEX00106;
        Sat, 01 Aug 2015 20:22:06 +0200
In-Reply-To: <20150801164959.GC488564@vauxhall.crustytoothpaste.net>
X-Mailer: Claws Mail 3.12.0 (GTK+ 2.24.28; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275125>

Hello Brian,

thanks for your note. I think, I will remove the check
of list of mechanisms and put there a regex check.

On Sat, 1 Aug 2015 16:49:59 +0000
"brian m. carlson" <sandals@crustytoothpaste.net> wrote:

> On Sat, Aug 01, 2015 at 01:33:37AM +0200, Jan Viktorin wrote:
> > +	# Do not allow arbitrary strings.
> > +	my ($filtered_auth) = "";
> > +	foreach ("PLAIN", "LOGIN", "CRAM-MD5", "DIGEST-MD5") {
> 
> On my system, GSSAPI is also available, and it does indeed work, as
> I'm not prompted for a password.  (I have only PLAIN and GSSAPI
> available server-side, and AUTH is required.)
> 
> It may be better to simply force the text to upper case, as that would
> allow us not to have to change Git if Authen::SASL::Perl implements
> new mechanisms.

-- 
  Jan Viktorin                E-mail: Viktorin@RehiveTech.com
  System Architect            Web:    www.RehiveTech.com
  RehiveTech                  Phone: +420 606 201 868
  Brno, Czech Republic
