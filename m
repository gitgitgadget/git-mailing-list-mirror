From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Only update the cygwin-related configuration during state auto-setup
Date: Tue, 28 Oct 2008 13:21:59 +0100
Message-ID: <81b0412b0810280521x5982315ahe1d81c2c7176f1c8@mail.gmail.com>
References: <7viqri35dq.fsf@gitster.siamese.dyndns.org>
	 <20081027192018.6117@nanako3.lavabit.com>
	 <7vhc6xh010.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Nanako Shiraishi" <nanako3@lavabit.com>,
	"Mark Levedahl" <mlevedahl@gmail.com>, spearce@spearce.org,
	dpotapov@gmail.com, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 28 13:23:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KunbR-0001GR-RV
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 13:23:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753192AbYJ1MWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 08:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753157AbYJ1MWC
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 08:22:02 -0400
Received: from mail-gx0-f18.google.com ([209.85.217.18]:48992 "EHLO
	mail-gx0-f18.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbYJ1MWB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 08:22:01 -0400
Received: by mail-gx0-f18.google.com with SMTP id 11so1366288gxk.13
        for <git@vger.kernel.org>; Tue, 28 Oct 2008 05:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Q5KgAvV6a9I2hYdmKgEWZ6lMpZ8YokkjSg5R8S+ucBg=;
        b=VyN6hWA3nvLM3SgA1zOoPihB7rbKvW/droROHTA0NDcOFPbsBToNOs2Dg1XlrCevMa
         Z/LPZwC+b6CX+F1g6F73UB29iUgMrx5lQEmirRZIOubFmVpFTgn8XW1UBImdkm5lNWS9
         MBj8MFnbHRdzS/OttFHNDVbz0ZMOik9zb5j7s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=GlZg23zaLD42ujdfru6jAfrkISzrJbRNMbfXggK/wMDj3O6oJobAr0jzIqb7Ipl57Z
         UUKOoIO4adLmqgyEJ+hWVZNhmMFdhu6a7hWH8mgNRU/kbxoLEglCXX5FprkhZ3WBM+yq
         H7yIHKii1Xz9v7k70IsMdPrR0voARCUQ/4Bhw=
Received: by 10.100.41.9 with SMTP id o9mr7004851ano.39.1225196519777;
        Tue, 28 Oct 2008 05:21:59 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Tue, 28 Oct 2008 05:21:59 -0700 (PDT)
In-Reply-To: <7vhc6xh010.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99284>

2008/10/28 Junio C Hamano <gitster@pobox.com>:
> Nanako Shiraishi <nanako3@lavabit.com> writes:
>> Quoting Junio C Hamano <gitster@pobox.com>:
>>
>>> This is the answer to the question I asked in:
>>>
>>>  http://thread.gmane.org/gmane.comp.version-control.git/97986/focus=98066
>>>
>>> Perhaps we should use a separate variable as the original patch did, in:
>>>
>>>   http://article.gmane.org/gmane.comp.version-control.git/97987
>>>
>>> How about doing it like this instead?
>>
>> Junio, may I ask what the status of this patch is? I see you did not write tests nor commit message --- are you waiting for others to write them?
>
> Heh, Alex's ack is good enough for me as far as the code itself is
> concerned, but I do want these "fixes" accompanied by additional tests to
> reproduce to avoid future regressions, and this being a Cygwin fix, I am
> not really the right person to write tests nor run them.

I suggest NOT writing the test for the workaround for just one platform I
personally call the most idiotic of the Microsoft's fallouts. As the
fix is located
in the code specific to that platform, it wont do any harm for anyone, whether
it works or not (even if the code in tree does not work). The Junio's fix is
definitely enough for me and, I'm very sure, for anyone still having to
deal with cygwin.

So for the Google's record: the patch to fix the --encoding option of git
format-patch broken on cygwin is in the Junio's mail, to be found, i.e.:
http://marc.info/?l=git&m=122482769817566&w=4

Nanako, as there is not many of such poor bastards left, it is not
even a problem
to keep the fix just in Git mailing list archives. There is just not
enough of a looser
base to press its development in whatever direction.
