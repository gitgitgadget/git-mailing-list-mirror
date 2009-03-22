From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] builtin-fast-export.c: add default case to avoid crash on 
	corrupt repo
Date: Sun, 22 Mar 2009 13:32:58 +0100
Message-ID: <40aa078e0903220532n41895acemff175e4012e28ea6@mail.gmail.com>
References: <1237675051-6688-1-git-send-email-kusmabite@gmail.com>
	 <7vd4cabffl.fsf@gitster.siamese.dyndns.org>
	 <40aa078e0903220522g66cf2172l9f1a43ed562cc4d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 13:39:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlMxG-0005cS-RO
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 13:39:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897AbZCVMdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 08:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752599AbZCVMdE
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 08:33:04 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:39304 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbZCVMdD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 08:33:03 -0400
Received: by ewy9 with SMTP id 9so1263913ewy.37
        for <git@vger.kernel.org>; Sun, 22 Mar 2009 05:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=eR/oqqnTDaUpHrWyfG/DpQXVailRa7HSQlbmkeYVqNE=;
        b=Lbg0RY0zQfEtMqDjUMKd99qsBnbiUPPx2cic0IMwprhJ5AZKwThuHzYziqT88LRxVX
         M098hgbl7c/p3qOwLTXgMtOYYpkhXdyaLQAGnEpFU3P4d95Bnrr9cOcRLiyGVthSfRPe
         JxlafQeUIeOXaMjYKlu6fRu9a9DlrzsGhw2yA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qoEI2aai4d6uT2o7LHYs86YygkSzCBGm4ockgH+BSleZt+es4END8E16HqyKYjQMeg
         Q8bI2ciUu7by2NZMMHajbk71funJQBRkwXs4lh5vK0Qt1tCZDYe1noNvn/x29uJFxbom
         XiFxs9jXvP+/4FwIgi+8ZNB9Eoiqaaa6BoUkQ=
Received: by 10.210.136.10 with SMTP id j10mr2469296ebd.45.1237725178708; Sun, 
	22 Mar 2009 05:32:58 -0700 (PDT)
In-Reply-To: <40aa078e0903220522g66cf2172l9f1a43ed562cc4d3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114138>

> tag-object is NULL. Now, I'm no expert, but from browsing some code,
> it seems that "parse_object(tag->object.sha1)" should have been
> performed on the tag before looking up the tagged object. Does this
> make sense?

I guess I forgot to mention that adding a call to parse_object() does
make fast-exporting nested tags appear to work.


-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
