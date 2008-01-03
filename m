From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: Re: [PATCH 3/3] Replace setenv(GIT_DIR_ENVIRONMENT, ...) with set_git_dir()
Date: Wed, 2 Jan 2008 22:26:55 -0800
Message-ID: <a1bbc6950801022226k32cfd9b9t62939b3cbedef247@mail.gmail.com>
References: <11956768414090-git-send-email-prohaska@zib.de>
	 <7v63zv9fel.fsf@gitster.siamese.dyndns.org>
	 <C50619A0-4A67-4968-8431-D7A685F723B7@zib.de>
	 <7vsl2y90pm.fsf@gitster.siamese.dyndns.org>
	 <52415F60-C080-4260-86CD-32A379482341@zib.de>
	 <474552D6.5060305@viscovery.net>
	 <3B6B19E6-255F-4D8F-B6A3-255A9E8E0AB0@zib.de>
	 <0FFA1D0A-DB70-446C-9C43-A6FBAEFE7CA4@zib.de>
	 <a1bbc6950801022007w164d050bhf8a8a8c0ad6736b@mail.gmail.com>
	 <42F546CE-2564-4DFB-B260-FD50BD51F2BB@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Jan 03 07:27:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAJY6-00085N-0h
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 07:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756125AbYACG05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2008 01:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758672AbYACG05
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 01:26:57 -0500
Received: from an-out-0708.google.com ([209.85.132.245]:40123 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753AbYACG04 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 01:26:56 -0500
Received: by an-out-0708.google.com with SMTP id d31so1037602and.103
        for <git@vger.kernel.org>; Wed, 02 Jan 2008 22:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=9dV+zZ11b8KwN5LyA15QBnXB9o2EiFTUBTRZwfHTthk=;
        b=oBjoIMgZoE7V0N1L66VqV/EeavijeUcB54n0QnJhWixP6J/yY2Wb6C2T/It9jhQD+40k7QZLI5SIGXAL2ePmeUuoSuwN61kp7pK5L+60BaGKZRpuZCbMyIBpTTo5HJMUZfKNF6DrDLxLhPrEf5qPtWB3A/zuNxK5HJ7njmQc64U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MQgwW1e3nHWrdvYw+t9oZKlcmjMsoEHlp3+STBN7aPjn5Z8v7/RYfc98/RULXwQu09BrNgRv3JwW/i/W4fsziSsber6FdX60wOO4OcURaU3eYmpFfQ0234s+sbiz8SFDyPYbCZ8THpEEK+K+t2NM9Jtv8lyiXkXRS9JySqhxkqU=
Received: by 10.100.7.1 with SMTP id 1mr32149243ang.73.1199341615656;
        Wed, 02 Jan 2008 22:26:55 -0800 (PST)
Received: by 10.70.59.16 with HTTP; Wed, 2 Jan 2008 22:26:55 -0800 (PST)
In-Reply-To: <42F546CE-2564-4DFB-B260-FD50BD51F2BB@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69514>

On Jan 2, 2008 10:02 PM, Steffen Prohaska <prohaska@zib.de> wrote:
>
>
> On Jan 3, 2008, at 5:07 AM, Dmitry Kakurin wrote:
>
> > On Jan 1, 2008 10:52 AM, Steffen Prohaska <prohaska@zib.de> wrote:
> >> In conclusion, using setenv() as in the original code instead of
> >> set_git_dir() should be safe and this patch is not needed.
> >>
> >> I tend to revert the changes in msysgit and see if we hit any
> >> problems.  But I'll wait until 1.5.4 is released.
> >>
> >>        Steffen
> >
> > Please don't revert this change. I've made it in response to git clone
> > failing, commit 855f254b2b5b083a63fc8d7709a42e2cbdc5a136.
>
> I know.  But I cannot reproduce the error.
>
> Do you have a test case that demonstrates the problem?
>
> I either want to see the patch upstream in official git or revert
> it in msysgit.  But I cannot answer the questions that were
> raised after I sent the patch (see earlier in this thread).  And
> I can't see the problem that your patch solves, even after
> spending some time on reading and instrumenting code.

I remember that the problem was as simple as git clone or git clone
--bare failing.
Also I'm not sure if it matters but I'm running Vista.
There is also a chance that code has changed since then and this
problem went away.

-- 
- Dmitry
