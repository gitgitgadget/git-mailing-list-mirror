From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: "git pull . <branch>" versus "git merge <branch>"
Date: Tue, 10 Jun 2008 19:04:33 -0700
Message-ID: <484F32B1.4050506@gnu.org>
References: <484F2174.9020508@keyaccess.nl> <ee77f5c20806101806u6dc04152rb8307eb12a6167c@mail.gmail.com> <484F26C9.9080608@keyaccess.nl> <20080611015608.GD29404@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Rene Herman <rene.herman@keyaccess.nl>,
	David Symonds <dsymonds@gmail.com>, git <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 04:05:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6Fid-0007ja-2F
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 04:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754985AbYFKCEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 22:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755246AbYFKCEh
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 22:04:37 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:24146 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754985AbYFKCEg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 22:04:36 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2348959waf.23
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 19:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=Kz2crFd0QM7wkwwQ6vD1zRLHK/PXlh6DibMC1g0egg8=;
        b=ijZ2JGuZ7jY8M/daHPHxTzUd0uToe5/JA+P6GbtEFTreZnjTPqfOrKJ70LoRWhll9e
         /l376u4KQl6xi5lFtM9/gGXMFJoK4Wottm5CNaRe36oq/eCeKpSn7q6Oigq5xpq1E2yV
         yo/AImCAplkGtZxtD7s5YXKTOPEtgtWZLBDqk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender;
        b=pd47UkoqrqWi4CEDYxNtE5g9S0LiEf+CnnUUTEegUCrauRkbz2g1HBvy1o5kwB++8o
         lH0ENs0mIM+s9KT36NvbbS86Hf+iRQ+soLAhib5sqQsW3LDYZmZEsNOvx6PBDzYomEL7
         Svua3Gwcn3Ig4gZs2Qjly5megDJu5jdMKdV7k=
Received: by 10.114.66.2 with SMTP id o2mr5835469waa.124.1213149875688;
        Tue, 10 Jun 2008 19:04:35 -0700 (PDT)
Received: from scientist-2.local ( [65.248.49.163])
        by mx.google.com with ESMTPS id t1sm17479699poh.9.2008.06.10.19.04.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Jun 2008 19:04:34 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <20080611015608.GD29404@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84578>

Miklos Vajna wrote:
> On Wed, Jun 11, 2008 at 03:13:45AM +0200, Rene Herman <rene.herman@keyaccess.nl> wrote:
>> So in the case of merging a branch from the local repository into the 
>> current branch, there is no difference between the two?
> 
> There is no difference, but you really want to use git merge and not git
> pull in such a case, I guess the git pull form is supported mainly to
> keep backwards compatibility.

However, when you're on a tracking merge only "git pull" will merge the 
right branch automatically into the current branch, fetching the branch 
name to merge from the config.  If the branch.*.remote config key is 
".", it will do a local merge.

Note that "git pull ." is optimized in that the fetch does nothing 
except setting up MERGE_HEAD.

Paolo
