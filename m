From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: [PATCH 5/5] run-command: Error out if interpreter not found
Date: Fri, 27 Jan 2012 09:29:50 +0100
Message-ID: <CAH6sp9NEnkDY-BCccW9VM3waxg8sG8zV5-rVAuMUfZ9rji4-Qw@mail.gmail.com>
References: <1327444346-6243-1-git-send-email-fransklaver@gmail.com>
	<1327444346-6243-6-git-send-email-fransklaver@gmail.com>
	<20120124232421.GH8222@burratino>
	<op.v8moybu10aolir@keputer>
	<4F205028.4060606@kdbg.org>
	<7vr4ym2rad.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 09:29:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqhC0-0003pL-UJ
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 09:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041Ab2A0I3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 03:29:52 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:47219 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041Ab2A0I3v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 03:29:51 -0500
Received: by qcsg15 with SMTP id g15so794419qcs.19
        for <git@vger.kernel.org>; Fri, 27 Jan 2012 00:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xAtVj3xbuyKu9AJlXwB6FNA/YLjAm+B3JBcGGyUZ+kY=;
        b=cd9KcO+iFFfPE9XuHD418Dz6qSXiQUXFcrlAJRsi9de4A0yjwWAmmGVqNGV1J0rqim
         EXH4bJyoSIlyEuu05fcFG1s7l3dfkkY9FZ74m34kPlXALTYfMG1YVGAju18ZtcC/sQy+
         fpRHJCVOWwjY37onqC0MBHR9rv3Ds8oNSEJeQ=
Received: by 10.229.137.72 with SMTP id v8mr2033391qct.43.1327652990968; Fri,
 27 Jan 2012 00:29:50 -0800 (PST)
Received: by 10.224.105.143 with HTTP; Fri, 27 Jan 2012 00:29:50 -0800 (PST)
In-Reply-To: <7vr4ym2rad.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189204>

On Thu, Jan 26, 2012 at 8:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
>
>> No thanks. IMHO, this is already too much code for too little gain.
>
> Thanks for bringing a bit of sanity. You have already said it "In which
> way is git different from other tools that execvp other programs?" earlier
> (http://thread.gmane.org/gmane.comp.version-control.git/171755/focus=171848)

Well, one tool that it differs from is bash (although bash uses execve
directly I think). Personally I think this whole thing essentially a
lack of information from execv*. Also, I do agree that the code
required for this is quite more than I would have liked, but it will
reduce confusion when things go wrong. It's when things go wrong that
people get annoyed. Annoyed people look for greener grass. If that bit
of annoyance could be reduced, why not go the extra mile for that
little bit of gain?

Being as it is, I'll stop working on this. If this was pretty much
going to be /dev/null'ed from the beginning, I'd rather have heard it
after my first patches.

In any case, it has been an education so far. Thanks for that. And if
there's any issue you think I could start tackling, please don't
hesitate to cc me.

Cheers,
Frans
