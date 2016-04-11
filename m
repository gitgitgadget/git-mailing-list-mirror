From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: git interpret-trailers with multiple keys
Date: Mon, 11 Apr 2016 10:24:41 +0300
Message-ID: <20160411102346-mutt-send-email-mst@redhat.com>
References: <20160406191054-mutt-send-email-mst@redhat.com>
 <vpqlh4qbrnt.fsf@anie.imag.fr>
 <20160406201509-mutt-send-email-mst@redhat.com>
 <xmqq1t6iy6p9.fsf@gitster.mtv.corp.google.com>
 <20160406212940-mutt-send-email-mst@redhat.com>
 <CAP8UFD0Pw+yhO1jZTAbMkZ5d-usu3rx5N0Se=PNL=N7DD-BPcA@mail.gmail.com>
 <20160410182750-mutt-send-email-mst@redhat.com>
 <CAP8UFD1hSg9RXLavzQgff-QioVU28_ZYhrfAvrhzNe8zXwwv5w@mail.gmail.com>
 <20160410203556-mutt-send-email-mst@redhat.com>
 <vpqegac7hab.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 11 09:25:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apWDU-000475-Jv
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 09:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbcDKHYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2016 03:24:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55919 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751026AbcDKHYo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 03:24:44 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BE1DB811A2;
	Mon, 11 Apr 2016 07:24:43 +0000 (UTC)
Received: from redhat.com (vpn1-5-155.ams2.redhat.com [10.36.5.155])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u3B7OfH0004897;
	Mon, 11 Apr 2016 03:24:42 -0400
Content-Disposition: inline
In-Reply-To: <vpqegac7hab.fsf@anie.imag.fr>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291206>

On Mon, Apr 11, 2016 at 09:09:48AM +0200, Matthieu Moy wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Sun, Apr 10, 2016 at 06:57:53PM +0200, Christian Couder wrote:
> >> What I meant is that we could create new options called maybe
> >> trailer.autocommands and trailer.<token>.autocommands that default to
> >> 'true' and if 'false' the command would not be run automatically and
> >> the corresponding trailer would not be added.
> >
> > I don't think it has to do with commands.
> > For example, if we add "value" it should behave the same.
> >
> > So I think a better name is "ifnotlisted", with values "add"
> > and "donothing".
> 
> Having a negation in the variable name feels wrong. When the token is
> listed on the command-line and ifnotlisted=donothing, I have to apply a
> double-negation to guess what would happen (=> "if listed then do
> something").

Isn't this similar to ifmissing?

> I agree that having such variable would be a good thing. It would solve
> your issue (i.e. "How to I configure a token for quick use from the
> command-line without applying it unconditionally"), and allow full
> backward compatibility.
> 
> I'd call the option "apply" or perhaps "run", with values 1/true/always
> = default = current behavior, or "auto" = "apply when asked from the
> command-line". I'm wondering whether other values could make sense (not
> to implement it right now, but to keep the design open to further
> extensions): perhaps apply=ifauthor could mean "apply this trailer to
> patches I'm the author of" for example.
> 
> -- 
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
