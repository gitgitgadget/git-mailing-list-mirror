From: "Nikodemus Siivola" <nikodemus@random-state.net>
Subject: Re: Restoring files from old commits
Date: Wed, 15 Aug 2007 20:22:19 +0300
Message-ID: <6bcc356f0708151022v6cb8c348nb19690c81e489c5d@mail.gmail.com>
References: <4698BD17.5080205@random-state.net>
	 <20070714123754.GA29622@piper.oerlikon.madduck.net>
	 <20070714143233.GC2544@steel.home>
	 <7vbqeeizue.fsf@assigned-by-dhcp.cox.net>
	 <20070715084141.GA2568@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 15 19:22:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILMZn-0007Dc-JU
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 19:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933061AbXHORWX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 13:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932823AbXHORWX
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 13:22:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:11128 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932414AbXHORWV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 13:22:21 -0400
Received: by nf-out-0910.google.com with SMTP id g13so907768nfb
        for <git@vger.kernel.org>; Wed, 15 Aug 2007 10:22:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=OIHbCBwH6AdxJSSjRNXUT66JdBj84c3l3Jkzro57BUyJq3ywxhUXkpTfdS9fmzh94LVktXQkAc9iMtO2k8LcLArvwNh9V5riDc6gTmpaIf5Wdee0YRkwOfr8h+gM9nWuSj97OfPDVhkKIYZ/elyQRkjMZ6BEJJRkAiN2HyzfqGI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Mfe3eE/f/3QLXVEibX1O3QWThdW/ecsFejGsu5mDF8I562KbHexD41mBfSYkiJe5dc3E5ri6wD4Y9N+H7gRA7/hLHDoQ0SZUYwBSX5QJOypmQkl9E1Uqbc4ZQtIJ+/ge+ZUwGEFcChfbXo5q4YYg2WsqiaGXTiuU92Gs/N3D6zI=
Received: by 10.78.149.15 with SMTP id w15mr283289hud.1187198539458;
        Wed, 15 Aug 2007 10:22:19 -0700 (PDT)
Received: by 10.78.164.1 with HTTP; Wed, 15 Aug 2007 10:22:19 -0700 (PDT)
In-Reply-To: <20070715084141.GA2568@steel.home>
Content-Disposition: inline
X-Google-Sender-Auth: 28f73251e80f00c7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55928>

Tangentially related to my previous question:

Every once and a while I want to examine an older version
of a file in an editor.

(The typical case is first looking for the source of a change
with git-blame, and then wanting to look at the original code
and the diff side by side.)

My current (suboptimal, I hope!) way of doing getting the file
is git-cat-file: first look at the commit, then look at the tree,
... till I find the SHA1 for the file I want.

git-checkout <sha1-of-commit> <path>, but that leaves the old
version in both the index and the tree, which feels icky especially
if I'm giving this treatment to multiple files at the same time.

So what I'd like is something like

 git cat-path <commit> <path-in-the-tree-referenced-by-that-commit>

Does this exist, or is this scripting time?

Cheers,

 -- Nikodemus
