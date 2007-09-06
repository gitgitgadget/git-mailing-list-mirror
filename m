From: "Miles Bader" <miles@gnu.org>
Subject: Re: [PATCH] Include a git-push example for creating a remote branch
Date: Thu, 6 Sep 2007 14:57:26 +0900
Message-ID: <fc339e4a0709052257m4ddc5784obe64a8b75b79b19@mail.gmail.com>
References: <20070906044408.GA588@spearce.org>
	 <buoodggo0l2.fsf@dhapc248.dev.necel.com>
	 <20070906050127.GS18160@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 07:57:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITAMw-0007Xs-1v
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 07:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790AbXIFF5a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 01:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754082AbXIFF5a
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 01:57:30 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:46938 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545AbXIFF53 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 01:57:29 -0400
Received: by wx-out-0506.google.com with SMTP id h31so59742wxd
        for <git@vger.kernel.org>; Wed, 05 Sep 2007 22:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=SJB68wnd6/Johf38RV8zQuWwrSQZA7xnKYZ8oc8fEj0=;
        b=F31jSKFnof8fdaHvE0UehrBYi+7oD9JudPLyvVVt8cCv/tY2s24jemwFjWxNijmPnP1CMFslG46ABfObNAi9KrDOfGRNsZwc8D6ng/J4UeVYrUNhEUAmLTNGl8r614gi4BdTBVeQSBU7zIHk0CD+T1+5bc9GMFW1y3RY/dTCur0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=d3wgdupXqSp0/EwmPaHlwjHNhqVUOS3KRXrdOJm1rsPk5eq8Y5T31Wne4/u36eDMEN+hhXFpLx5JIqiqLM6sXZ/sWCqng2QMZEA2L80LApQuH6hMJYpJMg5gZSe5V1SEzRtKkQl57wSFtxtJKTDkRnHNa4zG7WNJxVkWwgqgiMQ=
Received: by 10.90.81.14 with SMTP id e14mr423045agb.1189058246439;
        Wed, 05 Sep 2007 22:57:26 -0700 (PDT)
Received: by 10.90.68.16 with HTTP; Wed, 5 Sep 2007 22:57:26 -0700 (PDT)
In-Reply-To: <20070906050127.GS18160@spearce.org>
Content-Disposition: inline
X-Google-Sender-Auth: bb76fe5f51fa8990
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57824>

On 9/6/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Miles Bader <miles.bader@necel.com> wrote:
> > > Many users get confused when `git push origin master:foo` works
> > > when foo already exists on the remote repository but are confused
> > > when foo doesn't exist as a branch and this form does not create
> > > the branch foo.
> >
> > Hmm, what _does_ it do in that case...?
>
> error: dst refspec experimental does not match any existing ref on the remote and does not start with refs/.

Hmm, I'm assuming people don't want to default to just creating a new
remote ref ('cause it might be too easy to muck up a remote archive
that way), but it seems like it would be nice to have a "prettier" way
to create a remote ref than explicitly giving the whole ref path on
the remote side.

Maybe I"m weird, but I tend to think of the refs/... syntax as being
for "only if you're doing something funny" cases.

I'm thinking of something like:

  ... create new local branch "zoink" ...
  git push --create origin zoink

-Miles

-- 
Do not taunt Happy Fun Ball.
