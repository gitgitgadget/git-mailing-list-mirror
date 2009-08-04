From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: How to fetch all remote branches from remote?
Date: Mon, 3 Aug 2009 20:17:20 -0400
Message-ID: <eaa105840908031717x43803dbbqbca126a9bc11f887@mail.gmail.com>
References: <2729632a0908031520n71514fffne0667c6b229f836f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Tue Aug 04 02:17:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY7ib-0004U6-TO
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 02:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbZHDARV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 20:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754309AbZHDARV
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 20:17:21 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:55470 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754095AbZHDARU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 20:17:20 -0400
Received: by ewy10 with SMTP id 10so3467205ewy.37
        for <git@vger.kernel.org>; Mon, 03 Aug 2009 17:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=RUtWHFLj5KJg0bTEiEvDDCRVjkPAqec1Dmg6Xy4YGWs=;
        b=yF46Wx8ILwMk5G74fqGDPjZx3b6UI+o4YlVRHFF5iYJPnsLEVDMgz9JUfQfk2hpj1e
         xM9WRB06D/zKVHlwdiJ6Uaozh0xgebMUnr+za9/qTRxLaCJEET87g1m6EO2X2ZNpuVZL
         qy4ieMEt2mdLsAskrrDmd3o8aC5yzamfgz0Kc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=jnsdw6VDdLt2B4nXhX3Dxz4zS1jL715/Y0BX+M+XW4rJG9A8YtQjf4Xh3SEOGozTNU
         crXPLjBdQC/7MeC4YjhmSxrd8domMf/C85pwNxfCjrNGGqa9wj+8QYkvnyJ2GDqRkXw7
         qRUH53D+oStYuI0xTN4wlvrCsXMXjPQt+dNQY=
Received: by 10.210.91.7 with SMTP id o7mr5884945ebb.25.1249345040287; Mon, 03 
	Aug 2009 17:17:20 -0700 (PDT)
In-Reply-To: <2729632a0908031520n71514fffne0667c6b229f836f@mail.gmail.com>
X-Google-Sender-Auth: b61b6c17450006ff
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124737>

On Mon, Aug 3, 2009 at 6:20 PM, <skillzero@gmail.com> wrote:
> Is there a way to fetch all the remote branches of a remote?

git config --add remote.$remote.fetch +refs/remotes/*:refs/remotes/*; git fetch

> I have
> one computer that cloned a repository from a server and I want clone
> that computer's repository to another computer, but it only brings
> over the local branches from the clone. I'd like to also get all the
> remote branches so it's the same as if I had cloned directly from the
> server. Just as if I had cp -R'd the .git folder (except with the
> remote tracking info I get when I clone). The source computer's
> repository is using git-svn so I'm trying to make a copy of that
> repository in a way that I can just push and pull changes to the
> intermediate git svn repository then later do the final git svn
> dcommit.

The above is what I use to set up my working copies from a
cron-enabled git-svn mirror.

Also,  if you're pushing instead of dcommitting from each clone, you
may wish to read  this thread:
http://thread.gmane.org/gmane.comp.version-control.git/111356/focus=112156
- your setup probably isn't that complex, but you might want to be
aware of some of the issues you might face in the "forced rebase"
environment of svn.

Peter Harris
