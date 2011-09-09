From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: RFD: leveraging GitHub's asciidoc rendering for our Documentation/
Date: Fri, 09 Sep 2011 18:05:24 +0200
Message-ID: <4E6A3944.8000403@drmicha.warpmail.net>
References: <4E6A23DB.1040606@drmicha.warpmail.net> <CAP2yMaJ+UBHZp0U=QWOZbnbbOuq8vNoJODWtxZPb1sKXTC_UEg@mail.gmail.com> <4E6A378E.6020704@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Scott Chacon <schacon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 09 18:05:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R23a9-0006yq-B9
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 18:05:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753796Ab1IIQF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 12:05:28 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:37449 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752443Ab1IIQF1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2011 12:05:27 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 719FC28F39;
	Fri,  9 Sep 2011 12:05:26 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 09 Sep 2011 12:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=PQBHhoFE1ngKvSPcuMOCKu
	sH6cw=; b=CMi+ZARsdwiYIFyNcCMB9epaiG+LHBoonqXgPQYhO//59ogLtZSPBV
	Pq+UdsAhWrbfQliu7GIlqyTbAE+CdhKgGJvsCA7nlz5n3iJt4tjLO+Y1gLD/s4sH
	tIcetk30Zt+F0aSbLhv0syezDiDp8cKFKFLA0Z+y8I06xi6f2+wwk=
X-Sasl-enc: LB6gtKP8SYa9AStIZSBS/pbfuew4401glA77rYf+/POM 1315584326
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B0FD09C0690;
	Fri,  9 Sep 2011 12:05:25 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <4E6A378E.6020704@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181090>

Michael Haggerty venit, vidit, dixit 09.09.2011 17:58:
> On 09/09/2011 05:45 PM, Scott Chacon wrote:
>> On Fri, Sep 9, 2011 at 7:34 AM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> which has all the renaming (*.txt -> *.asciidoc) and Makefile and script
>>> changes, but is missing some include changes (because include breaks
>>> anyway, see below).
>>
>> I can change this so we can render .asc if that's less ugly.  I've
>> been meaning to do this for a while, but I don't think I ever
>> incorporated it.
> 
> What about letting the project set a gitattribute that tells github how
> to render particular files?  It would not require files to be renamed,
> and it would be more flexible.
> 
> OTOH it would not be possible to apply gitattributes (or file renamings)
> to old revisions, so the history would continue to be rendered naively.
>  But here's an additional idea: github could provide web access to the
> equivalent of $GIT_DIR/info/attributes (a project-wide .gitattributes
> file), which would allow the rendering of files in historical revisions
> to be customized and would also allow github rendering behavior to be
> defined even in projects that do not want github-specific tags in the
> .gitattributes files in their project.
> 
> Michael

I don't think that the naming is a problem. In fact, we have .txt files
which are asciidoc and some which are not, so renaming the former is an
improvement in itself.

Also, I don't mean to replace our prerendered html. Just a nicer source
view for documentation source.

Since this is about source view, we might not even want to execute an
include - but we don't want the rendering to stop where there is one either.

Besides linkgit and things like apostrophe, all our asciidoc marcos are
workarounds for docbook, and thus a non-issue for html rendering.

Don't know where the parser gets stuck. Maybe cwd is not where one
thinks it is, and safe mode spoils the party.

Michael
