From: Frank Terbeck <ft@bewatermyfriend.org>
Subject: Re: [PATCH v2 2/4] Add format.coverauto boolean
Date: Tue, 5 May 2009 10:49:16 +0200
Message-ID: <20090505084916.GB26208@fsst.voodoo.lan>
References: <7v8wlxx18c.fsf@gitster.siamese.dyndns.org> <1241431142-8444-3-git-send-email-ft@bewatermyfriend.org> <7v8wlc4fqo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 05 10:49:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1GLK-00046V-6X
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 10:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021AbZEEIta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 04:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752159AbZEEIta
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 04:49:30 -0400
Received: from smtprelay11.ispgateway.de ([80.67.29.28]:48543 "EHLO
	smtprelay11.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbZEEIt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 04:49:29 -0400
Received: from [212.117.84.253] (helo=fsst.voodoo.lan)
	by smtprelay11.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1M1GL9-0002el-Jm; Tue, 05 May 2009 10:49:27 +0200
Received: from hawk by fsst.voodoo.lan with local (Exim 4.69)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1M1GKz-0000wK-Aj; Tue, 05 May 2009 10:49:17 +0200
Content-Disposition: inline
In-Reply-To: <7v8wlc4fqo.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: 430444
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118283>

Junio C Hamano <gitster@pobox.com>:
> Frank Terbeck <ft@bewatermyfriend.org> writes:
> 
> > If set to true, format-patch behaves like it had been started
> > using the --cover-letter option.
> 
> I thought "If this is set, you can run format-patch without giving an
> explicit --cover-letter=foo from the command line" was already done with
> the earlier format.coverletter configuration variable.  Why do you need a
> separate variable?  It does not make any sense to me, unless I am missing
> something.

Well, the two can certainly by merged. That could potentially break
people's existing scripts - either by new default behaviour or by the
setting of format.coverletter of an individual user. That could still
happen when using coverauto, so maybe my reasoning was flawed - given
that Stephen raised the same question.

So, I should create one option 'coverletter'. If it's set to zero,
never create cover letters; if one, always create cover letters; if
any other positive integer, create cover letters automatically if a
patch series is at least that long. And do that without requiring the
user to supply --cover-letter; only provide that option to explicitly
overwrite the configured behaviour. Right?

If so, do you want coverletter to default to zero (which wouldn't
change the default behaviour) or do you want it to default to two?

Regards, Frank

-- 
In protocol design, perfection has been reached not when there is
nothing left to add, but when there is nothing left to take away.
                                                  -- RFC 1925
