From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2/RFC] Make git-completion Bash 4 compatible.
Date: Thu, 28 Oct 2010 09:15:45 -0700 (PDT)
Message-ID: <m31v7ai9c2.fsf@localhost.localdomain>
References: <20101027131506.4da06c6d@MonteCarlo>
	<20101027173132.GA15657@burratino> <20101027225318.GB1877@neumann>
	<20101027205217.3f28b9d1@MonteCarlo>
	<20101028005455.GC31501@burratino>
	<20101028081445.27cc603b@MonteCarlo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	=?iso-8859-15?q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>
To: Peter van der Does <peter@avirtualhome.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 18:15:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBV8s-000538-Tb
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 18:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758753Ab0J1QPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 12:15:50 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:33786 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753683Ab0J1QPt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 12:15:49 -0400
Received: by ewy7 with SMTP id 7so1624144ewy.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 09:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=Mryu7iDlsVhoa3/hLCxrrEoXscg48hQEUUwhjNR38ko=;
        b=eaA+gfKU5Fau4kaL4IOpWJUmU4VE5xq4thtNhpeBjU4B+D4nFxNnrHjEymiQZz+Tr2
         +mWljXIdnLdGI1VvXocuaurNtUbvN6dtmPC0WTaa3KVw6/BtDU4hZum6GlHAdMwg7tPq
         MErmivme8Kas153Ic3jxeWG8ej+FtryeConrg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=otpxFnHr3+GC7wHH2TUouWDLgUDxiZl/7QhP4lfQIt7IB1iVuXOzQq7QhtTxM7T3dw
         wzE0FuQmozLmCcnmo3QcUZ5DzWIu1oaOOuaGa1c1frz9C4QHzsUgTwSIq4JPOo1kOjkL
         LcHPiEdBzfBMDGHXNmJnYTqTKQRaAoHZmR/r0=
Received: by 10.213.35.195 with SMTP id q3mr383581ebd.45.1288282548095;
        Thu, 28 Oct 2010 09:15:48 -0700 (PDT)
Received: from localhost.localdomain (abvj108.neoplus.adsl.tpnet.pl [83.8.207.108])
        by mx.google.com with ESMTPS id x54sm909529eeh.11.2010.10.28.09.15.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 09:15:45 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9SGEaZt011660;
	Thu, 28 Oct 2010 18:14:41 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o9SGDqo3011636;
	Thu, 28 Oct 2010 18:13:52 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20101028081445.27cc603b@MonteCarlo>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160185>

Peter van der Does <peter@avirtualhome.com> writes:
> On Wed, 27 Oct 2010 19:54:55 -0500
> Jonathan Nieder <jrnieder@gmail.com> wrote:
> 
> > Peter van der Does wrote:
> > 
> > > The bash completion script could still be included with the core,
> > > but we can offer different versions for different shells.
> > 
> > Why?  That's three times the maintenance work.
> 
> The cons of everything in one script:
> - If the script needs an update the submitter has to take in account
>   the different coding standards each shell has. Examples of this have
>   been given in the commit message of 06f44c3 (completion: make
>   compatible with zsh, 2010-09-06)
> 
> - The script could end up with a slew of if statements to see which
>   shell the script is running in and taking some action.
> 
> - Shells don't share all the same functions, the script could be filled
>   with functions not needed in other shells. the zsh patch includes
>   one, the Bash 4 patch includes several.
> 
> The pros of everything in one script:
> - Small changes, like adding an extra option to a git command for
>   completion only have to implemented in one script.

What about having separate scripts, but sourcing common library that
doesn't do completion, but just provides list of possible completions?
This would be best of both worlds, I think.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
