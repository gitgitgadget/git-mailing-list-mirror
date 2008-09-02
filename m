From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] for-each-ref: `:short` format for `refname`
Date: Tue, 2 Sep 2008 07:39:12 -0700
Message-ID: <20080902143912.GB28704@spearce.org>
References: <7vprnpbqmo.fsf@gitster.siamese.dyndns.org> <1220186467-24623-1-git-send-email-bert.wesarg@googlemail.com> <20080901131523.GA6739@neumann> <36ca99e90809010713h7c673d10j6addd1624a655371@mail.gmail.com> <36ca99e90809011052s568fa6e4y89e56769f63806c1@mail.gmail.com> <20080901191051.GD7482@spearce.org> <36ca99e90809011410w646cc6eajb3063ea3501f173c@mail.gmail.com> <7v7i9vv9n2.fsf@gitster.siamese.dyndns.org> <36ca99e90809011444v3fca09c4o4d9dcf1a7249a00a@mail.gmail.com> <36ca99e90809020026j37c41a8fu99b45abbd02eb372@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	SZEDER GGGbor <szeder@ira.uka.de>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 16:41:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaX3M-000329-N2
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 16:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbYIBOjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 10:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbYIBOjN
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 10:39:13 -0400
Received: from george.spearce.org ([209.20.77.23]:42102 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbYIBOjN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 10:39:13 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8831338375; Tue,  2 Sep 2008 14:39:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <36ca99e90809020026j37c41a8fu99b45abbd02eb372@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94676>

Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> 
> given these two refs:
> 
>   refs/heads/xyzzy
>   refs/tags/xyzzy
> 
> first try to shorten "refs/heads/xyzzy":
> 
>   first (from the end) matched pattern is "refs/heads/%.*s" with
> "xyzzy" as result
> 
>   but resolved ref for "xyzzy" is "refs/tags/xyzzy" => continue
> 
>   next matched pattern is "%.*s" with "refs/heads/xyzzy" as result
> 
>   end result is therefore: "refs/heads/xyzzy"
> 
> second try to shorten "refs/tags/xyzzy":
> 
>   first (from the end) matched pattern is "refs/tags/%.*s" with
> "xyzzy" as result
> 
>   resolved ref for "xyzzy" is "refs/tags/xyzzy" => end
> 
>   end result is therefore: "xyzzy"
> 
> the output would be:
> 
>   refs/heads/xyzzy
>   xyzzy
> 
> The question is now, if this is usable for bash completion? Current
> bash completion would handle this case wrong, because you get two
> xyzzy.

I think this is reasonable.  Its better than what we have today,
which is ambiguous completion.  So this looks reasoanble to me.
Usually people don't have ambiguous names, but it happens.  I've
been known to do something stupid like this:

  git checkout -b v1.0 v1.0
  git reset --hard v1.2
  git log v1.0
  # wtf?!?!!?!

;-)

-- 
Shawn.
