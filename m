From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Excruciatingly slow git-svn imports
Date: Mon, 5 May 2008 23:56:40 -0400
Message-ID: <32541b130805052056g450b69cfg46693bc3c0c5a1ed@mail.gmail.com>
References: <CC0F600D-71F3-493A-AA9C-AF901C1A58C4@adacore.com>
	 <2C39C19D-0B81-4879-92DC-C0436DB6E84E@midwinter.com>
	 <20080429071122.GG24171@muzzle>
	 <2B9E6C04-69F1-42BD-AE60-AFCE401E093E@adacore.com>
	 <20080506032846.GA15521@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Geert Bosch" <bosch@adacore.com>,
	"Steven Grimm" <koreth@midwinter.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue May 06 05:57:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtEJ2-0006RJ-NQ
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 05:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687AbYEFD4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 23:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754655AbYEFD4n
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 23:56:43 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:11341 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754007AbYEFD4m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 23:56:42 -0400
Received: by fk-out-0910.google.com with SMTP id 18so980869fkq.5
        for <git@vger.kernel.org>; Mon, 05 May 2008 20:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=yT1oodjF+o+PbSIY2eyH/OrBolA2Ljfo0yS7HGV8Zq0=;
        b=rRKWurxaK0iXtkJNwLS9D0+BAM46Dx0lZbom7jg+K8Mu8p29g1oPFFV1mMA7YA7EsJni9f09LAx/T1Fz1HKJJCxOW2mbQ3fCM7z9si7cYPX0qXQwHLtaYouZm6HKo2tzaPi2wFvvRY1v3YdSTws0TCiCzvLr0DPR8cE8ecvqFJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WtJExbZhe96UIXVN+0IngkWYFajEjZVA/EPKwhXV03oes4SBpD56mEQD1fZ6aEP8yPhWxy3Uvg8qN+luVlalIr/URLTLsr0Cet4DRkCn4b1y+FxOJmPtrn065E4uO9E1p8TxoVZo6DcHC7tn32LnfHO5wHfLfjAtNKvuU3k5LtM=
Received: by 10.82.164.17 with SMTP id m17mr20615bue.43.1210046200355;
        Mon, 05 May 2008 20:56:40 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Mon, 5 May 2008 20:56:40 -0700 (PDT)
In-Reply-To: <20080506032846.GA15521@untitled>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81326>

On 5/5/08, Eric Wong <normalperson@yhbt.net> wrote:
> Interesting.  By  "These commits seemed all to have thousands of files",
>  you mean the first 35K that took up most of the time?  If so, yes,
>  that's definitely a problem...
>
>  git-svn requests a log from SVN containing a list of all paths modified
>  in each revision.  By default, git-svn only requests log entries for up
>  to 100 revisions at a time to reduce memory usage.  However, having
>  thousands of files modified for each revision would still be
>  problematic, as would having insanely long commit messages.

On my system, any branch that was created using "svn cp" of a toplevel
directory seems to cause git-svn to (rather slowly) download every
single file in the entire branch for the first commit on that branch,
giving a symptom that sounds a lot like the above "commits with
thousands of files".  I assumed this was just an intentional design
decision in git-svn, to be slow and safe instead of fast and loose.
Is it actually supposed to do something smarter than that?

Thanks,

Avery
