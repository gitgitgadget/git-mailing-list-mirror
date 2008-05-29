From: "Andrew Arnott" <andrewarnott@gmail.com>
Subject: Re: How to merge branches except for one commit
Date: Wed, 28 May 2008 20:01:51 -0700
Message-ID: <216e54900805282001x299055c3r6cfffcebc61fa955@mail.gmail.com>
References: <216e54900805281932v1397fd30sad91f767175ba95e@mail.gmail.com>
	 <32541b130805281942g2550cad9k7ba530c59e050aa4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 29 05:02:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1YPd-0000ef-MU
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 05:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbYE2DBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 23:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbYE2DBy
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 23:01:54 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:22369 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779AbYE2DBx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 23:01:53 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2144496ywe.1
        for <git@vger.kernel.org>; Wed, 28 May 2008 20:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=lUkVJOHnSBfHGV/DevGZ9fGvmS9/3wBbDgTuCYNtvEU=;
        b=THe/8R55tRzn9m/Po6iZ83iy1nuspot0H90cjey7X9qmONOuMnPv5j/HMOykZnC8KGLCU3zQG6uky2TajG5CeuF/tKA3UUZ/L/JL2j41K3uWea2nWYb6TnhKCsjgtBGJIdClzKXKE7fAZB1Uryz/4euQQeAI7X1/jfri25AaNn4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sqCE1iihwJVqtH05qGKU5ZJNy4ftJDHqVxLivuAGErRdEBkm31SiBZEPvI3VLK0q50idf0mxhuPK+fGT2FTWSJkMKBH1GforuQ/AmerPWy4QaBXqyswDlEvHWFLkQXfPoWlIjoE+ooBFUivjlYNWA4ySfwW/J34Rf9GePuvGmdU=
Received: by 10.151.108.3 with SMTP id k3mr3157138ybm.172.1212030111542;
        Wed, 28 May 2008 20:01:51 -0700 (PDT)
Received: by 10.151.154.16 with HTTP; Wed, 28 May 2008 20:01:51 -0700 (PDT)
In-Reply-To: <32541b130805281942g2550cad9k7ba530c59e050aa4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83168>

Interesting.  I think working in the maintenance branch and merging
back into master should work... except when I'm in master when I find
the bug and just fix it there without thinking.

The merge and revert idea is interesting.  I may try that out in this
case since I'm already stuck with lots of commits in master.

Regarding why I am porting more than just *some* commits to the
maintenance branches, well, these are also stabilization branches
before an initial vX.0 release, so in the month or so of stabilization
there could be potentially be a great deal of work in master that I
decide is worth releasing sooner rather than later.  I guess it's not
really a stabilization branch in that scenario either, so it's
probably my fault trying to walk both sides of a line.

I appreciate the thoughts and critique.  If anyone else has more
thoughts please feel free to throw them in.

On Wed, May 28, 2008 at 7:42 PM, Avery Pennarun <apenwarr@gmail.com> wrote:
> On 5/28/08, Andrew Arnott <andrewarnott@gmail.com> wrote:
>>  At some point, most or all the commits on master since branching off
>>  v1.0 I want to include in the v1.1 release.
>
> I think this is perhaps the root of your problem.  Normally people
> don't merge from master into their bugfix release; they do it the
> other way around, making bugfixes in the bugfix branch, and merging
> them occasionally into master.
>
> Or alternatively, they cherry pick just *some* of the changes from
> master back into the bugfix release, because presumably there are also
> a bunch of non-critical new feature patches sitting in master.
>
> If you really want to do it the way you described, an easy answer
> might be to just merge the entire master into v1.1, then "git revert"
> (in v1.1) the patch that changes the version number :)
>
> Have fun,
>
> Avery
>



-- 
Andrew Arnott
