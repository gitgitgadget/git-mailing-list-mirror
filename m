From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: StGIT 0.13 recognizes but not list packed StGIT controlled branches
Date: Mon, 19 Nov 2007 19:26:07 +0100
Message-ID: <200711191926.07869.jnareb@gmail.com>
References: <200711190005.49990.jnareb@gmail.com> <200711191843.43247.jnareb@gmail.com> <b0943d9e0711190951u412b2c1apf6d7d48abdd59c07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 19:29:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuBML-0002t7-T6
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 19:28:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754164AbXKSS0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 13:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754755AbXKSS0P
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 13:26:15 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:23313 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754591AbXKSS0N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 13:26:13 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1498653nfb
        for <git@vger.kernel.org>; Mon, 19 Nov 2007 10:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=9rIautdQlAsL+ILZZbHdvPKrOqlxxcCL2FgmFuDbBXg=;
        b=TPSre170tv26h3NrMPWElKY0+C6Ww6hkgnwm5wvm6QNcX1/+qFnInpBPQFB28XiiwjCIKRu/REbIRQ6S/1te/3uyBHc6L7WAeqGeiISg/+75WC4iPniwnuRasj/ZRkc7iSy/3o8t2jv8JrLk6f6qaiO5q0kz7+di/JBVXz6cnw0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QGACmJzjB5Ajpwvffelvk1gZBQ+LYxPWa8HJo8BTfjV9WwHhAq7rrCykHXks3SvLhhb6MpRphPEWgVCXk5+UHC6lRpReyzEJ5XyzyvEp3ZIZYBAC/HCs1MWbqVzFmEMoVsiEqmu7SB5c5zZcSvrhc2lLNF8MKanHus2jBG0FrvE=
Received: by 10.86.4.2 with SMTP id 2mr5331685fgd.1195496770753;
        Mon, 19 Nov 2007 10:26:10 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.241.246])
        by mx.google.com with ESMTPS id e20sm7252193fga.2007.11.19.10.26.08
        (version=SSLv3 cipher=OTHER);
        Mon, 19 Nov 2007 10:26:09 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <b0943d9e0711190951u412b2c1apf6d7d48abdd59c07@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65483>

Catalin Marinas wrote:
> On 19/11/2007, Jakub Narebski <jnareb@gmail.com> wrote:
>>
>> By the way, does StGIT write something meaningful by default in reflog
>> messages? Because now my reflog looks like this:
> 
> No, it leaves it up to GIT to write whatever it finds appropriate.

But StGIT uses plumbing (or in the future perhaps PyGIT library).
And plumbing does not write by itself reflog messages. It is left
for porcelain (and StGIT being patch management interface is
porcelain) to provide reflog message in GIT_REFLOG_ACTION.

>> It would be really nice if StGIT wrote something meaningfull when
>> updating ref, like "stg refresh: <something>", or "stg rebase: <sth>"...
> 
> There is the 'stg log [<patch>]' command which shows the changes to a
> specific patch. You can run it with -d (for the diff) or -g (to invoke
> gitk).

If I remember correctly StGIT is made to be more friendly to and with
core-git. Providing reflog messages for "git reflog" / "git log -g"
would be nice.

Besides 'stg log [<patch>]' is a bit orthogonal: it describes history
of a patch, and I want history of HEAD or of branch head (with things
like refresh, new (!), goto, float / sink, rebase (!)).

-- 
Jakub Narebski
Poland
