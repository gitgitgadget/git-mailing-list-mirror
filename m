From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Wed, 16 Jul 2008 15:46:34 -0400
Message-ID: <32541b130807161246l579d3a5em65496ee9119ef1ef@mail.gmail.com>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
	 <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com>
	 <7v7iblsnfh.fsf@gitster.siamese.dyndns.org>
	 <32541b130807161151x19c20f9t91b7fb9b8c7b8c7b@mail.gmail.com>
	 <7vmykhr6h1.fsf@gitster.siamese.dyndns.org>
	 <32541b130807161229ob4c21cbsc6c86ee3e42c4101@mail.gmail.com>
	 <7vabghr5br.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 21:47:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJCyO-0000Sq-SJ
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 21:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753722AbYGPTqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 15:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753849AbYGPTqg
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 15:46:36 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:36042 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753722AbYGPTqf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 15:46:35 -0400
Received: by an-out-0708.google.com with SMTP id d40so84088and.103
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 12:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=1G97+8zYZVGRgSjXQawTKZCKp+3Y8c75n8fC+XWPYpM=;
        b=odKrpj02+53+RRLmytjaYIhcciXAKvXjcXC0eyIZ77o23r4brnjpsuavSEOiUAHA3s
         CMVUnYoECw2gF/1D6F1PortMdnPAN+4ahq+lr0EpdqiGRnA1eAufQYp7HJT8YCtjibwD
         QgaskjOZbcbB4kYs3l+CnZ5tk17HifuUp8jrI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=r5B1akyTsbJx2phpK5XGM7gZJpcUj7LOs9YJoWMONdKOjfGUIuumjZ2dlUUNj7/5D3
         5UROI0R1Er8wqvK1RtDXY8HnJO7EVOk2KsjyyWzf7aealPwgiR4Qgp/z7ufW52jR2Ozm
         RT7la3Zdj2sk9VWqrvLvgxbAnvIjJvO7ocysg=
Received: by 10.100.140.10 with SMTP id n10mr2668047and.129.1216237594437;
        Wed, 16 Jul 2008 12:46:34 -0700 (PDT)
Received: by 10.100.8.19 with HTTP; Wed, 16 Jul 2008 12:46:34 -0700 (PDT)
In-Reply-To: <7vabghr5br.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88736>

On 7/16/08, Junio C Hamano <gitster@pobox.com> wrote:
>  You said svn makes it easier because it makes it very hard to do merges
>  and forces users to stay away from them.  This results in user doing "svn
>  update" which is to resolve conflicts with large uncommitted changes but
>  keeps the history straight single-strand-of-pearls.
>
>  I am not saying the merge based workflow in git does not have any room to
>  improve.  I am just saying that there is nothing we can learn from svn in
>  that area.  "Solves it by not letting us to do merges" is not a solution.

What svn does is essentially an unsafe version of

       git stash && git pull x y && git stash apply

And that's actually a good example of what I'm talking about; in svn,
that's just "svn up", which is a daily operation that's easy and
leaves a clean, linear history.  In git, it takes three commands
instead of one (and 'git stash' wasn't anywhere in Dscho's list of
commands he teaches to newbies).

I think there's value in thinking about the relative convenience of
svn's workflow for novice users in their day-to-day lives.  Now, in
the case of svn, that "convenience" also leads to novice users blowing
up the local changes in their working copy occasionally, but that's
just an svn *architectural* problem.  Git doesn't have that
architectural problem.

To be more concrete: would anyone object to a patch that simply made
'git pull' include the above stash commands (or something like them)
by default, rather than giving up when dirty files would be changed?
Or can we do even better?

Have fun,

Avery
