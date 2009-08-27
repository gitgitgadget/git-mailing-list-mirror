From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Question regarding git fetch
Date: Thu, 27 Aug 2009 15:36:53 +0000
Message-ID: <32541b130908270836m50553ccatddf4c870eec54ddb@mail.gmail.com>
References: <1251387045053-3527289.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Tom Lambda <tom.lambda@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 17:37:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgh2Q-0000bw-Cb
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 17:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbZH0PhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 11:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752695AbZH0PhN
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 11:37:13 -0400
Received: from mail-yw0-f184.google.com ([209.85.211.184]:62262 "EHLO
	mail-yw0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997AbZH0PhL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 11:37:11 -0400
Received: by ywh14 with SMTP id 14so1559187ywh.1
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 08:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=ahLCsSPTjm7bLYpXwn0jlf8ZIONFL7qVrEFGfTgDEZc=;
        b=Orlyb0FOpAkzko+gS86zBqvFmMOI7IvL10MYXOT4CfSmT1p49vGj5I1zFsar010Vts
         Ro0CIvuYC2iOKyjfMn1rmwRWHNyqlDoXUAdFXnHn2M9y3l0JQhwomuYj/qaendPB34kb
         i7MKd5d2FgtIDtBNjz7rPByugnHMGnzGHvPk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=aGhJyAYWze3C60brIfPWDPnzNiDmwOZrcOZsmdhhiLjI5PzUZWKyAr+dVK6pDS12UB
         haQlghFd7aSD2MyVE37wJdn7QI7m+9bN+6iUquDN4BEnwQbiV3zmq1ztX0uy3KSBsBQu
         rw0FV236SJEoZJcCVMuDpsFaAQCICBYJhS6xA=
Received: by 10.150.8.3 with SMTP id 3mr57961ybh.62.1251387433163; Thu, 27 Aug 
	2009 08:37:13 -0700 (PDT)
In-Reply-To: <1251387045053-3527289.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127165>

On Thu, Aug 27, 2009 at 3:30 PM, Tom Lambda<tom.lambda@gmail.com> wrote:
> What was a little bit surprising to me is that running "git fetch central
> master" does not update refs/remotes/central/master but simply updates
> FETCH_HEAD.

I've often wanted this myself, especially when doing things like "git
pull origin master".  However, I know the current behaviour is also
useful sometimes, and changing it would introduce an unexpected side
effect.  Git currently promises that your refs/remotes/* branches will
never be updated unless you explicitly request it, even if you're
fetching, merging, and pulling other stuff.  This means you can write
scripts to do complicated things without triggering unexpected
user-visible side effects.

So basically, I agree that it would often be much more user-friendly
to do what you're asking.  But it would be less scripting-friendly.  I
don't think anyone has thought of an answer that better balances the
two.

Have fun,

Avery
