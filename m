From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [WIP PATCH 01/18] rev-parse: add --internal-cwd and --internal-git-dir for tests
Date: Mon, 25 Oct 2010 03:15:58 -0700 (PDT)
Message-ID: <m339ruk284.fsf@localhost.localdomain>
References: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
	<1287922310-14678-2-git-send-email-pclouds@gmail.com>
	<20101024154005.GB31764@burratino>
	<AANLkTimfDVPFK7y-bkg-QYsTyHKdoxmvZxzzt36w95r5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 25 12:16:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAK64-0006TS-4v
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 12:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755115Ab0JYKQD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 06:16:03 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:36637 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755107Ab0JYKQB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 06:16:01 -0400
Received: by wwe15 with SMTP id 15so570413wwe.1
        for <git@vger.kernel.org>; Mon, 25 Oct 2010 03:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=APhGo8UatTnm10ELZn4ZGWMgphuvXZ+5hgjYbe7c298=;
        b=q4LVKxyOQ84pFJGNuMLTDgfh01qDkPfNfwpoKB0b5LVfiDevxg5iAsnJqM8jDiMcF6
         LSv4KFIfbAszx1usPsDci33GVjq21Y1HRa2yVwxkL+zgA/+QHcCq6MgGUZhcF5O+oqJK
         7wl9Fj94jJeltt2PBmODX5y2CEMqAKtktw6I0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=NROs3p/rC+lqE0u4Rv+SOovuafgUoJH58bpq+xX5ZotOGI8AnwYFADpjbbp3mvSKU+
         lIc2gnB2Pv4qkukE7TepRbx+H4UvKaETKgQxG7XnBASZNWG3t2mnIX1ZtMeHTOUftfCW
         Qq8hkPDAoz2KPBCKIxyg2EoibRWqmMkQ3uXRU=
Received: by 10.227.135.16 with SMTP id l16mr6222969wbt.158.1288001760318;
        Mon, 25 Oct 2010 03:16:00 -0700 (PDT)
Received: from localhost.localdomain (abwi90.neoplus.adsl.tpnet.pl [83.8.232.90])
        by mx.google.com with ESMTPS id ga16sm5509567wbb.7.2010.10.25.03.15.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Oct 2010 03:15:58 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9PAFUpm019960;
	Mon, 25 Oct 2010 12:15:36 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o9PAFPdr019951;
	Mon, 25 Oct 2010 12:15:25 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTimfDVPFK7y-bkg-QYsTyHKdoxmvZxzzt36w95r5@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159937>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> 2010/10/24 Jonathan Nieder <jrnieder@gmail.com>:

> > I think it might: just like the exec: lines provide context about what
> > command is being traced, such trace: cwd: lines would make it clearer
> > what paths that are being output might be referring to.
> 
> Also prefix them all with "setup:", something like
> 
> setup: git_dir: ../.git
> setup: work_tree: /my/git/worktree
> setup: cwd: /my/git/worktree
> setup: prefix: sub/

I guess that those paths would be c-quoted, if necessary (trailing
space, embedded newline, quotes, etc.)?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
