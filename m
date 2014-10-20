From: Greg KH <greg@kroah.com>
Subject: Re: Sources for 3.18-rc1 not uploaded
Date: Tue, 21 Oct 2014 05:52:12 +0800
Message-ID: <20141020215212.GA1544@kroah.com>
References: <20141020115943.GA27144@gmail.com>
 <CA+55aFyDuHskYE66rBVL_P-T2pxg6f2m6mUicfz-mk+ysePBxg@mail.gmail.com>
 <xmqqoat6389s.fsf@gitster.dls.corp.google.com>
 <54455655.9010406@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	infra-steering@kernel.org, Git Mailing List <git@vger.kernel.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Mon Oct 20 23:53:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgKtI-0007Sd-It
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 23:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbaJTVxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 17:53:21 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59121 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751233AbaJTVxU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Oct 2014 17:53:20 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by gateway2.nyi.internal (Postfix) with ESMTP id B8BE2206B6
	for <git@vger.kernel.org>; Mon, 20 Oct 2014 17:53:19 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Mon, 20 Oct 2014 17:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:date:from:to:cc:subject
	:message-id:references:mime-version:content-type:in-reply-to; s=
	smtpout; bh=CqT13TB7D9ZpsaBWMWK/m54jMRo=; b=BbQqK/9ciHVa2pO7KRLS
	7aiy/W8jY/WwUY/SFHi872HPKZi3y6CToCDzozstHloXwLfESTev8eG3R2rFFQin
	K6/HVI8HWtSo8DnZnYL/1UqhPqfydB9OsogRTEdD29AkeFo+fTkSiozt8xGIFros
	20Cnws9UaNNyO1aY4i//9EA=
X-Sasl-enc: YNt7oTWXoFYfGGHPlXe/oCljsZmFzEku22DgHdfAEnfM 1413841998
Received: from localhost (unknown [220.128.240.151])
	by mail.messagingengine.com (Postfix) with ESMTPA id BDE566800EC;
	Mon, 20 Oct 2014 17:53:18 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <54455655.9010406@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 20, 2014 at 02:37:09PM -0400, Konstantin Ryabitsev wrote:
> On 20/10/14 02:28 PM, Junio C Hamano wrote:
> > I have to wonder why 10f343ea (archive: honor tar.umask even for pax
> > headers, 2014-08-03) is a problem but an earlier change v1.8.1.1~8^2
> > (archive-tar: split long paths more carefully, 2013-01-05), which
> > also should have broken bit-for-bit compatibility, went unnoticed,
> > though.  What I am getting at is that correcting past mistakes in
> > the output should not be forbidden unconditionally with a complaint
> > like this.
> 
> I think Greg actually ran into that one, and uses a separate 1.7 git
> tree for this reason.

I used to have to do this for the 3.0-stable kernel as one of the files
in it ran into the "very long path" problem.  I just ran the latest
version of git with that one commit reverted and all was fine.

After 3.0 was done, I just dropped that patch from my local version and
have been running with the latest git version of git with no problems.

> I can update our servers to git 2.1 (which most of them already have),
> which should help with previous incompatibilities -- but not the future
> ones obviously. :)

I thought you already did this.  Or was that only the public facing git
servers?

thanks,

greg k-h
