From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2009, #05; Sun, 22)
Date: Tue, 24 Nov 2009 02:53:48 -0800 (PST)
Message-ID: <m3ljhwb3d6.fsf@localhost.localdomain>
References: <7vhbsl935q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 11:54:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCt2I-0007xf-Gb
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 11:54:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932787AbZKXKxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 05:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932786AbZKXKxp
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 05:53:45 -0500
Received: from mail-bw0-f223.google.com ([209.85.218.223]:33235 "EHLO
	mail-bw0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932784AbZKXKxo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 05:53:44 -0500
Received: by bwz23 with SMTP id 23so6161795bwz.29
        for <git@vger.kernel.org>; Tue, 24 Nov 2009 02:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=RqRAEJaJ8FzJi2TvEpw3fXbaFf1VqOZVYQS0ttkOVXM=;
        b=m89dkusz3lQB2xPVH+P/vsReJTvecod3RJasZjuldwJEusyyjSoeQhtxoq8+dJSfTz
         gfc+pLFaz8rc7BQ6JRoZcYPlrSGjyDMCsgfiRMtgMYIX4Cv9xW1jaI3VbI193Y4TdmkV
         Qd/0sKRVUekQvaB+zf5hqdwSEyTgjDCxJHbh0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=AhI2RVX0NvMHHyQLhV2kPHwOje5TQQVeXwYfpVXUQjvJxO9T+hUzi/VB4iX0rYWg0R
         K17dU9AihXAw0ylb1cPzRc9MG0HfqlYZVUYuZlEMCI7jL0EHWD8csglTZDWUPXUmro7H
         0JCfns22Yej5ay4xauNfAowXRd8VgrDgJ/xDc=
Received: by 10.204.26.130 with SMTP id e2mr5948457bkc.144.1259060029819;
        Tue, 24 Nov 2009 02:53:49 -0800 (PST)
Received: from localhost.localdomain (abvk170.neoplus.adsl.tpnet.pl [83.8.208.170])
        by mx.google.com with ESMTPS id 15sm1354993bwz.8.2009.11.24.02.53.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Nov 2009 02:53:48 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nAOArjHs022568;
	Tue, 24 Nov 2009 11:53:45 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nAOArfJS022565;
	Tue, 24 Nov 2009 11:53:41 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vhbsl935q.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133572>

Junio C Hamano <gitster@pobox.com> writes:

> * jn/gitweb-blame (2009-11-19) 6 commits.
>  - gitweb.js: fix null object exception in initials calculation
>  - gitweb: Minify gitweb.js if JSMIN is defined
>  - gitweb: Create links leading to 'blame_incremental' using JavaScript
>   (merged to 'next' on 2009-10-11 at 73c4a83)
>  + gitweb: Colorize 'blame_incremental' view during processing
>  + gitweb: Incremental blame (using JavaScript)
>  + gitweb: Add optional "time to generate page" info in footer
> 
> Ajax-y blame, with a few recent fixes.

Unfortunately current version does not work with IE8 (reported by
Stephen Boyd); it stops at the very beginning of JavaScript blaming
with the two JavaScript errors:

- "firstChild is null or not an object", caused by the fact that
  '<a href=""> </a>' element doesn't have firstChild which is text
  node with space as contents in DOM.  This can be easily worked
  around.

- "Unspecified error" (twice (sic!) for the same line), which
  I have currently no idea how to fix; it points to the following
  line:

       if (xhr.readyState === 3 && xhr.status !== 200) {

> * pb/gitweb-no-project-list (2009-11-06) 3 commits.
>  . gitweb: Polish the content tags support
>  . gitweb: Support for no project list on gitweb front page
>  . gitweb: Refactor project list routines
> 
> I picked these up but didn't queue as Warthog9's comments made certain
> amount of sense to me.

I'd like to see at least refactoring project list subroutine:
currently printing list of projects is entangled with filtering
said list; IMHO filtering list of projects should be done upfront.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
