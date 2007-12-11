From: Mike Hommey <mh@glandium.org>
Subject: Re: [Resend PATCH 2/4] Use strbuf in http code
Date: Tue, 11 Dec 2007 07:16:20 +0100
Organization: glandium.org
Message-ID: <20071211061620.GA8047@glandium.org>
References: <7vy7c3ogu2.fsf@gitster.siamese.dyndns.org> <1197228659-19459-1-git-send-email-mh@glandium.org> <7vlk81him3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 07:17:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1yQN-0006jB-Ru
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 07:17:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbXLKGQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 01:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbXLKGQh
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 01:16:37 -0500
Received: from vuizook.err.no ([85.19.215.103]:43675 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750984AbXLKGQh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 01:16:37 -0500
Received: from aputeaux-153-1-79-219.w81-249.abo.wanadoo.fr ([81.249.109.219] helo=namakemono.glandium.org)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1J1yQX-0001Rk-3e; Tue, 11 Dec 2007 07:17:15 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1J1yPk-00029P-Mq; Tue, 11 Dec 2007 07:16:20 +0100
Content-Disposition: inline
In-Reply-To: <7vlk81him3.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: (score 5.2): Yes, score=5.2 required=5.0 tests=RCVD_IN_DSBL,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67797>

On Mon, Dec 10, 2007 at 10:04:52PM -0800, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> >  struct buffer
> >  {
> > -        size_t posn;
> > -        size_t size;
> > -        void *buffer;
> > +	struct strbuf buf;
> > +	size_t posn;
> >  };
> 
> With this definition of "struct buffer", I do not think this can be correct.
> 
> > @@ -1267,10 +1257,8 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
> >  {
> >  	struct active_request_slot *slot;
> >  	struct slot_results results;
> > -	struct buffer out_buffer;
> > -	struct buffer in_buffer;
> > -	char *out_data;
> > -	char *in_data;
> > +	struct buffer out_buffer = { 0, STRBUF_INIT };
> 
> How seriously have you proofread and tested this series before sending
> it out?

Damn ! I did fix this on sunday and was pretty sure to have sent it :-/

Mike
