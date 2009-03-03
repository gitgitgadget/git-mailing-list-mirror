From: David Copeland <davetron5000@gmail.com>
Subject: Re: move files between disparate repos and maintain version history
Date: Tue, 3 Mar 2009 13:08:17 -0500
Message-ID: <f95d47890903031008s36873f6ex94c7096f79cd6de@mail.gmail.com>
References: <0d8965bb-e2ed-4f49-b323-c110f605ae2c@33g2000yqm.googlegroups.com>
	 <20090303041300.GA18136@coredump.intra.peff.net>
	 <f95d47890903030858xb398b5fy1aeabb19166e6077@mail.gmail.com>
	 <20090303171835.GB454@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 19:10:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeZ3u-0006Xj-3H
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 19:09:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbZCCSIW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 13:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbZCCSIW
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 13:08:22 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:12831 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbZCCSIV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 13:08:21 -0500
Received: by fg-out-1718.google.com with SMTP id 16so111490fgg.17
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 10:08:19 -0800 (PST)
Received: by 10.86.82.16 with SMTP id f16mr8237688fgb.32.1236103698877; Tue, 
	03 Mar 2009 10:08:18 -0800 (PST)
In-Reply-To: <20090303171835.GB454@coredump.intra.peff.net>
X-Google-Sender-Auth: f6927e5879f7b921
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112139>

The patch file looks correct.  I'm wondering if this is a result of
both repos being connected to svn?

my process was:

- format patch
- go to other repo
- git svn rebase
- apply patch
- git svn dcommit

Could dcommit change the dates since, to svn, they are appear as
commits right now?

Dave

On Tue, Mar 3, 2009 at 12:18 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 03, 2009 at 11:58:42AM -0500, David Copeland wrote:
>
>> The first option worked, insomuch the history of diffs is preserved,
>> but the dates are all today.
>
> That's odd. It works fine here. Can you confirm that the correct date=
s
> in the "patches" file (i.e., the output of format-patch)? What are yo=
u
> using to look at the patches? Note that gitk will show you both the
> "committer" and the "author" fields. The "author" field should have t=
he
> original author and time of the patch, but the "committer" will be yo=
u,
> today.
>
>> The second option was a little over my head; is the idea there that
>> you are setting up a branch that has ONLY the files I care about (wi=
th
>> all their history), and then I pull from the other repo as if they a=
re
>> related? =A0That seems like it might preserve the dates...
>
> Yes, that is exactly what is happening in the second example.
>
> -Peff
>
