From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2009, #01; Wed, 07)
Date: Thu, 08 Oct 2009 18:38:48 -0700 (PDT)
Message-ID: <m3iqepgxcc.fsf@localhost.localdomain>
References: <7viqeqjsx6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 03:46:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mw4Z6-0004ni-Hk
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 03:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760152AbZJIBkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 21:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760129AbZJIBkj
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 21:40:39 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:1466 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757433AbZJIBki (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 21:40:38 -0400
Received: by fg-out-1718.google.com with SMTP id 22so171358fge.1
        for <git@vger.kernel.org>; Thu, 08 Oct 2009 18:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=yQp+hOxFa/htT/DXkYdkqViFNGY9Ft6v4l3Z66bBFLk=;
        b=XDPRgQKCCMCSMHtS9EzC33CfRTTp67elC/f327zdBR5XzAtz+cNDsftAQB0q8lfVz5
         Y1cuDwNNUgowMWH5MrwUpSnr+9JQ8B9OxNA9nNGCiikFzaHfnU0EG1PnEW3k20WrDeMy
         qBEPdqC5ueOcGUzdUvu1svDrcfC5LkxF5eGIA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=hHktSh3hzKAvx7ty3T5lzk+3OWtj1aifS16j7hu5lySyPmSOCF5qyoXxRbMp+k03mi
         +US21zZjeppF2ojZmVWfXB4LGXwhvpAv/QhkVDWT9JsjLwrnlFNd8i/mQQOGX6n6HIGZ
         ElKc/Ceopw05bLLEOieEimL++i/LDL65ej+Rs=
Received: by 10.86.181.6 with SMTP id d6mr1822568fgf.29.1255052329525;
        Thu, 08 Oct 2009 18:38:49 -0700 (PDT)
Received: from localhost.localdomain (abve46.neoplus.adsl.tpnet.pl [83.8.202.46])
        by mx.google.com with ESMTPS id d6sm1383785fga.0.2009.10.08.18.38.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Oct 2009 18:38:48 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n991dGnU025162;
	Fri, 9 Oct 2009 03:39:21 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n991d0rf025158;
	Fri, 9 Oct 2009 03:39:00 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7viqeqjsx6.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129728>

Junio C Hamano <gitster@pobox.com> writes:

> --------------------------------------------------
> [New Topics]

> * jn/gitweb-patch (2009-09-30) 1 commit
>  - gitweb: Do not show 'patch' link in 'commit' view for merges
> 
> jk: After some comments with Jakub, I think the code is right but he
> promised a re-roll with more in the commit message.

Not only better commit message, but a more complete patch as well.
 
> * mr/gitweb-snapshot (2009-09-26) 2 commits
>  - gitweb: append short hash ids to snapshot files
>  - gitweb: check given hash before trying to create snapshot
> 
> jk: He posted a v5 of his series. I didn't look at it closely, but Jakub
> ack'd it.

Actually I acked first patch in series (the "check hash" one), but the
second needs review, and I think corrections.  First there is matter
of tests and matter of not calling git_get_short_hash if it would not
be used (what was mentioned in my review).  But what is more important
that now that gitweb doesn't use full SHA-1 unconditionally, we have
to deal with stripping prefix from refs/tags/v1.6.3-rc3 and
refs/heads/master, and with hierarchical branch names such as
'mr/gitweb-snapshot'.  I'll post improved review soon.

In short: first patch is a go, second needs more work.

> * jc/pretty-lf (2009-10-04) 1 commit
>  - Pretty-format: %[+-]x to tweak inter-item newlines
> 
> I am not happy with this one yet.  I am contemplating to introduce a new
> syntax "%[magic(param)<anything>%]" to generalize expressions of this and
> line wrapping features in an extensible way.
> 
> * js/log-rewrap (2008-11-10) 3 commits
>  . Add "%w" to pretty formats, which rewraps the commit message
>  - Add strbuf_add_wrapped_text() to utf8.[ch]
>  - print_wrapped_text(): allow hard newlines
> 
> ... and the first two from this series will be useful to implement an
> example magic "wrap", e.g. "%{wrap(i,j,w)%s%+b%]".

So... it is magic %[...%] or %{...} or %{...%}?

BTW we can take rpm's queryformat as an example (or counterexample).
Also perhaps we can reuse minilanguage of git-for-each-ref format,
i.e. %(field:modifier).
  
> --------------------------------------------------
> [Cooking]

> * jn/gitweb-show-size (2009-09-07) 1 commit
>  - gitweb: Add 'show-sizes' feature to show blob sizes in tree view

What this one requires (beside better name for a feature)?

> * jn/gitweb-blame (2009-09-01) 5 commits
>  - gitweb: Minify gitweb.js if JSMIN is defined
>  - gitweb: Create links leading to 'blame_incremental' using JavaScript
>   (merged to 'next' on 2009-09-07 at 3622199)
>  + gitweb: Colorize 'blame_incremental' view during processing
>  + gitweb: Incremental blame (using JavaScript)
>  + gitweb: Add optional "time to generate page" info in footer
> 
> Ajax-y blame.

I reordered patches so JSMIN one is first (as it is less
controversial), but the 'create blame_incremental links' one needs
more work.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
