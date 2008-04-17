From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Intricacies of submodules
Date: Fri, 18 Apr 2008 02:29:07 +0400
Message-ID: <20080417222907.GP3133@dpotapov.dyndns.org>
References: <7vd4oxufwf.fsf@gitster.siamese.dyndns.org> <46dff0320804110904w531035f4w79c1889bc90c09ee@mail.gmail.com> <7vmyo0owep.fsf@gitster.siamese.dyndns.org> <1207970038.10408.8.camel@ginkgo> <7vlk3jlkrr.fsf@gitster.siamese.dyndns.org> <1208202740.25663.69.camel@work.sfbay.sun.com> <7vd4or7wdt.fsf@gitster.siamese.dyndns.org> <1208317795.26863.91.camel@goose.sun.com> <87lk3c4ali.fsf@jeremyms.com> <1208461808.26863.129.camel@goose.sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeremy Maitin-Shepard <jbms@cmu.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Ping Yin <pkufranky@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: "Roman V. Shaposhnik" <rvs@sun.com>
X-From: git-owner@vger.kernel.org Fri Apr 18 00:30:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmccD-00032O-13
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 00:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754611AbYDQW3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 18:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754594AbYDQW3Q
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 18:29:16 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:19199 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754536AbYDQW3P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 18:29:15 -0400
Received: by fk-out-0910.google.com with SMTP id 19so332563fkr.5
        for <git@vger.kernel.org>; Thu, 17 Apr 2008 15:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=zpvHkZIMNANmQwGtXifBksP2QdutO4ECJjMdDtFxxnI=;
        b=IyF/uIDl8JFkBlProN75FMDBhNz6c5Nh5dwCE1KCD2dfTafpfSgc2+N1NQAAuTZoW/nlsPW9I1Wfptt6gss12stAER73lRaM01eOvIcPYpH+XO9/vdmkRH/jMHhe61QaUQcWQ+r2kflydyYOTn5OuyzIxVPlQ+YXOjHoCBTNkGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=rJfDxfr8Raxn6BVyMWURxWJuP0T7JMPJSdYhyWpsXCITrOUdG/rNeXEsJBs00pY/wXjRIsRAiRTpcdpytmj9IXBT8Q2mcoVszVvkFk8cOievxqlqLlBe4IJWMWNnm+Ybx3cSlBsUB4Ep/a6LrF2wmJvg6dNaHXY0DJ5Y+yo731g=
Received: by 10.82.161.19 with SMTP id j19mr3270059bue.12.1208471353281;
        Thu, 17 Apr 2008 15:29:13 -0700 (PDT)
Received: from localhost ( [85.141.148.116])
        by mx.google.com with ESMTPS id 31sm696304nfu.24.2008.04.17.15.29.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Apr 2008 15:29:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1208461808.26863.129.camel@goose.sun.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79840>

On Thu, Apr 17, 2008 at 12:50:08PM -0700, Roman V. Shaposhnik wrote:
> Doing clone of the *remote*
> repository is a safe operation under such assumptions. Once you cloned
> it, you might need to eyeball the content of .gitconfig if you're really
> paranoid.

No, I don't think it is right. It is absolutely unacceptable to expect
all users to be aware of some hidden file and to eyeball it just to be
sure that the next 'git log' (or some other normal git operation) will
not remove all their files from the disk.

Perhaps, I have not followed this discussion carefully, so I am not sure
what .gitconfig is intended to solve. But if you think that _blindly_
adding some options to other people configurations is a good idea, I
have to disagree with you. Some options may be useful in some cases or
for some platforms, but not for others. So, having a single .gitconfig
is going to be a bad fit for some users. Thus a more flexible and more
secure solution is needed, and it already exists.

You can put git-configure at the top of your repository and tell people
to run it after cloning. In this way, anyone can inspect this script and
if they trust they will run it. This script can check on what system git
is running on, and maybe ask questions, etc, so it can be really helpful
for wide category of users.

Dmitry
