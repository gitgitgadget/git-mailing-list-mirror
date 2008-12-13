From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb and unicode special characters
Date: Sat, 13 Dec 2008 14:08:29 -0800 (PST)
Message-ID: <m3d4fvg23p.fsf@localhost.localdomain>
References: <3f2beab60812121033r5d41894t77acc271b7c6955c@mail.gmail.com>
	<m3y6ylf3mq.fsf@localhost.localdomain>
	<3f2beab60812121655m6cd868bfhaaf386e6f5457533@mail.gmail.com>
	<200812130231.06929.jnareb@gmail.com> <ghv8rf$47v$1@ger.gmane.org>
Mime-Version: 1.0
Cc: git@vger.kernel.org
To: "Edward Z. Yang" <edwardzyang@thewritingpot.com>
X-From: git-owner@vger.kernel.org Sat Dec 13 23:09:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBcgI-00038L-Uo
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 23:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbYLMWId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 17:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751680AbYLMWId
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 17:08:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:20962 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbYLMWIc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 17:08:32 -0500
Received: by ug-out-1314.google.com with SMTP id 39so69808ugf.37
        for <git@vger.kernel.org>; Sat, 13 Dec 2008 14:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version;
        bh=7XWZ43gPaj+gXr1VOpXcPJOa8iVnJObYsfUt/OzxFkg=;
        b=PDVt9AsTL8O/RVJ0Gsb3LZy1n4pUG84ijKjmoegSEdUIHVgQNB9zocppfJITNcqHxC
         NuvGnRepreGr5A6o5kKaGrMv9GL2835W8Q+DmKr5+ddqyNAuX4h37wN5t2vB37G6bWq/
         3GwQaKjDze3HZoM9VwSqNVm4KnGgOdTnM7i3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version;
        b=GsSiAJNb54dw2Ugz5pJSoYAI+baxnQL0u6i/PC+SI2hdV5/OPItF8nq6r+S01HLOtQ
         ZcyKZ5TTS4G5fLHqYCWvklEiNZE/UrcuPD1PiQ7EIdEJ/zpG/8Dnc83mO9N2EeWyMed6
         y2hfqtwxB9VEB4aaZ0EfZv8AeoJS2szjHFMs8=
Received: by 10.66.224.19 with SMTP id w19mr780749ugg.71.1229206110773;
        Sat, 13 Dec 2008 14:08:30 -0800 (PST)
Received: from localhost.localdomain (abvz56.neoplus.adsl.tpnet.pl [83.8.223.56])
        by mx.google.com with ESMTPS id l20sm109204uga.14.2008.12.13.14.08.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Dec 2008 14:08:29 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBDM8SYa011723;
	Sat, 13 Dec 2008 23:08:29 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBDM8RgZ011720;
	Sat, 13 Dec 2008 23:08:27 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <ghv8rf$47v$1@ger.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103028>

"Edward Z. Yang" <edwardzyang@thewritingpot.com> writes:
> Jakub Narebski wrote:

> > Sidenote: There is probably one exception we want to add, namely not
> > escape '\r' at the end of line, to be able to deal better with DOS
> > line endings (\r\n).
> 
> I'm sorry, but I have to disagree. I find being able to see \r
> line-endings in the pretty-printed format is exceedingly useful for
> figuring out if a file has been checked in with the wrong line-endings.
> The number of files that must have \r line endings are vanishingly small
> (BAT files are perhaps the one example I can think of right now).

Well, it is a bit annoying if you have checked file with wrong line
endings, and just noticed this... I was thinking about adding '(DOS)'
or something indicator at the bottom of 'blob' and 'blame' views, but
I guess I can live with '\r'...

In short: I agree, that was not a good idea.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
