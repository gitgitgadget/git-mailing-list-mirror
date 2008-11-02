From: "Elijah Newren" <newren@gmail.com>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI revamp
Date: Sat, 1 Nov 2008 22:41:17 -0600
Message-ID: <51419b2c0811012141x1620f111rbebc836f816c7b4e@mail.gmail.com>
References: <1225338485-11046-1-git-send-email-sam@vilain.net>
	 <20081030143918.GB14744@mit.edu> <1225389068.19891.28.camel@maia.lan>
	 <51419b2c0811011327j492b520dq2388fc8972b48cab@mail.gmail.com>
	 <20081102010634.GF8134@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Sam Vilain" <sam@vilain.net>, git@vger.kernel.org,
	"Sam Vilain" <samv@vilain.net>
To: "Theodore Tso" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Nov 02 05:42:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwUnI-0001mu-TV
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 05:42:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbYKBElT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 00:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbYKBElT
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 00:41:19 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:31621 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbYKBElS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 00:41:18 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1989750rvb.1
        for <git@vger.kernel.org>; Sat, 01 Nov 2008 21:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=vSUb7j2hkK5LxQOUndD+eldti6WSRQJMoBeb1Maed6o=;
        b=VviH0vRO/cUDqXkp0XJtTuurxSPTl6oBZF+rQ68flx34M5ub87K8+L9O9pDZHLos39
         HUKUXGDL+23uuinh4aCXe7Omx0lTgSBESbsXBBso0KHD1EsTaceLMCo77+fHWqz+d5cv
         7mbol7/nGnTyQm/YQMw3r/NoUBpLMvaqmj4EY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=xn0F4orBSe5JCV66dsFxXobzXXircNRLmZAe751dIKi/BH5HfCchoFyGWX1JEr6bFm
         UcGJVjUjQWwnkRGIb2DPhbe20yyFSOfPiWXcEmoQrv4DyGY/Lh3sd7WmcBCkjXhiv0NT
         wsd+ugtBfQ5YP6bKKIzjrvZPDe5gCVmBufeOE=
Received: by 10.141.195.5 with SMTP id x5mr7934682rvp.263.1225600877656;
        Sat, 01 Nov 2008 21:41:17 -0700 (PDT)
Received: by 10.141.163.16 with HTTP; Sat, 1 Nov 2008 21:41:17 -0700 (PDT)
In-Reply-To: <20081102010634.GF8134@mit.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99812>

On Sat, Nov 1, 2008 at 7:06 PM, Theodore Tso <tytso@mit.edu> wrote:
> In my opinion, that is a Really Bad Idea from a usability and UI
> design point of view.  Each command should do one and only one thing,
> and not do different things depending on what options you give it.
> Git violates this rules in a number of places already, What you call
> "revert-since" and "revert-in" are so different that using the same
> subcommand is just going to horribly confuse users.
>
> Better to have "git revert" print a message explining that it is
> deprecated, and to tell users that they probably want either "git
> cherry-pick --revert" or "git revert-file", depending on whether they
> are an experienced git user (in which case they probably want git
> cherry-pick --revert"), or if that person who is familiar svn or hg's
> "svn revert" or "hg revert", they probably want "git revert-file".

Yeah, good points.  I guess I could just make --no-commit the default
in all cases to remove the "magic", but then it's too much typing for
the revert-in case ("eg revert --commit --in REVISION" vs. "git revert
REVISION").  Two separate commands may make more sense, but then
there's the naming issue (I had difficulty coming up with a different
name that I liked, and it appears others are having a little trouble
with the naming too).  Tough nut to crack from any angle.  :-(
