From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: BUG: "git add --interactive" does not work with UTF-8 filenames
Date: Wed, 2 Apr 2008 12:17:14 +0100
Message-ID: <200804021317.16007.jnareb@gmail.com>
References: <200804012232.03559.tlikonen@iki.fi> <m3y77xtk32.fsf@localhost.localdomain> <7v63v1ccmb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 02 13:18:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jh0z5-0007wO-CB
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 13:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523AbYDBLRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 07:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755522AbYDBLRT
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 07:17:19 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:27306 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846AbYDBLRR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 07:17:17 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2845892fgb.17
        for <git@vger.kernel.org>; Wed, 02 Apr 2008 04:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=vwGfGXkA/GtK2aNts3P4F9jBmUOFayKsRYqaSXS6u5o=;
        b=PJEBNViZSMislr7+VbB+JHfWr1ebBLrIcNporbeJUq6na99WxRZG4bJW4wg2b4wDBfwvzPE2h2oXk2+G8kkhKrnC0d69xbchmmkLKgMkwqM+vA4XCD2/+tKd5ZSYwl+nQ9gwU2HDkvX4m90V3XrwOqI0hgqYnz5Je+1ngi9P+dA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RpO+eMTlu4IrYY5zkm4nTeIcbOSHu9d/ce+Ab4hMTG7aRR5B82iHpeSLkas7FQcs7JOExpYl+XQhB/18RbOFcxb6knHthHzYp5eh3vFmqj46T0fTtGUv3PtHP9pfDcWh9th58EtCdj8l2FGwSH9HHLi55J/9iATVaWWsTEg2b40=
Received: by 10.82.181.8 with SMTP id d8mr22276347buf.17.1207135035240;
        Wed, 02 Apr 2008 04:17:15 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.226.198])
        by mx.google.com with ESMTPS id m5sm1972251gve.9.2008.04.02.04.17.12
        (version=SSLv3 cipher=OTHER);
        Wed, 02 Apr 2008 04:17:13 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v63v1ccmb.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78690>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > git-config(1):
> >
> >   core.quotepath::
> > 	The commands that output paths (e.g. `ls-files`,
> > 	`diff`), when not given the `-z` option, will quote
> > 	"unusual" characters in the pathname by enclosing the
> > 	pathname in a double-quote pair and with backslashes the
> > 	same way strings in C source code are quoted.  If this
> > 	variable is set to false, the bytes higher than 0x80 are
> > 	not quoted but output as verbatim.  Note that double
> > 	quote, backslash and control characters are always
> > 	quoted without `-z` regardless of the setting of this
> > 	variable.
> >
> > Since 1.5.2.2 (I think), or at least 1.5.3, so you have new enough
> > version of git (git is now at 1.5.5-rc2).
> 
> Yes, but I do not think "add -i" unwraps the path quoting.  I think it
> should, but I do not think I bothered to.  Because it is trivial to do by
> any aspiring git hacker wannabes, I left it as an exercise to readers when
> I did the "interactive" as a quick-and-dirty hack (aka "demonstration").

By the way, the code to unwrap the path quoting can be found in gitweb
as unescape() subroutine... or git-add--interactive can use '-z' switch.

-- 
Jakub Narebski
Poland
