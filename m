From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Adding Git to Better SCM Initiative : Comparison
Date: Sun, 13 Jan 2008 17:25:07 +0100
Message-ID: <200801131725.09301.jnareb@gmail.com>
References: <20080113150541.21883.qmail@science.horizon.com> <vpqd4s5ycvv.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: linux@horizon.com, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Jan 13 17:26:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JE5fD-0000fX-Ou
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 17:26:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753278AbYAMQZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 11:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752838AbYAMQZR
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 11:25:17 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:59274 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752817AbYAMQZP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 11:25:15 -0500
Received: by ug-out-1314.google.com with SMTP id z38so731393ugc.16
        for <git@vger.kernel.org>; Sun, 13 Jan 2008 08:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=8olPURQGhmgzhMz6NBxJwGOMKNVHjNIe2vCx0OteDmU=;
        b=OgoF2Ovp4lxNq3ZtmHB0iOPewzni2gfkS4k9OKqoK2qV/BoIyrDYhL1CRMRB1AQjIQNrbvIVXzjy+y/sGmn5R98RGFC8xd5pssxo+1zCpmja0xDg41rt9+pB6dEfHp0i6PvwtTZfB9LIXozBIkCsQlFRN+qb+7KteMcyUzmMTpE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=D5T9FUBrCsdmcnyTntX+/P0gdqqx8YQiimgBsS1/AxgYbAebPRNh/jO7wD0iWSy78CnOLdg+p2o+3JX/YqoaLQfVlQj+EtiN6YA0lCUJF7WM//qgWOhiWIN2zV2QOvtIHMpu4/9Sywyw3HTL3henAMjj9YfeHjh8CXmBig9vhNI=
Received: by 10.67.32.7 with SMTP id k7mr2894408ugj.46.1200241513624;
        Sun, 13 Jan 2008 08:25:13 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.201.31])
        by mx.google.com with ESMTPS id k30sm17794339ugc.53.2008.01.13.08.25.11
        (version=SSLv3 cipher=OTHER);
        Sun, 13 Jan 2008 08:25:12 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <vpqd4s5ycvv.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70390>

On Sun, 13 January 2008, Matthieu Moy wrote:
> linux@horizon.com writes:

Can't you use a name or nick, by the way?
 
> > "Rename support" is a kludge to make a fundamentally broken model
> > less painful.
> 
> It's not.
> 
> Git _has_ rename support. Look into the code, you'll find some code
> whose purpose is to manage renames. And _no_, rename support is not
> just a direct consequence of commits being atomic.
> 
> Atomic commit help, but if you do nothing else, moving a file and then
> trying to merge will fail for example. So, in addition to atomic
> commits, you have at least 3 options : explicit file ID (bzr),
> recording renames (hg), or detecting renames after-the-fact (git).

Rename detection / dealing with renames in SCMs is needed for:
0. Recovering previous state
1. Merging correct files
2. Forensic (log, blame) across renames / code movement

While the fact that Git is snapshot based and has whole-tree atomic
commits (Subversion does too) make it automatically obey 0., some
kind of rename support is needed for merges (Better SCM has it in TODO),
and for examining history, for example if the file was renamed in
one of the branches.

For example "git log --follow=gitweb/gitweb.perl" follows history of
specified file (IIRC this does not work for directory; but then Git
does not per se tracks directories), even if it was called gitweb.cgi
at the very beginning. "git blame -M" assign commit to a line denoting
when line was created, and not when it was moved (perhaps across file
boundaries) in the current place.

-- 
Jakub Narebski
Poland
