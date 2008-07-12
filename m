From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Remove --undo flags from stg commands and docs
Date: Sat, 12 Jul 2008 10:58:44 +0100
Message-ID: <b0943d9e0807120258g26e30c4bn5b7f77f69a0c3db3@mail.gmail.com>
References: <20080704063536.9570.43526.stgit@yoghurt>
	 <b0943d9e0807071354j50dca83aya90317f97f559b19@mail.gmail.com>
	 <20080708042131.GB2247@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 11:59:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHbtK-0007SP-H9
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 11:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025AbYGLJ6s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jul 2008 05:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752123AbYGLJ6s
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 05:58:48 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:53402 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555AbYGLJ6r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jul 2008 05:58:47 -0400
Received: by rv-out-0506.google.com with SMTP id k40so4749096rvb.1
        for <git@vger.kernel.org>; Sat, 12 Jul 2008 02:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=gHWTipvlw1lgpe4yCOVdnWhQPlLydEwRK8UHgbCMpYs=;
        b=Ma3LtyCQzAVZ44qQpef7F0cGeAWGH2LGbJwRWxNPE+64atEnrHJFK8PDexIJ7vxzyr
         9fs+QNo2kkB/hgJTQIByJK9ERQKd48rZFZpIdl67PnOKLvKpfEsVhfPogSRp60GYSOhc
         AXZDBak0tskAGo/Cy3RFEox+yimF/vXTNlmLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=XSRNt1gSpGMVS24eR1NkCWSJiprMvWtB70/xSILuTnagp+8SlkUnM42A/7qIKSkN6S
         sUkxnofMjFw4gmLwAXwHfuXWGv807YlyUr6BJTLoB0dYGJxCuYxaWHaBcX7OVg5LnPys
         ALkbsT848XlEISzGLwMqpfu9w8aThvTo3cs5M=
Received: by 10.114.180.1 with SMTP id c1mr15447042waf.85.1215856725021;
        Sat, 12 Jul 2008 02:58:45 -0700 (PDT)
Received: by 10.114.124.9 with HTTP; Sat, 12 Jul 2008 02:58:44 -0700 (PDT)
In-Reply-To: <20080708042131.GB2247@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88229>

2008/7/8 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-07-07 21:54:01 +0100, Catalin Marinas wrote:
>
>> 2008/7/4 Karl Hasselstr=F6m <kha@treskal.com>:
>>
>> > In this one, I've just removed the --undo flag from sync without
>> > adding anything back. Still undetermined if that's OK.
>>
>> I think it should be ok (see the other thread). Anyway, have you
>> heard of anyone else using sync apart from me?
>
> No, I haven't.
>
> I've tried to understand what it does, and as far as I can tell it
> doesn't do quite what I want. (What I want is the ability to 3-way
> merge StGit patch stacks, so that I can modify the same patch stack i=
n
> several places and merge back and forth. From what I recall, the sync
> command is more like a 2-way merge -- that is, it doesn't take the
> last common ancestor into account. But it's been a while since I
> studied it.)

No, the sync command is a 3-way merge between the top of a remote
patch, the top of the current patch (current HEAD actually) and the
bottom of the remote patch as ancestor. It also has a mode to
synchronise with a patch file and it applies the patch onto the bottom
of the current patch and does the merging between patch tops
afterwards.

This is not ideal as I have to deal with safe conflicts several time
(maybe adding git-rerere support would help). If you have better ideas
for keeping two stacks in sync, I'm happy to accept them (or maybe
just a different workflow).

--=20
Catalin
