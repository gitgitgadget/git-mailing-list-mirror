From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 6/8] imap-send: change msg_data from storing (char *, len)
 to storing strbuf
Date: Mon, 3 Dec 2012 13:06:32 -0200
Message-ID: <CACnwZYdUN+8iubjFsLMbQvEdYjvZFj_XM+oAeTsUe0EUoCwm_g@mail.gmail.com>
References: <1353841721-16269-1-git-send-email-mhagger@alum.mit.edu>
	<1353841721-16269-7-git-send-email-mhagger@alum.mit.edu>
	<7vboegp04x.fsf@alter.siamese.dyndns.org>
	<50B8B66F.3090300@alum.mit.edu>
	<7v624lns00.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Jeremy White <jwhite@codeweavers.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 16:06:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfXbf-0005n8-AI
	for gcvg-git-2@plane.gmane.org; Mon, 03 Dec 2012 16:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528Ab2LCPGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2012 10:06:35 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:57431 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490Ab2LCPGe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2012 10:06:34 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so2346331lag.19
        for <git@vger.kernel.org>; Mon, 03 Dec 2012 07:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=G53KjwGFx3Eo+FssvJYAnkhp5HiFapf5W72Q7hq55mo=;
        b=gMngLp17g3iEDJ1h4KsumFE8pqCgSzmMrIq52gXWo1QM9+v1BDQ2Ma7wAXmPk1hUXp
         sJ7rUocBKb6VLcbcjWAo4vgFuwsLe1IJAVJKXQTwDKrscyYHxpUdIiYkd4rwEbpI6sZL
         Map1x2Vjwa/LC7K0KKiWilOYJe+zyuY/cUMzQ4J59LzlzcJlidWQfMwFZmtCn+5ahSCS
         2bKNLynvmivI+6L0mBOZE5m/xfeNN1gKVHF9j6/bcTSKGZFwFSf/ASLbOCHkwfZZG1tJ
         kJOfsPMAM0h5FTHO830eaz09Yaif7fZXu9g7EMNBkMNvSZH0OcEAvsuU0I2c6r7fFPp6
         t56g==
Received: by 10.112.31.200 with SMTP id c8mr4392510lbi.61.1354547193092; Mon,
 03 Dec 2012 07:06:33 -0800 (PST)
Received: by 10.112.39.137 with HTTP; Mon, 3 Dec 2012 07:06:32 -0800 (PST)
In-Reply-To: <7v624lns00.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211040>

On Sat, Dec 1, 2012 at 11:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> I suggest a separate patch series dedicated to deleting *all* the extra
>> imap infrastructure at once.  That being said, I'm not committing to do
>> so.  (We could add it to an "straightforward projects for aspiring git
>> developers" list, if we had such a thing.)
>
> A "low-hanging fruit and/or janitorial work" stack may be worth
> having.

That would be good for not so versed developers, I think. Do we have a
place for listing janitor projects?
