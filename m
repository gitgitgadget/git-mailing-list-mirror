From: Anton Gladkov <agladkov@parallels.com>
Subject: Re: [PATCH] [RFC] add Message-ID field to log on git-am operation
Date: Mon, 24 Mar 2008 09:43:27 +0300
Message-ID: <20080324064327.GE22468@atn.sw.ru>
References: <1206136805-20115-1-git-send-email-agladkov@parallels.com> <7v4payilkp.fsf@gitster.siamese.dyndns.org> <20080323171621.GA3886@atn.sw.ru> <7v4pax70lz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 07:37:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdgJX-0004vX-Nm
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 07:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755036AbYCXGgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 02:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754115AbYCXGgt
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 02:36:49 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:43748 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753353AbYCXGgs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 02:36:48 -0400
Received: from atn.sw.ru ([10.30.3.212])
	by relay.sw.ru (8.13.4/8.13.4) with ESMTP id m2O6acAO011170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 24 Mar 2008 09:36:40 +0300 (MSK)
Received: from atn.sw.ru (localhost.localdomain [127.0.0.1])
	by atn.sw.ru (8.14.2/8.14.1) with ESMTP id m2O6hU9L007168;
	Mon, 24 Mar 2008 09:43:30 +0300
Received: (from anton@localhost)
	by atn.sw.ru (8.14.2/8.14.2/Submit) id m2O6hRpq007167;
	Mon, 24 Mar 2008 09:43:27 +0300
X-Authentication-Warning: atn.sw.ru: anton set sender to agladkov@parallels.com using -f
Content-Disposition: inline
In-Reply-To: <7v4pax70lz.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78006>

On Sun, Mar 23, 2008 at 11:32:08AM -0700, Junio C Hamano wrote:
> Anton Gladkov <agladkov@parallels.com> writes:
> > ...
> > applypatch-msg hook executed on message applying, after that there could be
> > useful to test applied patch, so it is not the place for notification sending.
> 
> And nobody suggested to send anything from the hook.
> 
> As I understood from your e-mail without proposed commit log message, your
> assumed workflow was:
> 
> 	receive mail
>         "git am" it
> 	test rewrite amend whatever you want to convince yourself that
>          the received patch was Ok
>         push the result out
>         pushed-into repository has a hook to send notification,
>          by picking up the Message-ID from the commit object

That is it.

> 
> The only thing you need was that the message-id information is available
> somewhere in the commit object.  I objected to your patch that puts it in
> the commit object header and suggested it be placed in the commit log
> message.  You can implement such custom commit munging to add an extra
> Message-ID: line inside the hook.  You do not have to send out e-mail nor
> anything from it.

I've got your idea! Thank you :)

-- 
Best regards,
		anton
mailto:agladkov@sw.ru
