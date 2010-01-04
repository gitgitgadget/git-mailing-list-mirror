From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Tue, 5 Jan 2010 00:57:49 +0900
Message-ID: <fc339e4a1001040757n31298f3h724eacfafb68c63e@mail.gmail.com>
References: <7vtyv4cpna.fsf@alter.siamese.dyndns.org> <87ljgfgbl0.fsf@catnip.gol.com> 
	<fc339e4a1001021847hf1e1a7fq894de7908839ff77@mail.gmail.com> 
	<877hrzga16.fsf@catnip.gol.com> <alpine.LFD.2.00.1001031124420.3630@localhost.localdomain> 
	<7v3a2mzzg4.fsf@alter.siamese.dyndns.org> <20100104053125.GA5083@coredump.intra.peff.net> 
	<7vbphaquwl.fsf@alter.siamese.dyndns.org> <20100104064408.GA7785@coredump.intra.peff.net> 
	<alpine.LFD.2.00.1001040659150.3630@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 04 17:05:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRpQk-0004Fd-KS
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 17:05:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753557Ab0ADQFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 11:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753553Ab0ADQFO
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 11:05:14 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:50459 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753473Ab0ADQFM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 11:05:12 -0500
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Jan 2010 11:05:12 EST
Received: by iwn32 with SMTP id 32so138517iwn.33
        for <git@vger.kernel.org>; Mon, 04 Jan 2010 08:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type;
        bh=v0f7eeQkH04ulNBD5T9GLznxTN2z9SIWkyjNEjYBXTU=;
        b=fWrqSiQ1M8MHxBKKSdy437j4AOeE9JiR2Bqi5nfPLMlgjWENKMdPo5KerGdSskd12P
         XWpf2TwFXjHnXHZaBT1ZbT3Ui74WcN17FxIx4zaxaHj2T7OxHktO9oaZTFplV3xXmhuD
         0TdbL7B0hKyx3vY/XgXyUZ4zpRwair8fhezCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=O+HKcDgeJL1TstbXmxQOXpBdLvVfzf3SDoBUbrn8qXj9fZqRTG2LAED916GS45nw1E
         IG6m8RRC1TfpgCWrRUS0fbT945L7bmYIjHdfw2/0uFeS+UMzlkU3zwAhhBLl3jS9GJPm
         Vr6E170ZmM50ELIWD3yQgkmqpl1jKEdJYKQrY=
Received: by 10.231.122.139 with SMTP id l11mr395204ibr.53.1262620689132; Mon, 
	04 Jan 2010 07:58:09 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1001040659150.3630@localhost.localdomain>
X-Google-Sender-Auth: a2d61221886eed60
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136124>

On Tue, Jan 5, 2010 at 12:54 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> And "perf record" followed by "perf report" on the internal one shows
> that it's not even regexec() - we use strstr() for the trivial case:

Does strstr use e.g. boyer-moore?  I imagine grep does...

-miles

-- 
Do not taunt Happy Fun Ball.
