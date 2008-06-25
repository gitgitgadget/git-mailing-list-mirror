From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: Searching all git objects
Date: Wed, 25 Jun 2008 16:32:56 -0700
Message-ID: <905315640806251632m416a2406x301b857ec7faf09d@mail.gmail.com>
References: <E99352BE-5C43-437E-A5E6-622BEEA03DFA@comcast.net>
	 <20080625231742.GT11793@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Paul Mackerras" <paulus@samba.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Sam G." <ceptorial@comcast.net>
X-From: git-owner@vger.kernel.org Thu Jun 26 01:34:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBeUw-0000zK-A9
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 01:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084AbYFYXc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 19:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753151AbYFYXc7
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 19:32:59 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:25698 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbYFYXc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 19:32:58 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3436888fkq.5
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 16:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=SgVhQ1v/mTIPwWnT76C9nXTr1uW9URCrNi3ut/ytyrU=;
        b=PCmVNaQuT3XIqyyGLawnpDYjHAHeOvM8bYMdFFLFHJtDwTZ52LYa/RYsfj/AoWzocT
         c+YT7ucAMmZUasqfzIeKpqmljTdI0RblIMUiv3d+F+cDOIX0+DEE9/+0cJYx52oDqk1W
         kDcGiIG6jTgWnna3rtuE0efF46EVj4DimFfuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=m5Yp60YgQsD0AIp1mIp0gSKf+81pTD/f25VRcgKn2B811QM7lNTdDgE1M3bW+0bQZD
         rDn0iXWFzWo3FR2sVxm4n9/YvvIFJ/jaDsFMDoHiywAsQhGGJXeBbXgI33W/0SU76DmW
         84WX+lROAJeee0fdgKNC7rsDMDuLjcyQwRfO8=
Received: by 10.82.182.1 with SMTP id e1mr673314buf.41.1214436776845;
        Wed, 25 Jun 2008 16:32:56 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Wed, 25 Jun 2008 16:32:56 -0700 (PDT)
In-Reply-To: <20080625231742.GT11793@spearce.org>
Content-Disposition: inline
X-Google-Sender-Auth: 0ff2ae646c04a0e1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86373>

On Wed, Jun 25, 2008 at 4:17 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> "Sam G." <ceptorial@comcast.net> wrote:
>> We recently had a developer make a large commit (mostly centered
>> around one file) which she believed she properly pushed to a remote
>> repository last week, but looking at both her repository and the
>> remote repository, that commit is now nowhere to be found. If somehow
>> the master branch she was working on in her repository has lost the
>> reference to the commit through perhaps some errant rebasing, then
>> perhaps an object containing the commit (or an object containing the
>> file in that commit) still exists somewhere inside her .git/objects
>> directory? We haven't done any git-gc recently. If so, how can I
>> search through every single git object in her objects directory,
>> searching for perhaps a specific part of the commit string, a line in
>> the code or the filename of the file which was changed? Any help with
>> this would be greatly appreciated. Thanks!
>
> Odds are it is in her HEAD reflog.  You can look for it with
> `git log -g`.  If you know some part of the commit message you
> may be able to filter it down with `git log -g --grep=X` or part
> of the change with `git log -g -SX`.

If it helps, I like viewing the reflog with gitk.  Like this:
gitk $(git log -g --pretty=format:%H)

Is there a shorter way to do this with gitk?  It would be awesome to
have `gitk -g` .

-Tarmigan
