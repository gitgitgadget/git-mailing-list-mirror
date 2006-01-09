From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git pull on Linux/ACPI release tree
Date: Mon, 9 Jan 2006 19:08:44 +1300
Message-ID: <46a038f90601082208i95cd19fmda542da0da8cc9ef@mail.gmail.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A136DD@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "David S. Miller" <davem@davemloft.net>, torvalds@osdl.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 09 07:08:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvqD2-0006RL-R0
	for gcvg-git@gmane.org; Mon, 09 Jan 2006 07:08:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbWAIGIq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 01:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbWAIGIp
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 01:08:45 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:17036 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751476AbWAIGIp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 9 Jan 2006 01:08:45 -0500
Received: by wproxy.gmail.com with SMTP id i30so1487272wra
        for <git@vger.kernel.org>; Sun, 08 Jan 2006 22:08:44 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kP2iYVoU9qPONHr5194xtN6yJjzXvJey9TkFi0c6xp3JDGDDBtZgQPBjkta58jo/CowCJ3KSn582pyObiXuBB8ZqKwWEpQRBTYeoA/4pPutjQpNQf+kd4ROMoBz936XAstIortwkuNM6UHPOoRCkOY400Ee+U6tEPl06SAaH2x8=
Received: by 10.54.123.12 with SMTP id v12mr2761198wrc;
        Sun, 08 Jan 2006 22:08:44 -0800 (PST)
Received: by 10.54.71.5 with HTTP; Sun, 8 Jan 2006 22:08:44 -0800 (PST)
To: "Brown, Len" <len.brown@intel.com>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005A136DD@hdsmsx401.amr.corp.intel.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14353>

On 1/9/06, Brown, Len <len.brown@intel.com> wrote:
> This is completely insane.
> Do you have any idea what "sometimes has problems merging" means
> in practice?  It means the tools are really nifty in the trivial
> case but worse than worthless when you need them the most.

Len,

all I meant was that you will sometimes see conflicts. And in that
case, you are far better off cancelling the rebase and doing a merge,
where you will have to resolve the conflicts by hand.

git-rebase is for when the potential merge is clearly trivial. In any
other case, you do want a proper merge. But in any case, it is easy to
do

    git-fetch <upstream> && git-rebase <upstream>

and if it does anything but a very trivial merge, backtrack and do a merge.

In any case, if I have any suspicion that the merge may not be trivial, I do

   git-fetch <upstream> && gitk --since=" 1 month ago" upstream master

before deciding on a course of action. Of course, you can merge all
the time. It's whether people care about a readable/useful history
afterwards.

cheers,


martin
