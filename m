From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Allow cloning an empty repository
Date: Sat, 24 Jan 2009 01:42:30 +0100
Message-ID: <bd6139dc0901231642v6bd593d3mfefaca3c419a9f0a@mail.gmail.com>
References: <1232669252-21881-1-git-send-email-srabbelier@gmail.com>
	 <7vwscm4xx0.fsf@gitster.siamese.dyndns.org>
	 <bd6139dc0901221746h258f548etf857ab37399133da@mail.gmail.com>
	 <alpine.DEB.1.00.0901230333060.3586@pacific.mpi-cbg.de>
	 <20090123230520.GL21473@genesis.frugalware.org>
	 <alpine.DEB.1.00.0901240131570.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 24 01:43:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQWcv-0001dJ-9z
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 01:43:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344AbZAXAmd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 19:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752886AbZAXAmc
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 19:42:32 -0500
Received: from mail-gx0-f21.google.com ([209.85.217.21]:41656 "EHLO
	mail-gx0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797AbZAXAmc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 19:42:32 -0500
Received: by gxk14 with SMTP id 14so4533066gxk.13
        for <git@vger.kernel.org>; Fri, 23 Jan 2009 16:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=hhHlUSbPCxrLIqNYeB0y4BihN3sDiyTHf+rsgd4oQn8=;
        b=HMUCFmsQZACHgJDVHFYleiVkXZKPdbxCNiH6i+2dOEkQItX4I9qu1URoBCZ3uegmsU
         vN9moGCjJ8gyK75jWzmc+Db/E97TgGsGYGr9j2isCcfTRvDOnvkpFR4G2ZEN36Xxav/l
         MLkUqLWPKhGbKObxIMHf6yoAYzEEobtqbR/fw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=cSrKgHLn0ZKkJ845nqEJL/YytgNcLITIfQxIYbEIft0vt3cjh4zwV8Htzba2orCivx
         5Rhskl4l4fqxjDEzI+5DpC/WjYbEC6/0eXR4AmdPGcj8BqpmARlnCPqVv2Cd7dluQueG
         dBArKySZMBR1G3GTqIaXOky7gToL2jr6dHC04=
Received: by 10.151.7.4 with SMTP id k4mr4290784ybi.241.1232757750842; Fri, 23 
	Jan 2009 16:42:30 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901240131570.3586@pacific.mpi-cbg.de>
X-Google-Sender-Auth: 4c10af5ebc3017f1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106936>

On Sat, Jan 24, 2009 at 01:33, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Sat, 24 Jan 2009, Miklos Vajna wrote:
>> I'm not familiar with the HTTP code, either, but here is the call stack
>> I see:
>>
>> - builtin-clone calls transport_get_remote_refs()
>> - that will call transport->get_refs_list()
>> - that will call get_refs_via_curl()
>> - that die()s on error, does not use return error()

Which means all protocols actually die?

> Only after writing my email (and just before sending) did I remember that
> I have Mike's HTTP cleanups applied in my Git checkout.  So I was
> analyzing the wrong code.

Hmmm, can't blame you considering it was around 4am ;).

-- 
Cheers,

Sverre Rabbelier
