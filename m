From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH v3] Add push --set-upstream
Date: Sat, 16 Jan 2010 15:46:57 +0200
Message-ID: <20100116134656.GA4504@Knoppix>
References: <1263633827-23720-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <20100116203557.95340c00.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 15:47:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NW9w2-0006p4-D4
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 15:47:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285Ab0APOq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 09:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753255Ab0APOq7
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 09:46:59 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:45241 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069Ab0APOq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 09:46:58 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id C58F4C7D10;
	Sat, 16 Jan 2010 16:46:56 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A0413DC26B7; Sat, 16 Jan 2010 16:46:56 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id AA9B241BE4;
	Sat, 16 Jan 2010 16:46:54 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <20100116203557.95340c00.rctay89@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137230>

On Sat, Jan 16, 2010 at 08:35:57PM +0800, Tay Ray Chuan wrote:
> Hi,
> 
> On Sat, 16 Jan 2010 11:23:47 +0200
> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:
> > +		OPT_BIT('u', "set-upstream", &flags, "Set upstream for git pull", TRANSPORT_PUSH_SET_UPSTREAM),
> 
> This line exceeds 80 characters.

Broken into two (without breaking the message), it is still over 80.
 
> Also, I think you should follow the case-style of the other option
> descriptions and s/Set(?= upstream)/set/.

Fixed.

> > [snip]
> > +static void set_upstreams(struct transport *trans, struct ref *refs,
> 
> I would prefer if you could follow the naming convention and say
> "transport" instead of truncating to "trans".

Fixed.

> > +	struct ref *i;
> > +	for (i = refs; i; i = i->next) {
> 
> In most places, "ref" instead of "i" is used; ie.
 
Fixed.

> > +		 * alreay up-to-date ref create/modify (not delete).
> 
> s/alreay/already/.

Fixed.

> > +		/* Chase symbolic refs (mainly for HEAD). */
> 
> Did you mean "Change" here?

No. Changed to 'Follow'.

> Regarding the checking of ref->status here:
> 
> Is it possible to delegate this to push_had_errors(remote_refs)
> instead? We skip setting up upstream tracking when there are errors
> from pushing, so we don't have to check ref->status anymore.

No. As documetnation says, the update or no update is done on per-branch
basis.

<snip patch>
 
> (As a side note, if you apply this on top of 'tr/http-push-ref-status'
> in 'pu', the result of push_had_errors() is saved in a variable
> ('err'), so you could just use it and not have to call push_had_errors
> () again.)

See above.

I'll sit on v4 for some more time to wait for more comments.

-Ilari
