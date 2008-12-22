From: "David Copeland" <davetron5000@gmail.com>
Subject: Re: push to backup repo periodically fails with "not fast forward"
Date: Mon, 22 Dec 2008 12:15:31 -0500
Message-ID: <f95d47890812220915h5286d2bdv7c8412ecf77be999@mail.gmail.com>
References: <19016122-e19d-4885-8b0f-dec7b686c6ea@o4g2000pra.googlegroups.com>
	 <94a0d4530812220911l37b825edj55178658f24755c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Felipe Contreras" <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 18:17:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEoOj-0008As-IH
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 18:16:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991AbYLVRPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 12:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbYLVRPf
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 12:15:35 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:45182 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbYLVRPe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 12:15:34 -0500
Received: by bwz14 with SMTP id 14so8393456bwz.13
        for <git@vger.kernel.org>; Mon, 22 Dec 2008 09:15:32 -0800 (PST)
Received: by 10.102.234.20 with SMTP id g20mr2373353muh.116.1229966131991;
        Mon, 22 Dec 2008 09:15:31 -0800 (PST)
Received: by 10.103.214.9 with HTTP; Mon, 22 Dec 2008 09:15:31 -0800 (PST)
In-Reply-To: <94a0d4530812220911l37b825edj55178658f24755c1@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: f0686d8978eb083e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103761>

the original gets rebased from a git svn rebase on occasion; so I
guess that is causing things to not be fast-forward.

I guess all I really want to do is keep a duplicate copy of my repo
somewhere else.  Should I just use --force in my hook, or abandon git
as the mechanism and use rsync?

Dave

On Mon, Dec 22, 2008 at 12:11 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Mon, Dec 22, 2008 at 6:24 PM, davetron5000 <davetron5000@gmail.com> wrote:
>> I have a repo on another disk that I ONLY use to backup my in-use
>> local repo.  I have a post-commit hook that does the push (git push --
>> all remote-repo-name)
>>
>>>git commit -a -m 'some change'
>> Counting objects: 71, done.
>> Compressing objects: 100% (26/26), done.
>> Writing objects: 100% (29/29), 2.31 KiB, done.
>> Total 29 (delta 12), reused 0 (delta 0)
>> Unpacking objects: 100% (29/29), done.
>> To file:///Volumes/Git/pose/main
>>   22d7f10..0037aaf  bimonthly-frequency -> bimonthly-frequency
>>  ! [rejected]        master -> master (non-fast forward)
>> error: failed to push some refs to 'file:///Volumes/Git/pose/main'
>> Created commit 0037aaf: Removed assertion that made no sense.
>>  1 files changed, 0 insertions(+), 2 deletions(-)
>>
>> I'm using git as a front-end to Subversion, but I can't figure out why
>> this is happening.
>>
>> The repo at /Volumes/Git/pose/main is NEVER pulled from or pushed to
>> by anything other than my hook.  I can't understand why any push to it
>> would NOT be a fast-forward.
>>
>> Any ideas how I can figure out what's going on?
>
> Do you rebase your original repo?
>
> --
> Felipe Contreras
>
