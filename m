From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [RFC PATCH v3 00/17] Return of smart HTTP
Date: Fri, 16 Oct 2009 19:04:45 -0400
Message-ID: <ca433830910161604g5a6bde76n26eb2b1e8155fb36@mail.gmail.com>
References: <1255577814-14745-1-git-send-email-spearce@spearce.org>
	 <ca433830910152120l1bd358ads6401572ccc05b29@mail.gmail.com>
	 <20091016143154.GS10505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Oct 17 01:04:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Myvqu-0008NX-Cp
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 01:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbZJPXEn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Oct 2009 19:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbZJPXEn
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 19:04:43 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:63257 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbZJPXEm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Oct 2009 19:04:42 -0400
Received: by fxm18 with SMTP id 18so3007731fxm.37
        for <git@vger.kernel.org>; Fri, 16 Oct 2009 16:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bVZenEkoAwj57+sWiiS1wqMovj1iJ5/sZi9W6c2iQrY=;
        b=Hn68IguiMzWVaSBLMHhJXUeAAk8DjhkZmH7gJiykHCGEOQDdJxNQRRmapXOexu/Uay
         OuJtd3DP1FuU6gHi0+6/VLZR92fQCNxbCMemj3bS5W6b0DS0G418PSbvpOJpdiKcGgn4
         kW+TF5Tq80DKbUjbKiRGeTU6MTEt2Wl9YNVa4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Q4jPvp/AZR8vidcCvd7Rn11Yix2mkAvpachgnjMbXKzViZ+ZDhil0V0Mx7M3X24v/o
         Mc2XMw1yu8HICy305B1o0Xgy5sSJQyLrhLtq/aC5KQXyMFHjUkp9M87oRMKvWWY9rhf2
         YcW4m9tOWinZp/cxF1R9U0kmg2qPYZEWc0BQU=
Received: by 10.103.125.38 with SMTP id c38mr829431mun.119.1255734285762; Fri, 
	16 Oct 2009 16:04:45 -0700 (PDT)
In-Reply-To: <20091016143154.GS10505@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130534>

I just realized I forgot to say something in my last email: THANK
YOU!!!  I have been looking forward to this for a long time.  I was
planning to one day to sit down and start thinking about how to
implement a smart protocol, and then I see a post saying that not only
has someone figured out the protocol, but he has implemented it!
Amazing!  This is really crucial for corporate adoption, at least at
my job.  We need to have strong authentication for many users, and the
SSH key management is just a nightmare, not to mention that not all
users can SSH due to firewalls.  This will save me so much time and
frustration.  Thanks!

On Fri, Oct 16, 2009 at 10:31 AM, Shawn O. Pearce <spearce@spearce.org>=
 wrote:
> If users don't want to upgrade, or can't upgrade, then you can't
> push over HTTP. =C2=A0Simple.

Yeah, I realized after I wrote my previous email that it probably
doesn't matter - the current state of HTTP push is so awful that no
one probably uses it!

> Really, what it comes down to is, I don't think it matters that
> we don't have backwards compatiblity for pushing through WebDAV.
> If you think it matters, you are free to write a patch series on
> top of mine which adds the functionality. =C2=A0But don't wait for me
> to do it, it won't happen.

Agreed.  I was just wondering if it was on the to-do list for the far
off future.  Either way, it should probably be noted in the
documentation that dumb push is not supported.

>> Also, your examples use "DocumentRoot /pub/git", but I think most
>> people would want to have their main website as the DocumentRoot, ha=
ve
>> the URL "/git" serve the repositories through gitweb, and have that
>> same "/git" URL be `git clone'-able.
>
> Why not have git-http-backend exec gitweb when it gets a request
> for the repository itself? =C2=A0Why do you have to go through such
> contortions in Apache for this? =C2=A0The two CGIs are shipped in the
> same software package, surely one could actually invoke the other.
>
> [snip]
>
> Yes, I'd like to have examples in the git-http-backend manpage.
> I put a couple in there already, but they don't consider gitweb
> because I assumed we'd find a way to have gitweb be invoked out
> of git-http-backend.  Unfortunately that hasn't happened yet.

The gitweb part is just bonus.  (The only thing for gitweb is the one
ScriptAlias line.)  The real challenge is getting git-http-backend to
serve repositories out of something other than DocumentRoot - say
DocumentRoot is /var/www/htdocs but your git repositories are in
/pub/git - which is why I posted the configuration.  If you'd like, I
can send you a patch to add this to the documentation.

One idea to improve the situation is to first try
$GIT_PROJECT_ROOT$PATH_INFO, falling back to $PATH_TRANSLATED if
$GIT_PROJECT_ROOT is empty.  This would make the configuration simple:

-- 8< --
SetEnv GIT_PROJECT_ROOT /pub/git
ScriptAlias /git /usr/libexec/git-core/git-http-backend
-- >8 --

As far as having git-http-backend launch an external process such as
gitweb, I personally don't think this is important enough to block
this from continuing.  One could configure the webserver as I have in
my previous email until such a feature is implemented.  For cgit, the
solution is simple - just integrate git-http-backend into the
executable.

Regards,
Mark
