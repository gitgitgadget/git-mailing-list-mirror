From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] git-commit: add a prepare-commit-msg hook
Date: Mon, 21 Jan 2008 13:14:19 +0100
Message-ID: <47948C9B.7030100@gnu.org>
References: <4790BCED.4050207@gnu.org> <7vbq7ibxhh.fsf@gitster.siamese.dyndns.org> <4791C3A8.7000308@gnu.org> <alpine.LSU.1.00.0801191119050.5731@racer.site> <7vd4rw6siv.fsf@gitster.siamese.dyndns.org> <479438D1.2050107@gnu.org> <alpine.LSU.1.00.0801211101450.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 21 13:15:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGvYJ-00022K-7r
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 13:14:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754439AbYAUMO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 07:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754437AbYAUMO1
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 07:14:27 -0500
Received: from fk-out-0910.google.com ([209.85.128.184]:34662 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754373AbYAUMO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 07:14:26 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1337835fkz.5
        for <git@vger.kernel.org>; Mon, 21 Jan 2008 04:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=B3JYJoh6K1SZxJ9TET7pVDuszmt2rGtifnbDbkKPL4w=;
        b=tgn7uA2iANqzTqRay94Yk/k+amXY1Oa9A2s13tTZ++P+B7yLr/vRtt5VthUGORAa+MGsG/2z37DY3Et4dydar17V6YiwWWSzAyw5u10t/Ds0BYrGMoALyfv0fC31escp46doMERhKCHiavsAHq9x2KyUEgJrb9eZYItMPf76g/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=N/NjFLZqcwZnoeAKfRp5NWuZHg7sJjlPlLAJ4nI75hXAXDtrnzJ8mPs6sEkwskSVgB1SXL3jMVTMEIFPCWpY3Sunc3cOLIHrQfUZGw0pANp15mZkqiIWBRv4sY/Dk4nNtH82qJKfi0s9DuoB2tyewiYjzojxfW+1PE7vVM9yrZo=
Received: by 10.82.148.7 with SMTP id v7mr12219695bud.10.1200917662670;
        Mon, 21 Jan 2008 04:14:22 -0800 (PST)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id 13sm8041250fks.8.2008.01.21.04.14.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 21 Jan 2008 04:14:21 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Macintosh/20071031)
In-Reply-To: <alpine.LSU.1.00.0801211101450.5731@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71275>

> I have.  But I want to avoid a regression at any cost.  And your patch 
> just looks to me like it could do that.

What kind of regression?

> But it _has_ been already suggested that you could provide arguments for 
> the existing msg-hook, which would not break anything

Sure it won't break anything, but it won't work either!  The existing 
message hook runs after the editing session -- I want the hook to 
introduce text that is merely a suggestion that the user can delete, or 
a template that the user needs to customize further.

> since the hook does 
> not get any argument yet, and therefore existing hooks would be 
> unaffected.

How does adding a new hook affect existing hooks?

> Also, the change would be non-intrusive, easy-to-review

Please.  That's ludicrous.

My patch is 3 lines of inserted code and 0 modified lines, checking one 
variable that is set once in builtin-commit.c (edit_message).  The 
documentation says that it runs whenever the editor runs except for -c, 
and launch_editor runs after the 3 lines of code I inserted.

Seeing how biased you are, I don't really know why I bothered answering you.

> take so much time away from the bug-fixing that we want to do right now in 

That's the first sensible argument that I hear.

Paolo
