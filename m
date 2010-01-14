From: Geoffrey Lee <geoffreyj.lee@gmail.com>
Subject: Re: Syncing a git working tree with Dropbox?
Date: Thu, 14 Jan 2010 05:19:08 -0800
Message-ID: <83d7aaa41001140519g2f84199j38bd0e9a5c73953@mail.gmail.com>
References: <20100113235718.GA7033@dulip>
	 <be6fef0d1001132139p56944cdax22674ca773af0199@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: chombee <chombee@lavabit.com>, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 14:24:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVPgT-00043d-HL
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 14:24:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756686Ab0ANNYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 08:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756439Ab0ANNYQ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 08:24:16 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:51551 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755877Ab0ANNYP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 08:24:15 -0500
Received: by pwj9 with SMTP id 9so20616pwj.21
        for <git@vger.kernel.org>; Thu, 14 Jan 2010 05:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=Tlz2mxyGpDUR8rLyzruGFbbz/hu4VyMasVFg9w28cWY=;
        b=BQbWF0LeF4sq6L2CfHzLmSwrlSQ+4MGJogLK/LoMUNYX2ZxFUu9RZzikOEZWVChuP4
         HtwqvrMp4nx5osmBLftTvBU2u+F6IzBxSVCQ2KvVhT32sU6cgZy2DIaWvP6vo9gN6bXz
         9cDaEZNfEgDPhkRMJxEuCWAqBm8aV3CfzY4Jw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=IOVLRUxPZLAC8TlbyP+k5Ew8vvtbB76rfQJGypb6Dczmdt4MhpiQX+oTatEBVGkySC
         jpBYcac3PZy1fyGOwnwZ7rorn2X3pKhv0LbMU+BASg1Y49f6EGCUtKxq/U/JKEknFblq
         Kn2h52lbf9+fHTmSm7j2eqSTCAmsfFc6L/Y1Y=
Received: by 10.143.153.41 with SMTP id f41mr524707wfo.331.1263475148441; Thu, 
	14 Jan 2010 05:19:08 -0800 (PST)
In-Reply-To: <be6fef0d1001132139p56944cdax22674ca773af0199@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136989>

On Wed, Jan 13, 2010 at 9:39 PM, Tay Ray Chuan <rctay89@gmail.com> wrote:
> On Thu, Jan 14, 2010 at 7:57 AM, chombee <chombee@lavabit.com> wrote:
>> My idea is that I keep my .git folder safely outside of my Dropbox
>> folder, but my git repository has a detached working tree that is
>> located in the Dropbox folder. On machine B it would be the same setup.
>> So the two machines each have their own clone of the git repo and these
>> are synchronised by git push and git pull with a 'central' remote repo.
>> But the two clones share the same working tree, or more accurately their
>> working trees are synced by Dropbox.
>>
>> The working tree is just files, I don't see how it's different from
>> Dropbox syncing any other files. Dropbox and git ought not to collide in
>> any way. So this should work fine shouldn't it?
>
> Your changes in git (like new commits) won't be synced.

You have to sync your .git directory. For example, using your setup,
if you switch branches on Machine A, your working directory will
change on Machine B, but Machine B will still think it's on the
previous branch. This scenario would cause a lot of problems for Git.

There shouldn't be any problems with placing your entire repository
(working tree and .git directory) inside Dropbox as long as you only
use one computer at a time.

-Geoffrey Lee
