From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] config: Use parseopt.
Date: Sat, 14 Feb 2009 23:13:23 +0200
Message-ID: <94a0d4530902141313i24ddc571m6a041f3879960ab2@mail.gmail.com>
References: <1234577142-22965-1-git-send-email-felipe.contreras@gmail.com>
	 <7vab8pweod.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530902140237o7d26ff4j1c7350d926d12c1a@mail.gmail.com>
	 <alpine.DEB.1.00.0902141230250.10279@pacific.mpi-cbg.de>
	 <94a0d4530902140415j4168d09dh8abac0d6eba0b8cf@mail.gmail.com>
	 <alpine.DEB.1.00.0902142003300.10279@pacific.mpi-cbg.de>
	 <94a0d4530902141114s7352841cmf5c4259211a793e3@mail.gmail.com>
	 <alpine.DEB.1.00.0902142022340.10279@pacific.mpi-cbg.de>
	 <alpine.DEB.1.00.0902142025420.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 14 22:15:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYRr3-0003XF-2S
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 22:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754157AbZBNVN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 16:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754150AbZBNVN0
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 16:13:26 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:6677 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754130AbZBNVNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 16:13:25 -0500
Received: by fg-out-1718.google.com with SMTP id 16so77315fgg.17
        for <git@vger.kernel.org>; Sat, 14 Feb 2009 13:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AjTwKbtOxljB7Ovj9PEwhuh3XV1w+IzznmxEykHiS0w=;
        b=nwEyt9sFgUDKr5l20k6TAU8JP3KTz54ILu5F/d16Ybtb6MY8YPrx8go2SRIn9wgol8
         vXthfPD8kzfy7W13VHYcdGnGVjGVx69wY33FS+xmTIQbAEzd+GTMg+hphjx0RHeFzZDy
         jTCqyqugNkxVE1x9slJxdldTALxkw5gcW1hSI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jvHk4aAk6vkDO3SSH4HWg0FrXRvXagnqrbx9zING3uuX/XszEPalreqmqsmIKMMxMs
         QRrZxSN41P5Xh/vJ3YJ7JEcCa7foaN83EM2bWxhy7F96qoRelh7cJaA7MyaTn+p0Ns+a
         1VJNoLc2rnl0qRP9SOVUjzI9XqBts4ZUFJFBQ=
Received: by 10.86.92.9 with SMTP id p9mr531633fgb.15.1234646003454; Sat, 14 
	Feb 2009 13:13:23 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902142025420.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109929>

On Sat, Feb 14, 2009 at 9:26 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sat, 14 Feb 2009, Johannes Schindelin wrote:
>
>> On Sat, 14 Feb 2009, Felipe Contreras wrote:
>>
>> > On Sat, Feb 14, 2009 at 9:11 PM, Johannes Schindelin
>> > <Johannes.Schindelin@gmx.de> wrote:
>> > > Hi,
>> > >
>> > > On Sat, 14 Feb 2009, Felipe Contreras wrote:
>> > >
>> > >> 1) --list when no config file is given uses all the config files,
>> > >> wouldn't it make sense to have a --repo option?
>> > >
>> > > The idea of --list is not "cat .git/config".  The idea is to help users or
>> > > scripts to list the current settings (_including_ the global settings).
>> > >
>> > > You can force showing the repo-specific config with "git --file
>> > > .git/config", though.
>> >
>> > When you are on the root directory of the repo, and you don't have
>> > GIT_DIR, or --git-dir.
>>
>> When I wrote my response, I briefly considered if I had to be verbose, and
>> decided against it.
>>
>> But this is what I should have written:
>>
>>       git --file $(git rev-parse --git-dir)/config --list
>
> Okay, before anybody points out that I was not verbose enough -- again --
> this is what I really should have written:
>
>        git --file "$(git rev-parse --git-dir)"/config --list

Yeap, it's possible, but I think people would not complain about "git
--repo --list". I think it would be much clearer to have --global
--system --repo and --all. Then we can say --list by default uses
--all, and --edit uses --repo, and it doesn't make sense to do --edit
--all.

Anyway, I don't care that much.

-- 
Felipe Contreras
