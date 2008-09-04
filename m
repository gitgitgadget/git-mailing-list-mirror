From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [Monotone-devel] Re: [RFC] mtn to git conversion script
Date: Thu, 4 Sep 2008 16:21:48 +0300
Message-ID: <94a0d4530809040621h40111cwf412bc0f8811d9db@mail.gmail.com>
References: <94a0d4530808240218j4bedbe3di99303da9addc93a4@mail.gmail.com>
	 <20080824131405.GJ23800@genesis.frugalware.org>
	 <94a0d4530808241133n5cc9f17arc79a1a5013187869@mail.gmail.com>
	 <20080824224658.GA16590@spearce.org>
	 <94a0d4530808241745r3f2bdb56q9cfa8bc61f79223e@mail.gmail.com>
	 <g95eoo$5ok$8@ger.gmane.org>
	 <94a0d4530808280203o6d97f69we4768115e12800c2@mail.gmail.com>
	 <94a0d4530809040243k49635fd3kfef1ee22a6865e98@mail.gmail.com>
	 <m3vdxcp5gv.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Anand Kumria" <wildfire@progsoc.org>, monotone-devel@nongnu.org,
	git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 15:23:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbEnc-000107-7u
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 15:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832AbYIDNVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 09:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752699AbYIDNVv
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 09:21:51 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:6230 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177AbYIDNVu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 09:21:50 -0400
Received: by py-out-1112.google.com with SMTP id p76so1792128pyb.10
        for <git@vger.kernel.org>; Thu, 04 Sep 2008 06:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=s1jFKkwYYSRT3pxJPafHVxELP3uG68Fj4275tB5BR1s=;
        b=vdQVfrBoJqTvAP7tNQBpFscvnFmDqyhfPNTANMNco+l5IJixgMsQSyd4nh4iJc9Mf8
         jZF0xPuVqEvlQenY22CuXBGfgZHt8gLduY0Mq3YTQXChgKVYeYE88T9jrcg8f3WJxmtn
         U1aJmd9rAm41bhJnzlpoB28/AEGmcJ1L34QV8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=wWg0JlUeU13oOT0EggNgEmDS5CO+hulJTYbphGaPmPGm62cit/QC24OXxnkvPTWCex
         TPYsul7PiDczxSiKhM4oRMBYooXy3ZT1KsdQK1sxQ3Fuvt3k3fnXyBaYkDXkT6goBd2x
         gSknsEVL/c5x5qfBMPtYZs5R3B94KETGuEEXI=
Received: by 10.140.165.21 with SMTP id n21mr5669341rve.244.1220534508989;
        Thu, 04 Sep 2008 06:21:48 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Thu, 4 Sep 2008 06:21:48 -0700 (PDT)
In-Reply-To: <m3vdxcp5gv.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94930>

On Thu, Sep 4, 2008 at 1:31 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> "Felipe Contreras" <felipe.contreras@gmail.com> writes:
>
>> Ok, now the basics seem to be working. So I'm uploading some code if
>> anyone wants to take a look.
>>
>> The C code is generating a topologically sorted list of revisions, and
>> storing the relevant information (certs and parents) separately. This
>> code is very fast. It's using GLib and sqlite3, so probably the GLib
>> stuff should be converted to use libgit.
>> http://gist.github.com/8742
>>
>> The Ruby code takes that input and generates an output suitable for
>> fast-import. It would be tedious to port the parsing stuff to C, but
>> straightforward.
>> http://gist.github.com/8740
>>
>> A patch for fast-import is required, I already submitted it.
>>
>> Comments?
>
> If you feel like it is good enough, could you add information about
> this tool to Git Wiki:
>  http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
> in the "Interaction with other Revision Control Systems" section?

Not yet.

It still needs to add the branches, tags, and HEAD.

-- 
Felipe Contreras
