From: "Stephen Sinclair" <radarsat1@gmail.com>
Subject: Re: [Bug] vfat: Not a git archive
Date: Mon, 2 Jun 2008 11:16:43 -0400
Message-ID: <9b3e2dc20806020816r502de6bfjd704040d15858c82@mail.gmail.com>
References: <873anwt9ya.fsf@debian.erik.com>
	 <e1dab3980806020337x4d62dcablcf8d4385466b1b2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Thomas Christensen" <thomasc@thomaschristensen.org>,
	git@vger.kernel.org
To: "David Tweed" <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 17:18:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3BnE-0003WB-KK
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 17:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbYFBPQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 11:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752181AbYFBPQ7
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 11:16:59 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:38499 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbYFBPQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 11:16:58 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1081858rvb.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 08:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=uy0heXFzwmZYWHIfX6sAIeDvkyLVQudpzu5ijQ+Gpak=;
        b=hVDDY/Svl9wQTvY+L+raX6RS4Ow8WbnPcPtBuUyPJ5G7m+AgGKh9HNQ3pa6RW3F/dT/GBQCa1Pt+xzFHIMzLwLfd8gJt4659bJ+/YnY4KncNe95RxtOyOZ9W3oIrJrtnzdOz9F5Gtx2hnPRF5VKa60A+ksIGRep6rhF0CsJzCy0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MFmul4biziTS13cWHlmQcfOevA8FONXRKUkUx62q+79qqPYIpyN8ZxgquQdGrYtX9xIpnx8WzrOadMPv1pGf4gZTJCn2YSdcZ2FA2fbeAi0VubrDZxXshXg8JfGg2f+Pg7OADM3NBufeycmrB2t9TA1Kxc+gArAKyp4ZemqKz5I=
Received: by 10.141.193.1 with SMTP id v1mr5002808rvp.245.1212419817995;
        Mon, 02 Jun 2008 08:16:57 -0700 (PDT)
Received: by 10.141.66.3 with HTTP; Mon, 2 Jun 2008 08:16:43 -0700 (PDT)
In-Reply-To: <e1dab3980806020337x4d62dcablcf8d4385466b1b2f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83529>

On Mon, Jun 2, 2008 at 6:37 AM, David Tweed <david.tweed@gmail.com> wrote:
> On Mon, Jun 2, 2008 at 11:20 AM, Thomas Christensen
> <thomasc@thomaschristensen.org> wrote:
>> Hi,
>>
>> I am having this issue on Debian with kernel 2.6.25 (2.6.24 works fine)
>> and git 1.5.5.3.
>>
>>  $ git push /media/KINGSTON/foo.git
>>  fatal: '/media/KINGSTON/foo.git': unable to chdir or not a git archive
>>  fatal: The remote end hung up unexpectedly
>>
>> A notable difference between these 2 kernels is this line:
>>
>>  [   62.575939] FAT: utf8 is not a recommended IO charset for FAT
>>  filesystems, filesystem will be case sensitive!
>>
>> which appears in 2.6.25.
>
> I don't remember if it gives this particular error message, but some
> vfat mounting options cause the file 'HEAD' to appear to the
> filesystem as 'head' which git doesn't like. (I don't think there any
> other basic git files which have uppercase.)It's worth having a look
> and see if that's happened.

I recently had some issue where I got this "Not a git archive"
message.  Turned out it was something stupid I had done during a
failed filter-branch operation, related to deleting my refs.  But the
message "Not a git archive" wasn't very helpful.  Finally I found that
recreating my refs manually (using cat) did the trick.  But it would
have been nice to have a more specific error message along with "Not a
git archive", like "HEAD points to refs/heads/master, but file
.git/refs/heads/master not found."


Steve
