From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/4] glossary: define committish (a.k.a. commit-ish)
Date: Tue, 18 Jun 2013 23:19:39 -0700
Message-ID: <20130619061938.GA2968@elie.Belkin>
References: <1371607780-2966-1-git-send-email-rhansen@bbn.com>
 <1371607780-2966-3-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 08:19:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpBkF-0002pn-La
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 08:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756430Ab3FSGTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 02:19:47 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:50150 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183Ab3FSGTr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 02:19:47 -0400
Received: by mail-pb0-f51.google.com with SMTP id um15so4668109pbc.24
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 23:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7wSTSgMI3LuFm3La07HdVokDP2Hn01zItug/NZKoMb4=;
        b=yxjIgDJC0IqCmWIXwQuRJrpe6Cikv6dfw2db49suFbCeYfgMa5hPA4llnclLIYSypz
         Tipm1e5JkLHaFpcg7Lej1SHd7B6OXFamBC9HLndpSz8+mFfFxBemIvnOtjCUd3lqe6SQ
         B2ifIlMgFNpxYfRrUTOazQuUmLiVO9nrP1g36W+aQWP3Yh1dajgfKvJh+LIshKZcP7Fp
         +KcaYllWl1BvggZ4CkeRHi9FFp1mQumrwHy35o7zgAqg1kdoEzfwE3WEvwwZUHn1Z5UX
         1rcERMzgPIxjSqLff6rQfmGtrePz+jAcd7aBLDHr+LK0U0OgNsxfAPzcoHw5XTV9mqQm
         RIwA==
X-Received: by 10.68.131.168 with SMTP id on8mr1329223pbb.97.1371622786789;
        Tue, 18 Jun 2013 23:19:46 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id vb8sm21713431pbc.11.2013.06.18.23.19.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 23:19:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1371607780-2966-3-git-send-email-rhansen@bbn.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228349>

Hi,

Richard Hansen wrote:

> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -82,6 +82,17 @@ to point at the new commit.
>  	to the top <<def_directory,directory>> of the stored
>  	revision.
>  
> +[[def_committish]]committish (also commit-ish)::
> +	A <<def_ref,ref>> pointing to an <<def_object,object>> that
> +	can be recursively dereferenced to a
> +	<<def_commit_object,commit object>>.

Usually I would expect that the string "4d1c565" is not a ref, but the
glossary contains a different definition ("A 40-byte hex
representation of a SHA-1 or ...").  I guess we need a shorter name
for "extended SHA-1 syntax" (as described in gitrevisions(7)) that is
a little less confusing.

Perhaps we can sidestep the issue by saying

	A parameter pointing to an <<def_object,object>> that
	can be recursively dereferenced to ...

since the most common use of "commitish" is in describing a command's
syntax.  I'm tempted to go even further and just call that a "commit
parameter", explaining the more pedantic synonym here --- something
like

	[[def_commitish]]commitish (also commit-ish)::
		A commandline parameter to a command that requires a
		<<def_commit,commit>>.
	+
	The following are all commitishes: an expression (see
	linkgit:gitrevisions[7]) directly representing a commit object,
	an expression naming a tag that points to a commit object, a
	tag that points to a tag that points to a commit, etc.

Thanks,
Jonathan
