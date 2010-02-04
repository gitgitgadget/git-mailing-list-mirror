From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Dealing with many many git repos in a /home directory
Date: Thu, 4 Feb 2010 10:00:38 -0500
Message-ID: <46a038f91002040700x623a686ek4bc35d20f5d9cb86@mail.gmail.com>
References: <9b18b3111002040029x1c7de0afw4a5ef883588f7a18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 16:00:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd3CL-0004jE-RW
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 16:00:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244Ab0BDPAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 10:00:41 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:53837 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932140Ab0BDPAk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 10:00:40 -0500
Received: by bwz19 with SMTP id 19so364950bwz.28
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 07:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=BuWj7NHYJBYq6e4gY07L83gvyARhspdA5NIw99fJZ+w=;
        b=RymNgHBwhCPKcxxq4ecaxSOBvTImywoynS5rytgwilBnpEaKloHrHTO4TjEqTDoQma
         ZAQpNu/sOblxqu3j5RZMo4WjxNkfm+1kXM7PJzw3f+ThHxHNPCV14WFVmErTGH1LrFNj
         60CNv7Y1ucZl44nha/hXjhm2gkwUyQR2KgHhA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=GERfTkpb4VdiP6UHnk5S+NXyDD+sIgKYyqTebjfkOgFPWCutdKrG4CTx4Z3+Gg7d02
         3m8FL0C6Yn8meNVh+0XkEEnAWrUw25H9Cf68ISshZAIHTMIWXa3jZPBSFimzwE7I+Hrg
         EvdbyuqnH888GpeAcQ91G4zt1JIoUnpFMZpKg=
Received: by 10.204.33.131 with SMTP id h3mr793557bkd.53.1265295639214; Thu, 
	04 Feb 2010 07:00:39 -0800 (PST)
In-Reply-To: <9b18b3111002040029x1c7de0afw4a5ef883588f7a18@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138966>

On Thu, Feb 4, 2010 at 3:29 AM, demerphq <demerphq@gmail.com> wrote:
> This is starting to take a lot of space.

What I used to do was to

 - have a "canonical" local bare repo for each major project, fetching
and repacking nightly

 - a script that "injects" an "alternates" entry to matching user
repos -- logic to look at a repo and decide which alternate to hook it
to is left to the reader.

 - optional: automating repacks on users repos

As users repack, their "local" packs will only have the objects that
are not shared with the canonical repos. With Moodle repos, this was a
200MB savings per repo.

And the kernel keeps one set of packfiles in buffers, so everyone gets
much faster gitk / gitlog / blame...



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
